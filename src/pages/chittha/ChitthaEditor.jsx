import { useState, useEffect, useMemo } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { Save, ArrowLeft, Plus, Trash2, Search, UserPlus, X, ClipboardList, Clock } from 'lucide-react';
import { useAuth } from '../../contexts/AuthContext';
import { useToast } from '../../contexts/ToastContext';
import { db } from '../../firebase';
import { collection, query, where, getDocs, doc, getDoc, setDoc, updateDoc, serverTimestamp } from 'firebase/firestore';
import OfficerPickerModal from '../../components/chittha/OfficerPickerModal';

const DEFAULT_HEADS = [
  { id: 'head_police', headName: 'Police Official', total: 0, absent: 0, leave: 0, present: 0 },
  { id: 'head_spo', headName: 'SPO', total: 0, absent: 0, leave: 0, present: 0 },
  { id: 'head_hgh', headName: 'HGH', total: 0, absent: 0, leave: 0, present: 0 },
  { id: 'head_hkrn', headName: 'HKRN', total: 0, absent: 0, leave: 0, present: 0 },
  { id: 'head_groupd', headName: 'Group-D (P/Temp)', total: 0, absent: 0, leave: 0, present: 0 },
];

export default function ChitthaEditor() {
  const { id } = useParams();
  const navigate = useNavigate();
  const { user, isDistrictAdmin, isStateAdmin } = useAuth();
  const toast = useToast();

  const [loading, setLoading] = useState(!!id);
  const [saving, setSaving] = useState(false);
  const [units, setUnits] = useState([]);
  
  // Form State
  const [formData, setFormData] = useState({
    unitId: user?.unitId || '',
    unitName: user?.unitName || '',
    chitthaDate: new Date().toISOString().split('T')[0],
    dateLabel: '',
    status: 'Draft',
  });

  const [headSummary, setHeadSummary] = useState(DEFAULT_HEADS);
  const [sections, setSections] = useState([
    { id: 'sec_sho', title: '1. SHO', officers: [] },
    { id: 'sec_investigation', title: '2. Investigation Staff', officers: [] },
    { id: 'sec_mhc', title: '3. MHC Staff', officers: [] },
    { id: 'sec_mm', title: '4. MM Staff', officers: [] },
    { id: 'sec_sho_mobile', title: '5. SHO Mobile', officers: [] },
    { id: 'sec_erv', title: '6. ERV (Emergency Response)', officers: [] },
    { id: 'sec_rider', title: '7. Rider / Patrol', officers: [] },
    { id: 'sec_general_duty', title: '8. General Duty', officers: [] },
    { id: 'sec_groupd_staff', title: '9. Group-D Staff', officers: [] },
    { id: 'sec_leave_rest', title: '10. Leave / Weekly Rest', officers: [] },
    { id: 'sec_unallocated', title: '11. Unallocated', officers: [] },
  ]);

  const [isPickerOpen, setIsPickerOpen] = useState(false);
  const [activeSectionId, setActiveSectionId] = useState(null);

  useEffect(() => {
    fetchUnits();
    if (id) fetchChittha();
  }, [id]);

  async function fetchUnits() {
    try {
      const unitRef = collection(db, 'units');
      let q = query(unitRef);
      if (isDistrictAdmin) q = query(unitRef, where('districtId', '==', user.districtId));
      const snap = await getDocs(q);
      setUnits(snap.docs.map(d => ({ id: d.id, ...d.data() })));
    } catch (err) {
      console.error(err);
    }
  }

  async function fetchChittha() {
    try {
      const docRef = doc(db, 'naukriChittha', id);
      const snap = await getDoc(docRef);
      if (snap.exists()) {
        const data = snap.data();
        setFormData({
          unitId: data.unitId,
          unitName: data.unitName,
          chitthaDate: data.chitthaDate,
          dateLabel: data.dateLabel || '',
          status: data.status,
        });
        if (data.headSummary) setHeadSummary(data.headSummary);
        
        // Fetch assignments for sections
        const assignRef = collection(db, 'chitthaAssignments');
        const aSnap = await getDocs(query(assignRef, where('chitthaId', '==', id)));
        const allAssignments = aSnap.docs.map(d => ({ id: d.id, ...d.data() }));
        
        // Reconstruct sections if they were saved (or use default)
        // For this demo, let's assume sections are stored in the chittha document or derived
        if (data.sectionConfigs) {
           const reconstructed = data.sectionConfigs.map(s => ({
             ...s,
             officers: allAssignments.filter(a => a.sectionId === s.id)
           }));
           setSections(reconstructed);
        }
      }
    } catch (err) {
      toast.error('Failed to load roster');
    } finally {
      setLoading(false);
    }
  }

  const handleHeadChange = (id, field, value) => {
    const val = parseInt(value) || 0;
    setHeadSummary(prev => prev.map(h => {
      if (h.id === id) {
        const updated = { ...h, [field]: val };
        if (field !== 'present') {
           updated.present = updated.total - updated.absent - updated.leave;
        }
        return updated;
      }
      return h;
    }));
  };
  const addHeadRow = () => {
    const newId = `head_${Date.now()}`;
    setHeadSummary([...headSummary, { id: newId, headName: 'Custom Category', total: 0, absent: 0, leave: 0, present: 0 }]);
  };

  const deleteHeadRow = (id) => {
    setHeadSummary(headSummary.filter(h => h.id !== id));
  };

  async function handleSave() {
    try {
      if (!window.confirm('Do you want to save all changes to this roster?')) return;
      setSaving(true);
      const chitthaId = id || doc(collection(db, 'naukriChittha')).id;
      
      const payload = {
        id: chitthaId,
        ...formData,
        headSummary,
        sectionConfigs: sections.map(s => ({ id: s.id, title: s.title })),
        sectionCount: sections.length,
        updatedAt: serverTimestamp(),
      };

      if (!id) payload.createdAt = serverTimestamp();

      // 1. Save main document
      await setDoc(doc(db, 'naukriChittha', chitthaId), payload, { merge: true });

      // 2. Save assignments
      // Save new/updated assignments
      for (const section of sections) {
        for (const off of section.officers) {
          const assignId = `${chitthaId}_${section.id}_${off.personnelId}`;
          await setDoc(doc(db, 'chitthaAssignments', assignId), {
            ...off,
            chitthaId,
            sectionId: section.id,
            sectionTitle: section.title,
            chitthaDate: formData.chitthaDate,
            unitId: formData.unitId,
          });
        }
      }
      
      toast.success('Roster saved successfully');
      navigate('/chitthas');
    } catch (err) {
      console.error(err);
      toast.error('Failed to save roster');
    } finally {
      setSaving(false);
    }
  }

  const addSection = (title = 'New Section') => {
    if (!window.confirm(`Are you sure you want to add a new section named "${title}"?`)) return;
    setSections([...sections, { id: `sec_${Date.now()}`, title, officers: [] }]);
  };

  const deleteSection = (secId) => {
    const section = sections.find(s => s.id === secId);
    if (!window.confirm(`Are you sure you want to delete the section "${section?.title}" and all its assignments?`)) return;
    setSections(sections.filter(s => s.id !== secId));
  };

  const updateSectionTitle = (secId, title) => {
    setSections(sections.map(s => s.id === secId ? { ...s, title } : s));
  };

  const removeOfficer = (secId, personnelId) => {
    if (!window.confirm('Are you sure you want to remove this officer from the duty section?')) return;
    setSections(sections.map(s => {
      if (s.id === secId) {
        return { ...s, officers: s.officers.filter(o => o.personnelId !== personnelId) };
      }
      return s;
    }));
  };

  const openPicker = (secId) => {
    setActiveSectionId(secId);
    setIsPickerOpen(true);
  };

  const handleAddOfficers = (selectedOfficers) => {
    setSections(sections.map(s => {
      if (s.id === activeSectionId) {
        // Filter out those already in the section
        const currentIds = new Set(s.officers.map(o => o.personnelId));
        const newOfficers = selectedOfficers
          .filter(o => !currentIds.has(o.id))
          .map(o => ({
            personnelId: o.id,
            personnelName: o.fullName,
            personnelRank: o.rank,
            personnelBelt: o.beltNumber,
            personnelMobile: o.mobileNumber || '',
            remarkText: '',
          }));
        return { ...s, officers: [...s.officers, ...newOfficers] };
      }
      return s;
    }));
    setIsPickerOpen(false);
  };

  const getTimeStatus = () => {
    const now = new Date();
    const hour = now.getHours();
    if (hour < 17 || hour >= 21) {
      return { restricted: true, message: 'Official window: 5:00 PM – 9:00 PM' };
    }
    return { restricted: false };
  };

  if (loading) return <div className="spinner-container"><div className="spinner"></div></div>;

  const timeStatus = getTimeStatus();

  return (
    <div className="chittha-editor-page">
      <div className="page-header" style={{ position: 'sticky', top: 0, zIndex: 60, background: 'var(--gray-50)', padding: '16px 0' }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
          <button className="btn btn-ghost" onClick={() => navigate('/chitthas')}>
            <ArrowLeft size={20} />
          </button>
          <div style={{ display: 'flex', flexDirection: 'column' }}>
            <h2 style={{ fontSize: '1.25rem', lineHeight: 1 }}>{id ? 'Edit Chittha' : 'New Chittha'}</h2>
            {timeStatus.restricted && (
              <span style={{ fontSize: '0.7rem', color: 'var(--danger-600)', fontWeight: 700, marginTop: 4 }}>
                ⚠️ {timeStatus.message}
              </span>
            )}
          </div>
        </div>
        <button className="btn btn-primary" onClick={handleSave} disabled={saving}>
          <Save size={18} /> Save
        </button>
      </div>

      <div className="chittha-compact">
      <div className="editor-content" style={{ maxWidth: 1000, margin: '0 auto', display: 'flex', flexDirection: 'column', gap: 12, paddingBottom: 100 }}>
        
        {/* Card 1: Details */}
        <div className="panel">
          <div className="panel-header"><h3><ClipboardList size={18} /> Chittha Details</h3></div>
          <div className="panel-body grid-3">
            <div className="form-group">
              <label className="form-label">Unit</label>
              <select 
                className="form-select" 
                value={formData.unitId}
                onChange={(e) => {
                  const unit = units.find(u => u.id === e.target.value);
                  setFormData({ ...formData, unitId: e.target.value, unitName: unit?.unitName || '' });
                }}
              >
                <option value="">Select Unit</option>
                {units.map(u => <option key={u.id} value={u.id}>{u.unitName}</option>)}
              </select>
            </div>
            <div className="form-group">
              <label className="form-label">Date</label>
              <input 
                type="date" 
                className="form-input" 
                value={formData.chitthaDate}
                onChange={(e) => setFormData({ ...formData, chitthaDate: e.target.value })}
              />
            </div>
            <div className="form-group">
              <label className="form-label">Date Label (Optional)</label>
              <input 
                type="text" 
                className="form-input" 
                placeholder="e.g. 8 AM to 8 AM" 
                value={formData.dateLabel}
                onChange={(e) => setFormData({ ...formData, dateLabel: e.target.value })}
              />
            </div>
          </div>
        </div>

        <div className="panel summary-panel">
          <div className="compact-section-header">Head-wise Summary</div>
          <div className="panel-header" style={{ padding: '4px 12px', borderBottom: '1px solid #e2e8f0' }}>
            <span style={{ fontSize: '0.75rem', fontWeight: 600, color: '#64748b' }}>Strength Overview</span>
            <button className="btn btn-ghost btn-sm" onClick={addHeadRow} style={{ padding: '0 4px' }}><Plus size={12} /> Add</button>
          </div>
          <div className="table-container">
            <table className="data-table summary-table">
              <thead>
                <tr>
                  <th>HEAD CATEGORY</th>
                  <th style={{ width: 100 }}>TOTAL</th>
                  <th style={{ width: 100 }}>ABSENT</th>
                  <th style={{ width: 100 }}>LEAVE</th>
                  <th style={{ width: 100 }}>PRESENT</th>
                  <th style={{ width: 40 }}></th>
                </tr>
              </thead>
              <tbody>
                {headSummary.map((head) => (
                  <tr key={head.id}>
                    <td>
                      <input 
                        type="text" 
                        className="inline-input bold" 
                        value={head.headName} 
                        onChange={(e) => {
                          setHeadSummary(prev => prev.map(h => h.id === head.id ? { ...h, headName: e.target.value } : h))
                        }}
                      />
                    </td>
                    <td><input type="number" className="inline-input center" value={head.total} onChange={(e) => handleHeadChange(head.id, 'total', e.target.value)} /></td>
                    <td><input type="number" className="inline-input center" value={head.absent} onChange={(e) => handleHeadChange(head.id, 'absent', e.target.value)} /></td>
                    <td><input type="number" className="inline-input center" value={head.leave} onChange={(e) => handleHeadChange(head.id, 'leave', e.target.value)} /></td>
                    <td className="present-cell">{head.present}</td>
                    <td>
                       <button className="btn-icon-text delete" onClick={() => deleteHeadRow(head.id)}><X size={14} /></button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>

        {/* Dynamic Duty Sections */}
        <div className="sections-container" style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
          {sections.map(section => (
            <div key={section.id} className="panel duty-section">
              <div className="compact-section-header">
                <input 
                  type="text" 
                  className="section-title-input" 
                  style={{ textAlign: 'left', width: '100%', padding: 0 }}
                  value={section.title} 
                  onChange={(e) => updateSectionTitle(section.id, e.target.value)}
                />
                <button 
                  className="btn-icon" 
                  style={{ position: 'absolute', right: 8, top: '50%', transform: 'translateY(-50%)', background: 'none', border: 'none', color: 'rgba(255,255,255,0.6)', cursor: 'pointer' }} 
                  onClick={() => deleteSection(section.id)}
                >
                  <Trash2 size={12} />
                </button>
              </div>
              
              <div className="table-container">
                <table className="data-table">
                  <thead>
                    <tr>
                      <th style={{ width: 40 }}>SN</th>
                      <th style={{ width: 80 }}>Rank</th>
                      <th style={{ width: 180 }}>Name</th>
                      <th style={{ width: 100 }}>Belt No.</th>
                      <th>Remarks / Duty Point</th>
                      <th style={{ width: 120 }}>Mobile</th>
                      <th style={{ width: 40 }}></th>
                    </tr>
                  </thead>
                  <tbody>
                    {section.officers.length === 0 ? (
                      <tr>
                        <td colSpan={7} style={{ textAlign: 'center', color: '#999', padding: '12px', fontSize: '0.75rem' }}>
                          No officers assigned
                        </td>
                      </tr>
                    ) : section.officers.map((off, idx) => (
                      <tr key={off.personnelId}>
                        <td style={{ textAlign: 'center' }}>{idx + 1}</td>
                        <td style={{ textAlign: 'center' }}><span className="badge-compact">{off.personnelRank}</span></td>
                        <td style={{ fontWeight: 600 }}>{off.personnelName}</td>
                        <td style={{ textAlign: 'center' }}>{off.personnelBelt}</td>
                        <td>
                          <input 
                            className="inline-input" 
                            style={{ height: '24px' }}
                            placeholder="Duty remarks..." 
                            value={off.remarkText}
                            onChange={(e) => {
                              setSections(sections.map(s => {
                                if (s.id === section.id) {
                                  return { 
                                    ...s, 
                                    officers: s.officers.map(o => o.personnelId === off.personnelId ? { ...o, remarkText: e.target.value } : o) 
                                  };
                                }
                                return s;
                              }));
                            }}
                          />
                        </td>
                        <td style={{ textAlign: 'center' }}>{off.personnelMobile || '—'}</td>
                        <td style={{ textAlign: 'center' }}>
                          <button className="btn-icon" style={{ color: 'var(--danger-500)', background: 'none', border: 'none' }} onClick={() => removeOfficer(section.id, off.personnelId)}><X size={14} /></button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
              <div className="panel-footer" style={{ justifyContent: 'center', background: 'var(--gray-50)', padding: '4px' }}>
                <button className="btn btn-ghost btn-sm" style={{ fontSize: '0.7rem' }} onClick={() => openPicker(section.id)}>
                  <Plus size={12} /> Add Officer
                </button>
              </div>
            </div>
          ))}
        </div>

        {/* Footer actions */}
        <div className="editor-footer-actions" style={{ display: 'flex', gap: 12, alignItems: 'center', background: 'white', padding: '12px 20px', borderRadius: 8, border: '1px solid var(--gray-200)' }}>
          <input 
            type="text" 
            className="form-input" 
            placeholder="E.g. PCR, Naaka 1..." 
            id="newSectionTitle" 
            style={{ maxWidth: 250, height: 32, fontSize: '0.8rem' }}
          />
          <button 
            className="btn btn-secondary btn-sm" 
            onClick={() => {
              const input = document.getElementById('newSectionTitle');
              addSection(input.value || 'New Section');
              input.value = '';
            }}
          >
            <Plus size={14} /> Add Section
          </button>
        </div>
      </div>
      </div>

      <OfficerPickerModal 
        isOpen={isPickerOpen} 
        onClose={() => setIsPickerOpen(false)} 
        onAdd={handleAddOfficers}
        unitId={formData.unitId}
      />

      <style jsx>{`
        .grid-3 { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; }
        @media (max-width: 768px) { .grid-3 { grid-template-columns: 1fr; } }
        
        .summary-table th { background: var(--navy); color: white; border: none; }
        .summary-table td { padding: 8px 12px; }
        
        .inline-input { width: 100%; border: 1px solid transparent; background: none; padding: 4px 8px; font-size: 14px; border-radius: 4px; transition: border-color 0.2s; }
        .inline-input:focus { background: white; border-color: var(--blue-active); outline: none; }
        .inline-input.bold { font-weight: 600; color: var(--navy); }
        .inline-input.center { text-align: center; }
        
        .present-cell { font-weight: 700; text-align: center; color: var(--success-600); background: var(--success-50); }
        
        .section-title-header { display: flex; align-items: center; justify-content: space-between; padding: 12px 20px; background: var(--navy); border-bottom: none; }
        .section-title-input { background: none; border: 1px solid transparent; color: white; font-size: 1rem; font-weight: 700; padding: 4px 8px; border-radius: 4px; flex: 1; }
        .section-title-input:focus { background: rgba(255,255,255,0.1); border-color: rgba(255,255,255,0.3); outline: none; }
        
        .delete-sec { color: rgba(255,255,255,0.7) !important; }
        .delete-sec:hover { background: rgba(255,255,255,0.1) !important; color: white !important; }

        .btn-icon-text.delete { color: var(--danger-600); }
      `}</style>
    </div>
  );
}
