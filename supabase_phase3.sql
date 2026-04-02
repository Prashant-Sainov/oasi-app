-- ============================================================
-- PHASE 3: PERSONNEL & POSTING/TRANSFER MODULE
-- ============================================================

-- =====================
-- 3A. PERSONNEL TABLE (Core Bio-data)
-- =====================
CREATE TABLE personnel (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    -- Identity
    belt_number TEXT,
    pay_code TEXT,
    full_name TEXT NOT NULL,
    father_name TEXT,
    photo_url TEXT,
    -- Personal
    date_of_birth DATE,
    gender TEXT,
    blood_group TEXT,
    mobile_number TEXT NOT NULL,
    alternate_contact TEXT,
    religion TEXT,
    caste TEXT,
    category TEXT,
    aadhar_number TEXT,
    pan TEXT,
    -- Home Address
    village TEXT,
    police_station TEXT,
    home_district TEXT,
    -- Service Details
    rank TEXT,
    cadre TEXT,
    service_type TEXT,
    service_status TEXT DEFAULT 'Active',
    service_book_number TEXT,
    date_of_enlistment DATE,
    date_of_last_promotion DATE,
    retirement_date DATE,
    -- Duty & Role
    ps_duty_type TEXT,
    io_status TEXT,
    io_category TEXT,
    parade_group TEXT,
    spo_trade TEXT,
    company TEXT,
    r_batch TEXT,
    t_duty_order TEXT,
    remarks TEXT,
    -- Current Posting (Linked to hierarchy node)
    node_id UUID REFERENCES hierarchy_nodes(id) ON DELETE SET NULL,
    date_of_posting DATE,
    -- Metadata
    is_deleted BOOLEAN DEFAULT FALSE,
    created_by_user_id UUID,
    updated_by_user_id UUID,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    -- Dynamic/Extra fields
    extra_fields JSONB DEFAULT '{}'
);

CREATE INDEX idx_personnel_node ON personnel(node_id);
CREATE INDEX idx_personnel_belt ON personnel(belt_number);
CREATE INDEX idx_personnel_name ON personnel(full_name);
CREATE INDEX idx_personnel_deleted ON personnel(is_deleted);

-- =====================
-- 3B. PERSONNEL POSTING HISTORY (Transfer Tracking)
-- =====================
CREATE TABLE personnel_posting (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    personnel_id UUID NOT NULL REFERENCES personnel(id) ON DELETE CASCADE,
    -- Source & Destination
    from_node_id UUID REFERENCES hierarchy_nodes(id) ON DELETE SET NULL,
    to_node_id UUID REFERENCES hierarchy_nodes(id) ON DELETE SET NULL,
    -- Posting Details
    posting_date DATE,
    relieved_date DATE,
    posting_type TEXT DEFAULT 'Active',
    is_active BOOLEAN DEFAULT TRUE,
    -- Order Details
    order_number TEXT,
    order_date DATE,
    remarks TEXT,
    -- Workflow
    status TEXT DEFAULT 'Active',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_posting_personnel ON personnel_posting(personnel_id);
CREATE INDEX idx_posting_to_node ON personnel_posting(to_node_id);
CREATE INDEX idx_posting_from_node ON personnel_posting(from_node_id);

-- =====================
-- 3C. TRANSFER REGISTER (Workflow)
-- =====================
CREATE TABLE transfer_register (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    personnel_id UUID NOT NULL REFERENCES personnel(id) ON DELETE CASCADE,
    from_node_id UUID REFERENCES hierarchy_nodes(id),
    to_node_id UUID REFERENCES hierarchy_nodes(id),
    order_number TEXT,
    transfer_date DATE,
    reason TEXT,
    status TEXT DEFAULT 'Pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- =====================
-- 3D. RLS POLICIES
-- =====================
ALTER TABLE personnel ENABLE ROW LEVEL SECURITY;
ALTER TABLE personnel_posting ENABLE ROW LEVEL SECURITY;
ALTER TABLE transfer_register ENABLE ROW LEVEL SECURITY;

CREATE POLICY "read_all" ON personnel FOR SELECT USING (true);
CREATE POLICY "manage_all" ON personnel FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "read_all" ON personnel_posting FOR SELECT USING (true);
CREATE POLICY "manage_all" ON personnel_posting FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "read_all" ON transfer_register FOR SELECT USING (true);
CREATE POLICY "manage_all" ON transfer_register FOR ALL USING (true) WITH CHECK (true);

-- =====================
-- 3E. LINK PERSONNEL TO APP_USERS
-- =====================
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'app_users_personnel_id_fkey'
    ) THEN
        ALTER TABLE app_users
        ADD CONSTRAINT app_users_personnel_id_fkey
        FOREIGN KEY (personnel_id) REFERENCES personnel(id) ON DELETE SET NULL;
    END IF;
END $$;
