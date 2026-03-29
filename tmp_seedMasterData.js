import { initializeApp } from 'firebase/app';
import { getFirestore, doc, setDoc, serverTimestamp, collection, getDocs, query, where } from 'firebase/firestore';

const firebaseConfig = {
  apiKey: "AIzaSyCD3veNMEYJXJY_A3vaOeIhF0hXP7LwmlU",
  authDomain: "oasi-portal.firebaseapp.com",
  databaseURL: "https://oasi-portal-default-rtdb.firebaseio.com",
  projectId: "oasi-portal",
  storageBucket: "oasi-portal.firebasestorage.app",
  messagingSenderId: "43590378729",
  appId: "1:43590378729:web:c8fe29859ecb244a4dfc78"
};

const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

// All the data currently hardcoded in ranks.js and PersonnelForm
const SEED_DATA = {
  rank: {
    values: [
      // State Admin ranks (DSP and above)
      { value: 'DSP (Prob)', accessLevel: 'stateAdmin', order: 1 },
      { value: 'Deputy Superintendent of Police (DSP)', accessLevel: 'stateAdmin', order: 2 },
      { value: 'Assistant Commissioner of Police (ACP)', accessLevel: 'stateAdmin', order: 3 },
      { value: 'Additional Superintendent of Police (ASP)', accessLevel: 'stateAdmin', order: 4 },
      { value: 'Superintendent of Police (SP)', accessLevel: 'stateAdmin', order: 5 },
      { value: 'Senior Superintendent of Police (SSP)', accessLevel: 'stateAdmin', order: 6 },
      { value: 'Deputy Inspector General of Police (DIG)', accessLevel: 'stateAdmin', order: 7 },
      { value: 'Inspector General of Police (IG)', accessLevel: 'stateAdmin', order: 8 },
      { value: 'Additional Director General of Police (ADGP)', accessLevel: 'stateAdmin', order: 9 },
      { value: 'Director General of Police (DGP)', accessLevel: 'stateAdmin', order: 10 },
      // District/Unit Admin ranks (below DSP)
      { value: 'Insp', accessLevel: 'all', order: 11 },
      { value: 'PSI', accessLevel: 'all', order: 12 },
      { value: 'SI', accessLevel: 'all', order: 13 },
      { value: 'ASI/ESI', accessLevel: 'all', order: 14 },
      { value: 'ASI', accessLevel: 'all', order: 15 },
      { value: 'HC/ESI', accessLevel: 'all', order: 16 },
      { value: 'HC/EASI', accessLevel: 'all', order: 17 },
      { value: 'HC', accessLevel: 'all', order: 18 },
      { value: 'C-1/EHC', accessLevel: 'all', order: 19 },
      { value: 'C-1', accessLevel: 'all', order: 20 },
      { value: 'CT/ESI', accessLevel: 'all', order: 21 },
      { value: 'CT/EASI', accessLevel: 'all', order: 22 },
      { value: 'CT/EHC', accessLevel: 'all', order: 23 },
      { value: 'CT', accessLevel: 'all', order: 24 },
      { value: 'R/CT', accessLevel: 'all', order: 25 },
      { value: 'SPO', accessLevel: 'all', order: 26 },
    ]
  },
  category: {
    values: [
      { value: 'General', order: 1 },
      { value: 'OBC', order: 2 },
      { value: 'SC', order: 3 },
      { value: 'ST', order: 4 },
      { value: 'EWS', order: 5 },
    ]
  },
  gender: {
    values: [
      { value: 'Male', order: 1 },
      { value: 'Female', order: 2 },
      { value: 'Other', order: 3 },
    ]
  },
  serviceStatus: {
    values: [
      { value: 'Active', order: 1 },
      { value: 'Retired', order: 2 },
      { value: 'Deceased', order: 3 },
      { value: 'Suspended', order: 4 },
    ]
  },
  serviceType: {
    values: [
      { value: 'Regular', order: 1 },
      { value: 'Home Guard', order: 2 },
      { value: 'SPO', order: 3 },
      { value: 'Contractual', order: 4 },
    ]
  },
  religion: {
    values: [
      { value: 'Hindu', order: 1 },
      { value: 'Muslim', order: 2 },
      { value: 'Sikh', order: 3 },
      { value: 'Christian', order: 4 },
      { value: 'Buddhist', order: 5 },
      { value: 'Jain', order: 6 },
      { value: 'Other', order: 7 },
    ]
  },
  caste: {
    values: [
      { value: 'Jat', order: 1 },
      { value: 'Rajput', order: 2 },
      { value: 'Brahmin', order: 3 },
      { value: 'Bishnoi', order: 4 },
      { value: 'Gujjar', order: 5 },
      { value: 'Ahir', order: 6 },
      { value: 'Saini', order: 7 },
      { value: 'Chamar', order: 8 },
      { value: 'Balmiki', order: 9 },
      { value: 'Other', order: 10 },
    ]
  },
  cadre: {
    values: [
      { value: 'IPS', order: 1 },
      { value: 'HPS', order: 2 },
      { value: 'Direct', order: 3 },
      { value: 'Promoted', order: 4 },
    ]
  },
};

// We need a stateId. Fetch from Firestore.
async function getStateId() {
  const snap = await getDocs(collection(db, 'states'));
  if (snap.empty) {
    console.error('No states found in database. Please seed states first.');
    process.exit(1);
  }
  return snap.docs[0].id; // Use the first (only) state
}

async function migrate() {
  const stateId = await getStateId();
  console.log(`Using stateId: ${stateId}`);
  console.log('--- Starting Master Data Migration ---\n');

  let totalSeeded = 0;
  let totalSkipped = 0;

  for (const [fieldType, config] of Object.entries(SEED_DATA)) {
    console.log(`\n📂 Processing: ${fieldType}`);

    for (const item of config.values) {
      // Check for existing record
      const q = query(
        collection(db, 'masterData'),
        where('fieldType', '==', fieldType),
        where('value', '==', item.value),
        where('stateId', '==', stateId)
      );
      const existing = await getDocs(q);

      if (!existing.empty) {
        console.log(`   ⏭️  Skipped (exists): ${item.value}`);
        totalSkipped++;
        continue;
      }

      const newRef = doc(collection(db, 'masterData'));
      await setDoc(newRef, {
        fieldType,
        value: item.value,
        stateId,
        accessLevel: item.accessLevel || 'all',
        parentValue: null,
        isActive: true,
        displayOrder: item.order,
        createdAt: serverTimestamp(),
        updatedAt: serverTimestamp(),
      });
      console.log(`   ✅ Seeded: ${item.value}`);
      totalSeeded++;
    }
  }

  console.log(`\n--- Migration Complete ---`);
  console.log(`   Seeded: ${totalSeeded} | Skipped: ${totalSkipped}`);
  process.exit(0);
}

migrate().catch(err => { console.error(err); process.exit(1); });
