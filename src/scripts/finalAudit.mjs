import { initializeApp } from 'firebase/app';
import { getFirestore, collection, getDocs } from 'firebase/firestore';
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
const app = initializeApp({
  apiKey: env.VITE_FIREBASE_API_KEY,
  projectId: env.VITE_FIREBASE_PROJECT_ID
});
const db = getFirestore(app);

async function finalAudit() {
  console.log('--- FINAL HIERARCHY AUDIT ---');
  try {
    const unitsSnap = await getDocs(collection(db, 'units'));
    let unitsMissing = 0;
    unitsSnap.docs.forEach(d => {
      const data = d.data();
      if (!data.stateId || !data.rangeId || !data.districtId) unitsMissing++;
    });
    console.log(`Units: ${unitsSnap.size} total, ${unitsMissing} missing hierarchy info.`);

    const subUnitsSnap = await getDocs(collection(db, 'subUnits'));
    let subUnitsMissing = 0;
    subUnitsSnap.docs.forEach(d => {
      const data = d.data();
      if (!data.stateId || !data.rangeId || !data.districtId) subUnitsMissing++;
    });
    console.log(`Sub-Units: ${subUnitsSnap.size} total, ${subUnitsMissing} missing hierarchy info.`);

  } catch (err) {
    console.error('Audit failed:', err.message);
  }
  process.exit(0);
}

finalAudit();
