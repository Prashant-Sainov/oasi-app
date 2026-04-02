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
    ('super_admin', 'Full system access across all levels', 1),
    ('state_admin', 'State/PHQ level administration', 2),
    ('range_admin', 'Range level administration', 3),
    ('district_admin', 'District level management', 4),
    ('unit_admin', 'Unit level management', 5),
    ('staff', 'View-only access to own records', 6);

-- =====================
-- 2B. APP USERS TABLE
-- =====================
-- Now links to the recursive hierarchy via a single node_id.
CREATE TABLE app_users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    auth_user_id UUID UNIQUE,  -- FK to Supabase auth.users
    name TEXT NOT NULL,
    belt_number TEXT NOT NULL UNIQUE,
    password_hash TEXT,
    role_id UUID NOT NULL REFERENCES roles(id) ON DELETE RESTRICT,
    node_id UUID REFERENCES hierarchy_nodes(id) ON DELETE SET NULL, -- The node they manage or belong to
    personnel_id UUID,         -- Linked personnel (added in Phase 3)
    mobile_number TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    last_login TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_app_users_belt_number ON app_users(belt_number);
CREATE INDEX idx_app_users_node_id ON app_users(node_id);

-- =====================
-- 2C. DROPDOWN MASTER FIELD TYPES
-- =====================
-- Linked to a hierarchy node (e.g., PHQ level for state-wide defaults)
CREATE TABLE master_field_types (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    node_id UUID NOT NULL REFERENCES hierarchy_nodes(id) ON DELETE CASCADE,
    field_name TEXT NOT NULL,             
    display_name TEXT NOT NULL,           
    personnel_field_name TEXT,            
    helper_example TEXT DEFAULT 'Value1, Value2, Value3',
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(node_id, field_name)
);

-- =====================
-- 2D. DROPDOWN MASTER VALUES
-- =====================
CREATE TABLE master_dropdown_values (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    field_type_id UUID NOT NULL REFERENCES master_field_types(id) ON DELETE CASCADE,
    node_id UUID NOT NULL REFERENCES hierarchy_nodes(id) ON DELETE CASCADE,
    value TEXT NOT NULL,
    display_order INTEGER DEFAULT 0,
    access_level TEXT DEFAULT 'all',
    parent_value TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(field_type_id, node_id, value)
);

CREATE INDEX idx_master_dropdown_field_type ON master_dropdown_values(field_type_id);
CREATE INDEX idx_master_dropdown_node ON master_dropdown_values(node_id);

-- =====================
-- 2E. PERSONNEL FORM LAYOUTS
-- =====================
CREATE TABLE personnel_layouts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    node_id UUID NOT NULL UNIQUE REFERENCES hierarchy_nodes(id) ON DELETE CASCADE,
    sections JSONB NOT NULL DEFAULT '[]',
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- =====================
-- 2F. ATTENDANCE & DUTY TYPES (Master)
-- =====================
CREATE TABLE IF NOT EXISTS attendance_types (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    type_name TEXT NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

INSERT INTO attendance_types (type_name, description) VALUES
    ('Present', 'Full day present on duty'),
    ('Absent', 'Full day absent'),
    ('Leave', 'On approved leave'),
    ('Duty Outside', 'On duty outside the unit')
ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS duty_types (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    duty_type_name TEXT NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

INSERT INTO duty_types (duty_type_name, description) VALUES
    ('Naaka', 'Checking/barrier duty'),
    ('Escort', 'Escort duty'),
    ('Patrol', 'Area patrol duty'),
    ('Office Duty', 'Office/desk duty')
ON CONFLICT DO NOTHING;

-- =====================
-- 2G. RANKS (Master)
-- =====================
CREATE TABLE IF NOT EXISTS ranks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    rank_name TEXT NOT NULL UNIQUE,
    rank_level INTEGER NOT NULL,
    abbreviation TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

INSERT INTO ranks (rank_name, rank_level, abbreviation) VALUES
    ('DGP', 1, 'DGP'),
    ('IGP', 3, 'IGP'),
    ('SSP', 5, 'SSP'),
    ('SP', 6, 'SP'),
    ('DSP', 7, 'DSP'),
    ('Inspector', 8, 'Insp'),
    ('Sub Inspector', 9, 'SI'),
    ('ASI', 10, 'ASI'),
    ('Head Constable', 11, 'HC'),
    ('Constable', 12, 'Ct')
ON CONFLICT DO NOTHING;

-- ============================================================
-- 2H. ROW LEVEL SECURITY (RLS) POLICIES
-- ============================================================

ALTER TABLE app_users ENABLE ROW LEVEL SECURITY;
ALTER TABLE master_field_types ENABLE ROW LEVEL SECURITY;
ALTER TABLE master_dropdown_values ENABLE ROW LEVEL SECURITY;
ALTER TABLE personnel_layouts ENABLE ROW LEVEL SECURITY;
ALTER TABLE roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE attendance_types ENABLE ROW LEVEL SECURITY;
ALTER TABLE duty_types ENABLE ROW LEVEL SECURITY;
ALTER TABLE ranks ENABLE ROW LEVEL SECURITY;

-- Allow read access
CREATE POLICY "read_all" ON roles FOR SELECT USING (true);
CREATE POLICY "read_all" ON attendance_types FOR SELECT USING (true);
CREATE POLICY "read_all" ON duty_types FOR SELECT USING (true);
CREATE POLICY "read_all" ON ranks FOR SELECT USING (true);
CREATE POLICY "read_all" ON master_field_types FOR SELECT USING (true);
CREATE POLICY "read_all" ON master_dropdown_values FOR SELECT USING (true);
CREATE POLICY "read_all" ON personnel_layouts FOR SELECT USING (true);
CREATE POLICY "read_all" ON app_users FOR SELECT USING (true);

-- Admin Management (Anon/Service for now)
CREATE POLICY "manage_all" ON app_users FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "manage_all" ON master_field_types FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "manage_all" ON master_dropdown_values FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "manage_all" ON personnel_layouts FOR ALL USING (true) WITH CHECK (true);
