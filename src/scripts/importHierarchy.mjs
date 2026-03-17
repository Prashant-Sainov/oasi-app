/**
 * REFACTORED: Bulk Hierarchy Importer for OASI Portal
 * 
 * Strict Hierarchical Logic:
 * State → Range → District → Unit Category → Unit Name → Sub Unit
 * 
 * Rules:
 * 1. Data isolation via mandatory StateID mapping.
 * 2. Record-by-record verification/creation.
 * 3. Duplicate prevention: Skip if exists in parent context.
 * 4. Audit logging of insertions and skips.
 */
import { initializeApp } from 'firebase/app';
import { getFirestore, doc, setDoc, getDoc, serverTimestamp } from 'firebase/firestore';
import { createRequire } from 'module';
const require = createRequire(import.meta.url);
const XLSX = require('xlsx');
const { readFile, utils } = XLSX;
import { fileURLToPath } from 'url';
import path from 'path';

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

const slugify = (text) => {
  if (!text) return '';
  return text.toString().toLowerCase()
    .trim()
    .replace(/\s+/g, '_')
    .replace(/[^\w-]+/g, '')
    .replace(/--+/g, '_')
    .replace(/^-+/, '')
    .replace(/-+$/, '');
};

async function run() {
  const args = process.argv.slice(2);
  if (args.length === 0) {
    console.error('❌ Error: Please provide the path to the Excel file.');
    process.exit(1);
  }

  const filePath = path.resolve(args[0]);
  console.log(`📂 Reading file: ${filePath}`);

  try {
    const workbook = readFile(filePath);
    const sheetName = workbook.SheetNames[0];
    const data = utils.sheet_to_json(workbook.Sheets[sheetName]);

    console.log(`📊 Found ${data.length} records. Beginning hierarchical import...\n`);

    const stats = { inserted: 0, skipped: 0, states: 0, ranges: 0, districts: 0, units: 0, subUnits: 0 };
    
    // In-memory cache to reduce reads during the same run
    const cache = new Set();

    for (let i = 0; i < data.length; i++) {
      const row = data[i];
      const sName = row['State']?.toString().trim();
      const rName = row['Range']?.toString().trim();
      const dName = row['District']?.toString().trim();
      const uCat = row['Unit_Category']?.toString().trim() || 'Other';
      const uName = row['Unit_Name']?.toString().trim();
      const suName = row['Sub_Unit_Name']?.toString().trim();

      if (!sName || !rName || !dName || !uName) {
        console.warn(`[Row ${i+2}] ⚠️ Missing required data. Skipping row.`);
        stats.skipped++;
        continue;
      }

      // 1. STATE
      const sId = slugify(sName);
      if (!cache.has(`state:${sId}`)) {
        const sSnap = await getDoc(doc(db, 'states', sId));
        if (!sSnap.exists()) {
          await setDoc(doc(db, 'states', sId), {
            stateId: sId,
            stateName: sName,
            createdAt: serverTimestamp()
          });
          console.log(`[State] ✨ Created: ${sName}`);
          stats.states++;
        }
        cache.add(`state:${sId}`);
      }

      // 2. RANGE (Unique inside State)
      const rId = `${sId}_${slugify(rName)}`;
      if (!cache.has(`range:${rId}`)) {
        const rSnap = await getDoc(doc(db, 'ranges', rId));
        if (!rSnap.exists()) {
          await setDoc(doc(db, 'ranges', rId), {
            rangeId: rId,
            stateId: sId,
            rangeName: rName,
            createdAt: serverTimestamp()
          });
          console.log(`  [Range] ✨ Created: ${rName} (State: ${sName})`);
          stats.ranges++;
        }
        cache.add(`range:${rId}`);
      }

      // 3. DISTRICT (Unique inside Range + State)
      const dId = `${rId}_${slugify(dName)}`;
      if (!cache.has(`district:${dId}`)) {
        const dSnap = await getDoc(doc(db, 'districts', dId));
        if (!dSnap.exists()) {
          await setDoc(doc(db, 'districts', dId), {
            districtId: dId,
            rangeId: rId,
            stateId: sId,
            districtName: dName,
            createdAt: serverTimestamp()
          });
          console.log(`    [District] ✨ Created: ${dName} (Range: ${rName})`);
          stats.districts++;
        }
        cache.add(`district:${dId}`);
      }

      // 4. UNIT (Unique inside District + Category + State)
      const uId = `${dId}_${slugify(uCat)}_${slugify(uName)}`;
      if (!cache.has(`unit:${uId}`)) {
        const uSnap = await getDoc(doc(db, 'units', uId));
        if (!uSnap.exists()) {
          await setDoc(doc(db, 'units', uId), {
            unitId: uId,
            districtId: dId,
            stateId: sId,
            unitName: uName,
            unitType: uCat,
            createdAt: serverTimestamp()
          });
          console.log(`      [Unit] ✨ Created: ${uName} [${uCat}] (District: ${dName})`);
          stats.units++;
          stats.inserted++;
        } else {
          stats.skipped++;
        }
        cache.add(`unit:${uId}`);
      } else {
        // Even if Unit is in cache, we need to handle its sub-units if present
      }

      // 5. SUB-UNIT (Unique inside Unit)
      if (suName) {
        const suId = `${uId}_${slugify(suName)}`;
        if (!cache.has(`subunit:${suId}`)) {
          const suSnap = await getDoc(doc(db, 'subUnits', suId));
          if (!suSnap.exists()) {
            await setDoc(doc(db, 'subUnits', suId), {
              subUnitId: suId,
              unitId: uId,
              stateId: sId,
              subUnitName: suName,
              createdAt: serverTimestamp()
            });
            console.log(`        [Sub-Unit] ✨ Created: ${suName} (Unit: ${uName})`);
            stats.subUnits++;
          }
          cache.add(`subunit:${suId}`);
        }
      }
    }

    console.log('\n✅ Hierarchical Import Complete!');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log(` Result:     ${stats.inserted} Inserted / ${stats.skipped} Skipped`);
    console.log(` States:     ${stats.states}`);
    console.log(` Ranges:     ${stats.ranges}`);
    console.log(` Districts:  ${stats.districts}`);
    console.log(` Units:      ${stats.units}`);
    console.log(` SubUnits:   ${stats.subUnits}`);
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

  } catch (err) {
    console.error('❌ Fatal Error:', err.message);
  } finally {
    process.exit(0);
  }
}

run();
