import React from 'react';

/**
 * Placeholder component for modules in development.
 * Used for Phase 5+ features.
 */
export default function ComingSoon({ title }) {
  return (
    <div className="empty-state" style={{ minHeight: '50vh' }}>
      <div className="icon" style={{ opacity: 0.2, marginBottom: '1rem' }}>
        <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1" strokeLinecap="round" strokeLinejoin="round">
          <circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/>
        </svg>
      </div>
      <h4>{title}</h4>
      <p style={{ color: 'var(--gray-500)', maxWidth: '300px', margin: '0 auto' }}>
        This module is currently being finalized and will be available in the next system update.
      </p>
    </div>
  );
}
