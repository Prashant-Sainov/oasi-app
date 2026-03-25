import { createContext, useContext, useState, useEffect, useCallback, useRef } from 'react';
import { db } from '../firebase';
import { collection, query, where, getDocs, doc, getDoc, updateDoc, serverTimestamp } from 'firebase/firestore';

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

  // Restore session from localStorage and sync with Firestore
  useEffect(() => {
    async function syncSession() {
      const stored = localStorage.getItem('oasi_user');
      if (stored) {
        try {
          const parsed = JSON.parse(stored);
          setUser(parsed); // Set initial state from storage for speed

          // Re-fetch from Firestore to ensure data (like stateId) is fresh
          const userDoc = await getDoc(doc(db, 'users', parsed.uid));
          if (userDoc.exists()) {
            const userData = userDoc.data();
            
            // Fetch hierarchy names
            const names = await fetchHierarchyNames(userData);

            const updatedUser = {
              ...parsed,
              name: userData.name,
              beltNumber: userData.beltNumber,
              role: userData.role,
              roleLabel: ROLE_LABELS[userData.role] || userData.role,
              stateId: userData.stateId || null,
              rangeId: userData.rangeId || null,
              districtId: userData.districtId || null,
              unitId: userData.unitId || null,
              subUnitId: userData.subUnitId || null,
              personnelId: userData.personnelId || null,
              ...names,
            };
            localStorage.setItem('oasi_user', JSON.stringify(updatedUser));
            setUser(updatedUser);
          } else {
            // User deleted or disabled
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

  async function fetchHierarchyNames(userData) {
    const names = {
      stateName: '',
      rangeName: '',
      districtName: '',
      unitName: '',
      subUnitName: ''
    };

    try {
      if (userData.stateId) {
        const s = await getDoc(doc(db, 'states', userData.stateId));
        if (s.exists()) names.stateName = s.data().stateName;
      }
      if (userData.rangeId) {
        const r = await getDoc(doc(db, 'ranges', userData.rangeId));
        if (r.exists()) names.rangeName = r.data().rangeName;
      }
      if (userData.districtId) {
        const d = await getDoc(doc(db, 'districts', userData.districtId));
        if (d.exists()) names.districtName = d.data().districtName;
      }
      if (userData.unitId) {
        const u = await getDoc(doc(db, 'units', userData.unitId));
        if (u.exists()) names.unitName = u.data().unitName;
      }
      if (userData.subUnitId) {
        const su = await getDoc(doc(db, 'subUnits', userData.subUnitId));
        if (su.exists()) names.subUnitName = su.data().subUnitName;
      }
    } catch (e) {
      console.error('Error fetching hierarchy names:', e);
    }
    return names;
  }

  const login = useCallback(async (beltNumber, password) => {
    // Query users collection by beltNumber
    const usersRef = collection(db, 'users');
    const q = query(usersRef, where('beltNumber', '==', beltNumber.trim()), where('isActive', '==', true));
    const snap = await getDocs(q);

    if (snap.empty) {
      throw new Error('Invalid credentials. No active user found with this Belt Number.');
    }

    // Guard against multiple users with same belt number
    if (snap.docs.length > 1) {
      console.warn('Multiple active users found with belt number:', beltNumber);
    }

    const userDoc = snap.docs[0];
    const userData = userDoc.data();

    /**
     * ⚠️  SECURITY WARNING — PLAINTEXT PASSWORD COMPARISON
     * 
     * This is NOT safe for production. Passwords are stored in plaintext in Firestore.
     * 
     * MIGRATION PLAN:
     * 1. Create a Firebase Cloud Function that accepts (beltNumber, password)
     * 2. Use bcrypt.compare() in the Cloud Function to validate
     * 3. Return a Firebase Custom Token on success
     * 4. Use signInWithCustomToken() on the client
     * 5. Delete all plaintext passwords from Firestore
     * 
     * Alternatively, migrate to Firebase Auth (email/password) by generating
     * email addresses like beltNumber@oasi-portal.internal
     */
    if (userData.password !== password) {
      throw new Error('Invalid credentials. Password does not match.');
    }

    const sessionUser = {
      uid: userDoc.id,
      userId: userData.userId,
      name: userData.name,
      beltNumber: userData.beltNumber,
      role: userData.role,
      roleLabel: ROLE_LABELS[userData.role] || userData.role,
      stateId: userData.stateId || null,
      rangeId: userData.rangeId || null,
      districtId: userData.districtId || null,
      unitId: userData.unitId || null,
      subUnitId: userData.subUnitId || null,
      personnelId: userData.personnelId || null,
    };

    // Fetch hierarchy names for login
    const names = await fetchHierarchyNames(userData);
    Object.assign(sessionUser, names);

    // Update last login
    await updateDoc(doc(db, 'users', userDoc.id), { lastLogin: serverTimestamp() });

    localStorage.setItem('oasi_user', JSON.stringify(sessionUser));
    setUser(sessionUser);
    return sessionUser;
  }, []);

  const logout = useCallback(() => {
    localStorage.removeItem('oasi_user');
    setUser(null);
  }, []);

  // Stable ref for use in effects without dependency issues
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
