-- ============================================================
-- SEED DATA: RECURSIVE HIERARCHY NODES (1400+ Nodes)
-- ============================================================

BEGIN;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '1', 
  'PHQ', 
  1, 
  NULL, 
  TRUE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2', 
  'Ranges, Commissionerate and Districts', 
  1, 
  NULL, 
  TRUE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1', 
  'Gurugram Commissionerate', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1', 
  'Gurugram District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.1', 
  'CP Office', 
  4, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.2', 
  'Joint CP Office', 
  4, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3', 
  'Zones', 
  4, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1', 
  'East Zone', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.1', 
  'DLF-II', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.2', 
  'DLF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.3', 
  'DLF PHASE-1', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.4', 
  'GURGAON SADAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.5', 
  'SECTOR-40', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.6', 
  'SECTOR-56', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.7', 
  'SUSHANT LOK', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.8', 
  'METRO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.9', 
  'SECTOR - 50', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.10', 
  'SECTOR - 53', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.11', 
  'Cyber Crime Police Station, Gurugram', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.12', 
  'DLF PH-3rd', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.13', 
  'PS Cyber Manesar', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.14', 
  'PS Cyber West', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.15', 
  'PS Cyber South', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.16', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.17', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.18', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.19', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.20', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.21', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.22', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.23', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.24', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.25', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.26', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.27', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.28', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.29', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.30', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.31', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.32', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.33', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.34', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.35', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.36', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.37', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.38', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.39', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.40', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.41', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.42', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.1.43', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2', 
  'West Zone', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.1', 
  'CIVIL LINES GURGAON', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.2', 
  'GURGAON CITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.3', 
  'RAJENDRA PARK', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.4', 
  'PALAM VIHAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.5', 
  'SECTOR-10', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.6', 
  'SECTOR-5, GURGAON', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.7', 
  'SECTOR-17 / 18', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.8', 
  'SECTOR-14, Gurugram', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.9', 
  'UDYOG VIHAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.10', 
  'NEW COLONY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.11', 
  'SHIVAJI NAGAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.12', 
  'SECTOR - 9A', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.13', 
  'BAJGHERA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.14', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.15', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.16', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.17', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.18', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.19', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.20', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.21', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.22', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.23', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.24', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.25', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.26', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.27', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.28', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.29', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.30', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.31', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.32', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.33', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.34', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.35', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.36', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.37', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.38', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.39', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.40', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.2.41', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3', 
  'South Zone', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.1', 
  'BADSHAHPUR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.2', 
  'BHONDSI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.3', 
  'SOHNA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.4', 
  'CITY SOHANA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.5', 
  'SECTOR-65', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.6', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.7', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.8', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.9', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.10', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.11', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.12', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.13', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.14', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.15', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.16', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.17', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.18', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.19', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.20', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.21', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.22', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.23', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.24', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.25', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.26', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.27', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.28', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.29', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.30', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.31', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.32', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.3.33', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4', 
  'Manesar Zone', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.1', 
  'BILASPUR GURUGRAM', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.2', 
  'FURRUKH NAGAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.3', 
  'KHEDKI DAULA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.4', 
  'MANESAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.5', 
  'PATAUDI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.6', 
  'SECTOR - 37', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.7', 
  'INDUSTRIAL SECTOR - 7, MANESAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.8', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.9', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.10', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.11', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.12', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.13', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.14', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.15', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.16', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.17', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.18', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.19', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.20', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.21', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.22', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.23', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.24', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.25', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.26', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.27', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.28', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.29', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.30', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.31', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.32', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.33', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.34', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.4.35', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.5', 
  'HQ', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.6', 
  'Crime', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.1.1.3.7', 
  'Traffic', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.1.1.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2', 
  'Faridabad Commissionerate', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1', 
  'Faridabad District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.1', 
  'CP Office', 
  4, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.2', 
  'Joint CP Office', 
  4, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3', 
  'Zones', 
  4, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1', 
  'NIT Zone', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.1', 
  'FARIDABAD KOTWALI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.2', 
  'FARIDABAD N.I.T.', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.3', 
  'MUJESAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.4', 
  'S.G.M. NAGAR (SANJAY GANDHI MEMORIAL NAGAR)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.5', 
  'SECTOR-58', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.6', 
  'SARAN', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.7', 
  'SURAJ KUND', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.8', 
  'Women Police Station NIT,Faridabad', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.9', 
  'DABUA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.10', 
  'DHAUJ', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.11', 
  'PS Cyber Crime NIT', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.12', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.13', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.14', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.15', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.16', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.17', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.18', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.19', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.20', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.21', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.22', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.23', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.24', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.25', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.26', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.27', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.28', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.29', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.30', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.31', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.32', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.33', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.34', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.35', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.36', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.37', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.38', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.1.39', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2', 
  'Central Zone', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.1', 
  'WOMEN POLICE STATION, FARIDABAD', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.2', 
  'BHUPANI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.3', 
  'FARIDABAD CENTRAL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.4', 
  'FARIDABAD OLD', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.5', 
  'SECTOR-31 FARIDABAD', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.6', 
  'SARAI KHAWAJA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.7', 
  'KHERIPUL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.8', 
  'SECTOR-17', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.9', 
  'PALLA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.10', 
  'Polilce Station B.P.T.P.', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.11', 
  'Metro Police Station Faridabad', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.12', 
  'PS Cyber Crime Central', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.13', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.14', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.15', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.16', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.17', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.18', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.19', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.20', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.21', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.22', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.23', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.24', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.25', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.26', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.27', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.28', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.29', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.30', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.31', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.32', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.33', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.34', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.35', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.36', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.37', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.38', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.39', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.2.40', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3', 
  'Ballabhgarh Zone', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.1', 
  'BALLABHGARH CITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.2', 
  'BALLABHGARH SADAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.3', 
  'CHHANSA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.4', 
  'TIGAON', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.5', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.6', 
  'SECTOR - 8', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.7', 
  'Women Police Station Ballabgarh', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.8', 
  'ADARSH NAGAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.9', 
  'PS Cyber Crime Ballabgarh', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.10', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.11', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.12', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.13', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.14', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.15', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.16', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.17', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.18', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.19', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.20', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.21', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.22', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.23', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.24', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.25', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.26', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.27', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.28', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.29', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.30', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.31', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.32', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.33', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.34', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.35', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.36', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.3.37', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.4', 
  'HQ', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.5', 
  'Crime', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.2.1.3.6', 
  'Traffic', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.2.1.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3', 
  'Panchkula Commissionerate', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1', 
  'Panchkula District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.1', 
  'CHANDIMANDIR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.2', 
  'CYBER CRIME', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.3', 
  'KALKA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.4', 
  'MANSA DEVI COMPLEX', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.5', 
  'Nodal Cyber Crime Police Station, Haryana', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.6', 
  'PANCHKULA SECTOR-5', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.7', 
  'PINJORE', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.8', 
  'RAIPUR RANI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.9', 
  'SECTOR-14, PANCHKULA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.10', 
  'SECTOR-20', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.11', 
  'SECTOR-7, PANCHKULA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.12', 
  'WOMEN POLICE STATION, PANCHKULA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.13', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.14', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.15', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.16', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.17', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.18', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.19', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.20', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.21', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.22', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.23', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.24', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.25', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.26', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.27', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.28', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.29', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.30', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.31', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.32', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.33', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.34', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.35', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.36', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.37', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.38', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.39', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.40', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.1', 
  'CP Office', 
  4, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.2', 
  'Zones', 
  4, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.2.1', 
  'Panchkula Zone', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.3.1.2.2', 
  'Traffic and Crime', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.3.1.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4', 
  'Sonipat Commissionerate', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1', 
  'Sonipat District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.1', 
  'CP Office', 
  4, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2', 
  'Zones', 
  4, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1', 
  'East Zone', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.1', 
  'GANNAUR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.2', 
  'KUNDLI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.3', 
  'MURTHAL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.4', 
  'RAI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.5', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.6', 
  'HSIDC BARHI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.7', 
  'BAHALGARH', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.8', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.9', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.10', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.11', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.12', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.13', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.14', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.15', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.16', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.17', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.18', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.19', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.20', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.21', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.22', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.23', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.24', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.25', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.26', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.27', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.28', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.29', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.30', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.31', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.32', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.33', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.34', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.1.35', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2', 
  'West Zone', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.1', 
  'SECTOR-27, SONIPAT', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.2', 
  'CIVIL LINE SONIPAT', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.3', 
  'KHARKHODA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.4', 
  'SONIPAT CITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.5', 
  'SONIPAT SADAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.6', 
  'WOMEN POLICE STATION', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.7', 
  'PS Cyber Sonipat', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.8', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.9', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.10', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.11', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.12', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.13', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.14', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.15', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.16', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.17', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.18', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.19', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.20', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.21', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.22', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.23', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.24', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.25', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.26', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.27', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.28', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.29', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.30', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.31', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.32', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.33', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.34', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.2.35', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3', 
  'Gohana Zone', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.1', 
  'BARAUDA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.2', 
  'GOHANA CITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.3', 
  'GOHANA SADAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.4', 
  'MOOHANA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.5', 
  'WOMEN PS KHANPUR KALAN', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.6', 
  'WOMEN PS GOHANA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.7', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.8', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.9', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.10', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.11', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.12', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.13', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.14', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.15', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.16', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.17', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.18', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.19', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.20', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.21', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.22', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.23', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.24', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.25', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.26', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.27', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.28', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.29', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.30', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.31', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.32', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.33', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.3.34', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.4', 
  'HQ', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.4.1.2.5', 
  'Crime', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.4.1.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5', 
  'Jhajjar Commissionerate', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1', 
  'Jhajjar District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.1', 
  'CP Office', 
  4, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2', 
  'Zones', 
  4, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1', 
  'Jhajjar Zone', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.1', 
  'WOMEN POLICE STATION, JHAJJAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.2', 
  'BERI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.3', 
  'SADAR JHAJJAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.4', 
  'SAHLAWAS', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.5', 
  'DUJANA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.6', 
  'MACHHROLI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.7', 
  'CITY JHAJJAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.8', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.9', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.10', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.11', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.12', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.13', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.14', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.15', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.16', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.17', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.18', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.19', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.20', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.21', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.22', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.23', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.24', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.25', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.26', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.27', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.28', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.29', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.30', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.31', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.32', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.33', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.34', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.1.35', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2', 
  'Bahadurgarh Zone', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.1', 
  'CITY BAHADURGARH', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.2', 
  'LINE PAR BAHADURGARH', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.3', 
  'SADAR BAHADURGARH', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.4', 
  'TRAFFIC BAHADURGARH', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.5', 
  'SECTOR-06 BAHADURGRH', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.6', 
  'ASAUDA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.7', 
  'BADLI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.8', 
  'WOMEN PS BAHADURGARH,JHAJJAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.9', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.10', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.11', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.12', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.13', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.14', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.15', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.16', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.17', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.18', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.19', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.20', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.21', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.22', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.23', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.24', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.25', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.26', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.27', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.28', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.29', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.30', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.31', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.32', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.33', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.34', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.35', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.2.36', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.3', 
  'HQ', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.5.1.2.4', 
  'Crime', 
  5, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.5.1.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6', 
  'Ambala Range', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.1', 
  'Ambala Range Office', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2', 
  'Ambala District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.1', 
  'AMBALA CANTT', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.2', 
  'AMBALA CITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.3', 
  'AMBALA SADAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.4', 
  'BALDEV NAGAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.5', 
  'BARARA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.6', 
  'MAHESH NAGAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.7', 
  'MULLANA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.8', 
  'NAGGAL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.9', 
  'NARAINGARH', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.10', 
  'PANJOKHRA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.11', 
  'PARAO AMBALA CANTT', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.12', 
  'PS CYBER CRIME AMBALA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.13', 
  'SAHA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.14', 
  'SECTOR-9, AMBALA CITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.15', 
  'SHAHZADPUR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.16', 
  'WOMEN POLICE STATION NARAINGARH, AMBALA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.17', 
  'WOMEN POLICE STATION, AMBALA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.18', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.19', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.20', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.21', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.22', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.23', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.24', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.25', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.26', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.27', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.28', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.29', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.30', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.31', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.32', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.33', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.34', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.35', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.36', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.37', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.38', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.39', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.40', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.41', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.42', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.43', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.44', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.2.45', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3', 
  'Kurukshetra District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.1', 
  'BABAIN', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.2', 
  'CITY PEHOWA, KURUKSHETRA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.3', 
  'CYBER CRIME POLICE STATION, KURUKSHETRA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.4', 
  'ISMAILABAD', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.5', 
  'JHANSA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.6', 
  'KRISHANA GATE, THANASAR KURUKSHETRA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.7', 
  'KURUKSHETRA UNIVERSITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.8', 
  'LADWA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.9', 
  'PEHOWA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.10', 
  'SHAHABAD', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.11', 
  'THANESAR CITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.12', 
  'THANESAR SADAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.13', 
  'WOMEN POLICE STATION, KURUKSHETRA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.14', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.15', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.16', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.17', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.18', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.19', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.20', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.21', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.22', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.23', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.24', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.25', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.26', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.27', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.28', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.29', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.30', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.31', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.32', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.33', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.34', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.35', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.36', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.37', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.38', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.39', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.40', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.3.41', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4', 
  'Yamunanagar District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.1', 
  'BILASPUR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.2', 
  'BURIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.3', 
  'CHHACHHRAULI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.4', 
  'CHHAPAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.5', 
  'Cyber Crime Police Station, Yamunanagar', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.6', 
  'FARAKPUR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.7', 
  'GANDHI NAGAR, YAMUNANAGAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.8', 
  'JAGADDHRI SADAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.9', 
  'JAGADHRI CITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.10', 
  'JATHLANA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.11', 
  'PRATAP NAGAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.12', 
  'RADAUR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.13', 
  'SADHAURA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.14', 
  'SEC.17 HUDA, JAGADHRI YAMUNANAGAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.15', 
  'WOMEN POLICE STATION, YAMUNA NAGAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.16', 
  'YAMUNA NAGAR CITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.17', 
  'YAMUNA NAGAR SADAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.18', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.19', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.20', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.21', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.22', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.23', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.24', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.25', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.26', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.27', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.28', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.29', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.30', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.31', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.32', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.33', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.34', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.35', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.36', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.37', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.38', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.39', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.40', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.41', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.42', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.43', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.44', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.6.4.45', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.6.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7', 
  'Karnal Range Office', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1', 
  'Karnal District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.1', 
  'ASSANDH', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.2', 
  'BUTANA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.3', 
  'Cyber Crime police station karnal', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.4', 
  'GHARAUNDA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.5', 
  'INDRI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.6', 
  'KARNAL CITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.7', 
  'KARNAL CIVIL LINES', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.8', 
  'KARNAL SADAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.9', 
  'KUNJPURA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.10', 
  'MADHUBAN', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.11', 
  'MUNAK, KARNAL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.12', 
  'NIGDHU KARNAL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.13', 
  'NISSING', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.14', 
  'RAM NAGAR KARNAL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.15', 
  'SECTOR 32-33 KARNAL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.16', 
  'TARAORI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.17', 
  'Women Police Station Assand,Karnal', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.18', 
  'WOMEN POLICE STATION, KARNAL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.19', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.20', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.21', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.22', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.23', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.24', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.25', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.26', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.27', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.28', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.29', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.30', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.31', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.32', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.33', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.34', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.35', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.36', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.37', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.38', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.39', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.40', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.41', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.42', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.43', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.44', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.45', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.1.46', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2', 
  'Kaithal District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.1', 
  'Cyber Crime Police Station Kaithal', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.2', 
  'CHEEKA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.3', 
  'CIVIL LINE KAITHAL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.4', 
  'Dhand', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.5', 
  'GUHLA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.6', 
  'KAITHAL CITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.7', 
  'KAITHAL SADAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.8', 
  'KALAYAT', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.9', 
  'PUNDRI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.10', 
  'RAJAUND', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.11', 
  'SIWAN', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.12', 
  'TITRAM', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.13', 
  'WOMEN POLICE STATION, KAITHAL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.14', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.15', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.16', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.17', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.18', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.19', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.20', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.21', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.22', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.23', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.24', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.25', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.26', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.27', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.28', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.29', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.30', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.31', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.32', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.33', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.34', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.35', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.36', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.37', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.38', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.39', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.40', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.2.41', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3', 
  'Panipat District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.1', 
  'BAPOLI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.2', 
  'CHANDNIBAGH', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.3', 
  'Cyber Crime Police Station Panipat', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.4', 
  'Industrial Sector 29 Panipat', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.5', 
  'ISRANA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.6', 
  'MATLAUDA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.7', 
  'Model Town Panipat', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.8', 
  'Old Industrial Panipat', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.9', 
  'PANIPAT CITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.10', 
  'PANIPAT SADAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.11', 
  'Quilla Panipat', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.12', 
  'SAMALKHA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.13', 
  'SANOLI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.14', 
  'SECTOR 13/17 PANIPAT', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.15', 
  'Tehsil Camp Panipat', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.16', 
  'WOMEN POLICE STATION, PANIPAT', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.17', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.18', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.19', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.20', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.21', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.22', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.23', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.24', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.25', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.26', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.27', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.28', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.29', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.30', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.31', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.32', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.33', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.34', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.35', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.36', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.37', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.38', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.39', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.40', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.41', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.42', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.43', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.7.3.44', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.7.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8', 
  'Hisar Range Office', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1', 
  'Hisar District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.1', 
  'ADAMPUR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.2', 
  'AGROHA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.3', 
  'AZAD NAGAR HISAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.4', 
  'BARWALA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.5', 
  'Cyber Crime, Police Station Hisar', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.6', 
  'HISAR CITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.7', 
  'HISAR CIVIL LINES', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.8', 
  'HISAR SADAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.9', 
  'HTM HISAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.10', 
  'UKLANA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.11', 
  'URBAN ESTATE HISAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.12', 
  'WOMEN POLICE STATION, HISSAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.13', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.14', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.15', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.16', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.17', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.18', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.19', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.20', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.21', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.22', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.23', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.24', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.25', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.26', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.27', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.28', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.29', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.30', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.31', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.32', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.33', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.34', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.35', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.36', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.37', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.38', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.39', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.1.40', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2', 
  'Hansi District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.1', 
  'BASS', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.2', 
  'HANSI CITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.3', 
  'HANSI SADAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.4', 
  'NARNAUND', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.5', 
  'PS CYBER CRIME, HANSI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.6', 
  'Women Police Station, HANSI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.7', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.8', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.9', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.10', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.11', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.12', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.13', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.14', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.15', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.16', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.17', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.18', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.19', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.20', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.21', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.22', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.23', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.24', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.25', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.26', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.27', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.28', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.29', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.30', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.31', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.32', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.33', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.2.34', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3', 
  'Jind District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.1', 
  'ALEWA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.2', 
  'CITY SAFIDON', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.3', 
  'Civil line Jind', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.4', 
  'GARHI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.5', 
  'JIND CITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.6', 
  'JIND SADAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.7', 
  'JULANA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.8', 
  'NARWANA CITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.9', 
  'NARWANA SADAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.10', 
  'PILLU KHERA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.11', 
  'PS Cyber, District Jind', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.12', 
  'SAFIDON', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.13', 
  'UCHANA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.14', 
  'WOMEN POLICE STATION, JIND', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.15', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.16', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.17', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.18', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.19', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.20', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.21', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.22', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.23', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.24', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.25', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.26', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.27', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.28', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.29', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.30', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.31', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.32', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.33', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.34', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.35', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.36', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.37', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.38', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.39', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.40', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.41', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.3.42', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4', 
  'Sirsa District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.1', 
  'BARAGUDHA(Sirsa)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.2', 
  'CITY MANDI DABWALI(Sirsa)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.3', 
  'Cyber Crime Police Station Sirsa', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.4', 
  'DING', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.5', 
  'ELLENABAD', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.6', 
  'NATHU SARAI CHOPTA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.7', 
  'Police Station,Civil Line Sirsa', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.8', 
  'RANIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.9', 
  'RORI(Sirsa)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.10', 
  'SIRSA CITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.11', 
  'SIRSA SADAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.12', 
  'WOMEN POLICE STATION, SIRSA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.13', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.14', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.15', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.16', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.17', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.18', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.19', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.20', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.21', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.22', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.23', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.24', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.25', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.26', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.27', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.28', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.29', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.30', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.31', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.32', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.33', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.34', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.35', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.36', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.37', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.38', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.39', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.4.40', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5', 
  'Dabwali District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.1', 
  'CITY MANDI DABWALI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.2', 
  'DABWALI SADAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.3', 
  'KALAN WALI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.4', 
  'ODHAN', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.5', 
  'Women Police Station Dabwali,Sirsa', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.6', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.7', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.8', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.9', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.10', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.11', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.12', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.13', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.14', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.15', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.16', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.17', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.18', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.19', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.20', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.21', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.22', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.23', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.24', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.25', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.26', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.27', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.28', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.29', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.30', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.31', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.32', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.5.33', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6', 
  'Fatehabad District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.1', 
  'BHATTU KALAN', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.2', 
  'BHUNA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.3', 
  'CITY FATEHABAD', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.4', 
  'CITY RATIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.5', 
  'CITY TOHANA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.6', 
  'Cyber Crime Police Station Fatehabad', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.7', 
  'JAKHAL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.8', 
  'SADAR FATEHABAD', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.9', 
  'SADAR RATTIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.10', 
  'SADAR TOHANA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.11', 
  'WOMEN POLICE STATION, FATEHABAD', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.12', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.13', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.14', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.15', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.16', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.17', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.18', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.19', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.20', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.21', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.22', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.23', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.24', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.25', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.26', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.27', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.28', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.29', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.30', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.31', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.32', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.33', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.34', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.35', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.36', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.37', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.38', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.8.6.39', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.8.6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9', 
  'Rohtak Range Office', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1', 
  'Rohtak District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.1', 
  'ARYA NAGAR ROHTAK', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.2', 
  'BAHUAKBARPUR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.3', 
  'Cyber Police Station Rohtak', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.4', 
  'I.M.T. ROHTAK', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.5', 
  'KALANAUR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.6', 
  'LAKHAN MAJRA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.7', 
  'MEHAM', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.8', 
  'P.G.I.M.S. ROHTAK', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.9', 
  'PURANI SABZI MANDI ROHTAK', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.10', 
  'ROHTAK CITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.11', 
  'ROHTAK CIVIL LINES', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.12', 
  'ROHTAK SADAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.13', 
  'SAMPLA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.14', 
  'SHIVAJI COLONY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.15', 
  'URBAN ESTATE ROHTAK', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.16', 
  'WOMEN POLICE STATION, ROHTAK', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.17', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.18', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.19', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.20', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.21', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.22', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.23', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.24', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.25', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.26', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.27', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.28', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.29', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.30', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.31', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.32', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.33', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.34', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.35', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.36', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.37', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.38', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.39', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.40', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.41', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.42', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.43', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.1.44', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2', 
  'Dadri District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.1', 
  'BADHRA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.2', 
  'BOND KALAN', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.3', 
  'DADRI CITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.4', 
  'DADRI SADAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.5', 
  'JHOJHU KALAN', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.6', 
  'PS Cyber Crime, Charkhi Dadri', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.7', 
  'Women Police Station, Charkhi Dadri', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.8', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.9', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.10', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.11', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.12', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.13', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.14', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.15', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.16', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.17', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.18', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.19', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.20', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.21', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.22', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.23', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.24', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.25', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.26', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.27', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.28', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.29', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.30', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.31', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.32', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.33', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.34', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.2.35', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3', 
  'Bhiwani District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.1', 
  'BAWANI KHERA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.2', 
  'BEHAL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.3', 
  'BHIWANI CITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.4', 
  'BHIWANI CIVIL LINES', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.5', 
  'BHIWANI SADAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.6', 
  'Cyber Crime Police Station, Bhiwani', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.7', 
  'JUI KALAN PS BHIWANI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.8', 
  'LOHARU', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.9', 
  'PS INDUSTRIAL AREA, BHIWANI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.10', 
  'SIWANI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.11', 
  'TOSHAM', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.12', 
  'WOMEN POLICE STATION, BHIWANI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.13', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.14', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.15', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.16', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.17', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.18', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.19', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.20', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.21', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.22', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.23', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.24', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.25', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.26', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.27', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.28', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.29', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.30', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.31', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.32', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.33', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.34', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.35', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.36', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.37', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.38', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.39', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.9.3.40', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.9.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10', 
  'South Range', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1', 
  'Rewari District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.1', 
  'BAWAL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.2', 
  'DHARUHERA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.3', 
  'JATUSANA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.4', 
  'KASOLA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.5', 
  'KHOL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.6', 
  'KOSLI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.7', 
  'MODEL TOWN REWARI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.8', 
  'POLICE STATION CYBER CRIME, REWARI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.9', 
  'RAMPURA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.10', 
  'REWARI CITY', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.11', 
  'REWARI SADAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.12', 
  'ROHADAI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.13', 
  'SEC-6, DHARUHERA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.14', 
  'WOMEN POLICE STATION, REWARI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.15', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.16', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.17', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.18', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.19', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.20', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.21', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.22', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.23', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.24', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.25', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.26', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.27', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.28', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.29', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.30', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.31', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.32', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.33', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.34', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.35', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.36', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.37', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.38', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.39', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.40', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.41', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.1.42', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2', 
  'Nuh District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.1', 
  'BICCHOR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.2', 
  'CITY NUH', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.3', 
  'CITY TAURU', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.4', 
  'FEROZEPUR JHIRKA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.5', 
  'NAGINA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.6', 
  'PINANGWA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.7', 
  'PS Akera', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.8', 
  'PS City Firozpur Jhirka', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.9', 
  'PS City Punhana', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.10', 
  'PS Cyber Crime Nuh(Mewat)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.11', 
  'PS Mohammadpur Ahir', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.12', 
  'PUNHANA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.13', 
  'ROZKA MEO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.14', 
  'SADAR NUH', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.15', 
  'SADAR TAURU', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.16', 
  'WOMEN POLICE STATION, MEWAT', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.17', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.18', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.19', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.20', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.21', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.22', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.23', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.24', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.25', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.26', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.27', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.28', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.29', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.30', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.31', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.32', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.33', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.34', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.35', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.36', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.37', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.38', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.39', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.40', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.41', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.42', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.43', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.2.44', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3', 
  'Palwal District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.1', 
  'BAHIN', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.2', 
  'CAMP PALWAL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.3', 
  'CHAND HUT', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.4', 
  'CITY PALWAL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.5', 
  'GADPURI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.6', 
  'HASSANPUR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.7', 
  'HATHIN', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.8', 
  'HODAL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.9', 
  'MUNDKATI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.10', 
  'PS Cyber Crime, District Palwal', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.11', 
  'SADAR PALWAL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.12', 
  'UTAWAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.13', 
  'WOMEN POLICE STATION, PALWAL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.14', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.15', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.16', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.17', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.18', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.19', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.20', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.21', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.22', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.23', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.24', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.25', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.26', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.27', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.28', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.29', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.30', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.31', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.32', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.33', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.34', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.35', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.36', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.37', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.38', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.39', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.40', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.3.41', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4', 
  'Narnaul District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.1', 
  'ATELI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.2', 
  'CITY KANINA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.3', 
  'CITY MAHENDERGARH', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.4', 
  'CITY NARNAUL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.5', 
  'CYBER POLICE STATION, MAHENDERGARH', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.6', 
  'NANGAL CHAUDHRI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.7', 
  'NIZAMPUR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.8', 
  'SADAR KANINA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.9', 
  'SADAR MAHENDERGARH', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.10', 
  'SADAR NARNAUL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.11', 
  'SATNALI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.12', 
  'WOMEN POLICE STATION, NARNAUL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.13', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.14', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.15', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.16', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.17', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.18', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.19', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.20', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.21', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.22', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.23', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.24', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.25', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.26', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.27', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.28', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.29', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.30', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.31', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.32', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.33', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.34', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.35', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.36', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.37', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.38', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.39', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.10.4.40', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.10.4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11', 
  'IGP Railways and Commando', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1', 
  'Railways District', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.1', 
  'GRP AMBALA Cantt', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.2', 
  'GRP BAHADURGARH', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.3', 
  'GRP CHANDIGARH', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.4', 
  'GRP FARIDABAD', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.5', 
  'GRP GURUGRAM', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.6', 
  'GRP HISAR', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.7', 
  'GRP JAGADHARI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.8', 
  'GRP JIND', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.9', 
  'GRP KALKA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.10', 
  'GRP KARNAL', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.11', 
  'GRP KURUKSHETRA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.12', 
  'GRP PANIPAT', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.13', 
  'GRP REWARI', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.14', 
  'GRP ROHTAK', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.15', 
  'GRP SIRSA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.16', 
  'GRP SONIPAT', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.17', 
  'ABVT STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.18', 
  'ADR Centre', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.19', 
  'ANC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.20', 
  'Challaning Branch', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.21', 
  'CIA', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.22', 
  'Couple Protection Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.23', 
  'Court Security', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.24', 
  'Deputation', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.25', 
  'DPO', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.26', 
  'EOW', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.27', 
  'GO Staffs', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.28', 
  'Gunmen', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.29', 
  'Head Proficient', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.30', 
  'Judicial Lockup', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.31', 
  'Missing Person Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.32', 
  'Naib Court', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.33', 
  'Naib Court (Civil)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.34', 
  'Pairvi Cell', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.35', 
  'PO STAFF', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.36', 
  'Police Lines', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.37', 
  'Prisoner Escort Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.38', 
  'PS TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.39', 
  'Standing Guard', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.40', 
  'Summon Staff', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.41', 
  'Temporary Posting (with order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.42', 
  'Temporary Posting (without order)', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.43', 
  'TRAFFIC', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '2.11.1.44', 
  'Training Courses', 
  6, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '2.11.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '3', 
  'Training Centres', 
  1, 
  NULL, 
  TRUE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '3.1', 
  'Women PTC Hisar', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '3.2', 
  'HPA', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '3.3', 
  'RTC, Bhondsi', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '3.4', 
  'PTC, Sunaria', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '3'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '4', 
  'Armed Police', 
  1, 
  NULL, 
  TRUE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '4.1', 
  'HAP', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '4.1.1', 
  'IG HAP', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '4.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '4.1.2', 
  '1st Bn HAP', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '4.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '4.1.3', 
  '2nd Bn HAP', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '4.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '4.1.4', 
  '3rd Bn HAP', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '4.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '4.1.5', 
  '4th Bn HAP', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '4.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '4.1.6', 
  '5th Bn HAP', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '4.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '4.1.7', 
  'DSRAF', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '4.1'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '4.2', 
  'IRB', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '4'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '4.2.1', 
  'IG IRB', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '4.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '4.2.2', 
  '1st Bn IRB', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '4.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '4.2.3', 
  '2nd Bn IRB', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '4.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '4.2.4', 
  '3rd Bn IRB', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '4.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '4.2.5', 
  '4th Bn IRB', 
  3, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '4.2'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '5', 
  'Forensic Labs', 
  1, 
  NULL, 
  TRUE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '5.1', 
  'FSL Madhuban', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '5.2', 
  'RFSL Sunaria', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '5.3', 
  'RFSL Hisar', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '5.4', 
  'RFSL Bhondsi', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '5.5', 
  'Cyber Lab Panchkula', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '5'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '6', 
  'Specialised/Deputation Units', 
  1, 
  NULL, 
  TRUE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '6.1', 
  'Commando', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '6.2', 
  'Telecom', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '6.3', 
  'CID', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '6.4', 
  'HSDRF', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '6.5', 
  'SCRB', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '6.6', 
  'ACB', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '6.7', 
  'HSEnB', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '6.8', 
  'State Crime Branch', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '6.9', 
  'Cyber Crime Branch', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '6.10', 
  'HSNCB', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '6.11', 
  'STF', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '6.12', 
  'TRAFFIC & HIGHWAYS', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '6.13', 
  'SPCA', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '6.14', 
  'HHRC', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '6.15', 
  'ATS', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '6.16', 
  'HOME GUARD', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '6.17', 
  'CPT&R', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '6.18', 
  'VIGILANCE & SECURITY', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '6.19', 
  'ERSS', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

INSERT INTO hierarchy_nodes (node_code, name, level, parent_id, is_fixed) 
VALUES (
  '6.20', 
  'CSO', 
  2, 
  (SELECT id FROM hierarchy_nodes WHERE node_code = '6'), 
  FALSE
) ON CONFLICT (node_code) DO NOTHING;

COMMIT;
