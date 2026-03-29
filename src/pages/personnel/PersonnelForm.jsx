import { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';
import { useToast } from '../../contexts/ToastContext';
import { db, storage } from '../../firebase';
import { collection, doc, getDoc, setDoc, updateDoc, serverTimestamp, query, where, getDocs } from 'firebase/firestore';
import { ref, uploadBytes, getDownloadURL } from 'firebase/storage';
import { Save, ArrowLeft, Camera, X } from 'lucide-react';
import { validateMobile, validateAadhar, validatePAN, validateDateOfBirth, validateDateOrder, maskAadhar, maskPAN } from '../../utils/validators';
import { useLocation } from 'react-router-dom';

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
  const location = useLocation();
  const isEdit = !!id && id !== 'add' && location.pathname.endsWith('/edit');
  const isView = !!id && id !== 'add' && !location.pathname.endsWith('/edit');
  
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

  // Dynamic Dropdown Master
  const [masterRanks, setMasterRanks] = useState([]);
  const [masterCategories, setMasterCategories] = useState([]);
  const [masterGenders, setMasterGenders] = useState([]);
  const [masterReligions, setMasterReligions] = useState([]);
  const [masterCastes, setMasterCastes] = useState([]);
  const [masterCadres, setMasterCadres] = useState([]);
  const [masterServiceTypes, setMasterServiceTypes] = useState([]);
  const [masterServiceStatuses, setMasterServiceStatuses] = useState([]);

  useEffect(() => {
    loadStates();
    loadCategories();
    loadMasterData();
    if (isEdit || isView) {
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
    if (!isSuperAdmin) return;
    const snap = await getDocs(collection(db, 'states'));
    setStates(snap.docs.map(d => ({ id: d.id, ...d.data() })));
  }

  async function loadCategories() {
    try {
      const q = query(collection(db, 'unitCategories'));
      const snap = await getDocs(q);
      setUnitCategories(snap.docs.map(d => d.data().name));
    } catch (err) {
      if (import.meta.env.DEV) console.error('Failed to load categories:', err);
    }
  }

  async function loadMasterData() {
    if (!user?.stateId) return;
    try {
      const q = query(
        collection(db, 'masterData'),
        where('stateId', '==', user.stateId),
        where('isActive', '==', true)
      );
      const snap = await getDocs(q);
      const all = snap.docs.map(d => ({ id: d.id, ...d.data() }));

      // Access Level Checker
      const hasAccess = (record) => {
        const level = record.accessLevel || 'all';
        if (level === 'all') return true;

        // "Only" - Exact Match
        if (level === 'super_admin_only') return isSuperAdmin;
        if (level === 'state_admin_only') return isStateAdmin;
        if (level === 'range_admin_only') return isRangeAdmin;
        if (level === 'district_admin_only') return isDistrictAdmin;
        if (level === 'unit_admin_only') return isUnitAdmin;

        // "Plus" - Hierarchical
        if (level === 'state_admin_plus') return isStateAdmin || isSuperAdmin;
        if (level === 'range_admin_plus') return isRangeAdmin || isStateAdmin || isSuperAdmin;
        if (level === 'district_admin_plus') return isDistrictAdmin || isRangeAdmin || isStateAdmin || isSuperAdmin;
        if (level === 'unit_admin_plus') return isUnitAdmin || isDistrictAdmin || isRangeAdmin || isStateAdmin || isSuperAdmin;

        return true;
      };

      const sortFn = (a, b) => (a.displayOrder || 0) - (b.displayOrder || 0);
      const getValues = (type) => all.filter(r => r.fieldType === type && hasAccess(r)).sort(sortFn);

      setMasterRanks(getValues('rank'));
      setMasterCategories(getValues('category'));
      setMasterGenders(getValues('gender'));
      setMasterReligions(getValues('religion'));
      setMasterCastes(getValues('caste'));
      setMasterCadres(getValues('cadre'));
      setMasterServiceTypes(getValues('serviceType'));
      setMasterServiceStatuses(getValues('serviceStatus'));
    } catch (err) {
      if (import.meta.env.DEV) console.error('Failed to load dropdown master data:', err);
    }
  }

  useEffect(() => {
    if (form.stateId) {
      loadRanges(form.stateId);
      if (!isEdit && !isView && isStateAdmin) {
        setForm(prev => ({ ...prev, rangeId: '', districtId: '', unitType: '', currentUnitId: '', currentSubUnitId: '' }));
      }
    }
  }, [form.stateId]);

  async function loadRanges(stateId) {
    if (!isSuperAdmin && !isStateAdmin) return;
    const q = query(collection(db, 'ranges'), where('stateId', '==', stateId));
    const snap = await getDocs(q);
    setRanges(snap.docs.map(d => ({ id: d.id, ...d.data() })));
  }

  useEffect(() => {
    if (form.rangeId) {
      loadDistricts(form.rangeId);
      if (!isEdit && !isView && isStateAdmin) {
        setForm(prev => ({ ...prev, districtId: '', unitType: '', currentUnitId: '', currentSubUnitId: '' }));
      }
    }
  }, [form.rangeId]);

  async function loadDistricts(rangeId) {
    if (!isSuperAdmin && !isStateAdmin && !isRangeAdmin) return;
    const q = query(collection(db, 'districts'), where('rangeId', '==', rangeId));
    const snap = await getDocs(q);
    setDistricts(snap.docs.map(d => ({ id: d.id, ...d.data() })));
  }

  useEffect(() => {
    // Dynamic fetch completes on mount, no need to overwrite category state here
  }, [form.districtId]);

  useEffect(() => {
    if (form.districtId && form.unitType) {
      loadUnits(form.districtId, form.unitType);
    } else {
      setUnits([]);
    }
  }, [form.districtId, form.unitType]);

  async function loadUnits(districtId, unitType) {
    if (!districtId || !unitType) return;
    if (!isSuperAdmin && !isStateAdmin && !isRangeAdmin && !isDistrictAdmin) return;
    try {
      const q = query(collection(db, 'units'), where('districtId', '==', districtId), where('unitType', '==', unitType));
      const snap = await getDocs(q);
      const loadedUnits = snap.docs.map(d => ({ id: d.id, ...d.data() }));
      setUnits(loadedUnits);
    } catch (err) {
      if (import.meta.env.DEV) console.error('Failed to load units:', err);
    }
  }

  useEffect(() => {
    if (form.currentUnitId && form.districtId) {
      loadSubUnits(form.currentUnitId, form.districtId);
      if (!loading) setForm(prev => ({ ...prev, currentSubUnitId: '' }));
    } else {
      setSubUnits([]);
    }
  }, [form.currentUnitId, form.districtId]);

  async function loadSubUnits(unitId, districtId) {
    if (!unitId || !districtId) return;
    try {
      const q = query(collection(db, 'subUnits'), where('unitId', '==', unitId), where('districtId', '==', districtId));
      const snap = await getDocs(q);
      setSubUnits(snap.docs.map(d => ({ id: d.id, ...d.data() })));
    } catch (err) {
      if (import.meta.env.DEV) console.error('Failed to load sub-units:', err);
    }
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
      if (import.meta.env.DEV) console.error('Personnel load error:', e);
      toast.error('Failed to load personnel details.');
    } finally {
      setLoading(false);
    }
  }

  function handleChange(e) {
    const { name, value } = e.target;
    
    setForm(prev => {
      let updated = { ...prev, [name]: value };
      
      // Hierarchy dependency cleaning
      if (name === 'stateId') {
        updated.rangeId = '';
        updated.districtId = '';
        updated.unitType = '';
        updated.currentUnitId = '';
        updated.currentSubUnitId = '';
      }
      if (name === 'rangeId') {
        updated.districtId = '';
        updated.unitType = '';
        updated.currentUnitId = '';
        updated.currentSubUnitId = '';
      }
      if (name === 'districtId') {
        updated.unitType = '';
        updated.currentUnitId = '';
        updated.currentSubUnitId = '';
      }
      if (name === 'unitType') {
        updated.currentUnitId = '';
        updated.currentSubUnitId = '';
      }
      if (name === 'currentUnitId') {
        updated.currentSubUnitId = '';
      }
      
      // Auto-fill PayCode from MobileNumber if PayCode is empty
      if (name === 'mobileNumber' && !prev.payCode) {
        updated.payCode = value;
      }

      return updated;
    });
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

    // Required fields
    if (!form.fullName.trim()) { toast.warning('Full Name is required.'); return; }
    if (!form.mobileNumber.trim()) { toast.warning('Mobile Number is required.'); return; }
    if (!form.rank) { toast.warning('Rank is required.'); return; }

    // Mobile validation
    const mobileCheck = validateMobile(form.mobileNumber.trim());
    if (!mobileCheck.valid) { toast.error(mobileCheck.message); return; }

    // Aadhar validation (optional field)
    if (form.aadharNumber) {
      const aadharCheck = validateAadhar(form.aadharNumber);
      if (!aadharCheck.valid) { toast.error(aadharCheck.message); return; }
    }

    // PAN validation (optional field)
    if (form.pan) {
      const panCheck = validatePAN(form.pan);
      if (!panCheck.valid) { toast.error(panCheck.message); return; }
    }

    // Date of birth validation
    if (form.dateOfBirth) {
      const dobCheck = validateDateOfBirth(form.dateOfBirth);
      if (!dobCheck.valid) { toast.error(dobCheck.message); return; }
    }

    // Date logic validations
    if (form.dateOfBirth && form.dateOfEnlistment) {
      const order = validateDateOrder(form.dateOfBirth, form.dateOfEnlistment, 'Date of Birth', 'Date of Enlistment');
      if (!order.valid) { toast.error(order.message); return; }
    }
    if (form.dateOfEnlistment && form.retirementDate) {
      const order = validateDateOrder(form.dateOfEnlistment, form.retirementDate, 'Date of Enlistment', 'Retirement Date');
      if (!order.valid) { toast.error(order.message); return; }
    }

    // Rank restriction enforcement (dynamic)
    const isRankAllowed = masterRanks.some(r => r.value === form.rank);
    if (!isRankAllowed && form.rank) {
      toast.error('This rank is not permitted for your role.');
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
        stateId: !isSuperAdmin ? user.stateId : form.stateId,
        rangeId: (!isSuperAdmin && !isStateAdmin) ? user.rangeId : form.rangeId,
        districtId: (!isSuperAdmin && !isStateAdmin && !isRangeAdmin) ? user.districtId : form.districtId,
        currentUnitId: (!isSuperAdmin && !isStateAdmin && !isRangeAdmin && !isDistrictAdmin) ? user.unitId : form.currentUnitId,
        updatedAt: serverTimestamp(),
        updatedByUserId: user.uid,
      };

      if (isEdit) {
        await updateDoc(doc(db, 'personnel', id), data);
        toast.success('Personnel record updated successfully.');
        navigate(`/personnel/${id}`); // Go back to view
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
      if (import.meta.env.DEV) console.error('Save error:', err);
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
          <h2>{isEdit ? 'Edit Personnel' : (isView ? 'Personnel Details' : 'Add New Personnel')}</h2>
        </div>
        {isView && (
          <button className="btn btn-secondary" onClick={() => navigate(`/personnel/${id}/edit`)}>
            <Edit size={16} /> Edit Record
          </button>
        )}
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
                  {masterRanks.map(r => (
                    <option key={r.id} value={r.value}>{r.value}</option>
                  ))}
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
                  {masterGenders.map(g => <option key={g.id} value={g.value}>{g.value}</option>)}
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
                  {masterServiceTypes.map(st => <option key={st.id} value={st.value}>{st.value}</option>)}
                </select>
              </div>
              <div className="form-group">
                <label className="form-label">Service Status</label>
                <select className="form-select" name="serviceStatus" value={form.serviceStatus} onChange={handleChange}>
                  {masterServiceStatuses.map(s => <option key={s.id} value={s.value}>{s.value}</option>)}
                </select>
              </div>
              <div className="form-group">
                <label className="form-label">Cadre</label>
                <select className="form-select" name="cadre" value={form.cadre} onChange={handleChange}>
                  <option value="">Select</option>
                  {masterCadres.map(c => <option key={c.id} value={c.value}>{c.value}</option>)}
                </select>
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
                <select className="form-select" name="religion" value={form.religion} onChange={handleChange}>
                  <option value="">Select</option>
                  {masterReligions.map(r => <option key={r.id} value={r.value}>{r.value}</option>)}
                </select>
              </div>
              <div className="form-group">
                <label className="form-label">Caste</label>
                <select className="form-select" name="caste" value={form.caste} onChange={handleChange}>
                  <option value="">Select</option>
                  {masterCastes.map(c => <option key={c.id} value={c.value}>{c.value}</option>)}
                </select>
              </div>
              <div className="form-group">
                <label className="form-label">Category</label>
                <select className="form-select" name="category" value={form.category} onChange={handleChange}>
                  <option value="">Select</option>
                  {masterCategories.map(c => <option key={c.id} value={c.value}>{c.value}</option>)}
                </select>
              </div>
            </div>
            <div className="form-row">
              <div className="form-group">
                <label className="form-label">Aadhar Number</label>
                <input className="form-input" name="aadharNumber" 
                  value={isView ? maskAadhar(form.aadharNumber) : form.aadharNumber} 
                  onChange={handleChange} placeholder="XXXX-XXXX-XXXX" disabled={isView} />
              </div>
              <div className="form-group">
                <label className="form-label">PAN</label>
                <input className="form-input" name="pan" 
                  value={isView ? maskPAN(form.pan) : form.pan} 
                  onChange={handleChange} disabled={isView} />
              </div>
              <div className="form-group">
                <label className="form-label">Alternate Contact</label>
                <input className="form-input" name="alternateContact" value={form.alternateContact} onChange={handleChange} type="tel" disabled={isView} />
              </div>
            </div>
          </div>
        </div>

        {/* Posting Details Restricted per Role - Removed for all admins per request */}
        {/* Current Posting Section - Restored for all admins with role-based locking */}
        <div className="panel" style={{ marginBottom: 'var(--space-5)' }}>
            <div className="panel-header">
              <h3>Current Posting</h3>
            </div>
            <div className="panel-body">
              <div className="form-row" style={{ gridTemplateColumns: 'repeat(3, 1fr)', marginBottom: '1rem' }}>
                <div className="form-group">
                  <label className="form-label">State</label>
                  {!isSuperAdmin ? (
                    <input className="form-input" disabled value={user?.stateName || 'Haryana'} title="Auto-filled & Locked" />
                  ) : (
                    <select className="form-select" name="stateId" value={form.stateId} onChange={handleChange}>
                      <option value="">Select State</option>
                      {states.map(s => <option key={s.id} value={s.id}>{s.stateName}</option>)}
                    </select>
                  )}
                </div>

                <div className="form-group">
                  <label className="form-label">Range</label>
                  {!isSuperAdmin && !isStateAdmin ? (
                    <input className="form-input" disabled value={user?.rangeName || 'Locked Range'} title="Auto-filled & Locked" />
                  ) : (
                    <select className="form-select" name="rangeId" value={form.rangeId} onChange={handleChange} disabled={!form.stateId}>
                      <option value="">{ranges.length === 0 && form.stateId ? 'No Ranges Found' : 'Select Range'}</option>
                      {ranges.map(r => <option key={r.id} value={r.id}>{r.rangeName}</option>)}
                    </select>
                  )}
                </div>

                <div className="form-group">
                  <label className="form-label">District</label>
                  {!isSuperAdmin && !isStateAdmin && !isRangeAdmin ? (
                    <input className="form-input" disabled value={user?.districtName || 'Locked District'} title="Auto-filled & Locked" />
                  ) : (
                    <select className="form-select" name="districtId" value={form.districtId} onChange={handleChange} disabled={!form.rangeId}>
                      <option value="">{districts.length === 0 && form.rangeId ? 'No Districts Found' : 'Select District'}</option>
                      {districts.map(d => <option key={d.id} value={d.id}>{d.districtName}</option>)}
                    </select>
                  )}
                </div>
              </div>
              
              <div className="form-row" style={{ gridTemplateColumns: 'repeat(3, 1fr)' }}>
                <div className="form-group">
                  <label className="form-label">Unit Category</label>
                  {!isSuperAdmin && !isStateAdmin && !isRangeAdmin && !isDistrictAdmin ? (
                    <input className="form-input" disabled value="Auto-determined" title="Auto-filled & Locked" />
                  ) : (
                    <select className="form-select" name="unitType" value={form.unitType} onChange={handleChange} disabled={!form.districtId}>
                      <option value="">Select Category</option>
                      {unitCategories.map(c => <option key={c} value={c}>{c}</option>)}
                    </select>
                  )}
                </div>

                <div className="form-group">
                  <label className="form-label">Unit</label>
                  {!isSuperAdmin && !isStateAdmin && !isRangeAdmin && !isDistrictAdmin ? (
                    <input className="form-input" disabled value={user?.unitName || 'Locked Unit'} title="Auto-filled & Locked" />
                  ) : (
                    <select className="form-select" name="currentUnitId" value={form.currentUnitId} onChange={handleChange} disabled={!form.unitType || !form.districtId}>
                      <option value="">{units.length === 0 && form.unitType ? 'No units available for selected category in this district' : 'Select Unit'}</option>
                      {units.map(u => (
                        <option key={u.id} value={u.id}>{u.unitName}</option>
                      ))}
                    </select>
                  )}
                </div>

                <div className="form-group">
                  <label className="form-label">Sub-Unit</label>
                  <select className="form-select" name="currentSubUnitId" value={form.currentSubUnitId} onChange={handleChange} disabled={(!isSuperAdmin && !isStateAdmin && !isRangeAdmin && !isDistrictAdmin && !isUnitAdmin) || !form.currentUnitId}>
                    <option value="">{subUnits.length === 0 && form.currentUnitId ? 'No sub-units available' : 'Select Sub-Unit'}</option>
                    {subUnits.map(su => <option key={su.id} value={su.id}>{su.subUnitName}</option>)}
                  </select>
                </div>
              </div>
            </div>
          </div>


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
