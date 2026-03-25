import { useState, useEffect, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';
import { useToast } from '../../contexts/ToastContext';
import { db } from '../../firebase';
import { collection, query, where, getDocs, getDoc, doc, deleteDoc, orderBy, limit, startAfter } from 'firebase/firestore';
import {
  Search, Plus, Eye, Edit, Trash2, Copy, Download,
  Filter, ChevronLeft, ChevronRight, Users
} from 'lucide-react';

const RESTRICTED_RANKS = [
  'Insp', 'PSI', 'SI', 'ASI/ESI', 'ASI', 'HC/ESI', 'HC/EASI', 'HC',
  'C-1/EHC', 'C-1', 'CT/ESI', 'CT/EASI', 'CT/EHC', 'CT', 'R/CT', 'SPO'
];

const ALLOWED_RANKS = [
  'DSP (Prob)', 'Deputy Superintendent of Police (DSP)', 'Assistant Commissioner of Police (ACP)',
  'Additional Superintendent of Police (ASP)', 'Superintendent of Police (SP)',
  'Senior Superintendent of Police (SSP)', 'Deputy Inspector General of Police (DIG)',
  'Inspector General of Police (IG)', 'Additional Director General of Police (ADGP)',
  'Director General of Police (DGP)'
];

const RANKS = [...ALLOWED_RANKS, ...RESTRICTED_RANKS];

const FIXED_CATEGORIES = [
  "Police Stations",
  "Traffic",
  "Special Staffs",
  "Court",
  "Administrative Units",
  "Security",
  "Temp_Dep_Trg"
];

const PAGE_SIZE = 25;

export default function PersonnelList() {
  const { user, isSuperAdmin, isStateAdmin, isRangeAdmin, isDistrictAdmin, isUnitAdmin } = useAuth();
  const toast = useToast();
  const navigate = useNavigate();

  const [personnel, setPersonnel] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [rankFilter, setRankFilter] = useState('');
  const [statusFilter, setStatusFilter] = useState('Active');
  
  // Hierarchy Filters
  const [hierFilters, setHierFilters] = useState({
    stateId: '', rangeId: '', districtId: '', unitType: '', unitId: '', subUnitId: ''
  });
  const [states, setStates] = useState([]);
  const [ranges, setRanges] = useState([]);
  const [districts, setDistricts] = useState([]);
  const [unitCategories, setUnitCategories] = useState([]);
  const [units, setUnits] = useState([]);
  const [subUnits, setSubUnits] = useState([]);
  
  const [currentPage, setCurrentPage] = useState(1);
  const [deleteModal, setDeleteModal] = useState(null);

  useEffect(() => {
    loadHierarchyCounts();
    loadPersonnel();
  }, [user]);

  async function loadHierarchyCounts() {
    // Initial load restricted by role
    if (isSuperAdmin) {
      const sSnap = await getDocs(collection(db, 'states'));
      setStates(sSnap.docs.map(d => ({ id: d.id, ...d.data() })));
    } else {
      // For other admins, State is fixed
      if (user?.stateId) {
        setHierFilters(p => ({ ...p, stateId: user.stateId }));
        // We don't need to load all states, just the one assigned
        // But we might want the name for the label if we show it (though we'll hide it)
        const sDoc = await getDoc(doc(db, 'states', user.stateId));
        if (sDoc.exists()) setStates([{ id: sDoc.id, ...sDoc.data() }]);
        
        // Auto-load ranges for State Admin
        if (isStateAdmin) loadRanges(user.stateId);
        
        // For Range Admin+, even Range is fixed
        if (user?.rangeId) {
          setHierFilters(p => ({ ...p, rangeId: user.rangeId }));
          if (isRangeAdmin) loadDistricts(user.rangeId);
        }

        // For District Admin+, even District is fixed
        if (user?.districtId) {
          setHierFilters(p => ({ ...p, districtId: user.districtId }));
          if (isDistrictAdmin) loadUnits(user.districtId);
        }

        // For Unit Admin, everything is fixed except Sub-Unit
        if (user?.unitId) {
          setHierFilters(p => ({ ...p, unitId: user.unitId }));
          if (isUnitAdmin) loadSubUnits(user.unitId);
        }
      }
    }
  }

  useEffect(() => {
    if (hierFilters.stateId) {
      loadRanges(hierFilters.stateId);
      setHierFilters(prev => ({ ...prev, rangeId: '', districtId: '', unitType: '', unitId: '', subUnitId: '' }));
    }
  }, [hierFilters.stateId]);

  async function loadRanges(stateId) {
    const q = query(collection(db, 'ranges'), where('stateId', '==', stateId));
    const snap = await getDocs(q);
    setRanges(snap.docs.map(d => ({ id: d.id, ...d.data() })));
  }

  useEffect(() => {
    if (hierFilters.rangeId) {
      loadDistricts(hierFilters.rangeId);
      setHierFilters(prev => ({ ...prev, districtId: '', unitType: '', unitId: '', subUnitId: '' }));
    }
  }, [hierFilters.rangeId]);

  async function loadDistricts(rangeId) {
    const q = query(collection(db, 'districts'), where('rangeId', '==', rangeId));
    const snap = await getDocs(q);
    setDistricts(snap.docs.map(d => ({ id: d.id, ...d.data() })));
  }

  useEffect(() => {
    if (hierFilters.districtId) {
      loadUnits(hierFilters.districtId);
      setHierFilters(prev => ({ ...prev, unitType: '', unitId: '', subUnitId: '' }));
    }
  }, [hierFilters.districtId]);

  async function loadUnits(districtId) {
    const q = query(collection(db, 'units'), where('districtId', '==', districtId));
    const snap = await getDocs(q);
    const loadedUnits = snap.docs.map(d => ({ id: d.id, ...d.data() }));
    setUnits(loadedUnits);
    setUnitCategories(FIXED_CATEGORIES);
  }

  useEffect(() => {
    if (hierFilters.unitId) {
      loadSubUnits(hierFilters.unitId);
      setHierFilters(prev => ({ ...prev, subUnitId: '' }));
    }
  }, [hierFilters.unitId]);

  async function loadSubUnits(unitId) {
    const q = query(collection(db, 'subUnits'), where('unitId', '==', unitId));
    const snap = await getDocs(q);
    setSubUnits(snap.docs.map(d => ({ id: d.id, ...d.data() })));
  }

  async function loadPersonnel() {
    try {
      setLoading(true);
      const personnelRef = collection(db, 'personnel');
      let constraints = [];

      // Role-based filtering (Strict enforcement from AuthContext)
      if (isUnitAdmin && user?.unitId) {
        constraints.push(where('currentUnitId', '==', user.unitId));
      } else if (isDistrictAdmin && user?.districtId) {
        constraints.push(where('districtId', '==', user.districtId));
      } else if (isRangeAdmin && user?.rangeId) {
        constraints.push(where('rangeId', '==', user.rangeId));
      } else if (isStateAdmin && user?.stateId) {
        constraints.push(where('stateId', '==', user.stateId));
      }

      const q = query(personnelRef, ...constraints);
      const snap = await getDocs(q);
      const data = snap.docs.map(d => ({ id: d.id, ...d.data() }));
      setPersonnel(data);
    } catch (e) {
      console.error('Personnel load error:', e);
      toast.error('Failed to load personnel records.');
    } finally {
      setLoading(false);
    }
  }

  // Client-side search and filter
  const filteredPersonnel = useMemo(() => {
    return personnel.filter(p => {
      // Status filter
      if (statusFilter && p.serviceStatus !== statusFilter) return false;

      // Rank filter
      if (rankFilter && p.rank !== rankFilter) return false;

      // Hierarchy Filters
      if (hierFilters.stateId && p.stateId !== hierFilters.stateId) return false;
      if (hierFilters.rangeId && p.rangeId !== hierFilters.rangeId) return false;
      if (hierFilters.districtId && p.districtId !== hierFilters.districtId) return false;
      if (hierFilters.unitType && p.unitType !== hierFilters.unitType) return false;
      if (hierFilters.unitId && (p.currentUnitId !== hierFilters.unitId)) return false;
      if (hierFilters.subUnitId && p.currentSubUnitId !== hierFilters.subUnitId) return false;

      // Search
      if (searchTerm) {
        const term = searchTerm.toLowerCase();
        const match =
          (p.fullName || '').toLowerCase().includes(term) ||
          (p.beltNumber || '').toLowerCase().includes(term) ||
          (p.payCode || '').toLowerCase().includes(term) ||
          (p.mobileNumber || '').toLowerCase().includes(term) ||
          (p.rank || '').toLowerCase().includes(term);
        if (!match) return false;
      }

      return true;
    });
  }, [personnel, searchTerm, rankFilter, statusFilter, hierFilters]);

  // Pagination
  const totalPages = Math.ceil(filteredPersonnel.length / PAGE_SIZE);
  const paginatedData = filteredPersonnel.slice(
    (currentPage - 1) * PAGE_SIZE,
    currentPage * PAGE_SIZE
  );

  useEffect(() => { setCurrentPage(1); }, [searchTerm, rankFilter, statusFilter]);

  async function handleDelete(person) {
    try {
      await deleteDoc(doc(db, 'personnel', person.id));
      toast.success(`${person.fullName} has been deleted.`);
      setPersonnel(prev => prev.filter(p => p.id !== person.id));
      setDeleteModal(null);
    } catch (err) {
      toast.error('Failed to delete personnel record.');
    }
  }

  return (
    <div>
      <div className="page-header">
        <h2>Personnel Records</h2>
        <div className="page-header-actions">
          {!isUnitAdmin && (
            <>
              <button className="btn btn-secondary" onClick={() => navigate('/personnel/import')}>
                <Download size={16} /> Import
              </button>
              <button className="btn btn-primary" onClick={() => navigate('/personnel/add')}>
                <Plus size={16} /> Add Personnel
              </button>
            </>
          )}
        </div>
      </div>

      {/* Search & Filter Bar */}
      <div className="panel" style={{ marginBottom: 'var(--space-4)' }}>
        <div className="panel-body">
          <div className="search-filter-bar" style={{ marginBottom: '1rem' }}>
            <div className="search-input-wrapper" style={{ flexGrow: 1 }}>
              <Search className="search-icon" size={18} />
              <input
                type="text"
                placeholder="Search by Name, Belt No, Pay Code, Mobile..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
              />
            </div>
            <select
              className="filter-select"
              value={rankFilter}
              onChange={(e) => setRankFilter(e.target.value)}
            >
              <option value="">All Ranks</option>
              {(() => {
                const rankList = isStateAdmin && !isSuperAdmin
                  ? ALLOWED_RANKS
                  : (!isStateAdmin && !isSuperAdmin ? RESTRICTED_RANKS : RANKS);
                return rankList.map(r => (
                  <option key={r} value={r}>{r}</option>
                ));
              })()}
            </select>
            <select
              className="filter-select"
              value={statusFilter}
              onChange={(e) => setStatusFilter(e.target.value)}
            >
              <option value="">All Status</option>
              <option value="Active">Active</option>
              <option value="Retired">Retired</option>
              <option value="Suspended">Suspended</option>
              <option value="Deceased">Deceased</option>
            </select>
          </div>

          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(6, 1fr)', gap: 8 }}>
            {/* State Selection - Hidden for State Admin and below */}
            {isSuperAdmin && (
              <select className="form-select form-select-sm" 
                value={hierFilters.stateId} 
                onChange={e => setHierFilters(p => ({ ...p, stateId: e.target.value }))}>
                <option value="">All States</option>
                {states.map(s => <option key={s.id} value={s.id}>{s.stateName}</option>)}
              </select>
            )}

            {/* Range Selection - Hidden for Range Admin and below */}
            {(isSuperAdmin || isStateAdmin) && (
              <select className="form-select form-select-sm" 
                value={hierFilters.rangeId} disabled={!hierFilters.stateId}
                onChange={e => setHierFilters(p => ({ ...p, rangeId: e.target.value }))}>
                <option value="">All Ranges</option>
                {ranges.map(r => <option key={r.id} value={r.id}>{r.rangeName}</option>)}
              </select>
            )}

            {/* District Selection - Hidden for District Admin and below */}
            {(isSuperAdmin || isStateAdmin || isRangeAdmin) && (
              <select className="form-select form-select-sm" 
                value={hierFilters.districtId} disabled={!hierFilters.rangeId}
                onChange={e => setHierFilters(p => ({ ...p, districtId: e.target.value }))}>
                <option value="">All Districts</option>
                {districts.map(d => <option key={d.id} value={d.id}>{d.districtName}</option>)}
              </select>
            )}

            {/* Unit Category Selection - Visible for all but might be locked? No, usually selectable */}
            {(isSuperAdmin || isStateAdmin || isRangeAdmin || isDistrictAdmin) && (
              <select className="form-select form-select-sm" 
                value={hierFilters.unitType} disabled={!hierFilters.districtId}
                onChange={e => setHierFilters(p => ({ ...p, unitType: e.target.value }))}>
                <option value="">All Categories</option>
                {unitCategories.map(c => <option key={c} value={c}>{c}</option>)}
              </select>
            )}

            {/* Unit Selection - Hidden for Unit Admin and below. Enabled without category only for District Admin per request. */}
            {(isSuperAdmin || isStateAdmin || isRangeAdmin || isDistrictAdmin) && (
              <select className="form-select form-select-sm" 
                value={hierFilters.unitId} disabled={isDistrictAdmin ? !hierFilters.districtId : !hierFilters.unitType}
                onChange={e => setHierFilters(p => ({ ...p, unitId: e.target.value }))}>
                <option value="">All Units</option>
                {units.filter(u => u.unitType === hierFilters.unitType || !hierFilters.unitType)
                  .map(u => <option key={u.id} value={u.id}>{u.unitName}</option>)}
              </select>
            )}

            {/* Sub-Unit Selection - Visible for all */}
            <select className="form-select form-select-sm" 
              value={hierFilters.subUnitId} disabled={!hierFilters.unitId}
              onChange={e => setHierFilters(p => ({ ...p, subUnitId: e.target.value }))}>
              <option value="">All Sub-Units</option>
              {subUnits.map(su => <option key={su.id} value={su.id}>{su.subUnitName}</option>)}
            </select>
          </div>
        </div>
      </div>

      <div className="panel">

        <div className="table-container">
          {loading ? (
            <div className="empty-state">
              <div className="spinner spinner-lg" style={{ margin: '0 auto' }}></div>
              <p>Loading personnel records...</p>
            </div>
          ) : paginatedData.length === 0 ? (
            <div className="empty-state">
              <Users className="icon" />
              <h4>No records found</h4>
              <p>{searchTerm ? 'Try adjusting your search or filters.' : 'Add personnel or import data to get started.'}</p>
            </div>
          ) : (
            <table className="data-table">
              <thead>
                <tr>
                  <th>S.No</th>
                  <th>Belt No.</th>
                  <th>Pay Code</th>
                  <th>Name</th>
                  <th>Father's Name</th>
                  <th>Rank</th>
                  <th>Mobile</th>
                  <th>Status</th>
                  <th style={{ textAlign: 'right' }}>Actions</th>
                </tr>
              </thead>
              <tbody>
                {paginatedData.map((p, idx) => (
                  <tr key={p.id}>
                    <td>{(currentPage - 1) * PAGE_SIZE + idx + 1}</td>
                    <td style={{ fontWeight: 600 }}>{p.beltNumber || '—'}</td>
                    <td>{p.payCode || '—'}</td>
                    <td>{p.fullName || '—'}</td>
                    <td>{p.fatherName || '—'}</td>
                    <td><span className="badge badge-primary">{p.rank || '—'}</span></td>
                    <td>{p.mobileNumber || '—'}</td>
                    <td>
                      <span className={`badge ${
                        p.serviceStatus === 'Active' ? 'badge-success' :
                        p.serviceStatus === 'Suspended' ? 'badge-danger' :
                        'badge-neutral'
                      }`}>
                        {p.serviceStatus || '—'}
                      </span>
                    </td>
                    <td>
                      <div className="actions">
                        <button className="btn btn-ghost btn-icon btn-sm" title="View"
                          onClick={() => navigate(`/personnel/${p.id}`)}>
                          <Eye size={15} />
                        </button>
                        <button className="btn btn-ghost btn-icon btn-sm" title="Edit"
                          onClick={() => navigate(`/personnel/${p.id}/edit`)}>
                          <Edit size={15} />
                        </button>
                        <button className="btn btn-ghost btn-icon btn-sm" title="Delete"
                          onClick={() => setDeleteModal(p)}
                          style={{ color: 'var(--danger-500)' }}>
                          <Trash2 size={15} />
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </div>

        {/* Pagination */}
        {totalPages > 1 && (
          <div className="panel-footer">
            <span style={{ fontSize: '0.8rem', color: 'var(--gray-500)' }}>
              Showing {(currentPage - 1) * PAGE_SIZE + 1}–{Math.min(currentPage * PAGE_SIZE, filteredPersonnel.length)} of {filteredPersonnel.length}
            </span>
            <div className="pagination">
              <button className="pagination-btn" disabled={currentPage === 1}
                onClick={() => setCurrentPage(p => p - 1)}>
                <ChevronLeft size={16} />
              </button>
              {Array.from({ length: Math.min(totalPages, 5) }, (_, i) => {
                const page = i + 1;
                return (
                  <button key={page}
                    className={`pagination-btn ${currentPage === page ? 'active' : ''}`}
                    onClick={() => setCurrentPage(page)}>
                    {page}
                  </button>
                );
              })}
              <button className="pagination-btn" disabled={currentPage === totalPages}
                onClick={() => setCurrentPage(p => p + 1)}>
                <ChevronRight size={16} />
              </button>
            </div>
          </div>
        )}
      </div>

      {/* Delete Confirmation Modal */}
      {deleteModal && (
        <div className="modal-overlay" onClick={() => setDeleteModal(null)}>
          <div className="modal" onClick={(e) => e.stopPropagation()}>
            <div className="modal-header">
              <h3>Confirm Delete</h3>
              <button className="btn btn-ghost btn-icon" onClick={() => setDeleteModal(null)}>
                <span style={{ fontSize: 20 }}>×</span>
              </button>
            </div>
            <div className="modal-body">
              <div className="confirm-dialog">
                <div className="icon danger"><Trash2 size={24} /></div>
                <h4>Delete Personnel Record?</h4>
                <p>
                  Are you sure you want to delete <strong>{deleteModal.fullName}</strong> (Belt No: {deleteModal.beltNumber})?
                  This action cannot be undone.
                </p>
              </div>
            </div>
            <div className="modal-footer">
              <button className="btn btn-secondary" onClick={() => setDeleteModal(null)}>Cancel</button>
              <button className="btn btn-danger" onClick={() => handleDelete(deleteModal)}>
                <Trash2 size={16} /> Delete
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
