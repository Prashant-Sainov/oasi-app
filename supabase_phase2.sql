-- ============================================================
-- PHASE 2: DROPDOWN MASTER, ROLES, AUTH & RLS
-- ============================================================

-- =====================
-- 2A. ROLES TABLE
-- =====================
CREATE TABLE roles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL UNIQUE,
    description TEXT,
    rank_level INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

INSERT INTO roles (name, description, rank_level) VALUES
    ('super_admin', 'Full system access across all states', 1),
    ('state_admin', 'State-level administration', 2),
    ('range_admin', 'Range-level administration (OASI)', 3),
    ('district_admin', 'District-level personnel and unit management', 4),
    ('unit_admin', 'Unit-level chittha, attendance, and duty management (MHC)', 5),
    ('staff', 'View-only access to own records', 6);

-- =====================
-- 2B. APP USERS TABLE
-- =====================
-- This table stores portal-specific user profiles.
-- Links to Supabase Auth (auth.users) via auth_user_id for future migration,
-- but currently supports belt_number + password login.
CREATE TABLE app_users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    auth_user_id UUID UNIQUE,  -- FK to Supabase auth.users (nullable during transition)
    name TEXT NOT NULL,
    belt_number TEXT NOT NULL UNIQUE,
    password_hash TEXT,         -- Will store bcrypt hash (NOT plaintext)
    role_id UUID NOT NULL REFERENCES roles(id) ON DELETE RESTRICT,
    state_id UUID REFERENCES states(id),
    range_id UUID REFERENCES ranges(id),
    district_id UUID REFERENCES districts(id),
    unit_id UUID REFERENCES units(id),
    sub_unit_id UUID REFERENCES sub_units(id),
    personnel_id UUID,         -- FK to personnel (added in Phase 3)
    mobile_number TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    last_login TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Index for fast login lookups
CREATE INDEX idx_app_users_belt_number ON app_users(belt_number);
CREATE INDEX idx_app_users_state_id ON app_users(state_id);

-- =====================
-- 2C. DROPDOWN MASTER FIELD TYPES
-- =====================
-- These define the categories/tabs in the Dropdown Master UI
-- e.g., "Rank", "Gender", "Blood Group", "Service Status"
CREATE TABLE master_field_types (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    state_id UUID NOT NULL REFERENCES states(id) ON DELETE CASCADE,
    field_name TEXT NOT NULL,             -- internal key: 'rank', 'gender', etc.
    display_name TEXT NOT NULL,           -- UI label: 'Rank', 'Gender', etc.
    personnel_field_name TEXT,            -- maps to personnel table column
    helper_example TEXT DEFAULT 'Value1, Value2, Value3',
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(state_id, field_name)
);

-- =====================
-- 2D. DROPDOWN MASTER VALUES
-- =====================
-- Actual dropdown options for each field type
CREATE TABLE master_dropdown_values (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    field_type_id UUID NOT NULL REFERENCES master_field_types(id) ON DELETE CASCADE,
    state_id UUID NOT NULL REFERENCES states(id) ON DELETE CASCADE,
    value TEXT NOT NULL,
    display_order INTEGER DEFAULT 0,
    access_level TEXT DEFAULT 'all',
    parent_value TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(field_type_id, state_id, value)
);

-- Index for fast filtering by field type
CREATE INDEX idx_master_dropdown_field_type ON master_dropdown_values(field_type_id);
CREATE INDEX idx_master_dropdown_state ON master_dropdown_values(state_id);

-- =====================
-- 2E. PERSONNEL FORM LAYOUTS
-- =====================
-- Stores the customizable section/field arrangement per state
CREATE TABLE personnel_layouts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    state_id UUID NOT NULL UNIQUE REFERENCES states(id) ON DELETE CASCADE,
    sections JSONB NOT NULL DEFAULT '[]',
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- =====================
-- 2F. ATTENDANCE TYPES (Master)
-- =====================
CREATE TABLE attendance_types (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    type_name TEXT NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

INSERT INTO attendance_types (type_name, description) VALUES
    ('Present', 'Full day present on duty'),
    ('Absent', 'Full day absent'),
    ('Half Day', 'Present for half day'),
    ('Hourly Leave', 'Absent for specific hours'),
    ('Leave', 'On approved leave'),
    ('Duty Outside', 'On duty outside the unit');

-- =====================
-- 2G. DUTY TYPES (Master)
-- =====================
CREATE TABLE duty_types (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    duty_type_name TEXT NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

INSERT INTO duty_types (duty_type_name, description) VALUES
    ('Naaka', 'Checking/barrier duty'),
    ('Escort', 'Escort duty'),
    ('Court Duty', 'Court appearance or guard'),
    ('Patrol', 'Area patrol duty'),
    ('Office Duty', 'Office/desk duty'),
    ('VIP Duty', 'VIP security duty'),
    ('Night Shift', 'Night duty shift'),
    ('Traffic', 'Traffic control duty'),
    ('Investigation', 'Case investigation');

-- =====================
-- 2H. RANKS (Master)
-- =====================
CREATE TABLE ranks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    rank_name TEXT NOT NULL UNIQUE,
    rank_level INTEGER NOT NULL,
    abbreviation TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

INSERT INTO ranks (rank_name, rank_level, abbreviation) VALUES
    ('DGP', 1, 'DGP'),
    ('ADGP', 2, 'ADGP'),
    ('IGP', 3, 'IGP'),
    ('DIG', 4, 'DIG'),
    ('SSP', 5, 'SSP'),
    ('SP', 6, 'SP'),
    ('DSP', 7, 'DSP'),
    ('Inspector', 8, 'Insp'),
    ('Sub Inspector', 9, 'SI'),
    ('ASI', 10, 'ASI'),
    ('Head Constable', 11, 'HC'),
    ('Constable', 12, 'Ct'),
    ('Home Guard', 13, 'HG');

-- ============================================================
-- 2I. ROW LEVEL SECURITY (RLS) POLICIES
-- ============================================================

-- Enable RLS on all tables
ALTER TABLE states ENABLE ROW LEVEL SECURITY;
ALTER TABLE ranges ENABLE ROW LEVEL SECURITY;
ALTER TABLE districts ENABLE ROW LEVEL SECURITY;
ALTER TABLE units ENABLE ROW LEVEL SECURITY;
ALTER TABLE sub_units ENABLE ROW LEVEL SECURITY;
ALTER TABLE app_users ENABLE ROW LEVEL SECURITY;
ALTER TABLE master_field_types ENABLE ROW LEVEL SECURITY;
ALTER TABLE master_dropdown_values ENABLE ROW LEVEL SECURITY;
ALTER TABLE personnel_layouts ENABLE ROW LEVEL SECURITY;
ALTER TABLE unit_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE attendance_types ENABLE ROW LEVEL SECURITY;
ALTER TABLE duty_types ENABLE ROW LEVEL SECURITY;
ALTER TABLE ranks ENABLE ROW LEVEL SECURITY;

-- Allow full read access to all authenticated users for reference/master tables
CREATE POLICY "Anyone can read states" ON states FOR SELECT USING (true);
CREATE POLICY "Anyone can read ranges" ON ranges FOR SELECT USING (true);
CREATE POLICY "Anyone can read districts" ON districts FOR SELECT USING (true);
CREATE POLICY "Anyone can read units" ON units FOR SELECT USING (true);
CREATE POLICY "Anyone can read sub_units" ON sub_units FOR SELECT USING (true);
CREATE POLICY "Anyone can read unit_categories" ON unit_categories FOR SELECT USING (true);
CREATE POLICY "Anyone can read roles" ON roles FOR SELECT USING (true);
CREATE POLICY "Anyone can read attendance_types" ON attendance_types FOR SELECT USING (true);
CREATE POLICY "Anyone can read duty_types" ON duty_types FOR SELECT USING (true);
CREATE POLICY "Anyone can read ranks" ON ranks FOR SELECT USING (true);
CREATE POLICY "Anyone can read master_field_types" ON master_field_types FOR SELECT USING (true);
CREATE POLICY "Anyone can read master_dropdown_values" ON master_dropdown_values FOR SELECT USING (true);
CREATE POLICY "Anyone can read personnel_layouts" ON personnel_layouts FOR SELECT USING (true);
CREATE POLICY "Anyone can read app_users" ON app_users FOR SELECT USING (true);

-- Allow full CRUD for service_role (backend/admin operations)
-- These policies allow the anon key to INSERT/UPDATE/DELETE for now
-- In production, tighten these to authenticated users only
CREATE POLICY "Service can manage states" ON states FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Service can manage ranges" ON ranges FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Service can manage districts" ON districts FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Service can manage units" ON units FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Service can manage sub_units" ON sub_units FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Service can manage unit_categories" ON unit_categories FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Service can manage app_users" ON app_users FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Service can manage master_field_types" ON master_field_types FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Service can manage master_dropdown_values" ON master_dropdown_values FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Service can manage personnel_layouts" ON personnel_layouts FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Service can manage roles" ON roles FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Service can manage attendance_types" ON attendance_types FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Service can manage duty_types" ON duty_types FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Service can manage ranks" ON ranks FOR ALL USING (true) WITH CHECK (true);

-- ============================================================
-- 2J. SEED DEFAULT ADMIN USER
-- ============================================================
-- Create the default State Admin user (matching existing Firebase seed)
INSERT INTO app_users (name, belt_number, password_hash, role_id, state_id, is_active)
SELECT
    'SP Hisar',
    'ADMIN',
    'oasi@2026',  -- TEMPORARY: Will be replaced with bcrypt hash
    r.id,
    s.id,
    true
FROM roles r, states s
WHERE r.name = 'state_admin' AND s.name = 'Haryana'
ON CONFLICT (belt_number) DO NOTHING;
