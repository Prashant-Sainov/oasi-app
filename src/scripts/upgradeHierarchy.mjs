import { initializeApp } from 'firebase/app';
import { getFirestore, collection, getDocs, updateDoc, doc, deleteDoc } from 'firebase/firestore';
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
  projectId: env.VITE_FIREBASE_PROJECT_ID,
};

const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

const CATEGORY_MAP = {
  'Police Station': 'Police Stations',
  'Police Stations': 'Police Stations',
  'Traffic': 'Traffic',
  'Special Branch': 'Special Staffs',
  'Special Staffs': 'Special Staffs',
  'Crime Unit': 'Special Staffs',
  'DPO': 'Administrative Units',
  'Police Line': 'Administrative Units',
  'Administrative Units': 'Administrative Units',
  'Court': 'Court',
  'Security': 'Security',
  'Temp_Dep_Trg': 'Temp_Dep_Trg'
};

const FIXED_CATEGORIES = [
  "Police Stations",
  "Traffic",
  "Special Staffs",
  "Court",
  "Administrative Units",
  "Security",
  "Temp_Dep_Trg"
];

async function upgrade() {
  console.log('--- HIERARCHY UPGRADE & CLEANUP STARTED ---');

  const unitsSnap = await getDocs(collection(db, 'units'));
  let unitUpdates = 0;
  let unitDeletions = 0;

  for (const uDoc of unitsSnap.docs) {
    const u = uDoc.data();
    const id = uDoc.id;

    // 1. New Delhi Cleanup in Haryana
    if (u.stateId === 'haryana' && (u.unitType === 'New Delhi' || u.unitName.includes('New Delhi'))) {
      await deleteDoc(doc(db, 'units', id));
      console.log(`Deleted New Delhi unit from Haryana: ${u.unitName}`);
      unitDeletions++;
      continue;
    }

    // 2. Category Mapping
    let newType = CATEGORY_MAP[u.unitType] || 'Administrative Units';
    
    const updates = {};
    if (u.unitType !== newType) {
      updates.unitType = newType;
    }

    if (Object.keys(updates).length > 0) {
      await updateDoc(doc(db, 'units', id), updates);
      unitUpdates++;
    }
  }

  console.log(`Units processed: ${unitsSnap.size}`);
  console.log(`Units updated: ${unitUpdates}`);
  console.log(`Units deleted (cleanup): ${unitDeletions}`);

  // 3. Sub-unit sync (Ensure sub-units in Haryana don't have Delhi parents)
  const subSnap = await getDocs(collection(db, 'subUnits'));
  let subDeletions = 0;
  for (const suDoc of subSnap.docs) {
    const su = suDoc.data();
    if (su.stateId === 'haryana' && su.subUnitName.includes('New Delhi')) {
      await deleteDoc(doc(db, 'subUnits', suDoc.id));
      subDeletions++;
    }
  }
  console.log(`Sub-units cleaned: ${subDeletions}`);

  console.log('--- HIERARCHY UPGRADE & CLEANUP COMPLETE ---');
  process.exit(0);
}

upgrade().catch(err => {
  console.error('Fatal Upgrade Error:', err);
  process.exit(1);
});
