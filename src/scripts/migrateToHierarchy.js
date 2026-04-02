import { db } from '../firebase.js';
import { collection, doc, writeBatch, serverTimestamp, getDocs, query, where } from 'firebase/firestore';
import processedData from '../../hierarchy_processed.json' assert { type: 'json' };

/**
 * Migrates hierarchy_processed.json into Firestore 'hierarchy_nodes' collection.
 * Uses batch writes for efficiency.
 */
export async function migrateHierarchy() {
  console.log('🚀 Starting Hierarchy Migration...');
  
  const colRef = collection(db, 'hierarchy_nodes');
  const batch = writeBatch(db);
  let count = 0;

  // 1. Clear existing (Optional, but safer for re-runs)
  const existing = await getDocs(colRef);
  if (!existing.empty) {
    console.log('🧹 Clearing existing hierarchy_nodes...');
    const deleteBatch = writeBatch(db);
    existing.docs.forEach(d => deleteBatch.delete(d.ref));
    await deleteBatch.commit();
  }

  // 2. Upload in chunks of 500 (Firestore limit)
  const chunks = [];
  for (let i = 0; i < processedData.length; i += 500) {
    chunks.push(processedData.slice(i, i + 500));
  }

  for (const chunk of chunks) {
    const currentBatch = writeBatch(db);
    chunk.forEach(node => {
      // Use node_code as the document ID for easy parent linking
      const docRef = doc(colRef, node.node_code);
      currentBatch.set(docRef, {
        ...node,
        parent_id: node.parent_code || null, // In Firestore, we use the parent's node_code
        createdAt: serverTimestamp(),
        updatedAt: serverTimestamp()
      });
      count++;
    });
    await currentBatch.commit();
    console.log(`✅ Uploaded ${count} nodes...`);
  }

  console.log('🎉 Migration complete!');
  return count;
}
