import React, { useState, useEffect } from 'react';
import { useAuth } from '../contexts/AuthContext';
import { db } from '../firebase';
import { collection, query, where, getDocs, getCountFromServer, onSnapshot } from 'firebase/firestore';
import { Users, UserCheck, UserX, Building2, ClipboardList, AlertTriangle, TrendingUp, FileText, ChevronDown, ChevronRight } from 'lucide-react';
import { useNavigate } from 'react-router-dom';

export default function Dashboard() {
  const { user, isSuperAdmin, isStateAdmin, isRangeAdmin, isDistrictAdmin, isUnitAdmin } = useAuth();
  const navigate = useNavigate();
  const [stats, setStats] = useState({
    totalPersonnel: 0,
    presentToday: 0,
    absentToday: 0,
    activeChitthas: 0,
    pendingAlerts: 0,
  });
  const [hierarchyStats, setHierarchyStats] = useState({
    ranges: 0,
    commissionerates: 0,
    others: 0
  });
  const [recentPersonnel, setRecentPersonnel] = useState([]);
  
  // Super Admin specific state
  const [allDistricts, setAllDistricts] = useState([]);
  const [stateAdmins, setStateAdmins] = useState([]);
  const [statesList, setStatesList] = useState([]);
  const [expandedStates, setExpandedStates] = useState({});

  
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadDashboardData();
    
    // Automatic update for Hierarchy card
    if (user) {
      const q = query(collection(db, 'ranges'), where('stateId', '==', user.stateId || 'haryana'));
      const unsubscribe = onSnapshot(q, (snap) => {
        const counts = { ranges: 0, commissionerates: 0, others: 0 };
        snap.docs.forEach(doc => {
          const name = doc.data().rangeName || '';
          if (name.toLowerCase().includes('commissionerate')) counts.commissionerates++;
          else if (name.toLowerCase().includes('range')) counts.ranges++;
          else counts.others++;
        });
        setHierarchyStats(counts);
      }, (err) => console.error("Real-time hierarchy error:", err));
      
      // Real-time listener for Super Admin Districts
      if (user.role === 'super_admin') {
        const distUnsub = onSnapshot(collection(db, 'districts'), (snap) => {
          const list = snap.docs.map(d => ({ id: d.id, ...d.data() }));
          setAllDistricts(list);
        });
        return () => {
          unsubscribe();
          distUnsub();
        };
      }
      return () => unsubscribe();
    }
  }, [user]);

  async function loadDashboardData() {
    try {
      setLoading(true);

      // Build query based on role
      let personnelQuery;
      const personnelRef = collection(db, 'personnel');

      if (isUnitAdmin && user.unitId) {
        personnelQuery = query(personnelRef, where('currentUnitId', '==', user.unitId), where('serviceStatus', '==', 'Active'));
      } else if (isDistrictAdmin && user.districtId) {
        personnelQuery = query(personnelRef, where('districtId', '==', user.districtId), where('serviceStatus', '==', 'Active'));
      } else if (isRangeAdmin && user.rangeId) {
        personnelQuery = query(personnelRef, where('rangeId', '==', user.rangeId), where('serviceStatus', '==', 'Active'));
      } else {
        personnelQuery = query(personnelRef, where('serviceStatus', '==', 'Active'));
      }

      const personnelSnap = await getDocs(personnelQuery);
      const totalPersonnel = personnelSnap.size;

      // Get recent personnel (last 10 added)
      const recent = personnelSnap.docs
        .sort((a, b) => (b.data().createdAt?.seconds || 0) - (a.data().createdAt?.seconds || 0))
        .slice(0, 10)
        .map(doc => ({ id: doc.id, ...doc.data() }));
      setRecentPersonnel(recent);

      // (Hierarchy stats are now handled by real-time onSnapshot above)

      // Get today's attendance
      const today = new Date().toISOString().split('T')[0];
      const attendanceRef = collection(db, 'attendanceRegister');
      let attendQuery;
      if (isUnitAdmin && user.unitId) {
        attendQuery = query(attendanceRef, where('date', '==', today), where('unitId', '==', user.unitId));
      } else if (isDistrictAdmin && user.districtId) {
        attendQuery = query(attendanceRef, where('date', '==', today), where('districtId', '==', user.districtId));
      } else if (isRangeAdmin && user.rangeId) {
        attendQuery = query(attendanceRef, where('date', '==', today), where('rangeId', '==', user.rangeId));
      } else {
        attendQuery = query(attendanceRef, where('date', '==', today));
      }

      const attendSnap = await getDocs(attendQuery);
      const presentToday = attendSnap.docs.filter(d =>
        d.data().attendanceType === 'Present' || d.data().attendanceType === 'Duty Outside'
      ).length;

      setStats({
        totalPersonnel,
        presentToday,
        absentToday: totalPersonnel - presentToday,
        activeChitthas: 0,
        pendingAlerts: 0,
      });

      // Super Admin specific data points
      if (isSuperAdmin) {
        // Load States
        const stSnap = await getDocs(collection(db, 'states'));
        const stList = stSnap.docs.map(d => ({ id: d.id, ...d.data() }));
        setStatesList(stList.sort((a, b) => (a.stateName || '').localeCompare(b.stateName || '')));

        // Load State Admins
        const saSnap = await getDocs(query(collection(db, 'users'), where('role', '==', 'state_admin'), where('isActive', '==', true)));
        const saList = saSnap.docs.map(d => ({ id: d.id, ...d.data() }));
        setStateAdmins(saList);
      }
      
    } catch (err) {
      console.error('Dashboard load error:', err);
    } finally {
      setLoading(false);
    }
  }

  const vacancy = Math.max(0, stats.totalUnits * 30 - stats.totalPersonnel); // Estimated

  return (
    <div className="dashboard-content">
      <div className="page-header">
        <div>
          <h2>OASI Overview</h2>
          <span style={{ fontSize: '0.8rem', color: 'var(--gray-400)' }}>
            {new Date().toLocaleDateString('en-IN', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' })}
          </span>
        </div>
      </div>

      {/* Main Content Area based on Role */}
      {!isSuperAdmin ? (
        <>
          {/* Stats widgets */}
          <div className="stats-bar">
            <div className="stat-widget">
              <div className="stat-widget-icon blue"><Users size={22} /></div>
              <div className="stat-widget-data">
                <h3>{loading ? '—' : stats.totalPersonnel}</h3>
                <p>Total Personnel</p>
              </div>
            </div>
            <div className="stat-widget">
              <div className="stat-widget-icon green"><UserCheck size={22} /></div>
              <div className="stat-widget-data">
                <h3>{loading ? '—' : stats.presentToday}</h3>
                <p>Present Today</p>
              </div>
            </div>
            <div className="stat-widget">
              <div className="stat-widget-icon red"><UserX size={22} /></div>
              <div className="stat-widget-data">
                <h3>{loading ? '—' : stats.absentToday}</h3>
                <p>Absent Today</p>
              </div>
            </div>
            
            {!isDistrictAdmin && (
              <div className="stat-widget">
                <div className="stat-widget-data" style={{ width: '100%', padding: '0 5px' }}>
                  <p style={{ fontSize: '0.75rem', fontWeight: 700, color: 'var(--gray-800)', marginBottom: '8px', textTransform: 'uppercase', letterSpacing: '0.5px', borderBottom: '1px solid var(--gray-100)', paddingBottom: '4px' }}>
                    Org. Structure
                  </p>
                  {[
                    { label: 'Ranges', value: hierarchyStats.ranges },
                    { label: 'Commissionerates', value: hierarchyStats.commissionerates },
                    { label: 'Others', value: hierarchyStats.others }
                  ].map((row, idx) => (
                    <div key={row.label} style={{ 
                      display: 'flex', 
                      justifyContent: 'space-between', 
                      alignItems: 'center',
                      padding: '3px 0',
                      borderBottom: idx < 2 ? '1px solid var(--gray-50)' : 'none'
                    }}>
                      <span style={{ fontSize: '0.75rem', color: 'var(--gray-600)', fontWeight: 500 }}>{row.label}</span>
                      <span style={{ fontWeight: 800, fontSize: '0.9rem', color: 'var(--primary-700)' }}>
                        {loading ? '—' : (row.value ?? 0)}
                      </span>
                    </div>
                  ))}
                </div>
              </div>
            )}
            
            <div className="stat-widget" onClick={() => navigate('/reports/fir')} style={{ cursor: 'pointer' }}>
              <div className="stat-widget-icon purple"><FileText size={22} /></div>
              <div className="stat-widget-data">
                <h3><TrendingUp size={18} /></h3>
                <p>Crime Analytics</p>
              </div>
            </div>
          </div>

          <div className="panel">
            <div className="panel-header">
              <h3>Recent Personnel</h3>
            </div>
            <div className="table-container">
              {loading ? (
                <div className="empty-state">
                  <div className="spinner spinner-lg" style={{ margin: '0 auto' }}></div>
                  <p>Loading data...</p>
                </div>
              ) : recentPersonnel.length === 0 ? (
                <div className="empty-state">
                  <Users className="icon" />
                  <h4>No personnel records yet</h4>
                  <p>Add personnel or import data from Excel to get started.</p>
                </div>
              ) : (
                <table className="data-table">
                  <thead>
                    <tr>
                      <th>S.No</th>
                      <th>Belt No.</th>
                      <th>Name</th>
                      <th>Rank</th>
                      <th>Mobile</th>
                      <th>Status</th>
                    </tr>
                  </thead>
                  <tbody>
                    {recentPersonnel.map((p, idx) => (
                      <tr key={p.id}>
                        <td>{idx + 1}</td>
                        <td style={{ fontWeight: 600 }}>{p.beltNumber || '—'}</td>
                        <td>{p.fullName || '—'}</td>
                        <td>
                            <span className="badge badge-primary">{p.rank || '—'}</span>
                        </td>
                        <td>{p.mobileNumber || '—'}</td>
                        <td>
                          <span className={`badge ${p.serviceStatus === 'Active' ? 'badge-success' : 'badge-neutral'}`}>
                            {p.serviceStatus || 'Active'}
                          </span>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              )}
            </div>
          </div>
        </>
      ) : (
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(400px, 1fr))', gap: '20px' }}>
          {/* Districts Table (Grouped by State) - Minimal SuperAdmin Scope */}
          <div className="panel">
            <div className="panel-header">
              <h3>All Configured States & Districts</h3>
            </div>
            <div className="table-container" style={{ maxHeight: '500px', overflowY: 'auto' }}>
              {loading ? (
                <div className="empty-state"><div className="spinner" style={{ margin: '0 auto' }}></div></div>
              ) : allDistricts.length === 0 ? (
                <div className="empty-state"><p>No districts found.</p></div>
              ) : (
                <table className="data-table">
                  <thead style={{ position: 'sticky', top: 0, background: 'var(--white)', zIndex: 10 }}>
                    <tr>
                      <th style={{ width: '40px' }}></th>
                      <th>State / District Name</th>
                      <th>Total Districts</th>
                    </tr>
                  </thead>
                  <tbody>
                    {statesList.map((stateObj) => {
                      const stateId = stateObj.id;
                      const stateName = stateObj.stateName || stateId;
                      // Group districts for this state (fallback to 'haryana' if missing, for old data)
                      const stateDistricts = allDistricts.filter(d => (d.stateId || 'haryana') === stateId);
                      const isExpanded = expandedStates[stateId];

                      if (stateDistricts.length === 0) return null;

                      return (
                        <React.Fragment key={stateId}>
                          {/* State Group Row */}
                          <tr 
                            onClick={() => setExpandedStates(prev => ({ ...prev, [stateId]: !prev[stateId] }))}
                            style={{ cursor: 'pointer', background: 'var(--gray-50)' }}
                          >
                            <td style={{ textAlign: 'center', width: '40px' }}>
                              {isExpanded ? <ChevronDown size={18} /> : <ChevronRight size={18} />}
                            </td>
                            <td style={{ fontWeight: 700, fontSize: '0.95rem' }}>
                              <span style={{ textTransform: 'capitalize' }}>{stateName}</span>
                            </td>
                            <td>
                              <span className="badge badge-primary">{stateDistricts.length}</span>
                            </td>
                          </tr>
                          
                          {/* District Rows (Expandable) */}
                          {isExpanded && stateDistricts
                            .sort((a, b) => (a.districtName || '').localeCompare(b.districtName || ''))
                            .map((d, idx) => (
                              <tr key={d.id} style={{ background: 'var(--white)' }}>
                                <td style={{ textAlign: 'right', color: 'var(--gray-400)', width: '40px' }}>{idx + 1}.</td>
                                <td colSpan={2} style={{ paddingLeft: '1rem' }}>
                                  {d.districtName || '—'}
                                </td>
                              </tr>
                            ))}
                        </React.Fragment>
                      );
                    })}
                  </tbody>
                </table>
              )}
            </div>
          </div>

          {/* State Admins Table */}
          <div className="panel">
            <div className="panel-header">
              <h3>State Admin Users</h3>
            </div>
            <div className="table-container" style={{ maxHeight: '500px', overflowY: 'auto' }}>
              {loading ? (
                <div className="empty-state"><div className="spinner" style={{ margin: '0 auto' }}></div></div>
              ) : stateAdmins.length === 0 ? (
                <div className="empty-state"><p>No State Admins configured.</p></div>
              ) : (
                <table className="data-table">
                  <thead style={{ position: 'sticky', top: 0, background: 'var(--white)', zIndex: 10 }}>
                    <tr>
                      <th>S.No</th>
                      <th>Belt / User ID</th>
                      <th>Name</th>
                      <th>State Assigned</th>
                    </tr>
                  </thead>
                  <tbody>
                    {stateAdmins.map((admin, idx) => (
                      <tr key={admin.id}>
                        <td>{idx + 1}</td>
                        <td style={{ fontWeight: 600 }}>{admin.beltNumber || '—'}</td>
                        <td>{admin.name || '—'}</td>
                        <td>
                          <span className="badge badge-info" style={{ textTransform: 'uppercase', letterSpacing: '0.5px' }}>
                            {admin.stateId || '—'}
                          </span>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
