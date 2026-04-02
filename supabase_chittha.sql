-- 2H. CHITTHA (DUTY DEPLOYMENT)
CREATE TABLE chitthas (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    state_id UUID REFERENCES states(id),
    range_id UUID REFERENCES ranges(id),
    district_id UUID REFERENCES districts(id),
    unit_id UUID REFERENCES units(id),
    sub_unit_id UUID REFERENCES sub_units(id),
    chittha_date DATE NOT NULL,
    status TEXT DEFAULT 'Draft', -- Draft, Submitted, Approved
    created_by_user_id UUID,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    submitted_at TIMESTAMPTZ,
    
    UNIQUE(unit_id, sub_unit_id, chittha_date)
);

CREATE TABLE chittha_assignments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    chittha_id UUID NOT NULL REFERENCES chitthas(id) ON DELETE CASCADE,
    personnel_id UUID NOT NULL REFERENCES personnel(id) ON DELETE CASCADE,
    section_name TEXT NOT NULL,
    duty_type TEXT,
    duty_location TEXT,
    remark_text TEXT,
    state_id UUID REFERENCES states(id),
    range_id UUID REFERENCES ranges(id),
    district_id UUID REFERENCES districts(id),
    unit_id UUID REFERENCES units(id),
    sub_unit_id UUID REFERENCES sub_units(id),
    is_locked_by_osi BOOLEAN DEFAULT false,
    is_vip_duty BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Indices
CREATE INDEX idx_chittha_date ON chitthas(chittha_date);
CREATE INDEX idx_chittha_unit ON chitthas(unit_id);
CREATE INDEX idx_assign_chittha ON chittha_assignments(chittha_id);
CREATE INDEX idx_assign_personnel ON chittha_assignments(personnel_id);

-- RLS
ALTER TABLE chitthas ENABLE ROW LEVEL SECURITY;
ALTER TABLE chittha_assignments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can read chitthas" ON chitthas FOR SELECT USING (true);
CREATE POLICY "Users can manage chitthas" ON chitthas FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Anyone can read assignments" ON chittha_assignments FOR SELECT USING (true);
CREATE POLICY "Users can manage assignments" ON chittha_assignments FOR ALL USING (true) WITH CHECK (true);
