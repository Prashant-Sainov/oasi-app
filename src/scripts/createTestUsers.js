
import { initializeApp } from 'firebase/app';
import { getFirestore, doc, setDoc, serverTimestamp, collection, query, where, getDocs } from 'firebase/firestore';

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

const TEST_USERS = [
  {
    id: 'user_state_haryana',
    userId: 'state_admin_haryana',
    name: 'State Admin (Haryana)',
    beltNumber: 'STATE_ADMIN',
    password: 'oasi@state',
    role: 'state_admin',
    stateId: 'haryana',
    rangeId: '',
    districtId: '',
    unitId: '',
    subUnitId: '',
    isActive: true,
  },
  {
    id: 'user_district_hisar',
    userId: 'district_admin_hisar',
    name: 'District Admin (Hisar)',
    beltNumber: 'DISTRICT_ADMIN',
    password: 'oasi@district',
    role: 'district_admin',
    stateId: 'haryana',
    rangeId: 'haryana_hisar_range', // Confirmed from browser/greps earlier
    districtId: 'district_hisar',
    unitId: '',
    subUnitId: '',
    isActive: true,
  },
  {
    id: 'user_unit_hisar_city',
    userId: 'unit_admin_hisar_city',
    name: 'Unit Admin (Hisar City)',
    beltNumber: 'UNIT_ADMIN',
    password: 'oasi@unit',
    role: 'unit_admin',
    stateId: 'haryana',
    rangeId: 'haryana_hisar_range',
    districtId: 'district_hisar',
    unitId: 'haryana_hisar_range_hisar_police_station_hisar_city', // Reasonable ID based on naming convention
    subUnitId: '',
    isActive: true,
  }
];

async function createTestUsers() {
  console.log('Creating test users...');
  
  // Verify Unit ID for Unit Admin
  const unitRef = collection(db, 'units');
  const q = query(unitRef, where('districtId', '==', 'district_hisar'), where('unitName', '==', 'Hisar City'));
  const unitSnap = await getDocs(q);
  
  if (!unitSnap.empty) {
    const unitId = unitSnap.docs[0].id;
    TEST_USERS[2].unitId = unitId;
    console.log(`Using Unit ID: ${unitId} for Hisar City`);
  } else {
    // If 'Hisar City' not found, just pick the first unit in Hisar
    const q2 = query(unitRef, where('districtId', '==', 'district_hisar'));
    const unitSnap2 = await getDocs(q2);
    if (!unitSnap2.empty) {
      const unitId = unitSnap2.docs[0].id;
      TEST_USERS[2].unitId = unitId;
      TEST_USERS[2].name = `Unit Admin (${unitSnap2.docs[0].data().unitName})`;
      console.log(`Hisar City not found, using ${unitSnap2.docs[0].data().unitName} (ID: ${unitId})`);
    }
  }

  for (const user of TEST_USERS) {
    await setDoc(doc(db, 'users', user.id), {
      ...user,
      createdAt: serverTimestamp(),
    });
    console.log(`✅ Created ${user.role}: ${user.name}`);
  }
  process.exit(0);
}

createTestUsers().catch(console.error);
