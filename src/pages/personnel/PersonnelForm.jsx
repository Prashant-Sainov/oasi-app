import { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';
import { useToast } from '../../contexts/ToastContext';
import { db, storage } from '../../firebase';
import { collection, doc, getDoc, setDoc, updateDoc, serverTimestamp, query, where, getDocs } from 'firebase/firestore';
import { ref, uploadBytes, getDownloadURL } from 'firebase/storage';
import { Save, ArrowLeft, Camera, X } from 'lucide-react';

const RESTRICTED_RANKS = [
  'Insp', 'PSI', 'SI', 'ASI/ESI', 'ASI', 'HC/ESI', 'HC/EASI', 'HC',
  'C-1/EHC', 'C-1', 'CT/ESI', 'CT/EASI', 'CT/EHC', 'CT', 'R/CT', 'SPO'
];

const ALLOWED_RANKS = [
  'DSP (Prob)', 'Deputy Superintendent of Police (DSP)', 'Assistant Commissioner of Police (ACP)',
  'Additional Superintendent of Police (ASP)', 'Superintendent of Police (SP)',
  'Senior Superintendent of Police (SSP)', 'Deputy Inspector General of Police (DIG)',
  'Inspector General of Police (IG)', 'Additional Director General of Police (ADGP)',
  'Director General of Police (DGP)'
];

const RANKS = [...ALLOWED_RANKS, ...RESTRICTED_RANKS];
const FIXED_CATEGORIES = [
  "Police Stations",
  "Traffic",
  "Special Staffs",
  "Court",
  "Administrative Units",
  "Security",
  "Temp_Dep_Trg"
];

const CATEGORIES = ['General', 'OBC', 'SC', 'ST', 'EWS'];
const GENDERS = ['Male', 'Female', 'Other'];
const SERVICE_STATUSES = ['Active', 'Retired', 'Deceased', 'Suspended'];
const SERVICE_TYPES = ['Regular', 'Home Guard', 'SPO', 'Contractual'];

const EMPTY_FORM = {
  beltNumber: '', payCode: '', rank: '', fullName: '', fatherName: '',
  gender: '', dateOfBirth: '', religion: '', caste: '', category: '',
  cadre: '', serviceType: '', serviceBookNumber: '', dateOfEnlistment: '',
  dateOfLastPromotion: '', retirementDate: '', village: '', policeStation: '',
  homeDistrict: '', bloodGroup: '', mobileNumber: '', alternateContact: '',
  aadharNumber: '', pan: '', serviceStatus: 'Active',
  role1: '', role2: '', ioStatus: '', ioCategory: '',
  paradeGroup: '', spoTrade: '', promotionType: '', specialCourse: '',
  company: '', remarks: '',
  stateId: '', rangeId: '', districtId: '', unitType: '', currentUnitId: '', currentSubUnitId: '',
};

export default function PersonnelForm() {
  const [showPosting, setShowPosting] = useState(false);
  const { id } = useParams();
  const isEdit = !!id && id !== 'add';
  const navigate = useNavigate();
  const { user, isSuperAdmin, isStateAdmin, isRangeAdmin, isDistrictAdmin, isUnitAdmin } = useAuth();
  const toast = useToast();

  const [form, setForm] = useState({ ...EMPTY_FORM });
  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  
  const [states, setStates] = useState([]);
  const [ranges, setRanges] = useState([]);
  const [districts, setDistricts] = useState([]);
  const [unitCategories, setUnitCategories] = useState([]);
  const [units, setUnits] = useState([]);
  const [subUnits, setSubUnits] = useState([]);
  
  const [photoFile, setPhotoFile] = useState(null);
  const [photoPreview, setPhotoPreview] = useState(null);

  useEffect(() => {
    loadStates();
    if (isEdit) {
      loadPersonnel();
      setShowPosting(true);
    } else {
      // Auto-fill scope based on role for NEW personnel
      if (user) {
        setForm(prev => ({
          ...prev,
          stateId: user.stateId || '',
          rangeId: user.rangeId || '',
          districtId: user.districtId || '',
          currentUnitId: user.unitId || '',
        }));
      }
      setShowPosting(true);
    }
  }, [id, user, isEdit]);

  async function loadStates() {
    const snap = await getDocs(collection(db, 'states'));
    setStates(snap.docs.map(d => ({ id: d.id, ...d.data() })));
  }

  useEffect(() => {
    if (form.stateId) {
      loadRanges(form.stateId);
      // Only reset children if the user has permission to change them
      // (State Admin moving fields dynamically). If District Admin, it should stay auto-filled.
      if (!isEdit && isStateAdmin) {
        setForm(prev => ({ ...prev, rangeId: '', districtId: '', unitType: '', currentUnitId: '', currentSubUnitId: '' }));
      }
    }
  }, [form.stateId]);

  async function loadRanges(stateId) {
    const q = query(collection(db, 'ranges'), where('stateId', '==', stateId));
    const snap = await getDocs(q);
    setRanges(snap.docs.map(d => ({ id: d.id, ...d.data() })));
  }

  useEffect(() => {
    if (form.rangeId) {
      loadDistricts(form.rangeId);
      if (!isEdit && isStateAdmin) {
        setForm(prev => ({ ...prev, districtId: '', unitType: '', currentUnitId: '', currentSubUnitId: '' }));
      }
    }
  }, [form.rangeId]);

  async function loadDistricts(rangeId) {
    const q = query(collection(db, 'districts'), where('rangeId', '==', rangeId));
    const snap = await getDocs(q);
    setDistricts(snap.docs.map(d => ({ id: d.id, ...d.data() })));
  }

  useEffect(() => {
    if (form.districtId) {
      loadUnits(form.districtId);
      if (!isEdit && (isStateAdmin || isRangeAdmin || isDistrictAdmin)) {
         // District admin can change unit, so we might want to let them, but usually they just select unit.
         // Let's only reset unitType here if it's changing *after* initial mount or if they are state admin.
         // Since they only control unitType, it's safer to not auto-clear it on initial mount.
      }
    }
  }, [form.districtId]);

  async function loadUnits(districtId) {
    const q = query(collection(db, 'units'), where('districtId', '==', districtId));
    const snap = await getDocs(q);
    const loadedUnits = snap.docs.map(d => ({ id: d.id, ...d.data() }));
    setUnits(loadedUnits);
    
    // Derived unit categories are now fixed
    setUnitCategories(FIXED_CATEGORIES);
  }

  useEffect(() => {
    if (form.currentUnitId) {
      loadSubUnits(form.currentUnitId);
      if (!loading) setForm(prev => ({ ...prev, currentSubUnitId: '' }));
    }
  }, [form.currentUnitId]);

  async function loadSubUnits(unitId) {
    const q = query(collection(db, 'subUnits'), where('unitId', '==', unitId));
    const snap = await getDocs(q);
    setSubUnits(snap.docs.map(d => ({ id: d.id, ...d.data() })));
  }

  async function loadPersonnel() {
    try {
      setLoading(true);
      const docRef = doc(db, 'personnel', id);
      const snap = await getDoc(docRef);
      if (snap.exists()) {
        setForm({ ...EMPTY_FORM, ...snap.data() });
      } else {
        toast.error('Personnel record not found.');
        navigate('/personnel');
      }
    } catch (e) {
      console.error('Personnel load error:', e);
      toast.error('Failed to load personnel details.');
    } finally {
      setLoading(false);
    }
  }

  function handleChange(e) {
    const { name, value } = e.target;
    setForm(prev => ({ ...prev, [name]: value }));

    // Auto-fill PayCode from MobileNumber if PayCode is empty
    if (name === 'mobileNumber' && !form.payCode) {
      setForm(prev => ({ ...prev, payCode: value }));
    }
  }

  function handlePhotoChange(e) {
    const file = e.target.files[0];
    if (file) {
      if (file.size > 2 * 1024 * 1024) {
        toast.error('Image size should be less than 2MB');
        return;
      }
      setPhotoFile(file);
      const reader = new FileReader();
      reader.onloadend = () => setPhotoPreview(reader.result);
      reader.readAsDataURL(file);
    }
  }

  function removePhoto() {
    setPhotoFile(null);
    setPhotoPreview(null);
    setForm(prev => ({ ...prev, photoURL: '' }));
  }

  async function handleSubmit(e) {
    e.preventDefault();

    // Validation
    if (!form.fullName.trim()) { toast.warning('Full Name is required.'); return; }
    if (!form.mobileNumber.trim()) { toast.warning('Mobile Number is required.'); return; }
    if (!form.rank) { toast.warning('Rank is required.'); return; }

    // Backend Enforcement: State Admin rank restriction
    if (isStateAdmin && !isSuperAdmin && !ALLOWED_RANKS.includes(form.rank)) {
      toast.error('State Admins can only assign ranks of DSP and above.');
      return;
    }

    // Backend Enforcement: District Admin/Unit Admin rank restriction
    if (!isStateAdmin && !isSuperAdmin && !RESTRICTED_RANKS.includes(form.rank)) {
      toast.error('You only have permission to assign ranks below DSP (Prob).');
      return;
    }

    // Auto-fill payCode if empty
    const payCode = form.payCode.trim() || form.mobileNumber.trim();

    setSaving(true);
    try {
      let photoURL = form.photoURL || '';

      // Upload photo if a new one is selected
      if (photoFile) {
        const fileExt = photoFile.name.split('.').pop();
        const fileName = `${payCode}_${Date.now()}.${fileExt}`;
        const storageRef = ref(storage, `personnel_photos/${fileName}`);
        const snapshot = await uploadBytes(storageRef, photoFile);
        photoURL = await getDownloadURL(snapshot.ref);
      }

      const data = {
        ...form,
        payCode,
        photoURL,
        fullName: form.fullName.trim(),
        mobileNumber: form.mobileNumber.trim(),
        // Backend enforcement: ensure user cannot bypass UI restrictions
        stateId: user.stateId || form.stateId,
        rangeId: user.rangeId || form.rangeId,
        districtId: user.districtId || form.districtId,
        currentUnitId: user.unitId || form.currentUnitId,
        updatedAt: serverTimestamp(),
        updatedByUserId: user.uid,
      };

      if (isEdit) {
        await updateDoc(doc(db, 'personnel', id), data);
        toast.success('Personnel record updated successfully.');
      } else {
        const newDocRef = doc(collection(db, 'personnel'));
        data.personnelId = newDocRef.id;
        data.createdAt = serverTimestamp();
        data.createdByUserId = user.uid;
        await setDoc(newDocRef, data);
        toast.success('Personnel record created successfully.');
      }
      navigate('/personnel');
    } catch (err) {
      console.error('Save error:', err);
      toast.error('Failed to save personnel record.');
    } finally {
      setSaving(false);
    }
  }

  if (loading) {
    return (
      <div className="empty-state">
        <div className="spinner spinner-lg" style={{ margin: '0 auto' }}></div>
        <p>Loading personnel data...</p>
      </div>
    );
  }

  return (
    <div>
      <div className="page-header">
        <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
          <button className="btn btn-ghost btn-icon" onClick={() => navigate('/personnel')}>
            <ArrowLeft size={20} />
          </button>
          <h2>{isEdit ? 'Edit Personnel' : 'Add New Personnel'}</h2>
        </div>
      </div>

      <form onSubmit={handleSubmit}>
        {/* Basic Information */}
        <div className="panel" style={{ marginBottom: 'var(--space-5)' }}>
          <div className="panel-header"><h3>Basic Information</h3></div>
          <div className="panel-body">
            <div style={{ display: 'flex', gap: '2rem', marginBottom: '1.5rem', alignItems: 'flex-start' }}>
              <div style={{ flexShrink: 0 }}>
                <label className="form-label" style={{ textAlign: 'center', display: 'block' }}>Personnel Photo</label>
                <div className="photo-upload-container">
                  {photoPreview || form.photoURL ? (
                    <div style={{ position: 'relative' }}>
                      <img src={photoPreview || form.photoURL} alt="Preview" className="photo-preview-large" />
                      <button type="button" className="photo-remove-btn" onClick={removePhoto}><X size={14} /></button>
                    </div>
                  ) : (
                    <label className="photo-placeholder-large cursor-pointer">
                      <input type="file" accept="image/*" onChange={handlePhotoChange} style={{ display: 'none' }} />
                      <Camera size={32} />
                      <span>Upload Photo</span>
                    </label>
                  )}
                </div>
              </div>
              <div style={{ flexGrow: 1 }}>
                <div className="form-row" style={{ gridTemplateColumns: '1fr 1fr' }}>
                  <div className="form-group">
                    <label className="form-label">Full Name <span className="required">*</span></label>
                    <input className="form-input" name="fullName" value={form.fullName} onChange={handleChange} placeholder="Enter full name" />
                  </div>
                  <div className="form-group">
                    <label className="form-label">Father's Name</label>
                    <input className="form-input" name="fatherName" value={form.fatherName} onChange={handleChange} placeholder="Enter father's name" />
                  </div>
                </div>
                <div className="form-row" style={{ gridTemplateColumns: '1fr 1fr', marginTop: '1rem' }}>
                  <div className="form-group">
                    <label className="form-label">Belt Number</label>
                    <input className="form-input" name="beltNumber" value={form.beltNumber} onChange={handleChange} placeholder="e.g. 1234" />
                  </div>
                  <div className="form-group">
                <label className="form-label">Rank <span className="required">*</span></label>
                <select className="form-select" name="rank" value={form.rank} onChange={handleChange} required>
                  <option value="">Select</option>
                  {(() => {
                    const rankList = isStateAdmin && !isSuperAdmin
                      ? ALLOWED_RANKS
                      : (!isStateAdmin && !isSuperAdmin ? RESTRICTED_RANKS : RANKS);
                    return rankList.map(r => (
                      <option key={r} value={r}>{r}</option>
                    ));
                  })()}
                </select>
              </div>
                </div>
              </div>
            </div>
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">Mobile Number <span className="required">*</span></label>
                <input className="form-input" name="mobileNumber" value={form.mobileNumber} onChange={handleChange} placeholder="10-digit mobile" type="tel" />
              </div>
              <div className="form-group">
                <label className="form-label">Pay Code <span className="form-hint">(Auto-filled from Mobile)</span></label>
                <input className="form-input" name="payCode" value={form.payCode} onChange={handleChange} placeholder="Pay Code or Mobile No." />
              </div>
            </div>
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">Gender</label>
                <select className="form-select" name="gender" value={form.gender} onChange={handleChange}>
                  <option value="">Select</option>
                  {GENDERS.map(g => <option key={g} value={g}>{g}</option>)}
                </select>
              </div>
              <div className="form-group">
                <label className="form-label">Date of Birth</label>
                <input className="form-input" type="date" name="dateOfBirth" value={form.dateOfBirth} onChange={handleChange} />
              </div>
              <div className="form-group">
                <label className="form-label">Blood Group</label>
                <select className="form-select" name="bloodGroup" value={form.bloodGroup} onChange={handleChange}>
                  <option value="">Select</option>
                  {['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'].map(bg => <option key={bg} value={bg}>{bg}</option>)}
                </select>
              </div>
            </div>
          </div>
        </div>

        {/* Service Information */}
        <div className="panel" style={{ marginBottom: 'var(--space-5)' }}>
          <div className="panel-header"><h3>Service Details</h3></div>
          <div className="panel-body">
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">Service Type</label>
                <select className="form-select" name="serviceType" value={form.serviceType} onChange={handleChange}>
                  <option value="">Select</option>
                  {SERVICE_TYPES.map(st => <option key={st} value={st}>{st}</option>)}
                </select>
              </div>
              <div className="form-group">
                <label className="form-label">Service Status</label>
                <select className="form-select" name="serviceStatus" value={form.serviceStatus} onChange={handleChange}>
                  {SERVICE_STATUSES.map(s => <option key={s} value={s}>{s}</option>)}
                </select>
              </div>
              <div className="form-group">
                <label className="form-label">Cadre</label>
                <input className="form-input" name="cadre" value={form.cadre} onChange={handleChange} />
              </div>
            </div>
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">Date of Enlistment</label>
                <input className="form-input" type="date" name="dateOfEnlistment" value={form.dateOfEnlistment} onChange={handleChange} />
              </div>
              <div className="form-group">
                <label className="form-label">Date of Last Promotion</label>
                <input className="form-input" type="date" name="dateOfLastPromotion" value={form.dateOfLastPromotion} onChange={handleChange} />
              </div>
              <div className="form-group">
                <label className="form-label">Retirement Date</label>
                <input className="form-input" type="date" name="retirementDate" value={form.retirementDate} onChange={handleChange} />
              </div>
            </div>
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">Service Book Number</label>
                <input className="form-input" name="serviceBookNumber" value={form.serviceBookNumber} onChange={handleChange} />
              </div>
              <div className="form-group">
                <label className="form-label">Promotion Type</label>
                <input className="form-input" name="promotionType" value={form.promotionType} onChange={handleChange} />
              </div>
              <div className="form-group">
                <label className="form-label">Special Course</label>
                <input className="form-input" name="specialCourse" value={form.specialCourse} onChange={handleChange} />
              </div>
            </div>
          </div>
        </div>

        {/* Category & Identity */}
        <div className="panel" style={{ marginBottom: 'var(--space-5)' }}>
          <div className="panel-header"><h3>Category & Identity</h3></div>
          <div className="panel-body">
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">Religion</label>
                <input className="form-input" name="religion" value={form.religion} onChange={handleChange} />
              </div>
              <div className="form-group">
                <label className="form-label">Caste</label>
                <input className="form-input" name="caste" value={form.caste} onChange={handleChange} />
              </div>
              <div className="form-group">
                <label className="form-label">Category</label>
                <select className="form-select" name="category" value={form.category} onChange={handleChange}>
                  <option value="">Select</option>
                  {CATEGORIES.map(c => <option key={c} value={c}>{c}</option>)}
                </select>
              </div>
            </div>
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">Aadhar Number</label>
                <input className="form-input" name="aadharNumber" value={form.aadharNumber} onChange={handleChange} placeholder="XXXX-XXXX-XXXX" />
              </div>
              <div className="form-group">
                <label className="form-label">PAN</label>
                <input className="form-input" name="pan" value={form.pan} onChange={handleChange} />
              </div>
              <div className="form-group">
                <label className="form-label">Alternate Contact</label>
                <input className="form-input" name="alternateContact" value={form.alternateContact} onChange={handleChange} type="tel" />
              </div>
            </div>
          </div>
        </div>

        {/* Posting Details Restricted per Role - Removed for all admins per request */}
        {isSuperAdmin && (
          <div className="panel" style={{ marginBottom: 'var(--space-5)' }}>
            <div className="panel-header">
              <h3>Current Posting (Super Admin Only)</h3>
            </div>
            <div className="panel-body">
              <div className="form-row" style={{ gridTemplateColumns: 'repeat(3, 1fr)', marginBottom: '1rem' }}>
                <div className="form-group">
                  <label className="form-label">State</label>
                  <select className="form-select" name="stateId" value={form.stateId} onChange={handleChange}>
                    <option value="">Select State</option>
                    {states.map(s => <option key={s.id} value={s.id}>{s.stateName}</option>)}
                  </select>
                </div>

                <div className="form-group">
                  <label className="form-label">Range</label>
                  <select className="form-select" name="rangeId" value={form.rangeId} onChange={handleChange} disabled={!form.stateId}>
                    <option value="">Select Range</option>
                    {ranges.map(r => <option key={r.id} value={r.id}>{r.rangeName}</option>)}
                  </select>
                </div>

                <div className="form-group">
                  <label className="form-label">District</label>
                  <select className="form-select" name="districtId" value={form.districtId} onChange={handleChange} disabled={!form.rangeId}>
                    <option value="">Select District</option>
                    {districts.map(d => <option key={d.id} value={d.id}>{d.districtName}</option>)}
                  </select>
                </div>
              </div>
              
              <div className="form-row" style={{ gridTemplateColumns: 'repeat(3, 1fr)' }}>
                <div className="form-group">
                  <label className="form-label">Unit Category</label>
                  <select className="form-select" name="unitType" value={form.unitType} onChange={handleChange} disabled={!form.districtId}>
                    <option value="">Select Category</option>
                    {unitCategories.map(c => <option key={c} value={c}>{c}</option>)}
                  </select>
                </div>

                <div className="form-group">
                  <label className="form-label">Unit</label>
                  <select className="form-select" name="currentUnitId" value={form.currentUnitId} onChange={handleChange} disabled={!form.unitType}>
                    <option value="">Select Unit</option>
                    {units.filter(u => u.unitType === form.unitType || !form.unitType).map(u => (
                      <option key={u.id} value={u.id}>{u.unitName}</option>
                    ))}
                  </select>
                </div>

                <div className="form-group">
                  <label className="form-label">Sub-Unit</label>
                  <select className="form-select" name="currentSubUnitId" value={form.currentSubUnitId} onChange={handleChange} disabled={!form.currentUnitId}>
                    <option value="">Select Sub-Unit</option>
                    {subUnits.map(su => <option key={su.id} value={su.id}>{su.subUnitName}</option>)}
                  </select>
                </div>
              </div>
            </div>
          </div>
        )}

        {/* Duty/Role Information */}
        <div className="panel" style={{ marginBottom: 'var(--space-5)' }}>
          <div className="panel-header"><h3>Duty & Role</h3></div>
          <div className="panel-body">
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">Role 1</label>
                <input className="form-input" name="role1" value={form.role1} onChange={handleChange} />
              </div>
              <div className="form-group">
                <label className="form-label">Role 2</label>
                <input className="form-input" name="role2" value={form.role2} onChange={handleChange} />
              </div>
              <div className="form-group">
                <label className="form-label">IO Status</label>
                <input className="form-input" name="ioStatus" value={form.ioStatus} onChange={handleChange} />
              </div>
            </div>
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">IO Category</label>
                <input className="form-input" name="ioCategory" value={form.ioCategory} onChange={handleChange} />
              </div>
              <div className="form-group">
                <label className="form-label">Parade Group</label>
                <input className="form-input" name="paradeGroup" value={form.paradeGroup} onChange={handleChange} />
              </div>
              <div className="form-group">
                <label className="form-label">SPO Trade</label>
                <input className="form-input" name="spoTrade" value={form.spoTrade} onChange={handleChange} />
              </div>
            </div>
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">Company</label>
                <input className="form-input" name="company" value={form.company} onChange={handleChange} />
              </div>
              <div className="form-group" style={{ gridColumn: '2 / -1' }}>
                <label className="form-label">Remarks</label>
                <textarea className="form-textarea" name="remarks" value={form.remarks} onChange={handleChange} rows={2} />
              </div>
            </div>
          </div>
        </div>

        {/* Submit */}
        <div style={{ display: 'flex', gap: 12, justifyContent: 'flex-end', marginBottom: 40 }}>
          <button type="button" className="btn btn-secondary" onClick={() => navigate('/personnel')}>Cancel</button>
          <button type="submit" className="btn btn-primary btn-lg" disabled={saving}>
            {saving ? <><span className="spinner" style={{ width: 16, height: 16 }}></span> Saving...</> : <><Save size={18} /> {isEdit ? 'Update' : 'Save'} Personnel</>}
          </button>
        </div>
      </form>
    </div>
  );
}
