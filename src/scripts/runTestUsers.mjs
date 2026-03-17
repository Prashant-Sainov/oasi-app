import { initializeApp } from 'firebase/app';
import { getFirestore, doc, setDoc } from 'firebase/firestore';

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyCD3veNMEYJXJY_A3vaOeIhF0hXP7LwmlU",
  authDomain: "oasi-portal.firebaseapp.com",
  databaseURL: "https://oasi-portal-default-rtdb.firebaseio.com",
  projectId: "oasi-portal",
  storageBucket: "oasi-portal.firebasestorage.app",
  messagingSenderId: "43590378729",
  appId: "1:43590378729:web:c8fe29859ecb244a4dfc78"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

async function seedTestUsers() {
  console.log('Seeding test users for different roles...');

  const testUsers = [
    {
       uid: 'SUPER_ADMIN_TEST',
       name: 'Super Admin',
       beltNumber: 'SUPERADMIN',
       role: 'super_admin',
       password: 'password123',
       stateId: null,
       rangeId: null,
       districtId: null,
       unitId: null
    },
    {
       uid: 'STATE_ADMIN_TEST',
       name: 'State Admin (Haryana)',
       beltNumber: 'STATEADMIN',
       role: 'state_admin',
       password: 'password123',
       stateId: 'haryana',
       rangeId: null,
       districtId: null,
       unitId: null
    },
    {
       uid: 'RANGE_ADMIN_TEST',
       name: 'Range Admin (Hisar Range)',
       beltNumber: 'RANGEADMIN',
       role: 'range_admin',
       password: 'password123',
       stateId: 'haryana',
       rangeId: 'RANGE_HISAR',
       districtId: null,
       unitId: null
    },
    {
       uid: 'DISTRICT_ADMIN_TEST',
       name: 'District Admin (SP Hisar)',
       beltNumber: 'DISTRICTADMIN',
       role: 'district_admin',
       password: 'password123',
       stateId: 'haryana',
       rangeId: 'RANGE_HISAR',
       districtId: 'DISTRICT_HISAR',
       unitId: null
    },
    {
       uid: 'UNIT_ADMIN_TEST',
       name: 'Unit Admin (SHO City)',
       beltNumber: 'UNITADMIN',
       role: 'unit_admin',
       password: 'password123',
       stateId: 'haryana',
       rangeId: 'RANGE_HISAR',
       districtId: 'DISTRICT_HISAR',
       unitId: 'UNIT_CITY'
    },
    {
        uid: 'STAFF_TEST',
        name: 'Normal Staff (Constable)',
        beltNumber: '1234',
        role: 'staff',
        password: 'password123',
        stateId: 'haryana',
        rangeId: 'RANGE_HISAR',
        districtId: 'DISTRICT_HISAR',
        unitId: 'UNIT_CITY'
    }
  ];

  for (const user of testUsers) {
    try {
      await setDoc(doc(db, 'users', user.beltNumber.toUpperCase()), {
        userId: user.uid,
        name: user.name,
        beltNumber: user.beltNumber.toUpperCase(),
        role: user.role,
        password: user.password, // Plain text for demo purposes only
        stateId: user.stateId,
        rangeId: user.rangeId,
        districtId: user.districtId,
        unitId: user.unitId,
        createdAt: new Date(),
        isActive: true
      });
      console.log(`Created test user: ${user.name} (Belt: ${user.beltNumber})`);
    } catch (e) {
      console.error(`Error creating ${user.name}:`, e);
    }
  }

  console.log('Finished creating test users.');
  process.exit(0);
}

seedTestUsers();
