-- ============================================================
-- FOUNDATION: RECURSIVE HIERARCHY
-- ============================================================

-- Enables UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- HIERARCHY NODES TABLE
-- This recursive table replaces the old states, ranges, districts, and units.
CREATE TABLE IF NOT EXISTS hierarchy_nodes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    node_code TEXT NOT NULL UNIQUE,      -- e.g., "1", "2.1", "2.1.1.3"
    name TEXT NOT NULL,
    level INTEGER NOT NULL,              -- 1 (PHQ), 2 (Range), 3 (District), etc.
    parent_id UUID REFERENCES hierarchy_nodes(id) ON DELETE CASCADE,
    is_fixed BOOLEAN DEFAULT FALSE,     -- Level 1 nodes are fixed
    assigned_module TEXT DEFAULT 'attendance', -- 'attendance', 'chittha'
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for faster hierarchy traversal
CREATE INDEX IF NOT EXISTS idx_hierarchy_parent ON hierarchy_nodes(parent_id);
CREATE INDEX IF NOT EXISTS idx_hierarchy_code ON hierarchy_nodes(node_code);
CREATE INDEX IF NOT EXISTS idx_hierarchy_level ON hierarchy_nodes(level);

-- TRIGGER to auto-update updated_at field
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_hierarchy_nodes_modtime
    BEFORE UPDATE ON hierarchy_nodes
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- UNIT CATEGORIES (Helpful for grouping nodes like 'Police Station', 'CIA', etc.)
CREATE TABLE IF NOT EXISTS unit_categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Link hierarchy nodes to categories (Optional)
ALTER TABLE hierarchy_nodes ADD COLUMN IF NOT EXISTS category_id UUID REFERENCES unit_categories(id) ON DELETE SET NULL;
