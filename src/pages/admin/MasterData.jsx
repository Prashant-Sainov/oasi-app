import React, { useState, useEffect, useMemo } from 'react';
import { useAuth } from '../../contexts/AuthContext';
import { useToast } from '../../contexts/ToastContext';
import { db } from '../../firebase';
import {
  collection, query, where, getDocs, doc, setDoc, updateDoc, deleteDoc,
  serverTimestamp, orderBy, getCountFromServer, limit
} from 'firebase/firestore';
import {
  Database, Plus, Edit, Trash2, Check, X, Search,
  ChevronDown, Tag, ToggleLeft, ToggleRight, MoreVertical
} from 'lucide-react';

const ACCESS_LEVEL_LABELS = {
  all: 'All Roles',
  super_admin_only: 'Super Admin (Only)',
  state_admin_only: 'State Admin (Only)',
  range_admin_only: 'Range Admin (Only)',
  district_admin_only: 'District Admin (Only)',
  unit_admin_only: 'Unit Admin (Only)',
  state_admin_plus: 'State Admin & Above',
  range_admin_plus: 'Range Admin & Above',
  district_admin_plus: 'District Admin & Above',
  unit_admin_plus: 'Unit Admin & Above',
};

export default function MasterData() {
  const { user, isSuperAdmin, isStateAdmin } = useAuth();
  const toast = useToast();
  const canEdit = isStateAdmin || isSuperAdmin;

  const [activeTab, setActiveTab] = useState('');
  const [masterFields, setMasterFields] = useState([]);
  const [records, setRecords] = useState([]);
  const [loading, setLoading] = useState(true); // Overall initial loading
  const [recordsLoading, setRecordsLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');

  // Field Type Management
  const [showFieldTypeModal, setShowFieldTypeModal] = useState(false);
  const [editingFieldType, setEditingFieldType] = useState(null); // When editing a meta-field
  const [newFieldType, setNewFieldType] = useState({ 
    displayName: '', 
    fieldName: '', 
    personnelFieldName: '', 
    helperExample: 'Value1, Value2, Value3',
    description: '' 
  });
  const [activeMenu, setActiveMenu] = useState(null); // { id: string, top: number, left: number, openUp: boolean }


  // Comma-based multi-entry
  const [bulkInput, setBulkInput] = useState('');
  const [previewTags, setPreviewTags] = useState([]);
  const [showBulkEntry, setShowBulkEntry] = useState(false);

  // Edit modal
  const [editingRecord, setEditingRecord] = useState(null);
  const [editForm, setEditForm] = useState({ value: '', displayOrder: 0, accessLevel: 'all' });

  // Confirmation/Usage Modals
  const [confirmModal, setConfirmModal] = useState(null); // { title: '', message: '', onConfirm: fn, type: 'delete|save|deactivate' }

  useEffect(() => {
    loadFields();
  }, [user]);

  useEffect(() => {
    if (activeTab) {
      loadRecords();
      setSearchTerm('');
      setBulkInput('');
      setPreviewTags([]);
      setShowBulkEntry(false);
    }
  }, [activeTab, user]);

  async function loadFields() {
    if (!user?.stateId) return;
    try {
      setLoading(true);
      const q = query(
        collection(db, 'masterDataFields'),
        where('stateId', '==', user.stateId)
      );
      const snap = await getDocs(q);
      const data = snap.docs.map(d => ({ id: d.id, ...d.data() }));
      setMasterFields(data);
      if (data.length > 0) {
        if (!activeTab) setActiveTab(data[0].fieldName);
      } else {
        setLoading(false); // No fields, so loading is "done"
      }
    } catch (err) {
      toast.error('Failed to load field types.');
      setLoading(false);
    }
  }

  async function loadRecords() {
    if (!user?.stateId || !activeTab) {
      setRecordsLoading(false);
      return;
    }
    try {
      setRecordsLoading(true);
      const q = query(
        collection(db, 'masterData'),
        where('fieldType', '==', activeTab),
        where('stateId', '==', user.stateId)
      );
      const snap = await getDocs(q);
      const data = snap.docs.map(d => ({ id: d.id, ...d.data() }));
      data.sort((a, b) => (a.displayOrder || 0) - (b.displayOrder || 0));
      setRecords(data);
    } catch (err) {
      toast.error('Failed to load dropdown data.');
    } finally {
      setRecordsLoading(false);
      setLoading(false); // Initial load complete
    }
  }

  // --- Comma-Based Multi-Entry ---
  function processBulkInput(input) {
    const raw = input.split(',')
      .map(v => v.trim())
      .filter(v => v.length > 0);
    // Remove duplicates within input itself
    const unique = [...new Set(raw.map(v => v.toLowerCase()))].map(lower => {
      return raw.find(v => v.toLowerCase() === lower);
    });
    // Check against existing records
    const existingLower = records.filter(r => r.isActive).map(r => r.value.toLowerCase());
    const tags = unique.map(v => ({
      value: v,
      isDuplicate: existingLower.includes(v.toLowerCase())
    }));
    setPreviewTags(tags);
  }

  function handleBulkInputChange(e) {
    const val = e.target.value;
    setBulkInput(val);
    if (val.trim()) {
      processBulkInput(val);
    } else {
      setPreviewTags([]);
    }
  }

  async function saveBulkEntries() {
    const validTags = previewTags.filter(t => !t.isDuplicate);
    if (validTags.length === 0) {
      toast.warning('No new values to add. All entries already exist.');
      return;
    }

    setConfirmModal({
      title: 'Confirm Add Values',
      message: `Are you sure you want to add ${validTags.length} new value(s) to "${masterFields.find(f => f.fieldName === activeTab)?.displayName}"?`,
      onConfirm: async () => {
        try {
          setSaving(true);
          const maxOrder = records.reduce((max, r) => Math.max(max, r.displayOrder || 0), 0);

          for (let i = 0; i < validTags.length; i++) {
            const tag = validTags[i];
            const q = query(
              collection(db, 'masterData'),
              where('fieldType', '==', activeTab),
              where('value', '==', tag.value),
              where('stateId', '==', user.stateId)
            );
            const existing = await getDocs(q);
            if (!existing.empty) continue;

            const newRef = doc(collection(db, 'masterData'));
            await setDoc(newRef, {
              fieldType: activeTab,
              value: tag.value,
              stateId: user.stateId,
              accessLevel: 'all',
              parentValue: null,
              isActive: true,
              displayOrder: maxOrder + i + 1,
              createdAt: serverTimestamp(),
              updatedAt: serverTimestamp(),
            });
          }

          toast.success(`${validTags.length} value(s) added successfully.`);
          setBulkInput('');
          setPreviewTags([]);
          setShowBulkEntry(false);
          loadRecords();
        } catch (err) {
          toast.error('Failed to save entries.');
        } finally {
          setSaving(true); // Temporary to close modal
          setSaving(false);
          setConfirmModal(null);
        }
      }
    });
  }

  // --- Single Record Edit ---
  function openEdit(record) {
    setEditingRecord(record);
    setEditForm({
      value: record.value,
      displayOrder: record.displayOrder || 0,
      accessLevel: record.accessLevel || 'all'
    });
  }

  async function saveEdit() {
    if (!editForm.value.trim()) {
      toast.warning('Value cannot be empty.'); return;
    }
    // Check duplicate (excluding self)
    const isDup = records.some(r =>
      r.id !== editingRecord.id &&
      r.value.toLowerCase() === editForm.value.trim().toLowerCase()
    );
    if (isDup) {
      toast.warning('This value already exists.'); return;
    }
    try {
      setSaving(true);
      await updateDoc(doc(db, 'masterData', editingRecord.id), {
        value: editForm.value.trim(),
        displayOrder: parseInt(editForm.displayOrder) || 0,
        accessLevel: editForm.accessLevel,
        updatedAt: serverTimestamp(),
      });
      toast.success('Record updated.');
      setEditingRecord(null);
      loadRecords();
    } catch (err) {
      toast.error('Failed to update record.');
    } finally {
      setSaving(false);
    }
  }

  // --- Soft Delete (Toggle Active) ---
  async function toggleActive(record) {
    const action = record.isActive ? 'deactivate' : 'activate';
    setConfirmModal({
      title: `Confirm ${action.charAt(0).toUpperCase() + action.slice(1)}`,
      message: `Are you sure you want to ${action} "${record.value}"?`,
      onConfirm: async () => {
        try {
          setSaving(true);
          await updateDoc(doc(db, 'masterData', record.id), {
            isActive: !record.isActive,
            updatedAt: serverTimestamp(),
          });
          toast.success(`${record.value} ${record.isActive ? 'deactivated' : 'activated'}.`);
          loadRecords();
        } catch (err) {
          toast.error('Failed to update status.');
        } finally {
          setSaving(false);
          setConfirmModal(null);
        }
      }
    });
  }

  // --- SAFE DELETION LOGIC ---
  async function checkValueUsage(record) {
    const fieldType = record.fieldType;
    const value = record.value;
    const masterField = masterFields.find(f => f.fieldName === fieldType);
    
    if (!masterField?.personnelFieldName) return false;

    try {
      const q = query(
        collection(db, 'personnel'),
        where(masterField.personnelFieldName, '==', value),
        limit(1)
      );
      const snap = await getDocs(q);
      return !snap.empty;
    } catch (err) {
      console.error('Usage check failed:', err);
      return true; // Fail safe
    }
  }

  async function handleDeleteValue(record) {
    const isUsed = await checkValueUsage(record);
    if (isUsed) {
      setConfirmModal({
        title: 'Cannot Delete Value',
        message: `"${record.value}" is already in use in Personnel records and cannot be deleted. You may deactivate it instead.`,
        type: 'info',
        onConfirm: () => setConfirmModal(null)
      });
      return;
    }

    setConfirmModal({
      title: 'Confirm Permanent Delete',
      message: `Are you sure you want to permanently delete "${record.value}"? This action cannot be undone.`,
      onConfirm: async () => {
        try {
          setSaving(true);
          await deleteDoc(doc(db, 'masterData', record.id));
          toast.success('Record deleted.');
          loadRecords();
        } catch (err) {
          toast.error('Failed to delete record.');
        } finally {
          setSaving(false);
          setConfirmModal(null);
        }
      }
    });
  }

  // --- FIELD TYPE MANAGEMENT ---
  function openEditFieldType(field) {
    setEditingFieldType(field);
    setNewFieldType({
      displayName: field.displayName,
      fieldName: field.fieldName, // Keys shouldn't normally change, but we allow display name edit
      personnelFieldName: field.personnelFieldName || '',
      helperExample: field.helperExample || 'Value1, Value2, Value3',
      isActive: field.isActive !== false
    });
    setShowFieldTypeModal(true);
    setActiveMenu(null);
  }

  async function saveFieldType() {
    if (!newFieldType.displayName || !newFieldType.fieldName) {
      toast.warning('Name and Key are required.'); return;
    }
    const isEdit = !!editingFieldType;
    setConfirmModal({
      title: isEdit ? 'Update Category' : 'Add Field Type',
      message: `${isEdit ? 'Update' : 'Add'} "${newFieldType.displayName}" as a dropdown master category?`,
      onConfirm: async () => {
        try {
          setSaving(true);
          const docId = isEdit ? editingFieldType.id : `${user.stateId}_${newFieldType.fieldName}`;
          await setDoc(doc(db, 'masterDataFields', docId), {
            ...newFieldType,
            stateId: user.stateId,
            updatedAt: serverTimestamp(),
            ...(isEdit ? {} : { createdAt: serverTimestamp() })
          }, { merge: true });

          toast.success(isEdit ? 'Category updated.' : 'Field type added.');
          setShowFieldTypeModal(false);
          setEditingFieldType(null);
          loadFields();
        } catch (err) {
          toast.error('Failed to save category.');
        } finally {
          setSaving(false);
          setConfirmModal(null);
        }
      }
    });
  }

  async function toggleFieldTypeActive(field) {
     const nextState = field.isActive === false; 
     setConfirmModal({
        title: nextState ? 'Activate Category' : 'Deactivate Category',
        message: `Are you sure you want to ${nextState ? 'activate' : 'deactivate'} the "${field.displayName}" category?`,
        onConfirm: async () => {
          try {
            setSaving(true);
            await updateDoc(doc(db, 'masterDataFields', field.id), {
              isActive: nextState,
              updatedAt: serverTimestamp()
            });
            toast.success('Category updated.');
            loadFields();
          } catch (err) {
            toast.error('Failed to update category.');
          } finally {
            setSaving(false);
            setConfirmModal(null);
            setActiveMenu(null);
          }
        }
     });
  }

  function handleMenuClick(e, field) {
    e.stopPropagation();
    if (activeMenu?.id === field.id) {
      setActiveMenu(null);
      return;
    }
    const rect = e.currentTarget.getBoundingClientRect();
    const spaceBelow = window.innerHeight - rect.bottom;
    const menuHeight = 160; // Approximate
    const openUp = spaceBelow < menuHeight;
    
    setActiveMenu({
      id: field.id,
      top: openUp ? rect.top - 8 : rect.bottom + 8,
      left: rect.left,
      openUp
    });
  }

  async function deleteFieldType(field) {
    // Check if any masterData records exist for this type
    const q = query(collection(db, 'masterData'), where('fieldType', '==', field.fieldName), where('stateId', '==', user.stateId));
    const snap = await getDocs(q);
    if (!snap.empty) {
      setConfirmModal({
        title: 'Cannot Delete Tab',
        message: `The "${field.displayName}" category contains values and cannot be deleted. Remove all values first.`,
        type: 'error',
        onConfirm: () => setConfirmModal(null)
      });
      return;
    }

    setConfirmModal({
      title: 'Confirm Delete Tab',
      message: `Are you sure you want to remove the "${field.displayName}" category?`,
      onConfirm: async () => {
        try {
          setSaving(true);
          // In production, we'd delete the doc.id we know
          const docId = `${user.stateId}_${field.fieldName}`;
          // Since we might not be sure of the ID (if it was generated), let's find it.
          const fDoc = masterFields.find(f => f.fieldName === field.fieldName);
          if (fDoc) {
             await deleteDoc(doc(db, 'masterDataFields', fDoc.id));
          }
          toast.success('Tab removed.');
          setActiveTab(masterFields[0]?.fieldName || '');
          loadFields();
        } catch (err) {
          toast.error('Failed to remove tab.');
        } finally {
          setSaving(false);
          setConfirmModal(null);
        }
      }
    });
  }

  // --- Filtered Records ---
  const filteredRecords = useMemo(() => {
    if (!searchTerm) return records;
    return records.filter(r => r.value.toLowerCase().includes(searchTerm.toLowerCase()));
  }, [records, searchTerm]);

  const activeCount = records.filter(r => r.isActive).length;
  const inactiveCount = records.filter(r => !r.isActive).length;

  return (
    <div className="master-data-module">
      <div className="page-header">
        <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
          <Database size={24} className="text-primary" />
          <h2>Dropdown Master Management</h2>
        </div>
        <p className="text-sm text-gray-500" style={{marginTop: 4}}>
          Centralized dropdown values for the entire portal
        </p>
      </div>

      {/* Tab Selector */}
      <div className="panel mb-4">
        <div className="panel-body" style={{ padding: '12px 16px' }}>
          <div style={{
            display: 'flex', flexWrap: 'wrap', gap: '8px', alignItems: 'center'
          }}>
            {masterFields.map(ft => (
              <div key={ft.fieldName} style={{ position: 'relative', display: 'flex', alignItems: 'center' }}>
                <button
                  className={`btn btn-sm ${activeTab === ft.fieldName ? 'btn-primary' : 'btn-secondary'}`}
                  onClick={() => setActiveTab(ft.fieldName)}
                  style={{ 
                    borderRadius: '20px', padding: '6px 16px', 
                    fontWeight: activeTab === ft.fieldName ? 700 : 400,
                    opacity: ft.isActive === false ? 0.6 : 1,
                    display: 'flex', alignItems: 'center', gap: '8px'
                  }}
                >
                  {ft.displayName}
                  {ft.isActive === false && <span style={{fontSize: '0.7rem'}}>(Inactive)</span>}
                  
                  {canEdit && activeTab === ft.fieldName && (
                    <div 
                      onClick={(e) => handleMenuClick(e, ft)}
                      style={{ 
                        padding: '4px 6px', marginLeft: '8px', marginRight: '-10px',
                        display: 'flex', alignItems: 'center', 
                        backgroundColor: '#e6f0ff', color: '#0b3d91',
                        borderRadius: '4px', borderLeft: '1px solid rgba(0,0,0,0.05)',
                        transition: 'all 0.2s'
                      }}
                      className="tab-action-btn"
                    >
                      <MoreVertical size={16} />
                    </div>
                  )}
                </button>

                {/* Tab Menu Dropdown (Smart Positioned) */}
                {activeMenu?.id === ft.id && (
                  <>
                    <div 
                      style={{ position: 'fixed', inset: 0, zIndex: 998, background: 'rgba(0,0,0,0.02)' }} 
                      onClick={() => setActiveMenu(null)}
                    />
                    <div style={{ 
                      position: 'fixed', 
                      top: window.innerWidth < 768 ? 'auto' : activeMenu.top,
                      bottom: window.innerWidth < 768 ? 0 : (activeMenu.openUp ? (window.innerHeight - activeMenu.top) : 'auto'),
                      left: window.innerWidth < 768 ? 0 : activeMenu.left,
                      width: window.innerWidth < 768 ? '100%' : '180px',
                      zIndex: 999, 
                      backgroundColor: '#0b3d91', color: 'white',
                      boxShadow: '0 8px 30px rgba(0,0,0,0.3)',
                      borderRadius: window.innerWidth < 768 ? '16px 16px 0 0' : '8px', 
                      overflow: 'hidden', padding: '8px 0',
                      animation: window.innerWidth < 768 ? 'slideUp 0.3s ease-out' : 'fadeIn 0.2s ease-out',
                      transform: (!activeMenu.openUp || window.innerWidth < 768) ? 'none' : 'translateY(-100%)'
                    }}>
                      <div style={{ padding: '8px 16px', borderBottom: '1px solid rgba(255,255,255,0.1)', marginBottom: '4px', display: window.innerWidth < 768 ? 'block' : 'none' }}>
                         <p style={{ fontWeight: 700, margin: 0 }}>{ft.displayName} Options</p>
                      </div>
                      <button className="dropdown-item-gov" onClick={() => openEditFieldType(ft)}>
                        <Edit size={16} className="mr-3" /> Edit Meta
                      </button>
                      <button className="dropdown-item-gov" onClick={() => toggleFieldTypeActive(ft)}>
                        {ft.isActive === false ? <Check size={16} className="mr-3" /> : <X size={16} className="mr-3" />}
                        {ft.isActive === false ? 'Activate' : 'Deactivate'}
                      </button>
                      <div style={{ height: '1px', background: 'rgba(255,255,255,0.1)', margin: '4px 0' }} />
                      <button className="dropdown-item-gov text-danger-light" onClick={() => { deleteFieldType(ft); setActiveMenu(null); }}>
                        <Trash2 size={16} className="mr-3" /> Delete Tab
                      </button>
                      {window.innerWidth < 768 && (
                        <button className="dropdown-item-gov" style={{textAlign: 'center', marginTop: 8, opacity: 0.8}} onClick={() => setActiveMenu(null)}>
                          Close
                        </button>
                      )}
                    </div>
                  </>
                )}
              </div>
            ))}
            {canEdit && (
              <button 
                className="btn btn-ghost btn-sm" 
                onClick={() => setShowFieldTypeModal(true)}
                style={{ borderRadius: '20px', border: '1px dashed var(--gray-300)' }}
              >
                <Plus size={14} className="mr-1" /> Add Tab
              </button>
            )}
          </div>
        </div>
      </div>

      {/* Stats + Actions Bar */}
      <div className="panel mb-4">
        <div className="panel-body" style={{
          display: 'flex', flexWrap: 'wrap', alignItems: 'center', justifyContent: 'space-between', gap: '12px', padding: '12px 16px'
        }}>
          <div style={{ display: 'flex', gap: '16px', alignItems: 'center' }}>
            <span className="badge badge-success">{activeCount} Active</span>
            {inactiveCount > 0 && <span className="badge badge-warning">{inactiveCount} Inactive</span>}
          </div>
          <div style={{ display: 'flex', gap: '8px', alignItems: 'center' }}>
            <div style={{ position: 'relative' }}>
              <Search size={16} style={{ position: 'absolute', left: 10, top: '50%', transform: 'translateY(-50%)', color: 'var(--gray-400)' }} />
              <input
                className="form-input"
                placeholder="Search values..."
                value={searchTerm}
                onChange={e => setSearchTerm(e.target.value)}
                style={{ paddingLeft: 34, minWidth: 180 }}
              />
            </div>
            {canEdit && (
              <button className="btn btn-primary btn-sm" onClick={() => setShowBulkEntry(!showBulkEntry)}>
                <Plus size={16} className="mr-1" style={{display:'inline'}} />
                Add Values
              </button>
            )}
          </div>
        </div>
      </div>

      {/* Comma-Based Bulk Entry */}
      {showBulkEntry && canEdit && (
        <div className="panel mb-4" style={{ borderLeft: '4px solid var(--primary-500)' }}>
          <div className="panel-header" style={{ background: 'var(--primary-50)' }}>
            <h3 style={{ color: 'var(--primary-700)', fontSize: '0.95rem' }}>
              <Tag size={16} style={{ display: 'inline', marginRight: 8 }} />
              Add New {masterFields.find(f => f.fieldName === activeTab)?.displayName} Values
            </h3>
          </div>
          <div className="panel-body">
            <p className="text-sm text-gray-500 mb-3">
              Enter a single value or multiple values separated by commas (e.g., <strong>{masterFields.find(f => f.fieldName === activeTab)?.helperExample || 'Value1, Value2, Value3'}</strong>).
            </p>
            <input
              className="form-input"
              placeholder={`Enter values (e.g., ${masterFields.find(f => f.fieldName === activeTab)?.helperExample || 'Value1, Value2, Value3'})`}
              value={bulkInput}
              onChange={handleBulkInputChange}
              style={{ fontSize: '1rem', padding: '10px 14px' }}
              autoFocus
            />

            {/* Tag Preview */}
            {previewTags.length > 0 && (
              <div style={{ display: 'flex', flexWrap: 'wrap', gap: '8px', marginTop: '12px' }}>
                {previewTags.map((tag, i) => (
                  <span
                    key={i}
                    style={{
                      display: 'inline-flex', alignItems: 'center', gap: 4,
                      padding: '4px 12px', borderRadius: 16, fontSize: '0.85rem', fontWeight: 500,
                      background: tag.isDuplicate ? 'var(--warning-100)' : 'var(--success-100)',
                      color: tag.isDuplicate ? 'var(--warning-700)' : 'var(--success-700)',
                      border: `1px solid ${tag.isDuplicate ? 'var(--warning-300)' : 'var(--success-300)'}`,
                      textDecoration: tag.isDuplicate ? 'line-through' : 'none'
                    }}
                  >
                    {tag.value}
                    {tag.isDuplicate && <span style={{ fontSize: '0.75rem' }}>(exists)</span>}
                  </span>
                ))}
              </div>
            )}

            <div style={{ display: 'flex', gap: '8px', marginTop: '12px', justifyContent: 'flex-end' }}>
              <button className="btn btn-secondary btn-sm" onClick={() => { setShowBulkEntry(false); setBulkInput(''); setPreviewTags([]); }}>
                Cancel
              </button>
              <button
                className="btn btn-primary btn-sm"
                onClick={saveBulkEntries}
                disabled={saving || previewTags.filter(t => !t.isDuplicate).length === 0}
              >
                {saving ? 'Saving...' : `Save ${previewTags.filter(t => !t.isDuplicate).length} Value(s)`}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Data Table */}
      <div className="panel">
        <div className="table-container">
          {recordsLoading ? (
            <div className="empty-state" style={{ padding: 40 }}>
              <div className="spinner spinner-lg"></div>
              <p>Loading {masterFields.find(f => f.fieldName === activeTab)?.displayName || '...'} data...</p>
            </div>
          ) : masterFields.length === 0 && !loading ? (
             <div className="empty-state" style={{ padding: 40 }}>
              <Database size={40} style={{ color: 'var(--gray-300)' }} />
              <p>No dropdown master categories configured for your state.</p>
              {canEdit && (
                <button className="btn btn-primary btn-sm mt-3" onClick={() => setShowFieldTypeModal(true)}>
                  Create First Category
                </button>
              )}
            </div>
          ) : filteredRecords.length === 0 && !loading ? (
            <div className="empty-state" style={{ padding: 40 }}>
              <Database size={40} style={{ color: 'var(--gray-300)' }} />
              <p>{searchTerm ? 'No matching records found.' : 'No values configured yet.'}</p>
            </div>
          ) : (
            <table className="data-table">
              <thead>
                <tr>
                  <th style={{ width: 50 }}>#</th>
                  <th>Value</th>
                  <th>Access Level</th>
                  <th style={{ width: 80 }}>Order</th>
                  <th style={{ width: 100 }}>Status</th>
                  {canEdit && <th style={{ width: 120, textAlign: 'right' }}>Actions</th>}
                </tr>
              </thead>
              <tbody>
                {filteredRecords.map((record, idx) => (
                  <tr key={record.id} style={{ opacity: record.isActive ? 1 : 0.5 }}>
                    <td style={{ color: 'var(--gray-400)' }}>{idx + 1}</td>
                    <td style={{ fontWeight: 600 }}>{record.value}</td>
                    <td>
                      <span className={`badge ${
                        record.accessLevel?.includes('only') ? 'badge-danger' : 
                        record.accessLevel?.includes('plus') ? 'badge-warning' : 
                        'badge-info'
                      }`} style={{ fontSize: '0.75rem' }}>
                        {ACCESS_LEVEL_LABELS[record.accessLevel] || 'All Roles'}
                      </span>
                    </td>
                    <td>{record.displayOrder || '—'}</td>
                    <td>
                      <span className={`badge ${record.isActive ? 'badge-success' : 'badge-danger'}`} style={{ fontSize: '0.75rem' }}>
                        {record.isActive ? 'Active' : 'Inactive'}
                      </span>
                    </td>
                    {canEdit && (
                      <td>
                        <div className="actions">
                          <button className="btn btn-ghost btn-icon btn-sm" title="Edit" onClick={() => openEdit(record)}>
                            <Edit size={15} />
                          </button>
                          <button
                            className="btn btn-ghost btn-icon btn-sm"
                            title={record.isActive ? 'Deactivate' : 'Activate'}
                            onClick={() => toggleActive(record)}
                            style={{ color: record.isActive ? 'var(--warning-500)' : 'var(--success-500)' }}
                          >
                            {record.isActive ? <ToggleRight size={16} /> : <ToggleLeft size={16} />}
                          </button>
                          <button className="btn btn-ghost btn-icon btn-sm" title="Delete" onClick={() => handleDeleteValue(record)} style={{ color: 'var(--danger-500)' }}>
                            <Trash2 size={15} />
                          </button>
                        </div>
                      </td>
                    )}
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </div>
      </div>

      {/* Edit Modal */}
      {editingRecord && (
        <div className="modal-overlay" onClick={() => setEditingRecord(null)}>
          <div className="modal" onClick={e => e.stopPropagation()} style={{ maxWidth: 450 }}>
            <div className="modal-header">
              <h3>Edit {masterFields.find(f => f.fieldName === activeTab)?.displayName}</h3>
            </div>
            <div className="modal-body">
              <div className="form-group">
                <label className="form-label">Value <span className="required">*</span></label>
                <input className="form-input" value={editForm.value}
                  onChange={e => setEditForm(prev => ({ ...prev, value: e.target.value }))}
                  autoFocus />
              </div>
              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '12px' }}>
                <div className="form-group">
                  <label className="form-label">Display Order</label>
                  <input className="form-input" type="number" value={editForm.displayOrder}
                    onChange={e => setEditForm(prev => ({ ...prev, displayOrder: e.target.value }))} />
                </div>
                <div className="form-group">
                  <label className="form-label">Access Level</label>
                  <select className="form-select" value={editForm.accessLevel}
                    onChange={e => setEditForm(prev => ({ ...prev, accessLevel: e.target.value }))}>
                    {Object.entries(ACCESS_LEVEL_LABELS).map(([val, label]) => (
                      <option key={val} value={val}>{label}</option>
                    ))}
                  </select>
                </div>
              </div>
            </div>
            <div className="modal-footer">
              <button className="btn btn-secondary" onClick={() => setEditingRecord(null)} disabled={saving}>Cancel</button>
              <button className="btn btn-primary" onClick={saveEdit} disabled={saving}>
                {saving ? 'Saving...' : 'Update'}
              </button>
            </div>
          </div>
        </div>
      )}
      {/* Add Field Type Modal */}
      {showFieldTypeModal && (
        <div className="modal-overlay" style={{ zIndex: 1100 }}>
          <div className="modal" style={{ maxWidth: 500 }}>
            <div className="modal-header">
              <h3>{editingFieldType ? `Edit Category: ${editingFieldType.displayName}` : 'Add New Field Category'}</h3>
            </div>
            <div className="modal-body">
              <div className="form-group">
                <label className="form-label">Display Name <span className="required">*</span></label>
                <input className="form-input" placeholder="e.g. Nationality" 
                  value={newFieldType.displayName}
                  onChange={e => setNewFieldType(prev => ({ ...prev, displayName: e.target.value }))} />
              </div>
              <div className="form-group">
                <label className="form-label">Internal Field Key <span className="required">*</span></label>
                <input className="form-input" placeholder="e.g. nationality (lowercase, no spaces)"
                  value={newFieldType.fieldName}
                  onChange={e => setNewFieldType(prev => ({ ...prev, fieldName: e.target.value.toLowerCase().replace(/\s/g, '_') }))}
                  disabled={!!editingFieldType} />
                <p className="form-hint">{editingFieldType ? 'Database key cannot be changed after creation.' : 'Used for database filtering. Use only lowercase and underscores.'}</p>
              </div>
              <div className="form-group">
                <label className="form-label">Personnel Mapper Key <span className="form-hint">(Optional)</span></label>
                <input className="form-input" placeholder="e.g. nationality"
                  value={newFieldType.personnelFieldName}
                  onChange={e => setNewFieldType(prev => ({ ...prev, personnelFieldName: e.target.value }))} />
                <p className="form-hint">The exact key name in the Personnel record to check for usage.</p>
              </div>
              <div className="form-group">
                <label className="form-label">Bulk Input Examples <span className="form-hint">(Optional)</span></label>
                <input className="form-input" placeholder="e.g. SC, ST, OBC"
                  value={newFieldType.helperExample}
                  onChange={e => setNewFieldType(prev => ({ ...prev, helperExample: e.target.value }))} />
                <p className="form-hint">These examples will be shown to users when adding values in bulk.</p>
              </div>
            </div>
            <div className="modal-footer">
              <button className="btn btn-secondary" onClick={() => { setShowFieldTypeModal(false); setEditingFieldType(null); }}>Cancel</button>
              <button className="btn btn-primary" onClick={saveFieldType} disabled={saving}>
                {editingFieldType ? 'Update Category' : 'Add Field Type'}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Confirmation Modal - Rendered last with high z-index to stay on top */}
      {confirmModal && (
        <div className="modal-overlay" style={{ zIndex: 2000 }}>
          <div className="modal" style={{ maxWidth: 400 }}>
            <div className="modal-header">
              <h3 style={{ color: confirmModal.type === 'error' ? 'var(--danger-600)' : 'inherit' }}>
                {confirmModal.title}
              </h3>
            </div>
            <div className="modal-body">
              <p>{confirmModal.message}</p>
            </div>
            <div className="modal-footer">
              {confirmModal.type === 'info' || confirmModal.type === 'error' ? (
                <button className="btn btn-primary" onClick={confirmModal.onConfirm || (() => setConfirmModal(null))}>Close</button>
              ) : (
                <>
                  <button className="btn btn-secondary" onClick={() => setConfirmModal(null)}>Cancel</button>
                  <button className={`btn ${confirmModal.title.includes('Delete') ? 'btn-danger' : 'btn-primary'}`} 
                    onClick={confirmModal.onConfirm} disabled={saving}>
                    {saving ? 'Processing...' : 'Confirm'}
                  </button>
                </>
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
