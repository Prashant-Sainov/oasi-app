/**
 * Input validation utilities for the OASI Portal.
 */

/**
 * Validates a 10-digit Indian mobile number.
 * @param {string} mobile
 * @returns {{ valid: boolean, message: string }}
 */
export function validateMobile(mobile) {
  if (!mobile) return { valid: true, message: '' }; // optional unless required elsewhere
  const cleaned = mobile.replace(/[\s\-]/g, '');
  if (!/^\d{10}$/.test(cleaned)) {
    return { valid: false, message: 'Mobile number must be exactly 10 digits.' };
  }
  if (!/^[6-9]/.test(cleaned)) {
    return { valid: false, message: 'Mobile number must start with 6, 7, 8, or 9.' };
  }
  return { valid: true, message: '' };
}

/**
 * Validates a 12-digit Aadhar number.
 * @param {string} aadhar
 * @returns {{ valid: boolean, message: string }}
 */
export function validateAadhar(aadhar) {
  if (!aadhar) return { valid: true, message: '' };
  const cleaned = aadhar.replace(/[\s\-]/g, '');
  if (!/^\d{12}$/.test(cleaned)) {
    return { valid: false, message: 'Aadhar number must be exactly 12 digits.' };
  }
  return { valid: true, message: '' };
}

/**
 * Validates Indian PAN format (ABCDE1234F).
 * @param {string} pan
 * @returns {{ valid: boolean, message: string }}
 */
export function validatePAN(pan) {
  if (!pan) return { valid: true, message: '' };
  const cleaned = pan.trim().toUpperCase();
  if (!/^[A-Z]{5}\d{4}[A-Z]$/.test(cleaned)) {
    return { valid: false, message: 'PAN must be in format ABCDE1234F.' };
  }
  return { valid: true, message: '' };
}

/**
 * Validates that two dates are logically ordered.
 * @param {string} startDate - ISO date string (earlier date)
 * @param {string} endDate - ISO date string (later date)
 * @param {string} startLabel
 * @param {string} endLabel
 * @returns {{ valid: boolean, message: string }}
 */
export function validateDateOrder(startDate, endDate, startLabel, endLabel) {
  if (!startDate || !endDate) return { valid: true, message: '' };
  if (new Date(startDate) > new Date(endDate)) {
    return { valid: false, message: `${startLabel} cannot be after ${endLabel}.` };
  }
  return { valid: true, message: '' };
}

/**
 * Validates that a date of birth is not in the future and person is at least 18.
 * @param {string} dob - ISO date string
 * @returns {{ valid: boolean, message: string }}
 */
export function validateDateOfBirth(dob) {
  if (!dob) return { valid: true, message: '' };
  const birthDate = new Date(dob);
  const today = new Date();
  if (birthDate > today) {
    return { valid: false, message: 'Date of birth cannot be in the future.' };
  }
  const age = (today - birthDate) / (365.25 * 24 * 60 * 60 * 1000);
  if (age < 18) {
    return { valid: false, message: 'Personnel must be at least 18 years old.' };
  }
  return { valid: true, message: '' };
}

/**
 * Masks an Aadhar number for display (shows last 4 digits).
 * @param {string} aadhar
 * @returns {string}
 */
export function maskAadhar(aadhar) {
  if (!aadhar) return '';
  const cleaned = aadhar.replace(/[\s\-]/g, '');
  if (cleaned.length < 4) return '****';
  return 'XXXX-XXXX-' + cleaned.slice(-4);
}

/**
 * Masks a PAN number for display (shows first 2 and last 2 characters).
 * @param {string} pan
 * @returns {string}
 */
export function maskPAN(pan) {
  if (!pan) return '';
  if (pan.length < 4) return '****';
  return pan.slice(0, 2) + '******' + pan.slice(-2);
}
