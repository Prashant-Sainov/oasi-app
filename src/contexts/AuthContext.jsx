import { createContext, useContext, useState, useEffect, useCallback } from 'react';
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
            };
            localStorage.setItem('oasi_user', JSON.stringify(updatedUser));
            setUser(updatedUser);
          } else {
            // User deleted or disabled
            logout();
          }
        } catch (err) {
          console.error('Session sync failed:', err);
          localStorage.removeItem('oasi_user');
          setUser(null);
        }
      }
      setLoading(false);
    }
    syncSession();
  }, []);

  const login = useCallback(async (beltNumber, password) => {
    // Query users collection by beltNumber
    const usersRef = collection(db, 'users');
    const q = query(usersRef, where('beltNumber', '==', beltNumber.trim()), where('isActive', '==', true));
    const snap = await getDocs(q);

    if (snap.empty) {
      throw new Error('Invalid credentials. No active user found with this Belt Number.');
    }

    const userDoc = snap.docs[0];
    const userData = userDoc.data();

    // Simple password check (in production, use bcrypt via Cloud Functions)
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
