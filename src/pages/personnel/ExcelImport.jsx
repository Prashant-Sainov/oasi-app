import { useState, useRef, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';
import { useToast } from '../../contexts/ToastContext';
import { db } from '../../firebase';
import { collection, doc, setDoc, serverTimestamp, writeBatch } from 'firebase/firestore';
import * as XLSX from 'xlsx';
import {
  Upload, FileSpreadsheet, ArrowLeft, ArrowRight, Check,
  AlertTriangle, Download, X, ChevronRight
} from 'lucide-react';

// System fields that can be mapped
const SYSTEM_FIELDS = [
  { key: 'beltNumber', label: 'Belt Number', required: false },
  { key: 'payCode', label: 'Pay Code', required: false },
  { key: 'fullName', label: 'Full Name', required: true },
  { key: 'fatherName', label: "Father's Name", required: false },
  { key: 'rank', label: 'Rank', required: true },
  { key: 'gender', label: 'Gender', required: false },
  { key: 'dateOfBirth', label: 'Date of Birth', required: false },
  { key: 'religion', label: 'Religion', required: false },
  { key: 'caste', label: 'Caste', required: false },
  { key: 'category', label: 'Category (Gen/OBC/SC/ST)', required: false },
  { key: 'cadre', label: 'Cadre', required: false },
  { key: 'serviceType', label: 'Service Type', required: false },
  { key: 'serviceBookNumber', label: 'Service Book Number', required: false },
  { key: 'dateOfEnlistment', label: 'Date of Enlistment', required: false },
  { key: 'dateOfLastPromotion', label: 'Date of Last Promotion', required: false },
  { key: 'retirementDate', label: 'Retirement Date', required: false },
  { key: 'village', label: 'Village / Town', required: false },
  { key: 'policeStation', label: 'Police Station', required: false },
  { key: 'homeDistrict', label: 'Home District', required: false },
  { key: 'bloodGroup', label: 'Blood Group', required: false },
  { key: 'mobileNumber', label: 'Mobile Number', required: true },
  { key: 'alternateContact', label: 'Alternate Contact', required: false },
  { key: 'aadharNumber', label: 'Aadhar Number', required: false },
  { key: 'pan', label: 'PAN', required: false },
  { key: 'serviceStatus', label: 'Service Status', required: false },
  { key: 'role1', label: 'Role 1', required: false },
  { key: 'role2', label: 'Role 2', required: false },
  { key: 'ioStatus', label: 'IO Status', required: false },
  { key: 'ioCategory', label: 'IO Category', required: false },
  { key: 'paradeGroup', label: 'Parade Group', required: false },
  { key: 'spoTrade', label: 'SPO Trade', required: false },
  { key: 'promotionType', label: 'Promotion Type', required: false },
  { key: 'specialCourse', label: 'Special Course', required: false },
  { key: 'company', label: 'Company', required: false },
  { key: 'stateId', label: 'State ID', required: false },
  { key: 'rangeId', label: 'Range ID', required: false },
  { key: 'districtId', label: 'District ID', required: false },
  { key: 'unitType', label: 'Unit Category', required: false },
  { key: 'currentUnitId', label: 'Unit ID', required: false },
  { key: 'currentSubUnitId', label: 'Sub-Unit ID', required: false },
  { key: 'remarks', label: 'Remarks', required: false },
];

const STEPS = ['Upload File', 'Map Fields', 'Validate', 'Import'];

// Smart auto-mapping of columns to system fields
function autoMap(fileColumns) {
  const mapping = {};
  const normalise = (s) => s.toLowerCase().replace(/[^a-z0-9]/g, '');

  const ALIASES = {
    fullName: ['name', 'fullname', 'personnelname', 'employeename', 'officername'],
    fatherName: ['fathername', 'father', 'fathersname'],
    beltNumber: ['beltnumber', 'beltno', 'belt'],
    payCode: ['paycode', 'payid', 'employeeid', 'empid', 'empcode'],
    rank: ['rank', 'designation', 'post'],
    mobileNumber: ['mobile', 'mobilenumber', 'phone', 'phonenumber', 'contact', 'mobileno'],
    gender: ['gender', 'sex'],
    dateOfBirth: ['dob', 'dateofbirth', 'birthdate'],
    religion: ['religion'],
    caste: ['caste'],
    category: ['category', 'reservation', 'cat'],
    cadre: ['cadre'],
    serviceType: ['servicetype', 'type'],
    dateOfEnlistment: ['doe', 'dateofenlistment', 'joiningdate', 'doj'],
    dateOfLastPromotion: ['lastpromotion', 'promotiondate'],
    retirementDate: ['retirementdate', 'dor', 'retirement'],
    village: ['village', 'town', 'address'],
    policeStation: ['policestation', 'ps', 'thana'],
    homeDistrict: ['homedistrict', 'district'],
    bloodGroup: ['bloodgroup', 'blood'],
    alternateContact: ['alternatecontact', 'altcontact'],
    aadharNumber: ['aadhar', 'aadharnumber', 'uid'],
    role1: ['role1', 'role', 'duty'],
    ioStatus: ['iostatus', 'io'],
    company: ['company', 'coy'],
    remarks: ['remarks', 'remark', 'note', 'notes'],
    stateId: ['stateid', 'state'],
    rangeId: ['rangeid', 'range'],
    districtId: ['districtid', 'currentdistrict'],
    unitType: ['unittype', 'unitcategory', 'category'],
    currentUnitId: ['unitid', 'currentunit'],
    currentSubUnitId: ['subunitid', 'currentsubunit'],
  };

  fileColumns.forEach(col => {
    const norm = normalise(col);
    for (const [sysKey, aliases] of Object.entries(ALIASES)) {
      if (aliases.includes(norm) || norm.includes(aliases[0])) {
        if (!Object.values(mapping).includes(sysKey)) {
          mapping[col] = sysKey;
          break;
        }
      }
    }
  });

  return mapping;
}

export default function ExcelImport() {
  const navigate = useNavigate();
  const { user } = useAuth();
  const toast = useToast();
  const fileInputRef = useRef(null);

  const [step, setStep] = useState(0);
  const [fileName, setFileName] = useState('');
  const [fileColumns, setFileColumns] = useState([]);
  const [rawData, setRawData] = useState([]);
  const [mapping, setMapping] = useState({});
  const [validationResults, setValidationResults] = useState(null);
  const [importing, setImporting] = useState(false);
  const [importResults, setImportResults] = useState(null);

  // Step 1: File Upload
  const handleFileUpload = useCallback((e) => {
    const file = e.target.files?.[0];
    if (!file) return;

    const validTypes = [
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'application/vnd.ms-excel',
      'text/csv',
    ];
    const ext = file.name.split('.').pop().toLowerCase();
    if (!validTypes.includes(file.type) && !['xlsx', 'xls', 'csv'].includes(ext)) {
      toast.error('Please upload an Excel (.xlsx, .xls) or CSV (.csv) file.');
      return;
    }

    setFileName(file.name);
    const reader = new FileReader();
    reader.onload = (evt) => {
      try {
        const data = new Uint8Array(evt.target.result);
        const wb = XLSX.read(data, { type: 'array' });
        const sheetName = wb.SheetNames[0];
        const ws = wb.Sheets[sheetName];
        const json = XLSX.utils.sheet_to_json(ws, { defval: '' });

        if (json.length === 0) {
          toast.error('The file is empty or has no data rows.');
          return;
        }

        const cols = Object.keys(json[0]);
        setFileColumns(cols);
        setRawData(json);

        // Auto-map columns
        const autoMapping = autoMap(cols);
        setMapping(autoMapping);

        setStep(1);
        toast.success(`File loaded: ${json.length} rows, ${cols.length} columns detected.`);
      } catch (err) {
        console.error('Parse error:', err);
        toast.error('Failed to parse the file. Please check the format.');
      }
    };
    reader.readAsArrayBuffer(file);
  }, [toast]);

  const handleDrop = useCallback((e) => {
    e.preventDefault();
    e.stopPropagation();
    const file = e.dataTransfer.files?.[0];
    if (file) {
      const input = fileInputRef.current;
      const dt = new DataTransfer();
      dt.items.add(file);
      input.files = dt.files;
      handleFileUpload({ target: { files: dt.files } });
    }
  }, [handleFileUpload]);

  // Step 2: Mapping change
  function handleMappingChange(fileCol, sysField) {
    setMapping(prev => {
      const next = { ...prev };
      // Remove previous mapping for this system field (prevent duplicates)
      for (const key of Object.keys(next)) {
        if (next[key] === sysField && key !== fileCol) {
          delete next[key];
        }
      }
      if (sysField === '') {
        delete next[fileCol];
      } else {
        next[fileCol] = sysField;
      }
      return next;
    });
  }

  // Step 3: Validate
  function runValidation() {
    const errors = [];
    const warnings = [];
    const validRows = [];

    const requiredFields = SYSTEM_FIELDS.filter(f => f.required).map(f => f.key);
    const mappedFields = Object.entries(mapping);

    rawData.forEach((row, idx) => {
      const rowNum = idx + 2; // Excel row (1-indexed header)
      const mapped = {};
      let rowErrors = [];

      mappedFields.forEach(([fileCol, sysKey]) => {
        mapped[sysKey] = String(row[fileCol] || '').trim();
      });

      // Check required fields
      requiredFields.forEach(reqKey => {
        if (!mapped[reqKey]) {
          rowErrors.push(`Row ${rowNum}: Missing required field "${SYSTEM_FIELDS.find(f => f.key === reqKey)?.label}"`);
        }
      });

      // Auto-fill payCode from mobileNumber if not mapped
      if (!mapped.payCode && mapped.mobileNumber) {
        mapped.payCode = mapped.mobileNumber;
      }

      if (rowErrors.length > 0) {
        errors.push(...rowErrors);
      } else {
        validRows.push(mapped);
      }
    });

    // Check for duplicate mobile numbers
    const mobiles = validRows.map(r => r.mobileNumber).filter(Boolean);
    const duplicates = mobiles.filter((m, i) => mobiles.indexOf(m) !== i);
    if (duplicates.length > 0) {
      warnings.push(`${duplicates.length} duplicate mobile numbers found. They will still be imported.`);
    }

    setValidationResults({ errors, warnings, validRows, totalRows: rawData.length });
    setStep(2);
  }

  // Step 4: Import to Firestore using writeBatch for performance and atomicity
  async function startImport() {
    if (!validationResults?.validRows?.length) return;

    setImporting(true);
    setStep(3);

    let successCount = 0;
    let errorCount = 0;
    const errorRows = [];
    const BATCH_LIMIT = 500;
    const rows = validationResults.validRows;

    for (let batchStart = 0; batchStart < rows.length; batchStart += BATCH_LIMIT) {
      const chunk = rows.slice(batchStart, batchStart + BATCH_LIMIT);
      const batch = writeBatch(db);

      chunk.forEach((row) => {
        try {
          const docRef = doc(collection(db, 'personnel'));
          const data = {
            ...row,
            personnelId: docRef.id,
            serviceStatus: row.serviceStatus || 'Active',
            stateId: row.stateId || user.stateId || '',
            rangeId: row.rangeId || user.rangeId || '',
            districtId: row.districtId || user.districtId || '',
            unitType: row.unitType || '',
            currentUnitId: row.currentUnitId || user.unitId || '',
            currentSubUnitId: row.currentSubUnitId || user.subUnitId || '',
            createdAt: serverTimestamp(),
            createdByUserId: user.uid,
            updatedAt: serverTimestamp(),
            updatedByUserId: user.uid,
          };
          batch.set(docRef, data);
          successCount++;
        } catch (err) {
          errorCount++;
          errorRows.push({ row: batchStart + chunk.indexOf(row) + 1, error: err.message });
        }
      });

      try {
        await batch.commit();
      } catch (err) {
        // If the entire batch fails, count all rows in it as errors
        errorCount += chunk.length - errorRows.filter(e => e.row >= batchStart + 1 && e.row <= batchStart + chunk.length).length;
        successCount = Math.max(0, successCount - chunk.length);
        errorRows.push({ row: batchStart + 1, error: `Batch commit failed: ${err.message}` });
        if (import.meta.env.DEV) console.error('Batch import error:', err);
      }
    }

    setImportResults({ successCount, errorCount, errorRows });
    setImporting(false);
    toast.success(`Import complete: ${successCount} records created.`);
  }

  function resetImport() {
    setStep(0);
    setFileName('');
    setFileColumns([]);
    setRawData([]);
    setMapping({});
    setValidationResults(null);
    setImportResults(null);
    if (fileInputRef.current) fileInputRef.current.value = '';
  }

  return (
    <div>
      <div className="page-header">
        <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
          <button className="btn btn-ghost btn-icon" onClick={() => navigate('/personnel')}>
            <ArrowLeft size={20} />
          </button>
          <h2>Import Personnel from Excel / CSV</h2>
        </div>
      </div>

      {/* Step Progress */}
      <div className="step-progress">
        {STEPS.map((s, i) => (
          <div key={s} style={{ display: 'flex', alignItems: 'center' }}>
            <div className={`step-item ${step === i ? 'active' : step > i ? 'completed' : ''}`}>
              <div className="step-circle">
                {step > i ? <Check size={14} /> : i + 1}
              </div>
              <span style={{ display: 'inline-block', minWidth: 70 }}>{s}</span>
            </div>
            {i < STEPS.length - 1 && <div className={`step-connector ${step > i ? 'completed' : ''}`} />}
          </div>
        ))}
      </div>

      {/* Step 0: Upload */}
      {step === 0 && (
        <div className="panel">
          <div className="panel-body" style={{ padding: 40 }}>
            <div
              className="file-upload-area"
              onClick={() => fileInputRef.current?.click()}
              onDrop={handleDrop}
              onDragOver={(e) => e.preventDefault()}
            >
              <FileSpreadsheet className="icon" size={40} />
              <h4>Drop your Excel or CSV file here</h4>
              <p>or click to browse — Supports .xlsx, .xls, .csv</p>
              <input
                ref={fileInputRef}
                type="file"
                accept=".xlsx,.xls,.csv"
                style={{ display: 'none' }}
                onChange={handleFileUpload}
              />
            </div>
          </div>
        </div>
      )}

      {/* Step 1: Mapping */}
      {step === 1 && (
        <div className="panel">
          <div className="panel-header">
            <h3>Map File Columns to System Fields</h3>
            <span style={{ fontSize: '0.8rem', color: 'var(--gray-500)' }}>
              {rawData.length} rows • {fileColumns.length} columns • File: {fileName}
            </span>
          </div>
          <div className="panel-body">
            <p style={{ marginBottom: 16, color: 'var(--gray-500)', fontSize: '0.85rem' }}>
              We've auto-detected some mappings. Review and adjust as needed. Fields marked <span style={{ color: 'var(--danger-500)' }}>*</span> are required.
            </p>
            <div className="table-container">
              <table className="data-table">
                <thead>
                  <tr>
                    <th>Your File Column</th>
                    <th style={{ textAlign: 'center' }}>→</th>
                    <th>System Field</th>
                    <th>Sample Data</th>
                  </tr>
                </thead>
                <tbody>
                  {fileColumns.map(col => {
                    const mapped = mapping[col] || '';
                    const sampleVal = rawData[0]?.[col] || '';
                    return (
                      <tr key={col}>
                        <td style={{ fontWeight: 600 }}>{col}</td>
                        <td style={{ textAlign: 'center', color: 'var(--gray-400)' }}>
                          <ChevronRight size={16} />
                        </td>
                        <td>
                          <select
                            className="form-select"
                            value={mapped}
                            onChange={(e) => handleMappingChange(col, e.target.value)}
                            style={{ minWidth: 200 }}
                          >
                            <option value="">— Skip this column —</option>
                            {SYSTEM_FIELDS.map(sf => {
                              const alreadyMapped = Object.values(mapping).includes(sf.key) && mapping[col] !== sf.key;
                              return (
                                <option key={sf.key} value={sf.key} disabled={alreadyMapped}>
                                  {sf.label} {sf.required ? '*' : ''} {alreadyMapped ? '(mapped)' : ''}
                                </option>
                              );
                            })}
                          </select>
                        </td>
                        <td style={{ color: 'var(--gray-400)', fontSize: '0.8rem', maxWidth: 200, overflow: 'hidden', textOverflow: 'ellipsis' }}>
                          {String(sampleVal).substring(0, 60)}
                        </td>
                      </tr>
                    );
                  })}
                </tbody>
              </table>
            </div>
          </div>
          <div className="panel-footer" style={{ justifyContent: 'flex-end' }}>
            <button className="btn btn-secondary" onClick={resetImport}>Cancel</button>
            <button className="btn btn-primary" onClick={runValidation}>
              <ArrowRight size={16} /> Validate Data
            </button>
          </div>
        </div>
      )}

      {/* Step 2: Validation results */}
      {step === 2 && validationResults && (
        <div className="panel">
          <div className="panel-header">
            <h3>Validation Results</h3>
          </div>
          <div className="panel-body">
            <div className="stats-bar" style={{ marginBottom: 20 }}>
              <div className="stat-widget">
                <div className="stat-widget-icon blue"><FileSpreadsheet size={20} /></div>
                <div className="stat-widget-data">
                  <h3>{validationResults.totalRows}</h3>
                  <p>Total Rows</p>
                </div>
              </div>
              <div className="stat-widget">
                <div className="stat-widget-icon green"><Check size={20} /></div>
                <div className="stat-widget-data">
                  <h3>{validationResults.validRows.length}</h3>
                  <p>Ready to Import</p>
                </div>
              </div>
              <div className="stat-widget">
                <div className="stat-widget-icon red"><AlertTriangle size={20} /></div>
                <div className="stat-widget-data">
                  <h3>{validationResults.errors.length}</h3>
                  <p>Errors</p>
                </div>
              </div>
            </div>

            {validationResults.warnings.length > 0 && (
              <div style={{ background: 'var(--warning-50)', padding: 12, borderRadius: 8, marginBottom: 16, fontSize: '0.85rem', color: 'var(--warning-600)' }}>
                {validationResults.warnings.map((w, i) => <p key={i}>⚠️ {w}</p>)}
              </div>
            )}

            {validationResults.errors.length > 0 && (
              <div style={{ maxHeight: 200, overflow: 'auto', background: 'var(--danger-50)', padding: 12, borderRadius: 8, fontSize: '0.8rem', color: 'var(--danger-700)' }}>
                {validationResults.errors.slice(0, 20).map((e, i) => <p key={i}>❌ {e}</p>)}
                {validationResults.errors.length > 20 && <p>...and {validationResults.errors.length - 20} more errors</p>}
              </div>
            )}
          </div>
          <div className="panel-footer" style={{ justifyContent: 'flex-end' }}>
            <button className="btn btn-secondary" onClick={() => setStep(1)}>
              <ArrowLeft size={16} /> Back to Mapping
            </button>
            <button
              className="btn btn-success"
              disabled={validationResults.validRows.length === 0}
              onClick={startImport}
            >
              <Upload size={16} /> Import {validationResults.validRows.length} Records
            </button>
          </div>
        </div>
      )}

      {/* Step 3: Import progress / results */}
      {step === 3 && (
        <div className="panel">
          <div className="panel-header"><h3>Import Results</h3></div>
          <div className="panel-body" style={{ textAlign: 'center', padding: 40 }}>
            {importing ? (
              <>
                <div className="spinner spinner-lg" style={{ margin: '0 auto 16px' }}></div>
                <p style={{ color: 'var(--gray-500)' }}>Importing records... Please wait.</p>
              </>
            ) : importResults ? (
              <>
                <div style={{ width: 64, height: 64, borderRadius: '50%', background: 'var(--success-50)', display: 'flex', alignItems: 'center', justifyContent: 'center', margin: '0 auto 16px' }}>
                  <Check size={32} color="var(--success-600)" />
                </div>
                <h3 style={{ marginBottom: 8 }}>Import Complete!</h3>
                <p style={{ color: 'var(--gray-500)', marginBottom: 20 }}>
                  <strong>{importResults.successCount}</strong> records imported successfully.
                  {importResults.errorCount > 0 && <><br /><span style={{ color: 'var(--danger-500)' }}>{importResults.errorCount} records failed.</span></>}
                </p>
                <div style={{ display: 'flex', gap: 12, justifyContent: 'center' }}>
                  <button className="btn btn-secondary" onClick={resetImport}>Import More</button>
                  <button className="btn btn-primary" onClick={() => navigate('/personnel')}>View Personnel</button>
                </div>
              </>
            ) : null}
          </div>
        </div>
      )}
    </div>
  );
}
