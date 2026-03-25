
import { db } from '../firebase.js';
import { collection, getDocs, query, where, deleteDoc, doc } from 'firebase/firestore';

async function diagnoseAndFixRanges() {
  console.log('--- Ranges ---');
  const rangesSnap = await getDocs(collection(db, 'ranges'));
  const allRanges = rangesSnap.docs.map(d => ({ id: d.id, ...d.data() }));
  console.log(JSON.stringify(allRanges, null, 2));

  console.log('\n--- Districts ---');
  const districtsSnap = await getDocs(collection(db, 'districts'));
  const allDistricts = districtsSnap.docs.map(d => ({ id: d.id, ...d.data() }));
  console.log(JSON.stringify(allDistricts, null, 2));

  const hisarRanges = allRanges.filter(r => r.rangeName === 'Hisar Range');
  console.log(`\nFound ${hisarRanges.length} Hisar Ranges.`);

  if (hisarRanges.length > 1) {
    console.log('Duplicate detected. Checking which one has districts...');
    for (const r of hisarRanges) {
      const dists = allDistricts.filter(d => d.rangeId === r.id);
      console.log(`Range ID: ${r.id} has ${dists.length} districts.`);
    }
  }
}

diagnoseAndFixRanges();
