import { useState, useEffect, useMemo } from 'react';
import { useAuth } from '../../contexts/AuthContext';
import { useToast } from '../../contexts/ToastContext';
import { supabase } from '../../supabase';
import { useNavigate } from 'react-router-dom';
import { 
  MessageSquare, Search, Plus, CheckCircle, 
  Clock, XCircle, AlertCircle, ChevronRight,
  MoreVertical, Send, User, Calendar
} from 'lucide-react';

const GRIEVANCE_STATUSES = [
  { value: 'Open', label: 'Open', color: 'badge-danger' },
  { value: 'InProgress', label: 'In Progress', color: 'badge-warning' },
  { value: 'Resolved', label: 'Resolved', color: 'badge-success' },
  { value: 'Closed', label: 'Closed', color: 'badge-neutral' },
];

export default function GrievanceList() {
  const { user, isRangeAdmin, isDistrictAdmin, isUnitAdmin, isStateAdmin, isSuperAdmin } = useAuth();
  const toast = useToast();
  const navigate = useNavigate();

  const [grievances, setGrievances] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [statusFilter, setStatusFilter] = useState('');

  useEffect(() => {
    fetchGrievances();
  }, [user]);

  async function fetchGrievances() {
    try {
      setLoading(true);
      
      let queryBuilder = supabase
        .from('grievances')
        .select('*')
        .order('created_at', { ascending: false });

      // Role-based filtering
      if (isUnitAdmin && user.unitId) {
        queryBuilder = queryBuilder.eq('unit_id', user.unitId);
      } else if (isDistrictAdmin && user.districtId) {
        queryBuilder = queryBuilder.eq('district_id', user.districtId);
      } else if (isRangeAdmin && user.rangeId) {
        queryBuilder = queryBuilder.eq('range_id', user.rangeId);
      } else if (!isStateAdmin && !isSuperAdmin) {
        // Staff/Basic user only sees their own submissions
        queryBuilder = queryBuilder.eq('created_by_user_id', user.id);
      }

      const { data, error } = await queryBuilder;
      if (error) throw error;

      setGrievances(data.map(g => ({
        id: g.id,
        personnelName: g.applicant_name,
        subject: g.grievance_type,
        description: g.description,
        status: g.status,
        beltNumber: g.belt_number,
        createdAt: g.created_at,
        ...g
      })));
    } catch (err) {
      console.error('Fetch grievances error:', err);
      toast.error('Failed to load grievances.');
    } finally {
      setLoading(false);
    }
  }

  const filteredItems = useMemo(() => {
    return grievances.filter(g => {
      if (statusFilter && g.status !== statusFilter) return false;
      if (searchTerm) {
        const term = searchTerm.toLowerCase();
        return (
          (g.subject || '').toLowerCase().includes(term) ||
          (g.personnelName || '').toLowerCase().includes(term) ||
          (g.beltNumber || '').toLowerCase().includes(term)
        );
      }
      return true;
    });
  }, [grievances, searchTerm, statusFilter]);

  async function updateStatus(id, newStatus) {
    try {
      const gDoc = doc(db, 'grievances', id);
      await updateDoc(gDoc, {
        status: newStatus,
        updatedAt: serverTimestamp(),
        resolvedByUserId: newStatus === 'Resolved' || newStatus === 'Closed' ? (user.uid || user.userId) : null,
        resolvedAt: newStatus === 'Resolved' || newStatus === 'Closed' ? serverTimestamp() : null,
      });

      setGrievances(prev => prev.map(g => g.id === id ? { ...g, status: newStatus } : g));
      toast.success(`Grievance marked as ${newStatus}.`);
    } catch (err) {
      console.error('Update grievance error:', err);
      toast.error('Failed to update status.');
    }
  }

  // Formatting date for display
  const formatDate = (timestamp) => {
    if (!timestamp) return '—';
    // Handle both Firestore Timestamp object and Date string formats depending on how it was saved
    const date = timestamp.seconds ? new Date(timestamp.seconds * 1000) : new Date(timestamp);
    return date.toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' });
  };

  return (
    <div>
      <div className="page-header">
        <h2>Grievance Redressal</h2>
        <div className="page-header-actions">
          <button className="btn btn-primary" onClick={() => navigate('/grievances/new')}>
            <Plus size={18} /> File Grievance
          </button>
        </div>
      </div>

      <div className="panel">
        <div className="panel-header">
          <div className="search-filter-bar">
            <div className="search-input-wrapper">
              <Search className="search-icon" size={18} />
              <input
                type="text"
                placeholder="Search subject, name, belt no..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
              />
            </div>
            <select
              className="filter-select"
              value={statusFilter}
              onChange={(e) => setStatusFilter(e.target.value)}
            >
              <option value="">All Statuses</option>
              {GRIEVANCE_STATUSES.map(s => <option key={s.value} value={s.value}>{s.label}</option>)}
            </select>
          </div>
        </div>

        <div className="table-container">
          {loading ? (
            <div className="empty-state">
              <div className="spinner spinner-lg"></div>
              <p>Loading grievances...</p>
            </div>
          ) : filteredItems.length === 0 ? (
            <div className="empty-state">
              <MessageSquare className="icon" />
              <h4>No grievances found</h4>
              <p>No complaints match your current filters.</p>
            </div>
          ) : (
            <table className="data-table">
              <thead>
                <tr>
                  <th>Date</th>
                  <th>Personnel (Complainant)</th>
                  <th>Subject</th>
                  <th>Status</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                {filteredItems.map(g => (
                  <tr key={g.id}>
                    <td>
                      <span style={{ fontSize: '0.85rem', color: 'var(--gray-600)' }}>
                        {formatDate(g.createdAt)}
                      </span>
                    </td>
                    <td>
                      <div style={{ display: 'flex', flexDirection: 'column' }}>
                        <span style={{ fontWeight: 600 }}>{g.personnelName}</span>
                        <span style={{ fontSize: '0.75rem', color: 'var(--gray-500)' }}>
                          {g.beltNumber}
                        </span>
                      </div>
                    </td>
                    <td style={{ maxWidth: 300 }}>
                      <div style={{ display: 'flex', flexDirection: 'column' }}>
                        <span style={{ fontWeight: 600, color: 'var(--gray-900)' }}>{g.subject}</span>
                        <span style={{ 
                          fontSize: '0.8rem', 
                          color: 'var(--gray-500)',
                          whiteSpace: 'nowrap',
                          overflow: 'hidden',
                          textOverflow: 'ellipsis' 
                        }}>
                          {g.description}
                        </span>
                      </div>
                    </td>
                    <td>
                      <span className={`badge ${GRIEVANCE_STATUSES.find(s => s.value === g.status)?.color}`}>
                        {g.status}
                      </span>
                    </td>
                    <td>
                      <div style={{ display: 'flex', gap: 4 }}>
                        {user.role !== 'staff' && g.status === 'Open' && (
                          <button
                            className="btn btn-warning btn-sm"
                            onClick={() => updateStatus(g.id, 'InProgress')}
                            title="Acknowledge and mark In Progress"
                          >
                            Investigate
                          </button>
                        )}
                        {user.role !== 'staff' && g.status === 'InProgress' && (
                          <button
                            className="btn btn-success btn-sm"
                            onClick={() => updateStatus(g.id, 'Resolved')}
                          >
                            Resolve
                          </button>
                        )}
                        <button className="btn btn-ghost btn-sm">
                          Details
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </div>
      </div>
    </div>
  );
}
