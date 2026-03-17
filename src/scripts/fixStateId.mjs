import { initializeApp } from 'firebase/app';
import { getFirestore, collection, getDocs, updateDoc, doc, query, where } from 'firebase/firestore';
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

async function fix() {
  console.log('--- FIXING stateId MISMATCH ---');

  // 1. Fix Users
  const usersSnap = await getDocs(collection(db, 'users'));
  let userFixes = 0;
  for (const uDoc of usersSnap.docs) {
    if (uDoc.data().stateId === 'state_haryana') {
      await updateDoc(doc(db, 'users', uDoc.id), { stateId: 'haryana' });
      userFixes++;
    }
  }
  console.log(`Users fixed: ${userFixes}`);

  // 2. Fix Units (just in case any were created with 'state_haryana')
  const unitsSnap = await getDocs(collection(db, 'units'));
  let unitFixes = 0;
  for (const uDoc of unitsSnap.docs) {
    if (uDoc.data().stateId === 'state_haryana') {
      await updateDoc(doc(db, 'units', uDoc.id), { stateId: 'haryana' });
      unitFixes++;
    }
  }
  console.log(`Units fixed: ${unitFixes}`);

  // 3. Fix SubUnits
  const subSnap = await getDocs(collection(db, 'subUnits'));
  let subFixes = 0;
  for (const suDoc of subSnap.docs) {
    if (suDoc.data().stateId === 'state_haryana') {
      await updateDoc(doc(db, 'subUnits', suDoc.id), { stateId: 'haryana' });
      subFixes++;
    }
  }
  console.log(`SubUnits fixed: ${subFixes}`);

  console.log('\n--- FIX COMPLETE ---');
  process.exit(0);
}

fix();
