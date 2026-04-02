-- 2G. ATTENDANCE REGISTER
CREATE TABLE attendance_register (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    personnel_id UUID NOT NULL REFERENCES personnel(id) ON DELETE CASCADE,
    date DATE NOT NULL,
    attendance_type TEXT NOT NULL, -- e.g., 'Present', 'Absent', 'Leave', etc.
    attendance_source TEXT DEFAULT 'Register',
    marking_method TEXT DEFAULT 'Manual',
    state_id UUID REFERENCES states(id),
    range_id UUID REFERENCES ranges(id),
    district_id UUID REFERENCES districts(id),
    unit_id UUID REFERENCES units(id),
    sub_unit_id UUID REFERENCES sub_units(id),
    marked_by_user_id UUID, -- References app_users.id (if we had a FK)
    marked_by_role TEXT,
    is_late BOOLEAN DEFAULT false,
    marked_at TIMESTAMPTZ DEFAULT now(),
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    
    -- Ensure one record per personnel per day
    UNIQUE(personnel_id, date)
);

-- Indices for performance
CREATE INDEX idx_attendance_date ON attendance_register(date);
CREATE INDEX idx_attendance_unit ON attendance_register(unit_id);
CREATE INDEX idx_attendance_personnel ON attendance_register(personnel_id);

-- RLS Policies
ALTER TABLE attendance_register ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can read attendance" ON attendance_register FOR SELECT USING (true);
CREATE POLICY "Users can manage attendance" ON attendance_register FOR ALL USING (true) WITH CHECK (true);
