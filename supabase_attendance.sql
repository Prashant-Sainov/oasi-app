-- ============================================================
-- ATTENDANCE MODULE
-- ============================================================

CREATE TABLE attendance_register (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    personnel_id UUID NOT NULL REFERENCES personnel(id) ON DELETE CASCADE,
    date DATE NOT NULL,
    attendance_type TEXT NOT NULL, 
    attendance_source TEXT DEFAULT 'Register',
    marking_method TEXT DEFAULT 'Manual',
    -- Linked to node_id instead of legacy location IDs
    node_id UUID REFERENCES hierarchy_nodes(id) ON DELETE SET NULL,
    marked_by_user_id UUID REFERENCES app_users(id),
    marked_by_role TEXT,
    is_late BOOLEAN DEFAULT false,
    marked_at TIMESTAMPTZ DEFAULT now(),
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    
    UNIQUE(personnel_id, date)
);

CREATE INDEX idx_attendance_date ON attendance_register(date);
CREATE INDEX idx_attendance_node ON attendance_register(node_id);
CREATE INDEX idx_attendance_personnel ON attendance_register(personnel_id);

ALTER TABLE attendance_register ENABLE ROW LEVEL SECURITY;

CREATE POLICY "read_all" ON attendance_register FOR SELECT USING (true);
CREATE POLICY "manage_all" ON attendance_register FOR ALL USING (true) WITH CHECK (true);
