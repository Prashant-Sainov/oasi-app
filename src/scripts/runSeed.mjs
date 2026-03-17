/**
 * Standalone Node.js seeding script for OASI Portal
 * Run: node src/scripts/runSeed.mjs
 */
import { initializeApp } from 'firebase/app';
import { getFirestore, doc, setDoc, serverTimestamp, collection } from 'firebase/firestore';

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

async function seedAll() {
  console.log('🌱 Starting OASI Portal data seeding...\n');

  // 1. State
  await setDoc(doc(db, 'states', 'haryana'), {
    stateId: 'haryana', stateName: 'Haryana', createdAt: serverTimestamp(),
  });
  console.log('✅ State: Haryana');

  // 2. Range
  await setDoc(doc(db, 'ranges', 'range_hisar'), {
    rangeId: 'range_hisar', stateId: 'haryana', rangeName: 'Hisar Range', createdAt: serverTimestamp(),
  });
  console.log('✅ Range: Hisar Range');

  // 3. District
  await setDoc(doc(db, 'districts', 'district_hisar'), {
    districtId: 'district_hisar', rangeId: 'range_hisar', districtName: 'Hisar', createdAt: serverTimestamp(),
  });
  console.log('✅ District: Hisar');

  // 4. Roles
  const ROLES = [
    { id: 'role_state_admin', roleName: 'State Admin', description: 'Full system access' },
    { id: 'role_range_admin', roleName: 'Range Admin (OASI)', description: 'Range-level admin' },
    { id: 'role_district_admin', roleName: 'District Admin (OASI)', description: 'District-level admin' },
    { id: 'role_unit_admin', roleName: 'Unit Admin (MHC)', description: 'Unit-level admin' },
    { id: 'role_staff', roleName: 'Normal Staff', description: 'View-only access' },
  ];
  for (const role of ROLES) {
    await setDoc(doc(db, 'roles', role.id), { roleId: role.id, ...role, createdAt: serverTimestamp() });
  }
  console.log('✅ Roles (5)');

  // 5. Superadmin
  await setDoc(doc(db, 'users', 'user_sp_hisar'), {
    userId: 'user_sp_hisar', name: 'SP Hisar', beltNumber: 'ADMIN',
    password: 'oasi@2026', role: 'state_admin', roleLabel: 'State Admin',
    stateId: 'haryana', rangeId: 'range_hisar', districtId: 'district_hisar',
    unitId: '', subUnitId: '', isActive: true, mobileNumber: '', personnelId: '',
    createdAt: serverTimestamp(),
  });
  console.log('✅ Superadmin: SP Hisar (ADMIN / oasi@2026)');

  // 6. Attendance Types
  const ATT_TYPES = [
    { id: 'att_present', typeName: 'Present' }, { id: 'att_absent', typeName: 'Absent' },
    { id: 'att_half_day', typeName: 'Half Day' }, { id: 'att_hourly_leave', typeName: 'Hourly Leave' },
    { id: 'att_leave', typeName: 'Leave' }, { id: 'att_duty_outside', typeName: 'Duty Outside' },
  ];
  for (const at of ATT_TYPES) {
    await setDoc(doc(db, 'attendanceTypes', at.id), { attendanceTypeId: at.id, ...at, createdAt: serverTimestamp() });
  }
  console.log('✅ Attendance Types (6)');

  // 7. Duty Types
  const DUTY_TYPES = [
    { id: 'duty_naaka', dutyTypeName: 'Naaka' }, { id: 'duty_escort', dutyTypeName: 'Escort' },
    { id: 'duty_court', dutyTypeName: 'Court Duty' }, { id: 'duty_patrol', dutyTypeName: 'Patrol' },
    { id: 'duty_office', dutyTypeName: 'Office Duty' }, { id: 'duty_vip', dutyTypeName: 'VIP Duty' },
    { id: 'duty_night', dutyTypeName: 'Night Shift' }, { id: 'duty_traffic', dutyTypeName: 'Traffic' },
    { id: 'duty_investigation', dutyTypeName: 'Investigation' },
  ];
  for (const dt of DUTY_TYPES) {
    await setDoc(doc(db, 'dutyTypes', dt.id), { dutyTypeId: dt.id, ...dt, createdAt: serverTimestamp() });
  }
  console.log('✅ Duty Types (9)');

  // 8. Ranks
  const RANKS = [
    { id: 'rank_dgp', rankName: 'DGP', rankLevel: 1 }, { id: 'rank_adgp', rankName: 'ADGP', rankLevel: 2 },
    { id: 'rank_igp', rankName: 'IGP', rankLevel: 3 }, { id: 'rank_dig', rankName: 'DIG', rankLevel: 4 },
    { id: 'rank_ssp', rankName: 'SSP', rankLevel: 5 }, { id: 'rank_sp', rankName: 'SP', rankLevel: 6 },
    { id: 'rank_dsp', rankName: 'DSP', rankLevel: 7 }, { id: 'rank_inspector', rankName: 'Inspector', rankLevel: 8 },
    { id: 'rank_si', rankName: 'Sub Inspector', rankLevel: 9 }, { id: 'rank_asi', rankName: 'ASI', rankLevel: 10 },
    { id: 'rank_hc', rankName: 'Head Constable', rankLevel: 11 }, { id: 'rank_constable', rankName: 'Constable', rankLevel: 12 },
    { id: 'rank_homeguard', rankName: 'Home Guard', rankLevel: 13 },
  ];
  for (const rank of RANKS) {
    await setDoc(doc(db, 'ranks', rank.id), { rankId: rank.id, ...rank, createdAt: serverTimestamp() });
  }
  console.log('✅ Ranks (13)');

  console.log('\n🎉 OASI Portal seeding complete!');
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  console.log('Login credentials:');
  console.log('  Belt Number: ADMIN');
  console.log('  Password:    oasi@2026');
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
}

seedAll().then(() => {
  console.log('\nDone. You can now close this terminal.');
  process.exit(0);
}).catch(err => {
  console.error('❌ Seeding failed:', err);
  process.exit(1);
});
