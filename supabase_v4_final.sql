-- FIR Reports Table
CREATE TABLE IF NOT EXISTS fir_reports (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    state_id TEXT,
    range_id TEXT,
    district_id TEXT,
    unit_id TEXT,
    sub_unit_id TEXT,
    year TEXT NOT NULL,
    quarter TEXT NOT NULL,
    police_station TEXT NOT NULL,
    fir_count INTEGER DEFAULT 0,
    charge_sheet_filed INTEGER DEFAULT 0,
    conviction INTEGER DEFAULT 0,
    pending INTEGER DEFAULT 0,
    cognizable INTEGER DEFAULT 0,
    non_cognizable INTEGER DEFAULT 0,
    created_by_user_id TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Index for FIR Reports
CREATE INDEX IF NOT EXISTS idx_fir_reports_period ON fir_reports (year, quarter);

-- Grievances Table
CREATE TABLE IF NOT EXISTS grievances (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    state_id TEXT,
    range_id TEXT,
    district_id TEXT,
    unit_id TEXT,
    sub_unit_id TEXT,
    applicant_name TEXT NOT NULL,
    applicant_mobile TEXT,
    grievance_type TEXT,
    description TEXT,
    status TEXT DEFAULT 'Pending' CHECK (status IN ('Pending', 'In Progress', 'Resolved', 'Closed')),
    assigned_to_user_id TEXT,
    resolution_text TEXT,
    created_by_user_id TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Leaves Table
CREATE TABLE IF NOT EXISTS leaves (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    personnel_id UUID REFERENCES personnel(id),
    state_id TEXT,
    range_id TEXT,
    district_id TEXT,
    unit_id TEXT,
    sub_unit_id TEXT,
    leave_type TEXT NOT NULL, -- e.g., Casual, Medical, Earned
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_days INTEGER,
    reason TEXT,
    status TEXT DEFAULT 'Applied' CHECK (status IN ('Applied', 'Approved', 'Rejected', 'Cancelled')),
    approved_by_user_id TEXT,
    approval_date TIMESTAMP WITH TIME ZONE,
    remarks TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Transfers Table
CREATE TABLE IF NOT EXISTS transfers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    personnel_id UUID REFERENCES personnel(id),
    state_id TEXT,
    range_id TEXT,
    district_id TEXT,
    from_unit_id UUID REFERENCES units(id),
    to_unit_id UUID REFERENCES units(id),
    order_number TEXT,
    order_date DATE,
    relieving_date DATE,
    joining_date DATE,
    status TEXT DEFAULT 'Ordered' CHECK (status IN ('Ordered', 'Relieved', 'Joined', 'Cancelled')),
    remarks TEXT,
    created_by_user_id TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Add RLS Policies for new tables
ALTER TABLE fir_reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE grievances ENABLE ROW LEVEL SECURITY;
ALTER TABLE leaves ENABLE ROW LEVEL SECURITY;
ALTER TABLE transfers ENABLE ROW LEVEL SECURITY;

-- Permissive policies for migration
CREATE POLICY "Allow all for authenticated users on fir_reports" ON fir_reports FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for authenticated users on grievances" ON grievances FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for authenticated users on leaves" ON leaves FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for authenticated users on transfers" ON transfers FOR ALL TO anon USING (true) WITH CHECK (true);
