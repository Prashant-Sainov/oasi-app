import { db } from '../firebase.js';
import { collection, getDocs, updateDoc, doc, query, where, limit } from 'firebase/firestore';

async function migrate() {
  console.log('--- Starting Hierarchy Sync ---');
  
  // Load all hierarchy reference data
  const subUnitsSnap = await getDocs(collection(db, 'subUnits'));
  const subUnitsMap = {};
  subUnitsSnap.docs.forEach(d => subUnitsMap[d.id] = { id: d.id, ...d.data() });
  console.log(`Loaded ${subUnitsSnap.size} Sub-Units`);

  const unitsSnap = await getDocs(collection(db, 'units'));
  const unitsMap = {};
  unitsSnap.docs.forEach(d => unitsMap[d.id] = { id: d.id, ...d.data() });
  console.log(`Loaded ${unitsSnap.size} Units`);

  const personnelSnap = await getDocs(collection(db, 'personnel'));
  console.log(`Auditing ${personnelSnap.size} Personnel records...`);

  let updatedCount = 0;
  for (const pDoc of personnelSnap.docs) {
    const p = pDoc.data();
    const updates = {};

    // 1. Try to recover parentage from subUnitId
    if (p.currentSubUnitId && subUnitsMap[p.currentSubUnitId]) {
      const su = subUnitsMap[p.currentSubUnitId];
      if (!p.currentUnitId) updates.currentUnitId = su.unitId;
    }

    // 2. Recover from unitId
    const targetUnitId = updates.currentUnitId || p.currentUnitId;
    if (targetUnitId && unitsMap[targetUnitId]) {
      const u = unitsMap[targetUnitId];
      if (u.districtId && p.districtId !== u.districtId) updates.districtId = u.districtId;
      if (u.rangeId && p.rangeId !== u.rangeId) updates.rangeId = u.rangeId;
      if (u.stateId && p.stateId !== u.stateId) updates.stateId = u.stateId;
      if (u.unitType && p.unitType !== u.unitType) updates.unitType = u.unitType;
    }

    if (Object.keys(updates).length > 0) {
      await updateDoc(doc(db, 'personnel', pDoc.id), updates);
      updatedCount++;
    }
  }

  console.log(`Sync complete. Updated ${updatedCount} personnel records.`);
  process.exit(0);
}

migrate().catch(err => {
  console.error(err);
  process.exit(1);
});
