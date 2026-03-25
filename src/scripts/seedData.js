/**
 * OASI Portal — Firebase Data Seeding Script
 *
 * Run this script ONCE after setting up Firebase to create:
 * 1. Haryana state
 * 2. Hisar Range
 * 3. Hisar District
 * 4. SP Hisar superadmin user
 * 5. Roles master data
 * 6. Attendance Types
 * 7. Duty Types
 * 8. Ranks master table
 *
 * Usage: node src/scripts/seedData.js
 * (Requires Firebase Admin SDK or you can paste this in browser console after login)
 *
 * NOTE: For browser-side seeding, import this as a module and call seedAll()
 */

import { db } from '../firebase.js';
import { doc, setDoc, serverTimestamp, collection, getDocs, writeBatch, query, limit } from 'firebase/firestore';

// ==================== SEED DATA ====================

const STATE = {
  id: 'haryana',
  stateName: 'Haryana',
};

const RANGE = {
  id: 'range_hisar',
  stateId: 'haryana',
  rangeName: 'Hisar Range',
};

const DISTRICT = {
  id: 'district_hisar',
  rangeId: 'range_hisar',
  districtName: 'Hisar',
};

const ROLES = [
  { id: 'role_state_admin', roleName: 'State Admin', description: 'Full system access for state-level administration' },
  { id: 'role_range_admin', roleName: 'Range Admin (OASI)', description: 'Range-level administration' },
  { id: 'role_district_admin', roleName: 'District Admin (OASI)', description: 'District-level personnel and unit management' },
  { id: 'role_unit_admin', roleName: 'Unit Admin (MHC)', description: 'Unit-level chittha, attendance, and duty management' },
  { id: 'role_staff', roleName: 'Normal Staff', description: 'View-only access to own records (future phase)' },
];

const SUPERADMIN = {
  id: 'user_sp_hisar',
  userId: 'user_sp_hisar',
  name: 'SP Hisar',
  beltNumber: 'ADMIN',
  password: 'oasi@2026',
  role: 'state_admin',
  stateId: 'haryana',
  rangeId: 'range_hisar',
  districtId: 'district_hisar',
  unitId: '',
  subUnitId: '',
  isActive: true,
  mobileNumber: '',
  personnelId: '',
};

const ATTENDANCE_TYPES = [
  { id: 'att_present', typeName: 'Present', description: 'Full day present on duty' },
  { id: 'att_absent', typeName: 'Absent', description: 'Full day absent' },
  { id: 'att_half_day', typeName: 'Half Day', description: 'Present for half day' },
  { id: 'att_hourly_leave', typeName: 'Hourly Leave', description: 'Absent for specific hours' },
  { id: 'att_leave', typeName: 'Leave', description: 'On approved leave' },
  { id: 'att_duty_outside', typeName: 'Duty Outside', description: 'On duty outside the unit' },
];

const DUTY_TYPES = [
  { id: 'duty_naaka', dutyTypeName: 'Naaka', description: 'Checking/barrier duty' },
  { id: 'duty_escort', dutyTypeName: 'Escort', description: 'Escort duty' },
  { id: 'duty_court', dutyTypeName: 'Court Duty', description: 'Court appearance or guard' },
  { id: 'duty_patrol', dutyTypeName: 'Patrol', description: 'Area patrol duty' },
  { id: 'duty_office', dutyTypeName: 'Office Duty', description: 'Office/desk duty' },
  { id: 'duty_vip', dutyTypeName: 'VIP Duty', description: 'VIP security duty' },
  { id: 'duty_night', dutyTypeName: 'Night Shift', description: 'Night duty shift' },
  { id: 'duty_traffic', dutyTypeName: 'Traffic', description: 'Traffic control duty' },
  { id: 'duty_investigation', dutyTypeName: 'Investigation', description: 'Case investigation' },
];

const RANKS = [
  { id: 'rank_dgp', rankName: 'DGP', rankLevel: 1, abbreviation: 'DGP' },
  { id: 'rank_adgp', rankName: 'ADGP', rankLevel: 2, abbreviation: 'ADGP' },
  { id: 'rank_igp', rankName: 'IGP', rankLevel: 3, abbreviation: 'IGP' },
  { id: 'rank_dig', rankName: 'DIG', rankLevel: 4, abbreviation: 'DIG' },
  { id: 'rank_ssp', rankName: 'SSP', rankLevel: 5, abbreviation: 'SSP' },
  { id: 'rank_sp', rankName: 'SP', rankLevel: 6, abbreviation: 'SP' },
  { id: 'rank_dsp', rankName: 'DSP', rankLevel: 7, abbreviation: 'DSP' },
  { id: 'rank_inspector', rankName: 'Inspector', rankLevel: 8, abbreviation: 'Insp' },
  { id: 'rank_si', rankName: 'Sub Inspector', rankLevel: 9, abbreviation: 'SI' },
  { id: 'rank_asi', rankName: 'ASI', rankLevel: 10, abbreviation: 'ASI' },
  { id: 'rank_hc', rankName: 'Head Constable', rankLevel: 11, abbreviation: 'HC' },
  { id: 'rank_constable', rankName: 'Constable', rankLevel: 12, abbreviation: 'Ct' },
  { id: 'rank_homeguard', rankName: 'Home Guard', rankLevel: 13, abbreviation: 'HG' },
];

// ==================== SEED FUNCTIONS ====================

export async function seedAll() {
  console.log('🌱 Starting OASI Portal data seeding...');

  try {
    // 1. State
    await setDoc(doc(db, 'states', STATE.id), {
      stateId: STATE.id,
      stateName: STATE.stateName,
      createdAt: serverTimestamp(),
    });
    console.log('✅ State: Haryana created');

    // 2. Range
    await setDoc(doc(db, 'ranges', RANGE.id), {
      rangeId: RANGE.id,
      stateId: RANGE.stateId,
      rangeName: RANGE.rangeName,
      createdAt: serverTimestamp(),
    });
    console.log('✅ Range: Hisar Range created');

    // 3. District
    await setDoc(doc(db, 'districts', DISTRICT.id), {
      districtId: DISTRICT.id,
      rangeId: DISTRICT.rangeId,
      districtName: DISTRICT.districtName,
      createdAt: serverTimestamp(),
    });
    console.log('✅ District: Hisar created');

    // 4. Roles
    for (const role of ROLES) {
      await setDoc(doc(db, 'roles', role.id), {
        roleId: role.id,
        roleName: role.roleName,
        description: role.description,
        createdAt: serverTimestamp(),
      });
    }
    console.log('✅ Roles seeded (5 roles)');

    // 5. Superadmin user
    await setDoc(doc(db, 'users', SUPERADMIN.id), {
      ...SUPERADMIN,
      createdAt: serverTimestamp(),
    });
    console.log('✅ Superadmin: SP Hisar created');
    console.log('   Login: Belt Number = ADMIN, Password = oasi@2026');

    // 6. Attendance Types
    for (const at of ATTENDANCE_TYPES) {
      await setDoc(doc(db, 'attendanceTypes', at.id), {
        attendanceTypeId: at.id,
        typeName: at.typeName,
        description: at.description,
        createdAt: serverTimestamp(),
      });
    }
    console.log('✅ Attendance Types seeded (6 types)');

    // 7. Duty Types
    for (const dt of DUTY_TYPES) {
      await setDoc(doc(db, 'dutyTypes', dt.id), {
        dutyTypeId: dt.id,
        dutyTypeName: dt.dutyTypeName,
        description: dt.description,
        createdAt: serverTimestamp(),
      });
    }
    console.log('✅ Duty Types seeded (9 types)');

    // 8. Ranks
    for (const rank of RANKS) {
      await setDoc(doc(db, 'ranks', rank.id), {
        rankId: rank.id,
        rankName: rank.rankName,
        rankLevel: rank.rankLevel,
        abbreviation: rank.abbreviation,
        createdAt: serverTimestamp(),
      });
    }
    console.log('✅ Ranks seeded (13 ranks)');

    console.log('\n🎉 OASI Portal seeding complete!');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log('Login credentials:');
    console.log('  Belt Number: ADMIN');
    console.log('  Password:    oasi@2026');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

    return true;
  } catch (err) {
    if (import.meta.env.DEV) console.error('❌ Seeding failed:', err);
    throw err;
  }
}

/**
 * PURGE FUNCTION: Deletes all personnel and transactional data
 * Safe: Keeps States, Ranges, Districts, Units, Roles, and Ranks.
 */
export async function purgeAllPersonnelData() {
  const COLLECTIONS_TO_PURGE = [
    'personnel', 'attendance', 'leaves', 'chitthas', 
    'firs', 'grievances', 'dutyAssignments'
  ];

  if (import.meta.env.DEV) console.log('🧹 Starting bulk data purge...');

  try {
    for (const collName of COLLECTIONS_TO_PURGE) {
      if (import.meta.env.DEV) console.log(`  Deleting from: ${collName}...`);
      
      let deletedCount = 0;
      // Fetch documents in batches to avoid memory issues
      const snap = await getDocs(collection(db, collName));
      
      if (snap.empty) continue;

      const chunks = [];
      const docs = snap.docs;
      for (let i = 0; i < docs.length; i += 500) {
        chunks.push(docs.slice(i, i + 500));
      }

      for (const chunk of chunks) {
        const batch = writeBatch(db);
        chunk.forEach(d => batch.delete(d.ref));
        await batch.commit();
        deletedCount += chunk.length;
      }
      
      if (import.meta.env.DEV) console.log(`  ✅ Removed ${deletedCount} records from ${collName}`);
    }
    
    if (import.meta.env.DEV) console.log('🎉 Bulk purge complete! Hierarchy is preserved.');
    return true;
  } catch (err) {
    if (import.meta.env.DEV) console.error('❌ Purge failed:', err);
    throw err;
  }
}
