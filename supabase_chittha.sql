-- ============================================================
-- CHITTHA (DUTY DEPLOYMENT) MODULE
-- ============================================================

CREATE TABLE chitthas (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    node_id UUID REFERENCES hierarchy_nodes(id) ON DELETE SET NULL,
    chittha_date DATE NOT NULL,
    status TEXT DEFAULT 'Draft', -- Draft, Submitted, Approved
    created_by_user_id UUID REFERENCES app_users(id),
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    submitted_at TIMESTAMPTZ,
    
    UNIQUE(node_id, chittha_date)
);

CREATE TABLE chittha_assignments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    chittha_id UUID NOT NULL REFERENCES chitthas(id) ON DELETE CASCADE,
    personnel_id UUID NOT NULL REFERENCES personnel(id) ON DELETE CASCADE,
    section_name TEXT NOT NULL,
    duty_type TEXT,
    duty_location TEXT,
    remark_text TEXT,
    node_id UUID REFERENCES hierarchy_nodes(id) ON DELETE SET NULL, -- Current node where they are assigned
    is_locked_by_osi BOOLEAN DEFAULT false,
    is_vip_duty BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Indices
CREATE INDEX idx_chittha_date ON chitthas(chittha_date);
CREATE INDEX idx_chittha_node ON chitthas(node_id);
CREATE INDEX idx_assign_chittha ON chittha_assignments(chittha_id);
CREATE INDEX idx_assign_personnel ON chittha_assignments(personnel_id);

-- RLS
ALTER TABLE chitthas ENABLE ROW LEVEL SECURITY;
ALTER TABLE chittha_assignments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "read_all" ON chitthas FOR SELECT USING (true);
CREATE POLICY "manage_all" ON chitthas FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "read_all" ON chittha_assignments FOR SELECT USING (true);
CREATE POLICY "manage_all" ON chittha_assignments FOR ALL USING (true) WITH CHECK (true);
