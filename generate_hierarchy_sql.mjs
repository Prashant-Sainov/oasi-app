import fs from 'fs';
import path from 'path';

/**
 * Parses hierarchy_data.csv and generates SQL INSERT statements.
 * Handles the recursive parent-child relationship based on the node_code (Index).
 */
const csvPath = 'hierarchy_data.csv';
const outputPath = 'supabase_hierarchy_data.sql';

function generateHierarchySQL() {
    console.log('Reading CSV...');
    const data = fs.readFileSync(csvPath, 'utf8');
    const lines = data.split('\n');
    
    let sql = '-- ============================================================\n';
    sql += '-- SEED DATA: RECURSIVE HIERARCHY NODES (1400+ Nodes)\n';
    sql += '-- ============================================================\n\n';
    
    // We'll use a transaction for speed and safety
    sql += 'BEGIN;\n\n';

    // To prevent errors, we'll use a temporary mapping or subqueries
    // Subquery approach is safer for a single SQL file
    
    for (let i = 1; i < lines.length; i++) {
        const line = lines[i].trim();
        if (!line) continue;

        // Simple CSV split (handling quotes)
        const parts = line.split(/,(?=(?:(?:[^"]*"){2})*[^"]*$)/);
        if (parts.length < 8) continue;

        let nodeCode = parts[0].trim();
        // Remove trailing dot if exists (e.g. "2.1." -> "2.1")
        if (nodeCode.endsWith('.')) nodeCode = nodeCode.slice(0, -1);

        // Find the name (it will be in one of the Level columns)
        let name = '';
        let level = 0;
        for (let l = 1; l <= 7; l++) {
            if (parts[l] && parts[l].trim().replace(/^"|"$/g, '')) {
                name = parts[l].trim().replace(/^"|"$/g, '');
                level = l;
                break;
            }
        }

        if (!name) continue;

        // Determine parent code
        const codeParts = nodeCode.split('.');
        const parentCode = codeParts.length > 1 ? codeParts.slice(0, -1).join('.') : null;

        // Generate SQL
        sql += `INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) \n`;
        sql += `VALUES (\n`;
        sql += `  '${nodeCode}', \n`;
        sql += `  '${name.replace(/'/g, "''")}', \n`;
        sql += `  ${level}, \n`;
        if (parentCode) {
            sql += `  (SELECT id FROM hierarchy_nodes WHERE node_code = '${parentCode}'), \n`;
        } else {
            sql += `  NULL, \n`;
        }
        sql += `  ${level === 1 ? 'TRUE' : 'FALSE'}\n`;
        sql += `) ON CONFLICT (node_code) DO NOTHING;\n\n`;

        if (i % 100 === 0) console.log(`Processed ${i} nodes...`);
    }

    sql += 'COMMIT;\n';
    
    fs.writeFileSync(outputPath, sql);
    console.log(`✅ Success! Generated ${outputPath}`);
}

generateHierarchySQL();
