/**
 * Shared rank/category constants for the OASI Portal.
 * Single source of truth — used by PersonnelForm, PersonnelList, ExcelImport, etc.
 */

// Ranks available to State Admins only (DSP and above)
export const ALLOWED_RANKS = [
  'DSP (Prob)', 'Deputy Superintendent of Police (DSP)', 'Assistant Commissioner of Police (ACP)',
  'Additional Superintendent of Police (ASP)', 'Superintendent of Police (SP)',
  'Senior Superintendent of Police (SSP)', 'Deputy Inspector General of Police (DIG)',
  'Inspector General of Police (IG)', 'Additional Director General of Police (ADGP)',
  'Director General of Police (DGP)'
];

// Ranks available to District/Unit Admins (below DSP)
export const RESTRICTED_RANKS = [
  'Insp', 'PSI', 'SI', 'ASI/ESI', 'ASI', 'HC/ESI', 'HC/EASI', 'HC',
  'C-1/EHC', 'C-1', 'CT/ESI', 'CT/EASI', 'CT/EHC', 'CT', 'R/CT', 'SPO'
];

// All ranks combined
export const RANKS = [...ALLOWED_RANKS, ...RESTRICTED_RANKS];

// Fixed unit categories
export const FIXED_CATEGORIES = [
  "Police Stations",
  "Traffic",
  "Special Staffs",
  "Court",
  "Administrative Units",
  "Security",
  "Temp_Dep_Trg"
];

// Personnel form enums
export const CATEGORIES = ['General', 'OBC', 'SC', 'ST', 'EWS'];
export const GENDERS = ['Male', 'Female', 'Other'];
export const SERVICE_STATUSES = ['Active', 'Retired', 'Deceased', 'Suspended'];
export const SERVICE_TYPES = ['Regular', 'Home Guard', 'SPO', 'Contractual'];

/**
 * Returns the appropriate rank list based on user role.
 * @param {{ isSuperAdmin: boolean, isStateAdmin: boolean }} flags
 */
export function getRanksForRole({ isSuperAdmin, isStateAdmin }) {
  if (isSuperAdmin) return RANKS;
  if (isStateAdmin) return ALLOWED_RANKS;
  return RESTRICTED_RANKS;
}
