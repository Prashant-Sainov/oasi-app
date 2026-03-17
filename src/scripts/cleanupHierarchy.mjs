/**
 * Cleanup script to wipe hierarchy data for a fresh import.
 * Deletes: states, ranges, districts, units, subUnits.
 */
import { initializeApp } from 'firebase/app';
import { getFirestore, collection, getDocs, deleteDoc, doc } from 'firebase/firestore';

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

const COLLECTIONS = ['states', 'ranges', 'districts', 'units', 'subUnits'];

async function cleanup() {
  console.log('🧹 Starting Hierarchy Cleanup...');
  
  for (const collName of COLLECTIONS) {
    console.log(`🗑️ Deleting collection: ${collName}...`);
    const snap = await getDocs(collection(db, collName));
    let count = 0;
    for (const d of snap.docs) {
      await deleteDoc(doc(db, collName, d.id));
      count++;
    }
    console.log(`✅ Deleted ${count} documents from ${collName}.`);
  }
  
  console.log('\n✨ Hierarchy Cleanup Complete! You can now run the fresh import.');
  process.exit(0);
}

cleanup().catch(err => {
  console.error('❌ Error during cleanup:', err);
  process.exit(1);
});
