import { initializeApp } from 'firebase/app';
import { getFirestore, collection, getDocs, query, where, doc, updateDoc, deleteDoc, writeBatch } from 'firebase/firestore';

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

async function fixDuplicate() {
  const DUPLICATE_ID = 'range_hisar';
  const OFFICIAL_ID = 'haryana_hisar_range';
  const OLD_DISTRICT_ID = 'district_hisar';
  const NEW_DISTRICT_ID = 'haryana_hisar_range_hisar';

  console.log(`Starting migration from ${DUPLICATE_ID} to ${OFFICIAL_ID}...`);

  // 1. Move District
  const districtsSnap = await getDocs(query(collection(db, 'districts'), where('rangeId', '==', DUPLICATE_ID)));
  console.log(`Found ${districtsSnap.size} districts in duplicate range.`);
  
  const batch = writeBatch(db);
  districtsSnap.docs.forEach(d => {
    console.log(`- Moving district ${d.data().districtName} (ID: ${d.id}) to ${OFFICIAL_ID}`);
    batch.update(doc(db, 'districts', d.id), { rangeId: OFFICIAL_ID });
  });

  // 2. Update Personnel (in case some are assigned to range_hisar or district_hisar)
  const personnelSnap1 = await getDocs(query(collection(db, 'personnel'), where('rangeId', '==', DUPLICATE_ID)));
  personnelSnap1.docs.forEach(d => {
    console.log(`- Updating Personnel ${d.data().fullName} rangeId to ${OFFICIAL_ID}`);
    batch.update(doc(db, 'personnel', d.id), { rangeId: OFFICIAL_ID });
  });

  const personnelSnap2 = await getDocs(query(collection(db, 'personnel'), where('districtId', '==', OLD_DISTRICT_ID)));
  personnelSnap2.docs.forEach(d => {
    console.log(`- Updating Personnel ${d.data().fullName} districtId to ${NEW_DISTRICT_ID}`);
    batch.update(doc(db, 'personnel', d.id), { districtId: NEW_DISTRICT_ID, rangeId: OFFICIAL_ID });
  });

  // 3. Update Units
  const unitsSnap1 = await getDocs(query(collection(db, 'units'), where('rangeId', '==', DUPLICATE_ID)));
  unitsSnap1.docs.forEach(d => {
    console.log(`- Updating Unit ${d.data().unitName} rangeId to ${OFFICIAL_ID}`);
    batch.update(doc(db, 'units', d.id), { rangeId: OFFICIAL_ID });
  });

  const unitsSnap2 = await getDocs(query(collection(db, 'units'), where('districtId', '==', OLD_DISTRICT_ID)));
  unitsSnap2.docs.forEach(d => {
    console.log(`- Updating Unit ${d.data().unitName} districtId to ${NEW_DISTRICT_ID}`);
    batch.update(doc(db, 'units', d.id), { districtId: NEW_DISTRICT_ID, rangeId: OFFICIAL_ID });
  });

  // 4. Update Users (especially SP Hisar)
  const usersSnap = await getDocs(query(collection(db, 'users'), where('rangeId', '==', DUPLICATE_ID)));
  usersSnap.docs.forEach(d => {
    console.log(`- Updating User ${d.data().name} rangeId to ${OFFICIAL_ID}`);
    batch.update(doc(db, 'users', d.id), { rangeId: OFFICIAL_ID });
  });

  // 5. Ensure all personnel have isDeleted: false
  const allPersonnel = await getDocs(collection(db, 'personnel'));
  allPersonnel.docs.forEach(d => {
    if (d.data().isDeleted === undefined) {
      batch.update(doc(db, 'personnel', d.id), { isDeleted: false });
    }
  });

  await batch.commit();
  console.log('Batch update committed.');

  // 6. Delete duplicate range
  await deleteDoc(doc(db, 'ranges', DUPLICATE_ID));
  console.log(`Deleted duplicate range document: ${DUPLICATE_ID}`);

  console.log('Migration complete!');
}

fixDuplicate().then(() => process.exit(0)).catch(err => {
  console.error(err);
  process.exit(1);
});
