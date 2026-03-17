import { initializeApp } from 'firebase/app';
import { getFirestore, collection, getDocs, limit, query } from 'firebase/firestore';
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

async function checkSubUnits() {
  console.log('--- Checking Sub-Units ---');
  try {
    const snap = await getDocs(query(collection(db, 'subUnits'), limit(5)));
    console.log(`Found ${snap.size} sample sub-units.`);
    snap.docs.forEach((d, i) => {
      const data = d.data();
      console.log(`\nSample ${i+1}:`);
      console.log(`ID: ${d.id}`);
      console.log(`Name: ${data.subUnitName}`);
      console.log(`StateId: ${data.stateId || 'MISSING'}`);
      console.log(`RangeId: ${data.rangeId || 'MISSING'}`);
      console.log(`DistrictId: ${data.districtId || 'MISSING'}`);
      console.log(`UnitId: ${data.unitId}`);
    });
  } catch (err) {
    console.error('Check failed:', err.message);
  }
  process.exit(0);
}

checkSubUnits();
