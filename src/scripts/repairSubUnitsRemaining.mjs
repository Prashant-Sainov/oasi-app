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
  projectId: env.VITE_FIREBASE_PROJECT_ID,
};

const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

async function repairSubUnits() {
  console.log('--- REPAIRING REMAINING SUB-UNITS ---');
  
  // Load Units for parentage
  const unitsSnap = await getDocs(collection(db, 'units'));
  const unitsMap = {};
  unitsSnap.docs.forEach(d => {
    unitsMap[d.id] = d.data();
  });
  console.log(`Units loaded: ${unitsSnap.size}`);

  const subSnap = await getDocs(collection(db, 'subUnits'));
  let subUpdates = 0;
  let skipped = 0;
  let errors = 0;

  for (const suDoc of subSnap.docs) {
    const su = suDoc.data();
    if (su.stateId && su.rangeId && su.districtId) {
      skipped++;
      continue;
    }

    const updates = {};
    if (su.unitId && unitsMap[su.unitId]) {
      const parent = unitsMap[su.unitId];
      if (!su.stateId) updates.stateId = parent.stateId || '';
      if (!su.rangeId) updates.rangeId = parent.rangeId || '';
      if (!su.districtId) updates.districtId = parent.districtId || '';
    }

    if (Object.keys(updates).length > 0) {
      try {
        await updateDoc(doc(db, 'subUnits', suDoc.id), updates);
        subUpdates++;
        if (subUpdates % 50 === 0) console.log(`Processed ${subUpdates} updates...`);
      } catch (err) {
        errors++;
        console.error(`Error updating subunit ${suDoc.id}: ${err.message}`);
      }
    }
  }

  console.log(`Repair Complete: ${subUpdates} updated, ${skipped} skipped, ${errors} errors.`);
  process.exit(0);
}

repairSubUnits();
