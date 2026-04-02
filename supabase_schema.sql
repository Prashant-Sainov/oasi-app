-- PHASE 1: HIERARCHY & FOUNDATION
-- Enables UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. States
CREATE TABLE states (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL UNIQUE,
    code TEXT UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Ranges
CREATE TABLE ranges (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    state_id UUID NOT NULL REFERENCES states(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(state_id, name)
);

-- 3. Districts
CREATE TABLE districts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    range_id UUID NOT NULL REFERENCES ranges(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(range_id, name)
);

-- 4. Unit Categories
CREATE TABLE unit_categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 5. Units
CREATE TABLE units (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    district_id UUID NOT NULL REFERENCES districts(id) ON DELETE RESTRICT,
    category_id UUID REFERENCES unit_categories(id) ON DELETE SET NULL,
    name TEXT NOT NULL,
    sanctioned_strength INTEGER DEFAULT 0,
    assigned_module TEXT DEFAULT 'attendance', -- e.g., 'attendance', 'chittha'
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(district_id, name)
);

-- 6. Sub-Units
CREATE TABLE sub_units (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    unit_id UUID NOT NULL REFERENCES units(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    assigned_module TEXT DEFAULT 'attendance',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(unit_id, name)
);

-- SEED DATA: Haryana State
INSERT INTO states (name, code) VALUES ('Haryana', 'HR') ON CONFLICT DO NOTHING;
