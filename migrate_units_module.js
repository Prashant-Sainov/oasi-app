import { db } from './src/firebase.js';
import { collection, getDocs, updateDoc, doc, writeBatch } from 'firebase/firestore';

async function migrateUnits() {
  console.log('Starting migration: Assigning all units/sub-units to "attendance"...');
  
  try {
    const batch = writeBatch(db);
    let count = 0;

    // 1. Units
    const unitsSnap = await getDocs(collection(db, 'units'));
    unitsSnap.docs.forEach(d => {
      if (!d.data().assignedModule) {
        batch.update(doc(db, 'units', d.id), { assignedModule: 'attendance' });
        count++;
      }
    });

    // 2. Sub-Units
    const subUnitsSnap = await getDocs(collection(db, 'subUnits'));
    subUnitsSnap.docs.forEach(d => {
      if (!d.data().assignedModule) {
        batch.update(doc(db, 'subUnits', d.id), { assignedModule: 'attendance' });
        count++;
      }
    });

    if (count > 0) {
      await batch.commit();
      console.log(`Success! Migrated ${count} records.`);
    } else {
      console.log('No migration needed. All records already have assignedModule.');
    }
  } catch (err) {
    console.error('Migration failed:', err);
  }
}

migrateUnits();
