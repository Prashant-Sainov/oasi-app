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

async function check() {
  const collections = ['states', 'ranges', 'districts', 'units', 'subUnits', 'personnel', 'attendance', 'naukriChittha', 'leaveRegister', 'transferRegister', 'grievances', 'firReports'];
  
  for (const coll of collections) {
    const snap = await getDocs(collection(db, coll));
    console.log(`Collection [${coll}]: ${snap.size} records`);
    if (snap.size > 0 && (coll === 'units' || coll === 'personnel' || coll === 'districts' || coll === 'ranges' || coll === 'subUnits')) {
      console.log(`Sample [${coll}]:`, JSON.stringify(snap.docs[0].data(), null, 2));
    }
  }
  process.exit(0);
}

check().catch(err => {
  console.error(err);
  process.exit(1);
});
