import { useState, useEffect } from 'react';
import { useAuth } from '../../contexts/AuthContext';
import { useToast } from '../../contexts/ToastContext';
import { supabase } from '../../supabase';
import { useNavigate } from 'react-router-dom';
import { Send, ArrowLeft, MessageSquare } from 'lucide-react';

export default function GrievanceApply() {
  const { user } = useAuth();
  const toast = useToast();
  const navigate = useNavigate();

  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [personnelInfo, setPersonnelInfo] = useState(null);

  const [formData, setFormData] = useState({
    subject: '',
    description: '',
  });

  useEffect(() => {
    loadPersonnelInfo();
  }, [user]);

  // Load personnel info representing the currently logged in user
  // Since we don't have a linked 'personnelId' on the basic user auth right now,
  // we'll try to match by BeltNumber or Mobile.
  async function loadPersonnelInfo() {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('personnel')
        .select('*')
        .eq('belt_number', user.beltNumber)
        .eq('is_deleted', false)
        .single();
      
      if (error && error.code !== 'PGRST116') throw error; // PGRST116 is no rows found
      
      if (data) {
        setPersonnelInfo({
          id: data.id,
          fullName: data.full_name,
          rank: data.rank,
          beltNumber: data.belt_number,
          stateId: data.state_id,
          rangeId: data.range_id,
          districtId: data.district_id,
          currentUnitId: data.current_unit_id,
          currentSubUnitId: data.current_sub_unit_id
        });
      } else {
         toast.warning('No personnel record found linked to your Belt Number.');
      }
    } catch (err) {
      console.error('Load personnel info error:', err);
      toast.error('Failed to load your profile information.');
    } finally {
      setLoading(false);
    }
  }

  function handleInputChange(e) {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  }

  async function handleSubmit(e) {
    e.preventDefault();
    
    if (!formData.subject || !formData.description) {
      toast.warning('Please fill all required fields.');
      return;
    }

    if (!personnelInfo) {
      toast.error('Cannot submit: Personnel profile not linked.');
      return;
    }

    setSubmitting(true);
    try {
      const payload = {
        applicant_name: personnelInfo.fullName || '',
        applicant_mobile: personnelInfo.mobileNumber || '', // Add mobile if available
        grievance_type: formData.subject,
        description: formData.description,
        status: 'Pending',
        
        state_id: personnelInfo.stateId || '',
        range_id: personnelInfo.rangeId || '',
        district_id: personnelInfo.districtId || '',
        unit_id: personnelInfo.currentUnitId || '',
        sub_unit_id: personnelInfo.currentSubUnitId || '',
        
        created_by_user_id: user.id || null, // Assuming user.id from AuthContext
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      };

      const { error } = await supabase.from('grievances').insert([payload]);
      if (error) throw error;

      toast.success('Grievance submitted successfully.');
      navigate('/grievances');
    } catch (err) {
      console.error('Grievance submit error:', err);
      toast.error('Failed to submit grievance.');
    } finally {
      setSubmitting(false);
    }
  }

  if (loading) {
    return (
      <div className="empty-state">
        <div className="spinner spinner-lg"></div>
        <p>Loading form...</p>
      </div>
    );
  }

  return (
    <div>
      <div className="page-header">
        <div style={{ display: 'flex', alignItems: 'center', gap: 16 }}>
          <button className="btn btn-ghost btn-icon" onClick={() => navigate('/grievances')}>
            <ArrowLeft size={20} />
          </button>
          <h2>File a Grievance</h2>
        </div>
      </div>

      <div className="panel" style={{ maxWidth: 700, margin: '0 auto' }}>
        <form onSubmit={handleSubmit} className="panel-body">
          
          <div className="form-section">
            <h3 className="form-section-title">Complainant Information</h3>
            <div style={{ 
              padding: '16px', 
              backgroundColor: 'var(--gray-50)', 
              borderRadius: '8px',
              display: 'flex',
              alignItems: 'center',
              gap: '16px',
              marginBottom: '24px'
            }}>
               <div style={{
                  width: 48, height: 48, borderRadius: '50%',
                  backgroundColor: 'var(--primary-100)', color: 'var(--primary-700)',
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  fontWeight: 600, fontSize: '1.2rem'
               }}>
                  {personnelInfo?.fullName?.[0] || 'U'}
               </div>
               <div>
                  <h4 style={{ margin: 0 }}>{personnelInfo?.fullName || 'Unknown User'}</h4>
                  <p style={{ margin: '4px 0 0 0', fontSize: '0.85rem', color: 'var(--gray-600)' }}>
                     {personnelInfo?.rank || 'No Rank'} • {personnelInfo?.beltNumber || user.beltNumber}
                  </p>
               </div>
            </div>

            <div className="form-group">
              <label className="form-label required">Subject</label>
              <input
                type="text"
                className="form-input"
                name="subject"
                value={formData.subject}
                onChange={handleInputChange}
                placeholder="Brief summary of your grievance..."
                required
                maxLength={100}
              />
            </div>

            <div className="form-group">
              <label className="form-label required">Description</label>
              <textarea
                className="form-input"
                name="description"
                value={formData.description}
                onChange={handleInputChange}
                placeholder="Provide detailed information about your issue..."
                required
                rows={6}
              />
            </div>
            
            <p style={{ fontSize: '0.8rem', color: 'var(--gray-500)', marginTop: 8 }}>
               Note: Once submitted, your grievance will be routed to your Unit or District Administrator for review. 
               You can track the status from the Grievance Register.
            </p>
          </div>

          <div className="panel-footer" style={{ marginTop: 24 }}>
            <button type="button" className="btn btn-secondary" onClick={() => navigate('/grievances')}>
              Cancel
            </button>
            <button type="submit" className="btn btn-primary" disabled={submitting || !personnelInfo}>
              {submitting ? 'Submitting...' : <><Send size={18} /> Submit Grievance</>}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
