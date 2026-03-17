import React, { useState, useEffect } from 'react';
import { useAuth } from '../../contexts/AuthContext';
import { useToast } from '../../contexts/ToastContext';
import { db } from '../../firebase';
import {
  collection, query, where, getDocs, doc, setDoc, updateDoc,
  deleteDoc, serverTimestamp
} from 'firebase/firestore';
import {
  Plus, Edit, Trash2, Building2, ChevronDown, ChevronRight,
  MapPin, X, AlertTriangle, Check
} from 'lucide-react';

const FIXED_CATEGORIES = [
  "Police Stations",
  "Traffic",
  "Special Staffs",
  "Court",
  "Administrative Units",
  "Security",
  "Temp_Dep_Trg"
];

export default function UnitSetup() {
  const { user, isSuperAdmin, isStateAdmin, isDistrictAdmin } = useAuth();
  const toast = useToast();

  const [units, setUnits] = useState([]);
  const [subUnits, setSubUnits] = useState({});
  const [expandedUnit, setExpandedUnit] = useState(null);
  const [expandedCategories, setExpandedCategories] = useState({});
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);

  // Hierarchy Explorer States
  const [explorerRange, setExplorerRange] = useState('');
  const [explorerDistrict, setExplorerDistrict] = useState('');

  // Modal states
  const [showUnitModal, setShowUnitModal] = useState(false);
  const [editingUnit, setEditingUnit] = useState(null);
  const [showSubUnitModal, setShowSubUnitModal] = useState(false);
  const [editingSubUnit, setEditingSubUnit] = useState(null);
  const [deleteModal, setDeleteModal] = useState(null);
  const [subUnitParentId, setSubUnitParentId] = useState(null);

  // Form states
  const [unitForm, setUnitForm] = useState({ 
    unitName: '', 
    unitType: '', 
    sanctionedStrength: '',
    stateId: '',
    rangeId: '',
    districtId: '',
    createSubUnit: false,
    initialSubUnitName: ''
  });
  const [subUnitForm, setSubUnitForm] = useState({ subUnitName: '' });

  // Hierarchy Data
  const [states, setStates] = useState([]);
  const [ranges, setRanges] = useState([]);
  const [districts, setDistricts] = useState([]);

  useEffect(() => {
    if (user?.stateId) {
      loadRanges(user.stateId);
    }
  }, [user]);

  async function loadRanges(stateId) {
    try {
      const q = query(collection(db, 'ranges'), where('stateId', '==', stateId));
      const snap = await getDocs(q);
      setRanges(snap.docs.map(d => ({ id: d.id, ...d.data() })));
    } catch (err) {
      toast.error('Failed to load ranges.');
    }
  }

  useEffect(() => {
    const rId = unitForm.rangeId || explorerRange;
    if (rId) {
      loadDistricts(rId);
    }
  }, [unitForm.rangeId, explorerRange]);

  async function loadDistricts(rangeId) {
    try {
      const q = query(collection(db, 'districts'), where('rangeId', '==', rangeId));
      const snap = await getDocs(q);
      const data = snap.docs.map(d => ({ id: d.id, ...d.data() }));
      setDistricts(data);
    } catch (err) {
      toast.error('Failed to load districts.');
    }
  }

  useEffect(() => { loadUnits(); }, [explorerDistrict, user]);

  async function loadUnits() {
    try {
      setLoading(true);
      const unitsRef = collection(db, 'units');
      let q;
      
      if (explorerDistrict) {
        q = query(unitsRef, where('districtId', '==', explorerDistrict));
      } else if (isDistrictAdmin && user.districtId) {
        q = query(unitsRef, where('districtId', '==', user.districtId));
      } else {
        // If state admin hasn't picked a district yet, show none or a message
        setUnits([]);
        setLoading(false);
        return;
      }

      const snap = await getDocs(q);
      setUnits(snap.docs.map(d => ({ id: d.id, ...d.data() })));
    } catch (err) {
      toast.error('Failed to load units.');
    } finally {
      setLoading(false);
    }
  }

  async function loadSubUnits(unitId) {
    try {
      const subRef = collection(db, 'subUnits');
      const q = query(subRef, where('unitId', '==', unitId));
      const snap = await getDocs(q);
      setSubUnits(prev => ({
        ...prev,
        [unitId]: snap.docs.map(d => ({ id: d.id, ...d.data() })),
      }));
    } catch (err) {
      toast.error('Failed to load sub-units.');
    }
  }

  function toggleExpand(unitId) {
    if (expandedUnit === unitId) {
      setExpandedUnit(null);
    } else {
      setExpandedUnit(unitId);
      if (!subUnits[unitId]) loadSubUnits(unitId);
    }
  }

  function toggleCategory(category) {
    setExpandedCategories(prev => ({
      ...prev,
      [category]: !prev[category]
    }));
  }

  // Unit CRUD
  function openUnitModal(category = '', unit = null) {
    setEditingUnit(unit);
    setUnitForm(unit ? {
      unitName: unit.unitName || '',
      unitType: unit.unitType || '',
      sanctionedStrength: unit.sanctionedStrength || '',
      stateId: unit.stateId || '',
      rangeId: unit.rangeId || '',
      districtId: unit.districtId || '',
      createSubUnit: false,
      initialSubUnitName: ''
    } : { 
      unitName: '', 
      unitType: category, 
      sanctionedStrength: '',
      stateId: user.stateId || '',
      rangeId: explorerRange || '',
      districtId: explorerDistrict || '',
      createSubUnit: false,
      initialSubUnitName: ''
    });
    setShowUnitModal(true);
  }

  async function saveUnit() {
    if (!isStateAdmin || isSuperAdmin) {
      toast.error('Only State Admins can create or edit Units.');
      return;
    }

    if (!unitForm.unitName.trim()) {
      toast.warning('Unit Name is required.');
      return;
    }
    if (!unitForm.rangeId || !unitForm.districtId) {
      toast.warning('Range and District are required.');
      return;
    }

    try {
      // Duplicate check (only on creation)
      if (!editingUnit) {
        const isDuplicate = units.some(u => 
          u.unitName.trim().toLowerCase() === unitForm.unitName.trim().toLowerCase() &&
          u.districtId === unitForm.districtId
        );
        if (isDuplicate) {
          toast.warning('A unit with this name already exists in this district.');
          return;
        }
      }

      setSaving(true);
      if (editingUnit) {
        await updateDoc(doc(db, 'units', editingUnit.id), {
          unitName: unitForm.unitName.trim(),
          unitType: unitForm.unitType,
          sanctionedStrength: parseInt(unitForm.sanctionedStrength) || 0,
          rangeId: unitForm.rangeId,
          districtId: unitForm.districtId,
          updatedAt: serverTimestamp(),
        });
        toast.success('Unit updated successfully.');
      } else {
        const newRef = doc(collection(db, 'units'));
        await setDoc(newRef, {
          unitId: newRef.id,
          stateId: user.stateId,
          rangeId: unitForm.rangeId,
          districtId: unitForm.districtId,
          unitName: unitForm.unitName.trim(),
          unitType: unitForm.unitType,
          sanctionedStrength: parseInt(unitForm.sanctionedStrength) || 0,
          createdAt: serverTimestamp(),
        });

        if (unitForm.createSubUnit && unitForm.initialSubUnitName.trim()) {
          const subRef = doc(collection(db, 'subUnits'));
          await setDoc(subRef, {
            subUnitId: subRef.id,
            unitId: newRef.id,
            stateId: user.stateId,
            rangeId: unitForm.rangeId,
            districtId: unitForm.districtId,
            subUnitName: unitForm.initialSubUnitName.trim(),
            createdAt: serverTimestamp(),
          });
        }
        
        toast.success('Unit created successfully.');
      }
      setShowUnitModal(false);
      loadUnits();
    } catch (err) {
      toast.error('Failed to save unit.');
    } finally {
      setSaving(false);
    }
  }

  function openSubUnitEdit(subUnit, unitId) {
    setSubUnitParentId(unitId);
    setEditingSubUnit(subUnit);
    setSubUnitForm({ subUnitName: subUnit.subUnitName || '' });
    setShowSubUnitModal(true);
  }

  function openSubUnitAdd(unitId) {
    setSubUnitParentId(unitId);
    setEditingSubUnit(null);
    setSubUnitForm({ subUnitName: '' });
    setShowSubUnitModal(true);
  }

  async function saveSubUnit() {
    if (!isStateAdmin || isSuperAdmin) {
      toast.error('Only State Admins can create or edit Sub-Units.');
      return;
    }

    if (!subUnitForm.subUnitName.trim()) {
      toast.warning('Sub-Unit Name is required.');
      return;
    }

    try {
      // Duplicate check
      const currentSubUnits = subUnits[subUnitParentId] || [];
      const isDuplicate = currentSubUnits.some(su => 
        su.subUnitName.trim().toLowerCase() === subUnitForm.subUnitName.trim().toLowerCase() &&
        su.id !== editingSubUnit?.id
      );

      if (isDuplicate) {
        toast.warning('A sub-unit with this name already exists in this unit.');
        return;
      }

      setSaving(true);
      const parentUnit = units.find(u => u.id === subUnitParentId);
      if (editingSubUnit) {
        await updateDoc(doc(db, 'subUnits', editingSubUnit.id), {
          subUnitName: subUnitForm.subUnitName.trim(),
          updatedAt: serverTimestamp(),
        });
        toast.success('Sub-Unit updated.');
      } else {
        const newRef = doc(collection(db, 'subUnits'));
        await setDoc(newRef, {
          subUnitId: newRef.id,
          unitId: subUnitParentId,
          stateId: parentUnit?.stateId || user.stateId,
          rangeId: parentUnit?.rangeId || '',
          districtId: parentUnit?.districtId || '',
          subUnitName: subUnitForm.subUnitName.trim(),
          createdAt: serverTimestamp(),
        });
        toast.success('Sub-Unit created.');
      }
      setShowSubUnitModal(false);
      loadSubUnits(subUnitParentId);
    } catch (err) {
      toast.error('Failed to save sub-unit.');
    } finally {
      setSaving(false);
    }
  }

  async function handleDelete() {
    if (!deleteModal) return;
    if (!isStateAdmin || isSuperAdmin) {
      toast.error('Only State Admins can delete hierarchy records.');
      return;
    }
    
    try {
      setSaving(true);
      await deleteDoc(doc(db, deleteModal.collection, deleteModal.id));
      toast.success(`${deleteModal.type} deleted.`);
      setDeleteModal(null);
      if (deleteModal.type === 'Unit') {
        loadUnits();
      } else {
        loadSubUnits(deleteModal.parentId);
      }
    } catch (err) {
      toast.error(`Failed to delete ${deleteModal.type}.`);
    } finally {
      setSaving(false);
    }
  }

  const getGroupedUnits = () => {
    const groups = {};
    FIXED_CATEGORIES.forEach(cat => groups[cat] = []);
    units.forEach(unit => {
      const type = unit.unitType;
      if (groups[type]) {
        groups[type].push(unit);
      } else {
        // Handle legacy or mis-typed units
        if (!groups['Administrative Units']) groups['Administrative Units'] = [];
        groups['Administrative Units'].push(unit);
      }
    });
    return groups;
  };

  const groupedUnits = getGroupedUnits();

  return (
    <div className="unit-setup">
      <div className="page-header">
        <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
          <Building2 size={24} className="text-primary" />
          <h2>Administrative Hierarchy</h2>
        </div>
      </div>

      {/* Hierarchy Master Explorer */}
      <div className="panel mb-4">
        <div className="panel-header">
          <h3>Hierarchy Master</h3>
        </div>
        <div className="panel-body" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '20px' }}>
          <div className="form-group">
            <label className="form-label">Range</label>
            <select className="form-select" value={explorerRange} 
              onChange={e => { setExplorerRange(e.target.value); setExplorerDistrict(''); }}>
              <option value="">Select Range</option>
              {ranges.map(r => <option key={r.id} value={r.id}>{r.rangeName}</option>)}
            </select>
          </div>
          <div className="form-group">
            <label className="form-label">District</label>
            <select className="form-select" value={explorerDistrict} disabled={!explorerRange}
              onChange={e => setExplorerDistrict(e.target.value)}>
              <option value="">Select District</option>
              {districts.map(d => <option key={d.id} value={d.id}>{d.districtName}</option>)}
            </select>
          </div>
        </div>
      </div>

      <div className="units-list">
        {!explorerDistrict ? (
          <div className="empty-state panel">
            <MapPin size={40} className="icon text-gray-300" />
            <p>Please select a <strong>Range</strong> and <strong>District</strong> to manage units.</p>
          </div>
        ) : loading ? (
          <div className="empty-state">
            <div className="spinner spinner-lg"></div>
            <p>Loading units for this district...</p>
          </div>
        ) : (
          FIXED_CATEGORIES.map(category => (
            <div key={category} className="panel mb-4 overflow-hidden">
              <div 
                className="panel-header" 
                style={{ 
                  background: 'var(--gray-50)', 
                  cursor: 'pointer',
                  borderBottom: expandedCategories[category] ? '1px solid var(--gray-200)' : 'none' 
                }}
                onClick={() => toggleCategory(category)}
              >
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px', flex: 1 }}>
                  {expandedCategories[category] ? <ChevronDown size={20} /> : <ChevronRight size={20} />}
                  <h3 style={{ margin: 0, color: 'var(--gray-700)' }}>
                    {category}
                    <span className="badge badge-info ml-2">{groupedUnits[category].length}</span>
                  </h3>
                </div>
                {isStateAdmin && (
                  <button className="btn btn-primary btn-sm" onClick={(e) => { e.stopPropagation(); openUnitModal(category); }}>
                    <Plus size={14} /> Add Unit
                  </button>
                )}
              </div>
              
              {expandedCategories[category] && (
                <div className="table-container">
                  {groupedUnits[category].length === 0 ? (
                    <p style={{ padding: '20px', textAlign: 'center', color: 'var(--gray-400)', fontSize: '0.9rem' }}>
                      No units created in this category yet.
                    </p>
                  ) : (
                    <table className="data-table">
                      <thead>
                        <tr>
                          <th style={{ width: 40 }}></th>
                          <th>Unit Name</th>
                          <th>Strength</th>
                          <th>Sub-Units</th>
                          <th style={{ textAlign: 'right' }}>Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        {groupedUnits[category].map(unit => (
                          <React.Fragment key={unit.id}>
                            <tr>
                              <td>
                                <button className="btn btn-ghost btn-icon btn-sm"
                                  onClick={() => toggleExpand(unit.id)}>
                                  {expandedUnit === unit.id ? <ChevronDown size={16} /> : <ChevronRight size={16} />}
                                </button>
                              </td>
                              <td style={{ fontWeight: 600 }}>{unit.unitName}</td>
                              <td>{unit.sanctionedStrength || '—'}</td>
                              <td>{subUnits[unit.id]?.length ?? '—'}</td>
                              <td>
                                <div className="actions">
                                  {isStateAdmin && (
                                    <>
                                      <button className="btn btn-ghost btn-sm" title="Add Sub-Unit"
                                        onClick={() => openSubUnitAdd(unit.id)}>
                                        <Plus size={14} /> Sub-Unit
                                      </button>
                                      <button className="btn btn-ghost btn-icon btn-sm" title="Edit"
                                        onClick={() => openUnitModal(category, unit)}>
                                        <Edit size={15} />
                                      </button>
                                      <button className="btn btn-ghost btn-icon btn-sm" title="Delete"
                                        onClick={() => setDeleteModal({ id: unit.id, collection: 'units', type: 'Unit', name: unit.unitName })}
                                        style={{ color: 'var(--danger-500)' }}>
                                        <Trash2 size={15} />
                                      </button>
                                    </>
                                  )}
                                </div>
                              </td>
                            </tr>
                            {expandedUnit === unit.id && (
                              <tr key={`sub-${unit.id}`}>
                                <td colSpan={5} style={{ padding: 0, background: 'var(--gray-50)' }}>
                                  <div style={{ padding: '12px 20px 12px 60px' }}>
                                    {!subUnits[unit.id] ? (
                                      <span style={{ color: 'var(--gray-400)' }}>Loading...</span>
                                    ) : subUnits[unit.id].length === 0 ? (
                                      <span style={{ color: 'var(--gray-400)' }}>No sub-units.</span>
                                    ) : (
                                      <table className="data-table" style={{ fontSize: '0.8rem' }}>
                                        <thead>
                                          <tr>
                                            <th>Sub-Unit Name</th>
                                            <th style={{ textAlign: 'right' }}>Actions</th>
                                          </tr>
                                        </thead>
                                        <tbody>
                                          {subUnits[unit.id].map(su => (
                                            <tr key={su.id}>
                                              <td>
                                                <MapPin size={14} style={{ display: 'inline', marginRight: 6, color: 'var(--primary-400)' }} />
                                                {su.subUnitName}
                                              </td>
                                              <td>
                                                <div className="actions">
                                                  {isStateAdmin && (
                                                    <>
                                                      <button className="btn btn-ghost btn-icon btn-sm"
                                                        onClick={() => openSubUnitEdit(su, unit.id)}>
                                                        <Edit size={14} />
                                                      </button>
                                                      <button className="btn btn-ghost btn-icon btn-sm"
                                                        onClick={() => setDeleteModal({ id: su.id, collection: 'subUnits', type: 'Sub-Unit', name: su.subUnitName, parentId: unit.id })}
                                                        style={{ color: 'var(--danger-500)' }}>
                                                        <Trash2 size={14} />
                                                      </button>
                                                    </>
                                                  )}
                                                </div>
                                              </td>
                                            </tr>
                                          ))}
                                        </tbody>
                                      </table>
                                    )}
                                  </div>
                                </td>
                              </tr>
                            )}
                          </React.Fragment>
                        ))}
                      </tbody>
                    </table>
                  )}
                </div>
              )}
            </div>
          ))
        )}
      </div>

      {/* Unit Create/Edit Modal */}
      {showUnitModal && (
        <div className="modal-overlay" onClick={() => setShowUnitModal(false)}>
          <div className="modal" onClick={e => e.stopPropagation()} style={{ maxWidth: 500 }}>
            <div className="modal-header">
              <h3>{editingUnit ? 'Edit Unit' : 'Add New Unit'}</h3>
              <p className="text-sm text-gray-500">{unitForm.unitType}</p>
            </div>
            <div className="modal-body">
              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '15px', marginBottom: '15px' }}>
                <div className="form-group" style={{ gridColumn: 'span 2' }}>
                  <label className="form-label">Unit Name <span className="required">*</span></label>
                  <input className="form-input" value={unitForm.unitName}
                    onChange={e => setUnitForm(prev => ({ ...prev, unitName: e.target.value }))}
                    placeholder="e.g. City Police Station" autoFocus />
                </div>
                
                <div className="form-group">
                  <label className="form-label">Range</label>
                  <select className="form-select" value={unitForm.rangeId} 
                    onChange={e => setUnitForm(prev => ({ ...prev, rangeId: e.target.value, districtId: '' }))}>
                    <option value="">Select Range</option>
                    {ranges.map(r => <option key={r.id} value={r.id}>{r.rangeName}</option>)}
                  </select>
                </div>

                <div className="form-group">
                  <label className="form-label">District</label>
                  <select className="form-select" value={unitForm.districtId} disabled={!unitForm.rangeId}
                    onChange={e => setUnitForm(prev => ({ ...prev, districtId: e.target.value }))}>
                    <option value="">Select District</option>
                    {districts.map(d => <option key={d.id} value={d.id}>{d.districtName}</option>)}
                  </select>
                </div>

                <div className="form-group">
                  <label className="form-label">Sanctioned Strength</label>
                  <input className="form-input" type="number" value={unitForm.sanctionedStrength}
                    onChange={e => setUnitForm(prev => ({ ...prev, sanctionedStrength: e.target.value }))}
                    placeholder="0" min="0" />
                </div>
              </div>

              {!editingUnit && (
                <div className="pt-3 border-t">
                  <label className="checkbox-container">
                    <input type="checkbox" checked={unitForm.createSubUnit} 
                      onChange={e => setUnitForm(prev => ({ ...prev, createSubUnit: e.target.checked }))} />
                    <span className="checkbox-label">Create a Sub-Unit immediately?</span>
                  </label>
                  
                  {unitForm.createSubUnit && (
                    <div className="form-group mt-2">
                      <label className="form-label">Sub-Unit Name</label>
                      <input className="form-input" value={unitForm.initialSubUnitName}
                        onChange={e => setUnitForm(prev => ({ ...prev, initialSubUnitName: e.target.value }))}
                        placeholder="e.g. Beat 1" />
                    </div>
                  )}
                </div>
              )}
            </div>
            <div className="modal-footer">
              <button className="btn btn-secondary" onClick={() => setShowUnitModal(false)} disabled={saving}>Cancel</button>
              <button className="btn btn-primary" onClick={saveUnit} disabled={saving}>
                {saving ? (
                  <>
                    <div className="spinner spinner-sm mr-2" />
                    Saving...
                  </>
                ) : (
                  <>
                    <Check size={16} className="mr-2" />
                    {editingUnit ? 'Update' : 'Create'} Unit
                  </>
                )}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* SubUnit Create/Edit Modal */}
      {showSubUnitModal && (
        <div className="modal-overlay" onClick={() => setShowSubUnitModal(false)}>
          <div className="modal" onClick={e => e.stopPropagation()} style={{ maxWidth: 400 }}>
            <div className="modal-header">
              <h3>{editingSubUnit ? 'Edit Sub-Unit' : 'Add New Sub-Unit'}</h3>
            </div>
            <div className="modal-body">
              <div className="form-group">
                <label className="form-label">Sub-Unit Name <span className="required">*</span></label>
                <input className="form-input" value={subUnitForm.subUnitName}
                  onChange={e => setSubUnitForm({ subUnitName: e.target.value })}
                  placeholder="e.g. Desk 1" autoFocus />
              </div>
            </div>
            <div className="modal-footer">
              <button className="btn btn-secondary" onClick={() => setShowSubUnitModal(false)} disabled={saving}>Cancel</button>
              <button className="btn btn-primary" onClick={saveSubUnit} disabled={saving}>
                {saving ? (
                  <>
                    <div className="spinner spinner-sm mr-2" />
                    Saving...
                  </>
                ) : (
                  <>
                    <Check size={16} className="mr-2" />
                    Save
                  </>
                )}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Delete Confirmation */}
      {deleteModal && (
        <div className="modal-overlay" onClick={() => setDeleteModal(null)}>
          <div className="modal" onClick={e => e.stopPropagation()} style={{ maxWidth: 400 }}>
            <div className="modal-body">
              <div className="confirm-dialog">
                <div className="icon danger"><Trash2 size={24} /></div>
                <h4>Delete {deleteModal.type}?</h4>
                <p>Delete <strong>{deleteModal.name}</strong>? This cannot be undone.</p>
              </div>
            </div>
            <div className="modal-footer" style={{ justifyContent: 'center' }}>
              <button className="btn btn-secondary" onClick={() => setDeleteModal(null)} disabled={saving}>Cancel</button>
              <button className="btn btn-danger" onClick={handleDelete} disabled={saving}>
                {saving ? 'Deleting...' : 'Delete'}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
