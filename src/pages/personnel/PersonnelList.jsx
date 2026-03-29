import { useState, useEffect, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';
import { useToast } from '../../contexts/ToastContext';
import { db } from '../../firebase';
import { collection, query, where, getDocs, getDoc, doc, updateDoc, serverTimestamp, orderBy, limit, startAfter } from 'firebase/firestore';
import { Search, Plus, Eye, Edit, Trash2, Copy, Download,
  Filter, ChevronLeft, ChevronRight, Users
} from 'lucide-react';

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
  const [masterRanks, setMasterRanks] = useState([]);

  useEffect(() => {
    loadCategories();
    loadMasterRanks();
    loadHierarchyCounts();
    loadPersonnel();
  }, [user]);

  async function loadMasterRanks() {
    if (!user?.stateId) return;
    try {
      const q = query(
        collection(db, 'masterData'),
        where('fieldType', '==', 'rank'),
        where('stateId', '==', user.stateId),
        where('isActive', '==', true)
      );
      const snap = await getDocs(q);
      const all = snap.docs.map(d => ({ id: d.id, ...d.data() }));

      // Access Level Checker
      const hasAccess = (record) => {
        const level = record.accessLevel || 'all';
        if (level === 'all') return true;

        if (level === 'super_admin_only') return isSuperAdmin;
        if (level === 'state_admin_only') return isStateAdmin;
        if (level === 'range_admin_only') return isRangeAdmin;
        if (level === 'district_admin_only') return isDistrictAdmin;
        if (level === 'unit_admin_only') return isUnitAdmin;

        if (level === 'state_admin_plus') return isStateAdmin || isSuperAdmin;
        if (level === 'range_admin_plus') return isRangeAdmin || isStateAdmin || isSuperAdmin;
        if (level === 'district_admin_plus') return isDistrictAdmin || isRangeAdmin || isStateAdmin || isSuperAdmin;
        if (level === 'unit_admin_plus') return isUnitAdmin || isDistrictAdmin || isRangeAdmin || isStateAdmin || isSuperAdmin;

        return true;
      };

      const data = all.filter(hasAccess);
      data.sort((a, b) => (a.displayOrder || 0) - (b.displayOrder || 0));
      setMasterRanks(data);
    } catch (err) {
      if (import.meta.env.DEV) console.error('Failed to load ranks:', err);
    }
  }

  async function loadCategories() {
    try {
      const q = query(collection(db, 'unitCategories'));
      const snap = await getDocs(q);
      setUnitCategories(snap.docs.map(d => d.data().name));
    } catch (err) {
      if (import.meta.env.DEV) console.error('Failed to load categories:', err);
    }
  }

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
          // Do not load units here because unitType is not selected yet
        }

        // For Unit Admin, everything is fixed except Sub-Unit
        if (user?.unitId) {
          setHierFilters(p => ({ ...p, unitId: user.unitId }));
          if (isUnitAdmin) loadSubUnits(user.unitId, user.districtId);
        }
      }
    }
  }

  // Consolidation of hierarchy loading logic to avoid cascading effects (M10)
  async function handleHierChange(field, value) {
    const nextFilters = { ...hierFilters, [field]: value };
    
    // Clear downstream filters
    if (field === 'stateId') {
      nextFilters.rangeId = ''; nextFilters.districtId = ''; nextFilters.unitType = ''; nextFilters.unitId = ''; nextFilters.subUnitId = '';
      if (value) loadRanges(value); else setRanges([]);
      setDistricts([]); setUnits([]); setSubUnits([]);
    } else if (field === 'rangeId') {
      nextFilters.districtId = ''; nextFilters.unitType = ''; nextFilters.unitId = ''; nextFilters.subUnitId = '';
      if (value) loadDistricts(value); else setDistricts([]);
      setUnits([]); setSubUnits([]);
    } else if (field === 'districtId') {
      nextFilters.unitType = ''; nextFilters.unitId = ''; nextFilters.subUnitId = '';
      setUnits([]);
      setSubUnits([]);
    } else if (field === 'unitType') {
      nextFilters.unitId = ''; nextFilters.subUnitId = '';
      if (nextFilters.districtId && value) {
        loadUnits(nextFilters.districtId, value);
      } else {
        setUnits([]);
      }
      setSubUnits([]);
    } else if (field === 'unitId') {
      nextFilters.subUnitId = '';
      if (value && nextFilters.districtId) {
        loadSubUnits(value, nextFilters.districtId);
      } else {
        setSubUnits([]);
      }
    }
    
    setHierFilters(nextFilters);
  }

  async function loadRanges(stateId) {
    const q = query(collection(db, 'ranges'), where('stateId', '==', stateId));
    const snap = await getDocs(q);
    setRanges(snap.docs.map(d => ({ id: d.id, ...d.data() })));
  }

  async function loadDistricts(rangeId) {
    const q = query(collection(db, 'districts'), where('rangeId', '==', rangeId));
    const snap = await getDocs(q);
    setDistricts(snap.docs.map(d => ({ id: d.id, ...d.data() })));
  }

  async function loadUnits(districtId, unitType) {
    if (!districtId || !unitType) return;
    const q = query(collection(db, 'units'), where('districtId', '==', districtId), where('unitType', '==', unitType));
    const snap = await getDocs(q);
    const loadedUnits = snap.docs.map(d => ({ id: d.id, ...d.data() }));
    setUnits(loadedUnits);
  }

  async function loadSubUnits(unitId, districtId) {
    if (!unitId || !districtId) return;
    const q = query(collection(db, 'subUnits'), where('unitId', '==', unitId), where('districtId', '==', districtId));
    const snap = await getDocs(q);
    setSubUnits(snap.docs.map(d => ({ id: d.id, ...d.data() })));
  }

  async function loadPersonnel() {
    try {
      setLoading(true);
      const personnelRef = collection(db, 'personnel');
      let constraints = [where('isDeleted', '==', false)];

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

      // Note: Ideally we would do more server-side filtering and pagination here
      // But adding multiple where clauses Requires manual Index creation in Firebase.
      // For this phase, we fetch the scoped set and filter/paginate in memory to ensure
      // the app remains functional without immediate Index management.
      const q = query(personnelRef, ...constraints);
      const snap = await getDocs(q);
      const data = snap.docs.map(d => ({ id: d.id, ...d.data() }));
      setPersonnel(data);
    } catch (e) {
      if (import.meta.env.DEV) console.error('Personnel load error:', e);
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

  // Soft-delete: mark record as deleted instead of removing
  const canDelete = isSuperAdmin || isStateAdmin || isDistrictAdmin;

  async function handleDelete(person) {
    if (!canDelete) {
      toast.error('You do not have permission to delete records.');
      return;
    }
    try {
      await updateDoc(doc(db, 'personnel', person.id), {
        isDeleted: true,
        deletedAt: serverTimestamp(),
        deletedBy: user.uid,
      });
      toast.success(`${person.fullName} has been removed.`);
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
              {masterRanks.map(r => (
                <option key={r.id} value={r.value}>{r.value}</option>
              ))}
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
            {/* State Selection */}
            {!isSuperAdmin ? (
              <input className="form-input form-input-sm" disabled value={user?.stateName || 'Haryana'} title="Auto-filled from your hierarchy" />
            ) : (
              <select className="form-select form-select-sm" 
                value={hierFilters.stateId} 
                onChange={e => handleHierChange('stateId', e.target.value)}>
                <option value="">All States</option>
                {states.map(s => <option key={s.id} value={s.id}>{s.stateName}</option>)}
              </select>
            )}

            {/* Range Selection */}
            {!isSuperAdmin && !isStateAdmin ? (
              <input className="form-input form-input-sm" disabled value={user?.rangeName || 'Locked Range'} title="Auto-filled from your hierarchy" />
            ) : (
              <select className="form-select form-select-sm" 
                value={hierFilters.rangeId} disabled={!hierFilters.stateId}
                onChange={e => handleHierChange('rangeId', e.target.value)}>
                <option value="">All Ranges</option>
                {ranges.map(r => <option key={r.id} value={r.id}>{r.rangeName}</option>)}
              </select>
            )}

            {/* District Selection */}
            {!isSuperAdmin && !isStateAdmin && !isRangeAdmin ? (
              <input className="form-input form-input-sm" disabled value={user?.districtName || 'Locked District'} title="Auto-filled from your hierarchy" />
            ) : (
              <select className="form-select form-select-sm" 
                value={hierFilters.districtId} disabled={!hierFilters.rangeId}
                onChange={e => handleHierChange('districtId', e.target.value)}>
                <option value="">All Districts</option>
                {districts.map(d => <option key={d.id} value={d.id}>{d.districtName}</option>)}
              </select>
            )}

            {/* Unit Category Selection */}
            {!isSuperAdmin && !isStateAdmin && !isRangeAdmin && !isDistrictAdmin ? (
              <input className="form-input form-input-sm" disabled value="Fixed Category" title="Auto-filled from your hierarchy" />
            ) : (
              <select className="form-select form-select-sm" 
                value={hierFilters.unitType} disabled={!hierFilters.districtId}
                onChange={e => handleHierChange('unitType', e.target.value)}>
                <option value="">All Categories</option>
                {unitCategories.map(c => <option key={c} value={c}>{c}</option>)}
              </select>
            )}

            {/* Unit Selection */}
            {!isSuperAdmin && !isStateAdmin && !isRangeAdmin && !isDistrictAdmin ? (
              <input className="form-input form-input-sm" disabled value={user?.unitName || 'Locked Unit'} title="Auto-filled from your hierarchy" />
            ) : (
              <select className="form-select form-select-sm" 
                value={hierFilters.unitId} disabled={!hierFilters.districtId || !hierFilters.unitType}
                onChange={e => handleHierChange('unitId', e.target.value)}>
                <option value="">{units.length === 0 && hierFilters.unitType ? 'No units available' : 'All Units'}</option>
                {units.map(u => <option key={u.id} value={u.id}>{u.unitName}</option>)}
              </select>
            )}

            {/* Sub-Unit Selection - Visible for all */}
            <select className="form-select form-select-sm" 
              value={hierFilters.subUnitId} disabled={!hierFilters.unitId}
              onChange={e => handleHierChange('subUnitId', e.target.value)}>
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
                        {canDelete && (
                          <button className="btn btn-ghost btn-icon btn-sm" title="Delete"
                            onClick={() => setDeleteModal(p)}
                            style={{ color: 'var(--danger-500)' }}>
                            <Trash2 size={15} />
                          </button>
                        )}
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
              {(() => {
                // Sliding window pagination
                let startPage = Math.max(1, currentPage - 2);
                let endPage = Math.min(totalPages, startPage + 4);
                if (endPage - startPage < 4) startPage = Math.max(1, endPage - 4);
                const pages = [];
                for (let p = startPage; p <= endPage; p++) pages.push(p);
                return pages.map(page => (
                  <button key={page}
                    className={`pagination-btn ${currentPage === page ? 'active' : ''}`}
                    onClick={() => setCurrentPage(page)}>
                    {page}
                  </button>
                ));
              })()}
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
