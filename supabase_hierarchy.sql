-- HIERARCHY NODES TABLE
-- This table replaces the old ranges, districts, and units structure.

CREATE TABLE IF NOT EXISTS hierarchy_nodes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    node_code TEXT NOT NULL UNIQUE, -- e.g., "1", "2.1", "2.1.1.3"
    name TEXT NOT NULL,
    level INTEGER NOT NULL,
    parent_id UUID REFERENCES hierarchy_nodes(id) ON DELETE CASCADE,
    is_fixed BOOLEAN DEFAULT FALSE, -- Level 1 nodes are fixed
    assigned_module TEXT DEFAULT 'attendance', -- legacy support
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- CREATE INDEXES for faster traversal
CREATE INDEX IF NOT EXISTS idx_hierarchy_parent ON hierarchy_nodes(parent_id);
CREATE INDEX IF NOT EXISTS idx_hierarchy_code ON hierarchy_nodes(node_code);

-- TRIGGER for updated_at
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
