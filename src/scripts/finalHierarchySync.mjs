import { initializeApp } from 'firebase/app';
import { getFirestore, collection, getDocs, updateDoc, doc } from 'firebase/firestore';
import fs from 'fs';
import path from 'path';

// Manual .env parser
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
  apiKey: env.VITE_FIREBASE_API_KEY || "PLACEHOLDER",
  authDomain: env.VITE_FIREBASE_AUTH_DOMAIN || "oasi-portal.firebaseapp.com",
  projectId: env.VITE_FIREBASE_PROJECT_ID || "oasi-portal",
  storageBucket: env.VITE_FIREBASE_STORAGE_BUCKET || "oasi-portal.appspot.com",
};

const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

async function migrate() {
  console.log('--- Global Hierarchy Sync Process Started ---');

  // 1. Map Units
  const unitsSnap = await getDocs(collection(db, 'units'));
  const unitsMap = {};
  unitsSnap.docs.forEach(d => {
    const data = d.data();
    unitsMap[d.id] = {
      stateId: data.stateId || '',
      rangeId: data.rangeId || '',
      districtId: data.districtId || '',
      unitType: data.unitType || ''
    };
  });
  console.log(`Mapped ${unitsSnap.size} units.`);

  // 2. Map Sub-Units
  const subUnitsSnap = await getDocs(collection(db, 'subUnits'));
  const subUnitsMap = {};
  subUnitsSnap.docs.forEach(d => {
    const data = d.data();
    subUnitsMap[d.id] = { unitId: data.unitId };
  });
  console.log(`Mapped ${subUnitsSnap.size} sub-units.`);

  const collectionsToSync = ['personnel', 'attendance', 'naukriChittha', 'leaveRegister', 'grievances', 'firReports'];
  
  for (const collName of collectionsToSync) {
    console.log(`Syncing collection: ${collName}...`);
    const snap = await getDocs(collection(db, collName));
    let count = 0;
    for (const d of snap.docs) {
      const data = d.data();
      const updates = {};
      
      // Determine primary unit ID
      let unitId = data.unitId || data.currentUnitId;
      const subUnitId = data.subUnitId || data.currentSubUnitId;
      
      if (subUnitId && !unitId && subUnitsMap[subUnitId]) {
        unitId = subUnitsMap[subUnitId].unitId;
        updates[data.currentUnitId !== undefined ? 'currentUnitId' : 'unitId'] = unitId;
      }
      
      if (unitId && unitsMap[unitId]) {
        const u = unitsMap[unitId];
        if (u.stateId && data.stateId !== u.stateId) updates.stateId = u.stateId;
        if (u.rangeId && data.rangeId !== u.rangeId) updates.rangeId = u.rangeId;
        if (u.districtId && data.districtId !== u.districtId) updates.districtId = u.districtId;
      }
      
      if (Object.keys(updates).length > 0) {
        await updateDoc(doc(db, collName, d.id), updates);
        count++;
      }
    }
    console.log(`Updated ${count} records in ${collName}.`);
  }

  // Special case: transferRegister (both from and to)
  console.log('Syncing transferRegister...');
  const tSnap = await getDocs(collection(db, 'transferRegister'));
  let tCount = 0;
  for (const d of tSnap.docs) {
    const data = d.data();
    const updates = {};
    
    // From side
    if (data.fromUnitId && unitsMap[data.fromUnitId]) {
      const u = unitsMap[data.fromUnitId];
      if (u.stateId && data.stateId !== u.stateId) updates.stateId = u.stateId;
      if (u.rangeId && data.rangeId !== u.rangeId) updates.rangeId = u.rangeId;
      if (u.districtId && data.districtId !== u.districtId) updates.districtId = u.districtId;
    }
    
    // To side
    if (data.toUnitId && unitsMap[data.toUnitId]) {
      const u = unitsMap[data.toUnitId];
      if (u.districtId && data.toDistrictId !== u.districtId) updates.toDistrictId = u.districtId;
      if (u.rangeId && data.toRangeId !== u.rangeId) updates.toRangeId = u.rangeId;
      if (u.stateId && data.toStateId !== u.stateId) updates.toStateId = u.stateId;
    }
    
    if (Object.keys(updates).length > 0) {
      await updateDoc(doc(db, 'transferRegister', d.id), updates);
      tCount++;
    }
  }
  console.log(`Updated ${tCount} records in transferRegister.`);
  console.log('--- Database Hierarchy Sync Complete ---');
  process.exit(0);
}

migrate().catch(err => {
  console.error(err);
  process.exit(1);
});
