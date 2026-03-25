import { useState, useEffect, useMemo } from 'react';
import { useAuth } from '../../contexts/AuthContext';
import { useToast } from '../../contexts/ToastContext';
import { db } from '../../firebase';
import {
  collection, query, where, getDocs, doc, setDoc, updateDoc,
  serverTimestamp, writeBatch
} from 'firebase/firestore';
import {
  CalendarCheck, Search, Save, ChevronLeft, ChevronRight,
  UserCheck, UserX, Clock, Filter
} from 'lucide-react';

const ATTENDANCE_OPTIONS = [
  { value: 'Present', label: 'Present', color: 'var(--success-500)' },
  { value: 'Absent', label: 'Absent', color: 'var(--danger-500)' },
  { value: 'Half Day', label: 'Half Day', color: 'var(--warning-500)' },
  { value: 'Hourly Leave', label: 'Hourly Leave', color: 'var(--info-500)' },
  { value: 'Leave', label: 'Leave', color: 'var(--gray-500)' },
  { value: 'Duty Outside', label: 'Duty Outside', color: 'var(--primary-500)' },
];

export default function AttendanceRegister() {
  const { user, isRangeAdmin, isDistrictAdmin, isUnitAdmin } = useAuth();
  const toast = useToast();

  const [selectedDate, setSelectedDate] = useState(() => {
    return new Date().toISOString().split('T')[0];
  });
  const [personnel, setPersonnel] = useState([]);
  const [attendanceMap, setAttendanceMap] = useState({}); // personnelId -> { id, attendanceType, ... }
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const [rankFilter, setRankFilter] = useState('');
  const [bulkAction, setBulkAction] = useState('');

  useEffect(() => {
    loadData();
  }, [selectedDate, user]);

  async function loadData() {
    try {
      setLoading(true);

      // Load personnel for this unit/district
      const personnelRef = collection(db, 'personnel');
      let constraints = [where('serviceStatus', '==', 'Active')];
      if (user.unitId) {
        constraints.push(where('currentUnitId', '==', user.unitId));
      } else if (isDistrictAdmin && user.districtId) {
        constraints.push(where('districtId', '==', user.districtId));
      } else if (isRangeAdmin && user.rangeId) {
        constraints.push(where('rangeId', '==', user.rangeId));
      }
      const personnelSnap = await getDocs(query(personnelRef, ...constraints));
      const personnelData = personnelSnap.docs.map(d => ({ id: d.id, ...d.data() }));
      setPersonnel(personnelData);

      // Load attendance for selected date
      const attendanceRef = collection(db, 'attendanceRegister');
      let attConstraints = [where('date', '==', selectedDate)];
      if (user.unitId) {
        attConstraints.push(where('unitId', '==', user.unitId));
      } else if (isDistrictAdmin && user.districtId) {
        attConstraints.push(where('districtId', '==', user.districtId));
      } else if (isRangeAdmin && user.rangeId) {
        attConstraints.push(where('rangeId', '==', user.rangeId));
      }
      const attSnap = await getDocs(query(attendanceRef, ...attConstraints));
      const attMap = {};
      attSnap.docs.forEach(d => {
        const data = d.data();
        attMap[data.personnelId] = { id: d.id, ...data };
      });
      setAttendanceMap(attMap);
    } catch (err) {
      console.error('Attendance load error:', err);
      toast.error('Failed to load attendance data.');
    } finally {
      setLoading(false);
    }
  }

  // Filter personnel
  const filteredPersonnel = useMemo(() => {
    return personnel.filter(p => {
      if (rankFilter && p.rank !== rankFilter) return false;
      if (searchTerm) {
        const term = searchTerm.toLowerCase();
        const match =
          (p.fullName || '').toLowerCase().includes(term) ||
          (p.beltNumber || '').toLowerCase().includes(term) ||
          (p.rank || '').toLowerCase().includes(term);
        if (!match) return false;
      }
      return true;
    });
  }, [personnel, searchTerm, rankFilter]);

  // Stats
  const stats = useMemo(() => {
    const total = personnel.length;
    const present = Object.values(attendanceMap).filter(a =>
      a.attendanceType === 'Present' || a.attendanceType === 'Duty Outside'
    ).length;
    const absent = Object.values(attendanceMap).filter(a => a.attendanceType === 'Absent').length;
    const onLeave = Object.values(attendanceMap).filter(a =>
      a.attendanceType === 'Leave' || a.attendanceType === 'Half Day' || a.attendanceType === 'Hourly Leave'
    ).length;
    const unmarked = total - Object.keys(attendanceMap).length;
    return { total, present, absent, onLeave, unmarked };
  }, [personnel, attendanceMap]);

  // Mark single attendance
  async function markAttendance(personnelId, attendanceType, hourlyDetails = {}) {
    try {
      const existing = attendanceMap[personnelId];
      const person = personnel.find(p => p.id === personnelId);

      if (existing) {
        await updateDoc(doc(db, 'attendanceRegister', existing.id), {
          attendanceType,
          ...hourlyDetails,
          updatedAt: serverTimestamp(),
          markedByUserId: user.uid || user.userId,
        });
      } else {
        const newRef = doc(collection(db, 'attendanceRegister'));
        await setDoc(newRef, {
          attendanceId: newRef.id,
          personnelId,
          date: selectedDate,
          attendanceType,
          attendanceSource: 'Register',
          stateId: person?.stateId || user.stateId || '',
          rangeId: person?.rangeId || user.rangeId || '',
          districtId: person?.districtId || user.districtId || '',
          unitId: person?.currentUnitId || user.unitId || '',
          subUnitId: person?.currentSubUnitId || user.subUnitId || '',
          ...hourlyDetails,
          markedByUserId: user.uid || user.userId,
          createdAt: serverTimestamp(),
          updatedAt: serverTimestamp(),
        });
      }

      // Update local state
      setAttendanceMap(prev => ({
        ...prev,
        [personnelId]: {
          ...(prev[personnelId] || {}),
          personnelId,
          attendanceType,
          ...hourlyDetails,
        },
      }));
    } catch (err) {
      console.error('Mark attendance error:', err);
      toast.error('Failed to update attendance.');
    }
  }

  // Bulk mark all visible personnel using writeBatch for performance
  async function handleBulkAction() {
    if (!bulkAction) return;
    setSaving(true);
    try {
      const BATCH_LIMIT = 500;
      let batch = writeBatch(db);
      let opCount = 0;

      for (const person of filteredPersonnel) {
        const existing = attendanceMap[person.id];
        if (existing) {
          const docRef = doc(db, 'attendanceRegister', existing.id);
          batch.update(docRef, {
            attendanceType: bulkAction,
            updatedAt: serverTimestamp(),
            markedByUserId: user.uid || user.userId,
          });
        } else {
          const newRef = doc(collection(db, 'attendanceRegister'));
          batch.set(newRef, {
            attendanceId: newRef.id,
            personnelId: person.id,
            date: selectedDate,
            attendanceType: bulkAction,
            attendanceSource: 'Register',
            stateId: person.stateId || user.stateId || '',
            rangeId: person.rangeId || user.rangeId || '',
            districtId: person.districtId || user.districtId || '',
            unitId: person.currentUnitId || user.unitId || '',
            subUnitId: person.currentSubUnitId || user.subUnitId || '',
            markedByUserId: user.uid || user.userId,
            createdAt: serverTimestamp(),
            updatedAt: serverTimestamp(),
          });
        }

        opCount++;
        // Firestore batch limit is 500 writes
        if (opCount === BATCH_LIMIT) {
          await batch.commit();
          batch = writeBatch(db);
          opCount = 0;
        }
      }

      if (opCount > 0) await batch.commit();

      // Update local state
      setAttendanceMap(prev => {
        const updated = { ...prev };
        filteredPersonnel.forEach(p => {
          updated[p.id] = { ...(prev[p.id] || {}), personnelId: p.id, attendanceType: bulkAction };
        });
        return updated;
      });

      toast.success(`Marked ${filteredPersonnel.length} personnel as "${bulkAction}".`);
      setBulkAction('');
    } catch (err) {
      if (import.meta.env.DEV) console.error('Bulk action error:', err);
      toast.error('Bulk action failed.');
    } finally {
      setSaving(false);
    }
  }

  // Date navigation
  function changeDate(delta) {
    const d = new Date(selectedDate);
    d.setDate(d.getDate() + delta);
    setSelectedDate(d.toISOString().split('T')[0]);
  }

  // Check if after 5 PM deadline
  const now = new Date();
  const deadlineHour = 17; // 5 PM
  const isAfterDeadline = now.getHours() >= deadlineHour && selectedDate === now.toISOString().split('T')[0];

  // Get unique ranks for filter
  const uniqueRanks = [...new Set(personnel.map(p => p.rank).filter(Boolean))];

  return (
    <div>
      <div className="page-header">
        <h2>Attendance Register</h2>
        <div className="page-header-actions">
          {isAfterDeadline && (
            <span className="badge badge-warning" style={{ padding: '6px 12px', fontSize: '0.8rem' }}>
              ⚠️ Past 5:00 PM deadline
            </span>
          )}
        </div>
      </div>

      {/* Date Selector & Stats */}
      <div className="stats-bar" style={{ marginBottom: 16 }}>
        <div className="stat-widget" style={{ flex: 2 }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
            <button className="btn btn-ghost btn-icon btn-sm" onClick={() => changeDate(-1)}>
              <ChevronLeft size={18} />
            </button>
            <input
              type="date"
              className="form-input"
              value={selectedDate}
              onChange={(e) => setSelectedDate(e.target.value)}
              style={{ maxWidth: 180, textAlign: 'center', fontWeight: 600 }}
            />
            <button className="btn btn-ghost btn-icon btn-sm" onClick={() => changeDate(1)}>
              <ChevronRight size={18} />
            </button>
            <button className="btn btn-ghost btn-sm" onClick={() => setSelectedDate(new Date().toISOString().split('T')[0])}>
              Today
            </button>
          </div>
        </div>
        <div className="stat-widget">
          <div className="stat-widget-icon green"><UserCheck size={18} /></div>
          <div className="stat-widget-data"><h3>{stats.present}</h3><p>Present</p></div>
        </div>
        <div className="stat-widget">
          <div className="stat-widget-icon red"><UserX size={18} /></div>
          <div className="stat-widget-data"><h3>{stats.absent}</h3><p>Absent</p></div>
        </div>
        <div className="stat-widget">
          <div className="stat-widget-icon amber"><Clock size={18} /></div>
          <div className="stat-widget-data"><h3>{stats.onLeave}</h3><p>Leave</p></div>
        </div>
        <div className="stat-widget">
          <div className="stat-widget-icon info"><CalendarCheck size={18} /></div>
          <div className="stat-widget-data"><h3>{stats.unmarked}</h3><p>Unmarked</p></div>
        </div>
      </div>

      {/* Main Panel */}
      <div className="panel">
        <div className="panel-header">
          <div className="search-filter-bar" style={{ width: '100%' }}>
            <div className="search-input-wrapper">
              <Search className="search-icon" size={18} />
              <input
                type="text"
                placeholder="Search by Name, Belt No..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
              />
            </div>
            <select className="filter-select" value={rankFilter} onChange={(e) => setRankFilter(e.target.value)}>
              <option value="">All Ranks</option>
              {uniqueRanks.map(r => <option key={r} value={r}>{r}</option>)}
            </select>

            {/* Bulk action */}
            <select className="filter-select" value={bulkAction} onChange={(e) => setBulkAction(e.target.value)}>
              <option value="">Bulk Action...</option>
              {ATTENDANCE_OPTIONS.map(opt => (
                <option key={opt.value} value={opt.value}>Mark All: {opt.label}</option>
              ))}
            </select>
            {bulkAction && (
              <button className="btn btn-primary btn-sm" onClick={handleBulkAction} disabled={saving}>
                {saving ? 'Applying...' : `Apply to ${filteredPersonnel.length}`}
              </button>
            )}
          </div>
        </div>

        <div className="table-container">
          {loading ? (
            <div className="empty-state">
              <div className="spinner spinner-lg" style={{ margin: '0 auto' }}></div>
              <p>Loading attendance data...</p>
            </div>
          ) : filteredPersonnel.length === 0 ? (
            <div className="empty-state">
              <CalendarCheck className="icon" />
              <h4>No personnel found</h4>
              <p>Adjust your filters or add personnel records first.</p>
            </div>
          ) : (
            <table className="data-table">
              <thead>
                <tr>
                  <th style={{ width: 50 }}>S.No</th>
                  <th>Belt No.</th>
                  <th>Name</th>
                  <th>Rank</th>
                  <th style={{ width: 200 }}>Attendance</th>
                  <th style={{ width: 100 }}>Status</th>
                </tr>
              </thead>
              <tbody>
                {filteredPersonnel.map((p, idx) => {
                  const att = attendanceMap[p.id];
                  const currentType = att?.attendanceType || '';
                  const statusOpt = ATTENDANCE_OPTIONS.find(o => o.value === currentType);
                  return (
                    <tr key={p.id}>
                      <td>{idx + 1}</td>
                      <td style={{ fontWeight: 600 }}>{p.beltNumber || '—'}</td>
                      <td>{p.fullName || '—'}</td>
                      <td><span className="badge badge-primary">{p.rank || '—'}</span></td>
                      <td>
                        <select
                          className="form-select"
                          value={currentType}
                          onChange={(e) => markAttendance(p.id, e.target.value)}
                          style={{
                            borderColor: statusOpt?.color || 'var(--gray-200)',
                            fontWeight: currentType ? 600 : 400,
                            color: statusOpt?.color || 'inherit',
                            fontSize: '0.8rem',
                          }}
                        >
                          <option value="">— Select —</option>
                          {ATTENDANCE_OPTIONS.map(opt => (
                            <option key={opt.value} value={opt.value}>{opt.label}</option>
                          ))}
                        </select>
                      </td>
                      <td>
                        {currentType ? (
                          <span className={`badge ${
                            currentType === 'Present' || currentType === 'Duty Outside' ? 'badge-success' :
                            currentType === 'Absent' ? 'badge-danger' :
                            'badge-warning'
                          }`} style={{ fontSize: '0.7rem' }}>
                            {currentType}
                          </span>
                        ) : (
                          <span className="badge badge-neutral" style={{ fontSize: '0.7rem' }}>Unmarked</span>
                        )}
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          )}
        </div>

        <div className="panel-footer">
          <span style={{ fontSize: '0.8rem', color: 'var(--gray-500)' }}>
            {filteredPersonnel.length} personnel • {Object.keys(attendanceMap).length} marked • {stats.unmarked} remaining
          </span>
        </div>
      </div>
    </div>
  );
}
