import { initializeApp } from 'firebase/app';
import { getFirestore, doc, setDoc, serverTimestamp, collection, getDocs } from 'firebase/firestore';

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

const FIXED_CATEGORIES = [
  "Police Stations",
  "Traffic",
  "Special Staffs",
  "Court",
  "Administrative Units",
  "Security",
  "Temp_Dep_Trg"
];

async function migrate() {
  console.log('Migrating FIXED_CATEGORIES to unitCategories collection...');
  
  // Check if they already exist to prevent duplicates
  const snap = await getDocs(collection(db, 'unitCategories'));
  if (!snap.empty) {
    console.log('Categories already exist in DB. Skipping migration.');
    return;
  }
  
  for (const cat of FIXED_CATEGORIES) {
    const newRef = doc(collection(db, 'unitCategories'));
    await setDoc(newRef, {
      name: cat,
      // Marking them as global (no specific state) or attaching to state
      // We will attach them globally for now (available everywhere) since the hardcoded array was global.
      createdAt: serverTimestamp()
    });
    console.log(`✅ Seeded category: ${cat}`);
  }
  console.log('Migration complete!');
  process.exit(0);
}

migrate().catch(console.error);
