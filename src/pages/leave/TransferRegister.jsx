import { useState, useEffect, useMemo } from 'react';
import { useAuth } from '../../contexts/AuthContext';
import { useToast } from '../../contexts/ToastContext';
import { db } from '../../firebase';
import {
  collection, query, where, getDocs, doc, updateDoc,
  serverTimestamp, orderBy, getDoc
} from 'firebase/firestore';
import {
  RefreshCw, Plus, Search, CheckCircle, XCircle,
  Clock, MapPin, ArrowRight
} from 'lucide-react';
import { useNavigate } from 'react-router-dom';

const TRANSFER_STATUSES = [
  { value: 'Pending', label: 'Pending', color: 'badge-warning' },
  { value: 'Approved', label: 'Approved', color: 'badge-success' },
  { value: 'Rejected', label: 'Rejected', color: 'badge-danger' },
  { value: 'Transferred', label: 'Completed', color: 'badge-primary' },
];

export default function TransferRegister() {
  const { user, isRangeAdmin, isDistrictAdmin, isUnitAdmin } = useAuth();
  const toast = useToast();
  const navigate = useNavigate();

  const [transfers, setTransfers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [statusFilter, setStatusFilter] = useState('');

  useEffect(() => {
    loadTransfers();
  }, [user]);

  async function loadTransfers() {
    try {
      setLoading(true);
      const ref = collection(db, 'transferRegister');
      let q = query(ref, orderBy('createdAt', 'desc'));

      // If unit admin, only see transfers originating from or coming to this unit
      // Since Firestore doesn't support OR queries well in this context, we fetch all for district and filter locally
      // For a real app with many records, we'd need a better index strategy
      if (user.role === 'district_admin' || user.role === 'unit_admin') {
         // Simplify: just fetch all and filter in memory for now based on role
      }

      const snap = await getDocs(q);
      const data = snap.docs.map(d => ({ id: d.id, ...d.data() }));
      
      setTransfers(data);
      if (user.role === 'unit_admin' && user.unitId) {
        setTransfers(data.filter(t => t.fromUnitId === user.unitId || t.toUnitId === user.unitId));
      } else if (user.role === 'district_admin' && user.districtId) {
        setTransfers(data.filter(t => t.districtId === user.districtId));
      } else if (user.role === 'range_admin' && user.rangeId) {
        setTransfers(data.filter(t => t.rangeId === user.rangeId));
      }
    } catch (err) {
      console.error('Load transfers error:', err);
      toast.error('Failed to load transfers.');
    } finally {
      setLoading(false);
    }
  }

  const filteredTransfers = useMemo(() => {
    return transfers.filter(t => {
      if (statusFilter && t.status !== statusFilter) return false;
      if (searchTerm) {
        const term = searchTerm.toLowerCase();
        return (
          (t.personnelName || '').toLowerCase().includes(term) ||
          (t.beltNumber || '').toLowerCase().includes(term) ||
          (t.orderNumber || '').toLowerCase().includes(term)
        );
      }
      return true;
    });
  }, [transfers, searchTerm, statusFilter]);

  async function updateStatus(transferId, newStatus) {
    try {
      const tDoc = doc(db, 'transferRegister', transferId);
      const transferData = transfers.find(t => t.id === transferId);

      // If marking as Transferred (Completed), we need to update the personnel record
      if (newStatus === 'Transferred') {
        const pRef = doc(db, 'personnel', transferData.personnelId);
        await updateDoc(pRef, {
          currentUnitId: transferData.toUnitId,
          currentSubUnitId: transferData.toSubUnitId || '',
          updatedAt: serverTimestamp(),
          updatedByUserId: user.uid || user.userId
        });
      }

      await updateDoc(tDoc, {
        status: newStatus,
        updatedAt: serverTimestamp(),
        approvedByUserId: user.uid || user.userId,
        approvedAt: newStatus === 'Approved' ? serverTimestamp() : null,
      });

      setTransfers(prev => prev.map(t => t.id === transferId ? { ...t, status: newStatus } : t));
      toast.success(`Transfer marked as ${newStatus}.`);
    } catch (err) {
      console.error('Update transfer error:', err);
      toast.error('Failed to update transfer status.');
    }
  }

  return (
    <div>
      <div className="page-header">
        <h2>Transfer Register</h2>
        <div className="page-header-actions">
          {user.role !== 'staff' && (
             <button className="btn btn-primary" onClick={() => navigate('/transfer/apply')}>
               <Plus size={18} /> Initiate Transfer
             </button>
          )}
        </div>
      </div>

      <div className="panel">
        <div className="panel-header">
          <div className="search-filter-bar">
            <div className="search-input-wrapper">
              <Search className="search-icon" size={18} />
              <input
                type="text"
                placeholder="Search name, belt no, order no..."
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
              {TRANSFER_STATUSES.map(s => <option key={s.value} value={s.value}>{s.label}</option>)}
            </select>
          </div>
        </div>

        <div className="table-container">
          {loading ? (
            <div className="empty-state">
              <div className="spinner spinner-lg"></div>
              <p>Loading transfer records...</p>
            </div>
          ) : filteredTransfers.length === 0 ? (
            <div className="empty-state">
              <RefreshCw className="icon" />
              <h4>No transfers found</h4>
              <p>No transfer orders match your criteria.</p>
            </div>
          ) : (
            <table className="data-table">
              <thead>
                <tr>
                  <th>Personnel</th>
                  <th>Order No & Date</th>
                  <th>Transfer Details</th>
                  <th>Status</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                {filteredTransfers.map(t => (
                  <tr key={t.id}>
                    <td>
                      <div style={{ display: 'flex', flexDirection: 'column' }}>
                        <span style={{ fontWeight: 600 }}>{t.personnelName}</span>
                        <span style={{ fontSize: '0.75rem', color: 'var(--gray-500)' }}>
                          {t.beltNumber} • {t.rank}
                        </span>
                      </div>
                    </td>
                    <td>
                      <div style={{ display: 'flex', flexDirection: 'column' }}>
                        <span style={{ fontWeight: 600 }}>{t.orderNumber || '—'}</span>
                        <span style={{ fontSize: '0.75rem', color: 'var(--gray-500)' }}>
                          {t.transferDate}
                        </span>
                      </div>
                    </td>
                    <td>
                      <div style={{ fontSize: '0.85rem', display: 'flex', alignItems: 'center', gap: 6 }}>
                        <MapPin size={14} className="text-gray-400" />
                        <span>{t.fromUnitName}</span>
                        <ArrowRight size={14} className="text-gray-400" />
                        <span style={{ fontWeight: 600, color: 'var(--primary-600)' }}>{t.toUnitName}</span>
                      </div>
                    </td>
                    <td>
                      <span className={`badge ${TRANSFER_STATUSES.find(s => s.value === t.status)?.color}`}>
                        {t.status}
                      </span>
                    </td>
                    <td>
                      <div style={{ display: 'flex', gap: 4 }}>
                        {t.status === 'Pending' && (user.role === 'state_admin' || user.role === 'district_admin') && (
                          <>
                            <button
                              className="btn btn-success btn-sm"
                              onClick={() => updateStatus(t.id, 'Approved')}
                            >
                              Approve
                            </button>
                            <button
                              className="btn btn-danger btn-sm"
                              onClick={() => updateStatus(t.id, 'Rejected')}
                            >
                              Reject
                            </button>
                          </>
                        )}
                        {t.status === 'Approved' && (
                          <button
                            className="btn btn-primary btn-sm"
                            onClick={() => updateStatus(t.id, 'Transferred')}
                            title="Mark as virtually completed and move personnel to new unit"
                          >
                            Complete Transfer
                          </button>
                        )}
                        {t.documentUrl && (
                          <a href={t.documentUrl} target="_blank" rel="noopener noreferrer" className="btn btn-ghost btn-sm">
                            View Order
                          </a>
                        )}
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
