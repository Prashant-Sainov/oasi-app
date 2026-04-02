-- ============================================================
-- PHASE 4: REPORTS, GRIEVANCES, LEAVES & REMAINING TABLES
-- ============================================================

-- FIR Reports Table
CREATE TABLE IF NOT EXISTS fir_reports (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    node_id UUID REFERENCES hierarchy_nodes(id) ON DELETE SET NULL,
    year TEXT NOT NULL,
    quarter TEXT NOT NULL,
    police_station TEXT NOT NULL,
    fir_count INTEGER DEFAULT 0,
    charge_sheet_filed INTEGER DEFAULT 0,
    conviction INTEGER DEFAULT 0,
    pending INTEGER DEFAULT 0,
    cognizable INTEGER DEFAULT 0,
    non_cognizable INTEGER DEFAULT 0,
    created_by_user_id UUID REFERENCES app_users(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_fir_reports_node ON fir_reports (node_id);
CREATE INDEX IF NOT EXISTS idx_fir_reports_period ON fir_reports (year, quarter);

-- Grievances Table
CREATE TABLE IF NOT EXISTS grievances (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    node_id UUID REFERENCES hierarchy_nodes(id) ON DELETE SET NULL,
    applicant_name TEXT NOT NULL,
    applicant_mobile TEXT,
    grievance_type TEXT,
    description TEXT,
    status TEXT DEFAULT 'Pending' CHECK (status IN ('Pending', 'In Progress', 'Resolved', 'Closed')),
    assigned_to_user_id UUID REFERENCES app_users(id),
    resolution_text TEXT,
    created_by_user_id UUID REFERENCES app_users(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Leaves Table
CREATE TABLE IF NOT EXISTS leaves (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    personnel_id UUID REFERENCES personnel(id) ON DELETE CASCADE,
    node_id UUID REFERENCES hierarchy_nodes(id) ON DELETE SET NULL,
    leave_type TEXT NOT NULL, 
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_days INTEGER,
    reason TEXT,
    status TEXT DEFAULT 'Applied' CHECK (status IN ('Applied', 'Approved', 'Rejected', 'Cancelled')),
    approved_by_user_id UUID REFERENCES app_users(id),
    approval_date TIMESTAMP WITH TIME ZONE,
    remarks TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Transfers Table (Alternative format for quick tracking)
CREATE TABLE IF NOT EXISTS transfers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    personnel_id UUID REFERENCES personnel(id) ON DELETE CASCADE,
    from_node_id UUID REFERENCES hierarchy_nodes(id),
    to_node_id UUID REFERENCES hierarchy_nodes(id),
    order_number TEXT,
    order_date DATE,
    relieving_date DATE,
    joining_date DATE,
    status TEXT DEFAULT 'Ordered' CHECK (status IN ('Ordered', 'Relieved', 'Joined', 'Cancelled')),
    remarks TEXT,
    created_by_user_id UUID REFERENCES app_users(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- RLS Policies
ALTER TABLE fir_reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE grievances ENABLE ROW LEVEL SECURITY;
ALTER TABLE leaves ENABLE ROW LEVEL SECURITY;
ALTER TABLE transfers ENABLE ROW LEVEL SECURITY;

CREATE POLICY "read_all" ON fir_reports FOR SELECT USING (true);
CREATE POLICY "manage_all" ON fir_reports FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "read_all" ON grievances FOR SELECT USING (true);
CREATE POLICY "manage_all" ON grievances FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "read_all" ON leaves FOR SELECT USING (true);
CREATE POLICY "manage_all" ON leaves FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "read_all" ON transfers FOR SELECT USING (true);
CREATE POLICY "manage_all" ON transfers FOR ALL USING (true) WITH CHECK (true);
