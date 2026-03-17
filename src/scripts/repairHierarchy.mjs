import { initializeApp } from 'firebase/app';
import { getFirestore, collection, getDocs, updateDoc, doc } from 'firebase/firestore';
import fs from 'fs';
import path from 'path';

function loadEnv() {
  const envPath = path.resolve(process.cwd(), '.env');
  if (!fs.existsSync(envPath)) return {};
  const content = fs.readFileSync(envPath, 'utf8');
  const env = {};
  content.split('\n').forEach(line => {
    const match = line.match(/^\s*([\w\.\-]+)\s*=\s*(.*)?\s*$/);
    if (match) {
      let value = match[2] || '';
      if (value.startsWith('"') && value.endsWith('"')) value = value.slice(1, -1);
      if (value.startsWith("'") && value.endsWith("'")) value = value.slice(1, -1);
      env[match[1]] = value;
    }
  });
  return env;
}

const env = loadEnv();
const firebaseConfig = {
  apiKey: env.VITE_FIREBASE_API_KEY,
  authDomain: env.VITE_FIREBASE_AUTH_DOMAIN,
  projectId: env.VITE_FIREBASE_PROJECT_ID,
  storageBucket: env.VITE_FIREBASE_STORAGE_BUCKET,
};

const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

async function globalSync() {
  console.log('--- GLOBAL HIERARCHY SYNC & REPAIR STARTED ---');

  // 1. Map Districts (The source of truth for Unit parents)
  const distSnap = await getDocs(collection(db, 'districts'));
  const districtsMap = {};
  distSnap.docs.forEach(d => {
    const data = d.data();
    districtsMap[d.id] = { rangeId: data.rangeId, stateId: data.stateId };
  });
  console.log(`Loaded ${distSnap.size} District mapping masters.`);

  // 2. Repair Units
  const unitsSnap = await getDocs(collection(db, 'units'));
  const unitsMap = {};
  let unitUpdates = 0;
  
  for (const uDoc of unitsSnap.docs) {
    const u = uDoc.data();
    const updates = {};
    
    if (u.districtId && districtsMap[u.districtId]) {
      const parent = districtsMap[u.districtId];
      if (!u.rangeId) updates.rangeId = parent.rangeId;
      if (!u.stateId) updates.stateId = parent.stateId;
    }
    
    if (Object.keys(updates).length > 0) {
      await updateDoc(doc(db, 'units', uDoc.id), updates);
      unitUpdates++;
    }
    
    // Fill unitsMap for sub-unit repair
    unitsMap[uDoc.id] = { ...u, ...updates };
  }
  console.log(`Repaired ${unitUpdates} Unit records with missing hierarchy IDs.`);

  // 3. Repair Sub-Units
  const subSnap = await getDocs(collection(db, 'subUnits'));
  let subUpdates = 0;
  for (const suDoc of subSnap.docs) {
    const su = suDoc.data();
    const updates = {};
    
    if (su.unitId && unitsMap[su.unitId]) {
      const parent = unitsMap[su.unitId];
      if (!su.stateId) updates.stateId = parent.stateId || '';
      if (!su.rangeId) updates.rangeId = parent.rangeId || '';
      if (!su.districtId) updates.districtId = parent.districtId || '';
    }
    
    if (Object.keys(updates).length > 0) {
      await updateDoc(doc(db, 'subUnits', suDoc.id), updates);
      subUpdates++;
    }
  }
  console.log(`Repaired ${subUpdates} Sub-Unit records.`);

  // 4. Sync All Secondary Collections
  const secondaryCollections = ['personnel', 'attendance', 'naukriChittha', 'leaveRegister', 'transferRegister', 'grievances', 'firReports'];
  for (const coll of secondaryCollections) {
    const snap = await getDocs(collection(db, coll));
    let collUpdates = 0;
    for (const d of snap.docs) {
      const data = d.data();
      const updates = {};
      
      const unitId = data.unitId || data.currentUnitId;
      if (unitId && unitsMap[unitId]) {
        const p = unitsMap[unitId];
        if (p.stateId && data.stateId !== p.stateId) updates.stateId = p.stateId;
        if (p.rangeId && data.rangeId !== p.rangeId) updates.rangeId = p.rangeId;
        if (p.districtId && data.districtId !== p.districtId) updates.districtId = p.districtId;
      }
      
      if (Object.keys(updates).length > 0) {
        await updateDoc(doc(db, coll, d.id), updates);
        collUpdates++;
      }
    }
    console.log(`Synced ${collUpdates} records in collection [${coll}].`);
  }

  console.log('--- GLOBAL HIERARCHY SYNC & REPAIR COMPLETE ---');
  process.exit(0);
}

globalSync().catch(err => {
  console.error('Fatal Sync Error:', err);
  process.exit(1);
});
