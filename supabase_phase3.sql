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
    -- Education & Training
    subject_graduation TEXT,
    subject_post_graduation TEXT,
    swat_awt_course TEXT,
    special_course TEXT,
    promotion_type TEXT,
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
    -- Current Posting (denormalized for fast queries)
    state_id UUID REFERENCES states(id),
    range_id UUID REFERENCES ranges(id),
    district_id UUID REFERENCES districts(id),
    unit_type TEXT,
    current_unit_id UUID REFERENCES units(id),
    current_sub_unit_id UUID REFERENCES sub_units(id),
    date_of_posting DATE,
    -- Metadata
    is_deleted BOOLEAN DEFAULT FALSE,
    created_by_user_id UUID,
    updated_by_user_id UUID,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    -- Dynamic/Extra fields stored as JSONB for extensibility
    extra_fields JSONB DEFAULT '{}'
);

-- Performance Indexes
CREATE INDEX idx_personnel_state ON personnel(state_id);
CREATE INDEX idx_personnel_district ON personnel(district_id);
CREATE INDEX idx_personnel_unit ON personnel(current_unit_id);
CREATE INDEX idx_personnel_subunit ON personnel(current_sub_unit_id);
CREATE INDEX idx_personnel_belt ON personnel(belt_number);
CREATE INDEX idx_personnel_name ON personnel(full_name);
CREATE INDEX idx_personnel_deleted ON personnel(is_deleted);
CREATE INDEX idx_personnel_rank ON personnel(rank);
-- Composite index for common filtering patterns
CREATE INDEX idx_personnel_district_unit ON personnel(district_id, current_unit_id);

-- =====================
-- 3B. PERSONNEL POSTING HISTORY (Transfer Tracking)
-- =====================
CREATE TABLE personnel_posting (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    personnel_id UUID NOT NULL REFERENCES personnel(id) ON DELETE CASCADE,
    -- Source (From)
    from_unit_id UUID REFERENCES units(id),
    from_sub_unit_id UUID REFERENCES sub_units(id),
    from_unit_name TEXT,          -- denormalized for history readability
    -- Destination (To)
    to_unit_id UUID REFERENCES units(id),
    to_sub_unit_id UUID REFERENCES sub_units(id),
    to_unit_name TEXT,            -- denormalized for history readability
    -- Posting Details
    posting_date DATE,
    relieved_date DATE,
    posting_type TEXT DEFAULT 'Active',  -- Active, History, Pending
    is_active BOOLEAN DEFAULT TRUE,
    -- Transfer Order
    order_number TEXT,
    order_date DATE,
    document_url TEXT,
    remarks TEXT,
    -- Approval Workflow
    status TEXT DEFAULT 'Active',        -- Active, Pending, Approved, Rejected, Transferred
    approved_by_user_id UUID,
    approved_at TIMESTAMP WITH TIME ZONE,
    -- Metadata
    created_by_user_id UUID,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_posting_personnel ON personnel_posting(personnel_id);
CREATE INDEX idx_posting_to_unit ON personnel_posting(to_unit_id);
CREATE INDEX idx_posting_from_unit ON personnel_posting(from_unit_id);
CREATE INDEX idx_posting_active ON personnel_posting(is_active);
CREATE INDEX idx_posting_status ON personnel_posting(status);

-- =====================
-- 3C. TRANSFER REGISTER (Standalone Transfer Workflow)
-- =====================
CREATE TABLE transfer_register (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    personnel_id UUID NOT NULL REFERENCES personnel(id) ON DELETE CASCADE,
    -- Denormalized Personnel Info (for fast display)
    personnel_name TEXT,
    belt_number TEXT,
    rank TEXT,
    -- Location Context
    state_id UUID REFERENCES states(id),
    range_id UUID REFERENCES ranges(id),
    district_id UUID REFERENCES districts(id),
    -- Transfer Details
    from_unit_id UUID REFERENCES units(id),
    from_sub_unit_id UUID REFERENCES sub_units(id),
    from_unit_name TEXT,
    to_unit_id UUID REFERENCES units(id),
    to_sub_unit_id UUID REFERENCES sub_units(id),
    to_unit_name TEXT,
    -- Order Details
    order_number TEXT,
    transfer_date DATE,
    document_url TEXT,
    reason TEXT,
    remarks TEXT,
    -- Workflow
    status TEXT DEFAULT 'Pending',  -- Pending, Approved, Rejected, Transferred
    approved_by_user_id UUID,
    approved_at TIMESTAMP WITH TIME ZONE,
    -- Metadata
    created_by_user_id UUID,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_transfer_personnel ON transfer_register(personnel_id);
CREATE INDEX idx_transfer_status ON transfer_register(status);
CREATE INDEX idx_transfer_district ON transfer_register(district_id);
CREATE INDEX idx_transfer_from_unit ON transfer_register(from_unit_id);
CREATE INDEX idx_transfer_to_unit ON transfer_register(to_unit_id);

-- =====================
-- 3D. RLS POLICIES FOR PHASE 3 TABLES
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
-- 3E. ADD PERSONNEL FK TO APP_USERS
-- =====================
-- Now that the personnel table exists, we can add the FK
-- (This is safe even if the column already has data — we just add the constraint)
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
