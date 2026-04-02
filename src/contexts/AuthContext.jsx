import { createContext, useContext, useState, useEffect, useCallback, useRef } from 'react';
import { supabase } from '../supabase';

const AuthContext = createContext(null);

export function useAuth() {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error('useAuth must be used within AuthProvider');
  return ctx;
}

const ROLE_LABELS = {
  super_admin: 'Super Admin (Headquarters)',
  state_admin: 'State Admin',
  range_admin: 'Range Admin (OASI)',
  district_admin: 'District Admin (OASI)',
  unit_admin: 'Unit Admin (MHC)',
  staff: 'Normal Staff',
};

export default function AuthProvider({ children }) {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  // Restore session from localStorage and sync with Supabase
  useEffect(() => {
    async function syncSession() {
      const stored = localStorage.getItem('oasi_user');
      if (stored) {
        try {
          const parsed = JSON.parse(stored);
          setUser(parsed); // Set initial state from storage for speed

          // Re-fetch from Supabase to ensure data is fresh
          const { data: userData, error } = await supabase
            .from('app_users')
            .select(`
              *,
              roles (name),
              states (name),
              ranges (name),
              districts (name),
              units (name),
              sub_units (name)
            `)
            .eq('id', parsed.uid)
            .single();

          if (userData && !error) {
            const updatedUser = {
              ...parsed,
              name: userData.name,
              beltNumber: userData.belt_number,
              role: userData.roles?.name || 'staff',
              roleLabel: ROLE_LABELS[userData.roles?.name] || userData.roles?.name || 'Normal Staff',
              stateId: userData.state_id,
              rangeId: userData.range_id,
              districtId: userData.district_id,
              unitId: userData.unit_id,
              subUnitId: userData.sub_unit_id,
              personnelId: userData.personnel_id,
              stateName: userData.states?.name || '',
              rangeName: userData.ranges?.name || '',
              districtName: userData.districts?.name || '',
              unitName: userData.units?.name || '',
              subUnitName: userData.sub_units?.name || '',
            };
            localStorage.setItem('oasi_user', JSON.stringify(updatedUser));
            setUser(updatedUser);
          } else {
            // User not found or error
            logoutRef.current();
          }
        } catch (err) {
          if (import.meta.env.DEV) console.error('Session sync failed:', err);
          localStorage.removeItem('oasi_user');
          setUser(null);
        }
      }
      setLoading(false);
    }
    syncSession();
  }, []);

  const login = useCallback(async (beltNumber, password) => {
    // Query app_users table by belt_number
    const { data: userData, error } = await supabase
      .from('app_users')
      .select(`
        *,
        roles (name),
        states (name),
        ranges (name),
        districts (name),
        units (name),
        sub_units (name)
      `)
      .eq('belt_number', beltNumber.trim())
      .eq('is_active', true)
      .single();

    if (error || !userData) {
      throw new Error('Invalid credentials. No active user found with this Belt Number.');
    }

    /**
     * ⚠️  SECURITY WARNING — PLAINTEXT PASSWORD COMPARISON
     * 
     * MIGRATION NOTE: The current schema uses 'password_hash'. 
     * For now we are doing a direct comparison to maintain parity with legacy logic,
     * but you should switch to Supabase Auth or bcrypt hashing ASAP.
     */
    if (userData.password_hash !== password) {
      throw new Error('Invalid credentials. Password does not match.');
    }

    const sessionUser = {
      uid: userData.id,
      name: userData.name,
      beltNumber: userData.belt_number,
      role: userData.roles?.name || 'staff',
      roleLabel: ROLE_LABELS[userData.roles?.name] || userData.roles?.name || 'Normal Staff',
      stateId: userData.state_id,
      rangeId: userData.range_id,
      districtId: userData.district_id,
      unitId: userData.unit_id,
      subUnitId: userData.sub_unit_id,
      personnelId: userData.personnel_id,
      stateName: userData.states?.name || '',
      rangeName: userData.ranges?.name || '',
      districtName: userData.districts?.name || '',
      unitName: userData.units?.name || '',
      subUnitName: userData.sub_units?.name || '',
    };

    // Update last login
    await supabase
      .from('app_users')
      .update({ last_login: new Date().toISOString() })
      .eq('id', userData.id);

    localStorage.setItem('oasi_user', JSON.stringify(sessionUser));
    setUser(sessionUser);
    return sessionUser;
  }, []);

  const logout = useCallback(() => {
    localStorage.removeItem('oasi_user');
    setUser(null);
  }, []);

  // Stable ref for use in effects
  const logoutRef = useRef(logout);
  logoutRef.current = logout;

  // Permission helpers
  const isSuperAdmin = user?.role === 'super_admin';
  const isStateAdmin = user?.role === 'state_admin';
  const isRangeAdmin = user?.role === 'range_admin';
  const isDistrictAdmin = user?.role === 'district_admin';
  const isUnitAdmin = user?.role === 'unit_admin';
  const isStaff = user?.role === 'staff';

  const canManageUnits = isSuperAdmin || isStateAdmin; 
  const canManagePersonnel = isSuperAdmin || isStateAdmin || isDistrictAdmin || isUnitAdmin;
  const canViewAllDistricts = isSuperAdmin || isStateAdmin;

  const value = {
    user,
    loading,
    login,
    logout,
    isSuperAdmin,
    isStateAdmin,
    isRangeAdmin,
    isDistrictAdmin,
    isUnitAdmin,
    isStaff,
    canManageUnits,
    canManagePersonnel,
    canViewAllDistricts,
    ROLE_LABELS,
  };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}
