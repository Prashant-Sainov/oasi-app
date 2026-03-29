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
  const { user, isSuperAdmin, isStateAdmin, isRangeAdmin, isDistrictAdmin, isUnitAdmin } = useAuth();
  const toast = useToast();

  const [selectedDate, setSelectedDate] = useState(() => {
    return new Date().toISOString().split('T')[0];
  });

  // UI State
  const [viewMode, setViewMode] = useState('hierarchy'); // 'hierarchy' | 'register'
  const [selectedEntity, setSelectedEntity] = useState(null); // { id, name, type, unitId }
  const [hierarchyLoading, setHierarchyLoading] = useState(true);
  const [expandedUnits, setExpandedUnits] = useState(new Set());
  const [searchHierarchy, setSearchHierarchy] = useState('');

  // Data State
  const [units, setUnits] = useState([]);
  const [subUnits, setSubUnits] = useState({}); // unitId -> subUnits[]
  const [personnel, setPersonnel] = useState([]);
  const [attendanceMap, setAttendanceMap] = useState({}); 
  const [masterRanks, setMasterRanks] = useState([]);
  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const [rankFilter, setRankFilter] = useState('');
  const [bulkAction, setBulkAction] = useState('');

  // Countdown State
  const [timeLeft, setTimeLeft] = useState('');
  const [isUrgent, setIsUrgent] = useState(false);
  const [isDeadlineReached, setIsDeadlineReached] = useState(false);

  // Smart Lookup State: id -> { name, module }
  const [lookupNames, setLookupNames] = useState({});

  // 1. Load Hierarchy on Mount
  useEffect(() => {
    loadHierarchy();
    loadMasterRanks();
  }, [user]);

  async function loadHierarchy() {
    try {
      setHierarchyLoading(true);
      const unitsRef = collection(db, 'units');
      let constraints = [where('assignedModule', '==', 'attendance')];

      if (isUnitAdmin && user?.unitId) {
        constraints.push(where('__name__', '==', user.unitId));
      } else if (isDistrictAdmin && user?.districtId) {
        constraints.push(where('districtId', '==', user.districtId));
      } else if (isRangeAdmin && user?.rangeId) {
        constraints.push(where('rangeId', '==', user.rangeId));
      } else if (user?.stateId) {
        constraints.push(where('stateId', '==', user.stateId));
      }

      const unitSnap = await getDocs(query(unitsRef, ...constraints));
      const unitData = unitSnap.docs.map(d => ({ id: d.id, ...d.data() }));
      unitData.sort((a, b) => a.unitName.localeCompare(b.unitName));
      setUnits(unitData);

      // Fetch all sub-units for these units in one go (or chunks)
      const uIds = unitData.map(u => u.id);
      if (uIds.length > 0) {
        const subUnitsMap = {};
        for (let i = 0; i < uIds.length; i += 30) {
          const chunk = uIds.slice(i, i + 30);
          const sq = query(
            collection(db, 'subUnits'), 
            where('unitId', 'in', chunk),
            where('assignedModule', '==', 'attendance')
          );
          const sSnap = await getDocs(sq);
          sSnap.docs.forEach(d => {
            const su = { id: d.id, ...d.data() };
            if (!subUnitsMap[su.unitId]) subUnitsMap[su.unitId] = [];
            subUnitsMap[su.unitId].push(su);
          });
        }
        setSubUnits(subUnitsMap);
      }
    } catch (err) {
      console.error('Hierarchy load error:', err);
      toast.error('Failed to load Unit hierarchy.');
    } finally {
      setHierarchyLoading(false);
    }
  }

  // Real-time Countdown Timer (to 5 PM)
  useEffect(() => {
    const checkTime = () => {
      const todayStr = new Date().toLocaleDateString('en-CA'); // YYYY-MM-DD in local time
      if (selectedDate !== todayStr) {
        setTimeLeft('');
        return;
      }

      const now = new Date();
      const deadline = new Date();
      deadline.setHours(17, 0, 0, 0); // 5 PM

      const diff = deadline - now;
      if (diff <= 0) {
        setTimeLeft('00:00:00');
        setIsUrgent(true);
        if (!isDeadlineReached && !loading && personnel.length > 0 && selectedEntity) {
          setIsDeadlineReached(true);
          triggerAutoMarking(personnel, attendanceMap);
        }
        return;
      }

      const h = Math.floor(diff / (1000 * 60 * 60));
      const m = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
      const s = Math.floor((diff % (1000 * 60)) / 1000);

      setTimeLeft(`${h.toString().padStart(2, '0')}:${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`);
      setIsUrgent(h === 0 && m < 30);
    };

    checkTime(); // Run immediately
    const timer = setInterval(checkTime, 1000);
    return () => clearInterval(timer);
  }, [selectedDate, loading, personnel, attendanceMap, isDeadlineReached, selectedEntity]);

  // 2. Load Personnel when entity is selected
  useEffect(() => {
    if (viewMode === 'register' && selectedEntity) {
      loadData();
    }
  }, [viewMode, selectedEntity, selectedDate]);

  async function loadData() {
    if (!selectedEntity) return;
    try {
      setLoading(true);
      let constraints = [where('serviceStatus', '==', 'Active')];

      if (selectedEntity.type === 'subunit') {
        constraints.push(where('currentSubUnitId', '==', selectedEntity.id));
      } else {
        constraints.push(where('currentUnitId', '==', selectedEntity.id));
        // If it's a "Unit (Main)" selection, we might want to exclude subunits, 
        // but typically currently personnel are assigned to either UnitId or SubUnitId.
      }

      // Fetch Personnel
      const personnelSnap = await getDocs(query(collection(db, 'personnel'), ...constraints));
      const personnelData = personnelSnap.docs.map(d => ({ id: d.id, ...d.data() }));
      setPersonnel(personnelData);

      // Resolve Hierarchy Names for stats/table
      resolveHierarchyNames(personnelData);

      // Fetch Attendance
      const attendanceRef = collection(db, 'attendanceRegister');
      let attConstraints = [where('date', '==', selectedDate)];
      
      if (selectedEntity.type === 'subunit') {
        attConstraints.push(where('subUnitId', '==', selectedEntity.id));
      } else {
        attConstraints.push(where('unitId', '==', selectedEntity.id));
      }

      const attSnap = await getDocs(query(attendanceRef, ...attConstraints));
      const attMap = {};
      attSnap.docs.forEach(d => {
        const data = d.data();
        attMap[data.personnelId] = { id: d.id, ...data };
      });
      setAttendanceMap(attMap);

      // Auto-Marking check
      if (selectedEntity && selectedDate === new Date().toISOString().split('T')[0]) {
        await triggerAutoMarking(personnelData, attMap);
      }
    } catch (err) {
      console.error('Data load error:', err);
      toast.error('Failed to load personnel data.');
    } finally {
      setLoading(false);
    }
  }

  function toggleUnit(unitId) {
    const next = new Set(expandedUnits);
    if (next.has(unitId)) next.delete(unitId);
    else next.add(unitId);
    setExpandedUnits(next);
  }

  function openRegister(entity) {
    setSelectedEntity(entity);
    setViewMode('register');
    window.scrollTo(0, 0);
  }

  function goBack() {
    setViewMode('hierarchy');
    setPersonnel([]);
    setAttendanceMap({});
  }

  useEffect(() => {
    loadData();
  }, [selectedDate, user, selectedDistrictId, selectedUnitId, selectedSubUnitId]);

  async function loadData() {
    try {
      setLoading(true);

      // 1. Build common hierarchy constraints based on most specific selection
      let constraints = [where('serviceStatus', '==', 'Active')];
      
      // Explicitly check for isDeleted: false if it exists in the schema
      // constraints.push(where('isDeleted', '==', false)); 

      if (selectedSubUnitId) {
        constraints.push(where('currentSubUnitId', '==', selectedSubUnitId));
      } else if (selectedUnitId) {
        constraints.push(where('currentUnitId', '==', selectedUnitId));
      } else if (selectedDistrictId) {
        constraints.push(where('districtId', '==', selectedDistrictId));
      } else if (selectedRangeId) {
        constraints.push(where('rangeId', '==', selectedRangeId));
      } else if (user?.stateId) {
        constraints.push(where('stateId', '==', user.stateId));
      }

      // Fetch Personnel
      const personnelSnap = await getDocs(query(collection(db, 'personnel'), ...constraints));
      const personnelData = personnelSnap.docs.map(d => ({ id: d.id, ...d.data() }));
      setPersonnel(personnelData);

      // Resolve Hierarchy Names on-the-fly for any missing Unit/Sub-Unit names
      resolveHierarchyNames(personnelData);

      // 2. Fetch Attendance for the same scope
      const attendanceRef = collection(db, 'attendanceRegister');
      let attConstraints = [where('date', '==', selectedDate)];
      
      // Mirror the hierarchy constraints for the attendance query
      if (selectedSubUnitId) {
        attConstraints.push(where('subUnitId', '==', selectedSubUnitId));
      } else if (selectedUnitId) {
        attConstraints.push(where('unitId', '==', selectedUnitId));
      } else if (selectedDistrictId) {
        attConstraints.push(where('districtId', '==', selectedDistrictId));
      } else if (selectedRangeId) {
        attConstraints.push(where('rangeId', '==', selectedRangeId));
      } else if (user?.stateId) {
        attConstraints.push(where('stateId', '==', user.stateId));
      }

      const attSnap = await getDocs(query(attendanceRef, ...attConstraints));
      const attMap = {};
      attSnap.docs.forEach(d => {
        const data = d.data();
        attMap[data.personnelId] = { id: d.id, ...data };
      });
      setAttendanceMap(attMap);

      // 3. Trigger Auto-Marking if conditions met (Only if a Unit is selected to prevent massive state-wide auto-marking)
      if (selectedUnitId && selectedDate === new Date().toISOString().split('T')[0]) {
        await triggerAutoMarking(personnelData, attMap);
      }
    } catch (err) {
      console.error('Attendance load error:', err);
      toast.error('Failed to load data. Ensure hierarchical indices are created.');
    } finally {
      setLoading(false);
    }
  }

  // Resolve Unit and Sub-Unit IDs to names on-the-fly
  async function resolveHierarchyNames(data) {
    // 1. Get unique IDs that require resolution
    // We only resolve if the name is not already in lookupNames or the dropdown states
    const unitIds = [...new Set(data.map(p => p.currentUnitId).filter(id => id && !lookupNames[id] && !units.some(u => u.id === id)))];
    const subUnitIds = [...new Set(data.map(p => p.currentSubUnitId).filter(id => id && !lookupNames[id] && !subUnits.some(su => su.id === id)))];

    if (unitIds.length === 0 && subUnitIds.length === 0) return;

    try {
      const newNames = {};
      
      // Batch fetch missing Unit names (Firestore allows 30 IDs per 'in' query)
      for (let i = 0; i < unitIds.length; i += 30) {
        const chunk = unitIds.slice(i, i + 30);
        const q = query(collection(db, 'units'), where('__name__', 'in', chunk));
        const snap = await getDocs(q);
        snap.docs.forEach(d => { 
          const data = d.data();
          newNames[d.id] = { name: data.unitName, module: data.assignedModule || 'attendance' }; 
        });
      }

      // Batch fetch missing Sub-Unit names
      for (let i = 0; i < subUnitIds.length; i += 30) {
        const chunk = subUnitIds.slice(i, i + 30);
        const q = query(collection(db, 'subUnits'), where('__name__', 'in', chunk));
        const snap = await getDocs(q);
        snap.docs.forEach(d => { 
          const data = d.data();
          newNames[d.id] = { name: data.subUnitName, module: data.assignedModule || 'attendance' }; 
        });
      }

      if (Object.keys(newNames).length > 0) {
        setLookupNames(prev => ({ ...prev, ...newNames }));
      }
    } catch (err) {
      console.error('Failed to resolve hierarchy names:', err);
    }
  }

  // Filter personnel: Search and Rank
  const filteredPersonnel = useMemo(() => {
    return personnel.filter(p => {
      // 1. Rank filter
      if (rankFilter && p.rank !== rankFilter) return false;

      // 2. Search filter
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
    const total = filteredPersonnel.length;
    const present = filteredPersonnel.filter(p => {
      const a = attendanceMap[p.id];
      return a?.attendanceType === 'Present' || a?.attendanceType === 'Duty Outside';
    }).length;
    const absent = filteredPersonnel.filter(p => attendanceMap[p.id]?.attendanceType === 'Absent').length;
    const onLeave = filteredPersonnel.filter(p => {
      const a = attendanceMap[p.id];
      return a?.attendanceType === 'Leave' || a?.attendanceType === 'Half Day' || a?.attendanceType === 'Hourly Leave';
    }).length;
    const unmarked = total - filteredPersonnel.filter(p => attendanceMap[p.id]).length;
    return { total, present, absent, onLeave, unmarked };
  }, [filteredPersonnel, attendanceMap]);

  const LATE_THRESHOLD = "10:00"; // 10:00 AM

  async function triggerAutoMarking(currentPersonnel, currentAttMap) {
    const now = new Date();
    if (now.getHours() < 17) return; // 5 PM logic

    const unmarked = currentPersonnel.filter(p => !currentAttMap[p.id]);
    if (unmarked.length === 0) return;

    try {
      setSaving(true);
      const batch = writeBatch(db);
      const autoMarkedIds = {};

      unmarked.forEach(p => {
        const newRef = doc(collection(db, 'attendanceRegister'));
        const data = {
          attendanceId: newRef.id,
          personnelId: p.id,
          date: selectedDate,
          attendanceType: 'Present',
          attendanceSource: 'System-Auto',
          markingMethod: 'System',
          stateId: p.stateId || user.stateId || '',
          rangeId: p.rangeId || user.rangeId || '',
          districtId: p.districtId || user.districtId || '',
          unitId: p.currentUnitId || user.unitId || '',
          subUnitId: p.currentSubUnitId || user.subUnitId || '',
          markedByUserId: 'SYSTEM_AUTOMATION',
          markedByRole: 'system',
          isLate: false,
          markedAt: serverTimestamp(),
          createdAt: serverTimestamp(),
          updatedAt: serverTimestamp(),
        };
        batch.set(newRef, data);
        autoMarkedIds[p.id] = data;
      });

      await batch.commit();
      setAttendanceMap(prev => ({ ...prev, ...autoMarkedIds }));
      toast.info(`System auto-marked ${unmarked.length} personnel as Present.`);
    } catch (err) {
      console.error('Auto-marking error:', err);
    } finally {
      setSaving(false);
    }
  }

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
      const data = snap.docs.map(d => ({ id: d.id, ...d.data() }));
      data.sort((a, b) => (a.displayOrder || 0) - (b.displayOrder || 0));
      setMasterRanks(data);
    } catch (err) {
      console.error('Failed to load ranks:', err);
    }
  }

  // Mark single attendance
  async function markAttendance(personnelId, attendanceType, hourlyDetails = {}) {
    try {
      const existing = attendanceMap[personnelId];
      const person = personnel.find(p => p.id === personnelId);

      // Check if late
      const now = new Date();
      const timeStr = now.toTimeString().slice(0, 5);
      const isLate = timeStr > LATE_THRESHOLD;

      if (existing) {
        await updateDoc(doc(db, 'attendanceRegister', existing.id), {
          attendanceType,
          ...hourlyDetails,
          updatedAt: serverTimestamp(),
          markedByUserId: user.uid || user.userId,
          markedByRole: user.role,
          markingMethod: 'Manual',
          isLate,
        });
      } else {
        const newRef = doc(collection(db, 'attendanceRegister'));
        await setDoc(newRef, {
          attendanceId: newRef.id,
          personnelId,
          date: selectedDate,
          attendanceType,
          attendanceSource: 'Register',
          markingMethod: 'Manual',
          stateId: person?.stateId || user.stateId || '',
          rangeId: person?.rangeId || user.rangeId || '',
          districtId: person?.districtId || user.districtId || '',
          unitId: person?.currentUnitId || user.unitId || '',
          subUnitId: person?.currentSubUnitId || user.subUnitId || '',
          ...hourlyDetails,
          markedByUserId: user.uid || user.userId,
          markedByRole: user.role,
          isLate,
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

      // Check if late
      const now = new Date();
      const timeStr = now.toTimeString().slice(0, 5);
      const isLate = timeStr > LATE_THRESHOLD;

      for (const person of filteredPersonnel) {
        const existing = attendanceMap[person.id];
        if (existing) {
          const docRef = doc(db, 'attendanceRegister', existing.id);
          batch.update(docRef, {
            attendanceType: bulkAction,
            updatedAt: serverTimestamp(),
            markedByUserId: user.uid || user.userId,
            markedByRole: user.role,
            markingMethod: 'Manual',
            isLate,
          });
        } else {
          const newRef = doc(collection(db, 'attendanceRegister'));
          batch.set(newRef, {
            attendanceId: newRef.id,
            personnelId: person.id,
            date: selectedDate,
            attendanceType: bulkAction,
            attendanceSource: 'Register',
            markingMethod: 'Manual',
            stateId: person.stateId || user.stateId || '',
            rangeId: person.rangeId || user.rangeId || '',
            districtId: person.districtId || user.districtId || '',
            unitId: person.currentUnitId || user.unitId || '',
            subUnitId: person.currentSubUnitId || user.subUnitId || '',
            markedByUserId: user.uid || user.userId,
            markedByRole: user.role,
            isLate,
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

  // Ranks for filter: Use master ranks if loaded, fallback to unique from personnel
  const availableRanks = useMemo(() => {
    if (masterRanks.length > 0) return masterRanks.map(r => r.value);
    return [...new Set(personnel.map(p => p.rank).filter(Boolean))];
  }, [masterRanks, personnel]);

  return (
    <div>
      <div className="page-header">
        <h2>Attendance Register</h2>
        <div className="page-header-actions" style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
          {/* Timer in Header */}
          {timeLeft && (
            <div className={`countdown-timer ${isUrgent ? 'urgent' : ''}`} 
              style={{ 
                display: 'flex', 
                alignItems: 'center', 
                gap: 8,
                padding: '6px 14px',
                borderRadius: '8px',
                background: isUrgent ? 'var(--danger-500)' : 'var(--success-600)',
                color: '#fff',
                boxShadow: '0 2px 4px rgba(0,0,0,0.1)',
                fontWeight: 700,
                fontSize: '0.9rem',
                border: 'none',
                minWidth: '180px',
                justifyContent: 'center'
              }}>
              <Clock size={18} />
              <span>{isDeadlineReached ? 'Auto-Marking Complete' : `Final Submission: ${timeLeft}`}</span>
            </div>
          )}
          {isAfterDeadline && !isDeadlineReached && (
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
              className="form-input date-field"
              value={selectedDate}
              onChange={(e) => setSelectedDate(e.target.value)}
              style={{ textAlign: 'center', fontWeight: 600 }}
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

      {/* Main Content Area */}
      <div className="panel card-container">
        {viewMode === 'hierarchy' ? (
          <div className="hierarchy-explorer">
            <div className="panel-header" style={{ borderBottom: '1px solid var(--gray-200)', background: 'var(--gray-50)' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 12, width: '100%', flexWrap: 'wrap' }}>
                <div className="search-input-wrapper" style={{ flex: 1, minWidth: '250px' }}>
                  <Search size={16} className="search-icon" />
                  <input 
                    type="text" 
                    className="form-input" 
                    placeholder="Find Unit / Sub-unit..." 
                    value={searchHierarchy}
                    onChange={e => setSearchHierarchy(e.target.value)}
                  />
                </div>
                <div style={{ color: 'var(--gray-500)', fontSize: '0.85rem' }}>
                  {units.length} Units Available
                </div>
              </div>
            </div>

            <div className="hierarchy-list" style={{ padding: '10px' }}>
              {hierarchyLoading ? (
                <div style={{ padding: '40px', textAlign: 'center' }}>
                  <div className="spinner spinner-lg"></div>
                  <p className="mt-4 text-gray-500">Building organizational hierarchy...</p>
                </div>
              ) : units.filter(u => u.unitName.toLowerCase().includes(searchHierarchy.toLowerCase())).length === 0 ? (
                <div style={{ padding: '40px', textAlign: 'center', color: 'var(--gray-400)' }}>
                  <Filter size={48} style={{ marginBottom: 16, opacity: 0.2 }} />
                  <p>No units matching your search scope.</p>
                </div>
              ) : (
                units
                  .filter(u => u.unitName.toLowerCase().includes(searchHierarchy.toLowerCase()) || 
                               (subUnits[u.id] || []).some(su => su.subUnitName.toLowerCase().includes(searchHierarchy.toLowerCase())))
                  .map(unit => {
                    const isOpen = expandedUnits.has(unit.id);
                    const unitSubUnits = subUnits[unit.id] || [];
                    
                    return (
                      <div key={unit.id} className="unit-section" style={{ 
                        marginBottom: 10, 
                        border: '1px solid var(--gray-200)', 
                        borderRadius: 12, 
                        overflow: 'hidden',
                        background: 'white',
                        boxShadow: '0 2px 4px rgba(0,0,0,0.02)'
                      }}>
                        <div 
                          className="unit-header" 
                          onClick={() => toggleUnit(unit.id)}
                          style={{ 
                            padding: '14px 20px', 
                            display: 'flex', 
                            alignItems: 'center', 
                            cursor: 'pointer',
                            background: isOpen ? 'var(--primary-50)' : 'transparent',
                            transition: 'all 0.2s'
                          }}
                        >
                          <div style={{ 
                            width: 32, 
                            height: 32, 
                            borderRadius: 8, 
                            background: isOpen ? 'var(--primary-100)' : 'var(--gray-100)', 
                            display: 'flex', 
                            alignItems: 'center', 
                            justifyContent: 'center',
                            marginRight: 16,
                            color: isOpen ? 'var(--primary-600)' : 'var(--gray-500)'
                          }}>
                            {isOpen ? <ChevronDown size={18} /> : <ChevronRight size={18} />}
                          </div>
                          <div style={{ flex: 1 }}>
                            <h3 style={{ margin: 0, fontSize: '1rem', color: 'var(--navy)' }}>{unit.unitName}</h3>
                            <p style={{ margin: 0, fontSize: '0.75rem', color: 'var(--gray-500)' }}>
                              {unitSubUnits.length} Sub-units • {unit.unitType || 'General'}
                            </p>
                          </div>
                          <button 
                            className="btn btn-ghost btn-sm" 
                            onClick={(e) => { e.stopPropagation(); openRegister({ id: unit.id, name: unit.unitName, type: 'unit' }); }}
                            style={{ fontSize: '0.75rem' }}
                          >
                            Mark Unit Staff
                          </button>
                        </div>

                        {isOpen && (
                          <div className="unit-body" style={{ background: 'var(--gray-50)', borderTop: '1px solid var(--gray-100)' }}>
                            {unitSubUnits.length === 0 ? (
                              <div style={{ padding: '20px', textAlign: 'center', color: 'var(--gray-400)', fontSize: '0.85rem' }}>
                                No designated sub-units for this unit.
                              </div>
                            ) : (
                              <div className="subunit-grid" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))', gap: '10px', padding: '15px' }}>
                                {unitSubUnits.map(su => (
                                  <div 
                                    key={su.id} 
                                    className="subunit-card"
                                    onClick={() => openRegister({ id: su.id, name: su.subUnitName, type: 'subunit', unitId: unit.id })}
                                    style={{ 
                                      background: 'white', 
                                      padding: '12px 16px', 
                                      borderRadius: 10, 
                                      border: '1px solid var(--gray-200)',
                                      display: 'flex',
                                      alignItems: 'center',
                                      justifyContent: 'space-between',
                                      cursor: 'pointer',
                                      transition: 'transform 0.1s, box-shadow 0.1s'
                                    }}
                                    onMouseOver={e => { e.currentTarget.style.transform = 'translateY(-2px)'; e.currentTarget.style.boxShadow = '0 4px 12px rgba(0,0,0,0.05)'; }}
                                    onMouseOut={e => { e.currentTarget.style.transform = 'none'; e.currentTarget.style.boxShadow = 'none'; }}
                                  >
                                    <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                                      <div style={{ width: 8, height: 8, borderRadius: '50%', background: 'var(--primary-400)' }}></div>
                                      <span style={{ fontWeight: 600, fontSize: '0.9rem', color: 'var(--gray-700)' }}>{su.subUnitName}</span>
                                    </div>
                                    <ChevronRight size={14} style={{ color: 'var(--gray-300)' }} />
                                  </div>
                                ))}
                              </div>
                            )}
                          </div>
                        )}
                      </div>
                    );
                  })
              )}
            </div>
          </div>
        ) : (
          <div className="register-view">
            <div className="panel-header" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', flexWrap: 'wrap', gap: 10 }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                <button className="btn btn-secondary btn-icon btn-sm" onClick={goBack}>
                  <ChevronLeft size={18} />
                </button>
                <div>
                  <h3 style={{ margin: 0 }}>{selectedEntity?.name}</h3>
                  <p style={{ margin: 0, fontSize: '0.75rem', color: 'var(--gray-500)' }}>
                    Detailed Attendance Register • {selectedDate}
                  </p>
                </div>
              </div>

              <div className="table-controls" style={{ display: 'flex', alignItems: 'center', gap: 8, flexWrap: 'wrap' }}>
                <div className="search-input-wrapper" style={{ width: 160 }}>
                  <Search size={14} className="search-icon" />
                  <input 
                    type="text" 
                    className="form-input" 
                    placeholder="Search personnel..." 
                    value={searchTerm}
                    onChange={e => setSearchTerm(e.target.value)}
                    style={{ fontSize: '0.8rem', padding: '4px 8px 4px 28px' }}
                  />
                </div>
                <select className="filter-select" style={{ width: 110, fontSize: '0.8rem' }} value={rankFilter} onChange={(e) => setRankFilter(e.target.value)}>
                  <option value="">All Ranks</option>
                  {availableRanks.map(r => <option key={r} value={r}>{r}</option>)}
                </select>
                <div style={{ display: 'flex', gap: '4px' }}>
                  <select className="filter-select" style={{ width: 120, fontSize: '0.8rem' }} value={bulkAction} onChange={(e) => setBulkAction(e.target.value)}>
                    <option value="">Bulk Action...</option>
                    {ATTENDANCE_OPTIONS.map(opt => (
                      <option key={opt.value} value={opt.value}>All: {opt.label}</option>
                    ))}
                  </select>
                  {bulkAction && (
                    <button className="btn btn-primary btn-sm" onClick={handleBulkAction} disabled={saving} style={{ padding: '4px 8px', fontSize: '0.8rem' }}>
                      Apply
                    </button>
                  )}
                </div>
              </div>
            </div>

        <div className="table-container">
            {loading ? (
              <div className="empty-state">
                <div className="spinner spinner-lg" style={{ margin: '0 auto' }}></div>
                <p>Loading personnel...</p>
              </div>
            ) : filteredPersonnel.length === 0 ? (
              <div className="empty-state">
                <CalendarCheck className="icon" style={{ opacity: 0.1 }} size={48} />
                <h4>No personnel found</h4>
                <p>No active personnel were found for the selected {selectedEntity?.type}.</p>
                <button className="btn btn-secondary mt-4" onClick={goBack}>Change Selection</button>
              </div>
            ) : (
            <table className="data-table">
              <thead>
                <tr>
                  <th style={{ width: 50 }}>S.No</th>
                  <th>Belt No.</th>
                  <th>Name</th>
                  <th>Rank</th>
                  <th>Unit</th>
                  <th>Sub-Unit</th>
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
                      <td style={{ fontSize: '0.8rem' }}>
                        {p.unitName || 
                         lookupNames[p.currentUnitId]?.name || 
                         units.find(u => u.id === p.currentUnitId)?.unitName || 
                         (selectedEntity?.type === 'unit' ? selectedEntity.name : '') ||
                         '—'}
                      </td>
                      <td style={{ fontSize: '0.8rem' }}>
                        {p.subUnitName || 
                         lookupNames[p.currentSubUnitId]?.name || 
                         (selectedEntity?.type === 'subunit' ? selectedEntity.name : '') ||
                         '—'}
                      </td>
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
    )}
    </div>
  </div>
);
}
