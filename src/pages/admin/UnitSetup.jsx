import React, { useState, useEffect } from 'react';
import { useAuth } from '../../contexts/AuthContext';
import { useToast } from '../../contexts/ToastContext';
import { supabase } from '../../supabase';
import {
  Plus, Edit, Trash2, Building2, ChevronRight,
  MapPin, X, AlertTriangle, Upload, Loader2
} from 'lucide-react';
import processedData from '../../data/hierarchy_processed.json';

export default function UnitSetup() {
  const { user, isSuperAdmin, isStateAdmin } = useAuth();
  const toast = useToast();

  const [nodes, setNodes] = useState([]);
  const [navigationStack, setNavigationStack] = useState([]); // Array of {id, name, node_code}
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [importing, setImporting] = useState(false);
  const [showConfirm, setShowConfirm] = useState(false);

  // Modal states
  const [showNodeModal, setShowNodeModal] = useState(false);
  const [editingNode, setEditingNode] = useState(null);
  const [deleteModal, setDeleteModal] = useState(null);

  // Form state
  const [nodeForm, setNodeForm] = useState({
    name: '',
    assignedModule: 'attendance'
  });

  const currentNode = navigationStack[navigationStack.length - 1] || null;

  useEffect(() => {
    loadNodes();
  }, [navigationStack]);

  async function loadNodes() {
    try {
      setLoading(true);
      let queryBuilder = supabase.from('hierarchy_nodes').select('*');

      if (!currentNode) {
        queryBuilder = queryBuilder.is('parent_id', null);
      } else {
        queryBuilder = queryBuilder.eq('parent_id', currentNode.id);
      }

      const { data, error } = await queryBuilder;
      if (error) throw error;
      
      const fetchedNodes = data || [];
      
      // Sort naturally (e.g. 2.1, 2.2, 2.10)
      fetchedNodes.sort((a, b) => {
        return a.node_code.localeCompare(b.node_code, undefined, { numeric: true, sensitivity: 'base' });
      });
      
      setNodes(fetchedNodes);
    } catch (err) {
      console.error(err);
      toast.error('Failed to load hierarchy nodes.');
    } finally {
      setLoading(false);
    }
  }

  function pushNavigation(node) {
    setNavigationStack(prev => [...prev, { id: node.id, name: node.name, node_code: node.node_code }]);
  }

  function popNavigation(index = -1) {
    if (index === -1) {
      setNavigationStack([]);
    } else {
      setNavigationStack(prev => prev.slice(0, index + 1));
    }
  }

  async function runBulkImport() {
    if (!isSuperAdmin && !isStateAdmin) return;
    
    if (!showConfirm) {
      setShowConfirm(true);
      return;
    }

    try {
      setImporting(true);
      setShowConfirm(false);
      
      // Bulk import for Supabase is direct .insert()
      // We need to resolve parent UUIDs if the JSON only has parent_code.
      // For now, let's process in order (parents first).
      
      const result = [];
      const codeToIdMap = new Map();

      // First pass: Clear existing
      const { error: delError } = await supabase.from('hierarchy_nodes').delete().neq('id', '00000000-0000-0000-0000-000000000000'); // Delete all
      if (delError) console.warn('Clear existing failed, continuing...', delError);

      for (const node of processedData) {
        const payload = {
          node_code: node.node_code,
          name: node.name,
          level: node.level,
          parent_id: node.parent_code ? codeToIdMap.get(node.parent_code) : null,
          is_fixed: node.is_fixed || false,
          assigned_module: node.assigned_module || 'attendance'
        };

        const { data, error } = await supabase
          .from('hierarchy_nodes')
          .insert([payload])
          .select();

        if (error) {
          console.error(`Error inserting node ${node.node_code}:`, error);
          continue;
        }

        if (data && data[0]) {
          codeToIdMap.set(node.node_code, data[0].id);
        }
      }

      toast.success(`Successfully processed ${codeToIdMap.size} nodes.`);
      loadNodes();
    } catch (err) {
      console.error('Import Error:', err);
      toast.error('Bulk import failed.');
    } finally {
      setImporting(false);
    }
  }

  function openNodeModal(node = null) {
    setEditingNode(node);
    setNodeForm(node ? {
      name: node.name,
      assignedModule: node.assigned_module || 'attendance'
    } : {
      name: '',
      assignedModule: currentNode?.assigned_module || 'attendance'
    });
    setShowNodeModal(true);
  }

  async function saveNode() {
    if (!nodeForm.name.trim()) {
      toast.warning('Node Name is required.');
      return;
    }

    try {
      setSaving(true);

      if (editingNode) {
        const { error } = await supabase
          .from('hierarchy_nodes')
          .update({
            name: nodeForm.name.trim(),
            assigned_module: nodeForm.assignedModule,
            updated_at: new Date().toISOString()
          })
          .eq('id', editingNode.id);
        
        if (error) throw error;
        toast.success('Node updated.');
      } else {
        // Find next suffix
        const nextSuffix = nodes.length + 1;
        const newNodeCode = currentNode 
          ? `${currentNode.node_code}.${nextSuffix}`
          : `${nextSuffix}`;

        const { error } = await supabase
          .from('hierarchy_nodes')
          .insert([{
            node_code: newNodeCode,
            name: nodeForm.name.trim(),
            level: (currentNode ? currentNode.node_code.split('.').length : 0) + 1,
            parent_id: currentNode?.id || null,
            is_fixed: false,
            assigned_module: nodeForm.assignedModule,
            updated_at: new Date().toISOString()
          }]);

        if (error) throw error;
        toast.success('Node created.');
      }
      setShowNodeModal(false);
      loadNodes();
    } catch (err) {
      toast.error('Failed to save node.');
    } finally {
      setSaving(false);
    }
  }

  async function handleDelete() {
    if (!deleteModal) return;
    try {
      setSaving(true);
      const { error } = await supabase
        .from('hierarchy_nodes')
        .delete()
        .eq('id', deleteModal.id);

      if (error) throw error;
      toast.success('Node deleted.');
      setDeleteModal(null);
      loadNodes();
    } catch (err) {
      toast.error('Failed to delete node.');
    } finally {
      setSaving(false);
    }
  }

  return (
    <div className="unit-setup">
      <div className="page-header">
        <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
          <Building2 size={24} className="text-primary" />
          <div>
            <h2>Unit Setup & Hierarchy</h2>
            <p className="text-sm text-gray-500">Manage organizational structure dynamically</p>
          </div>
        </div>
        <div className="actions">
          {(isSuperAdmin || isStateAdmin) && (
            <button 
              className={`btn ${showConfirm ? 'btn-danger' : 'btn-secondary'} mr-2`} 
              onClick={runBulkImport} 
              disabled={importing}
            >
              {importing ? <Loader2 size={16} className="animate-spin mr-2" /> : <Upload size={16} className="mr-2" />}
              {showConfirm ? 'Confirm Import?' : 'Import CSV Data'}
            </button>
          )}
          <button className="btn btn-primary" onClick={() => openNodeModal()}>
            <Plus size={18} className="mr-2" /> Add {currentNode ? 'Sub-Unit' : 'Level 1 Node'}
          </button>
        </div>
      </div>

      {/* Breadcrumbs */}
      <div className="mb-4 bg-white p-3 rounded-lg border border-gray-100 shadow-sm flex items-center gap-2 overflow-x-auto">
        <button 
          className={`px-3 py-1.5 rounded-md text-sm transition-colors whitespace-nowrap ${navigationStack.length === 0 ? 'bg-primary/10 text-primary font-bold' : 'text-gray-600 hover:bg-gray-100'}`}
          onClick={() => popNavigation(-1)}
        >
          Primary Hierarchy
        </button>
        {navigationStack.map((step, idx) => (
          <React.Fragment key={step.node_code}>
            <ChevronRight size={14} className="text-gray-300" />
            <button 
              className={`px-3 py-1.5 rounded-md text-sm transition-colors whitespace-nowrap ${idx === navigationStack.length - 1 ? 'bg-primary/10 text-primary font-bold' : 'text-gray-600 hover:bg-gray-100'}`}
              onClick={() => popNavigation(idx)}
            >
              {step.name}
            </button>
          </React.Fragment>
        ))}
      </div>

      <div className="panel overflow-hidden">
        <div className="table-container">
          <table className="data-table">
            <thead>
              <tr>
                <th style={{ width: '120px' }}>Index</th>
                <th>Name</th>
                <th>Type / Module</th>
                <th style={{ textAlign: 'right', paddingRight: '40px' }}>Actions</th>
              </tr>
            </thead>
            <tbody>
              {loading ? (
                <tr>
                  <td colSpan={4} className="text-center py-8">
                    <div className="spinner mx-auto mb-2"></div>
                    <p>Loading nodes...</p>
                  </td>
                </tr>
              ) : nodes.length === 0 ? (
                <tr>
                  <td colSpan={4} className="text-center py-16 text-gray-400">
                    <div className="flex flex-col items-center justify-center">
                      <MapPin size={48} className="mb-4 opacity-10" />
                      <p className="text-lg font-medium text-gray-500">No sub-units found</p>
                      <p className="text-sm text-gray-400 mb-6">Start by adding a node to the {currentNode ? currentNode.name : 'root hierarchy'}.</p>
                      <button className="btn btn-secondary btn-sm" onClick={() => openNodeModal()}>
                        <Plus size={16} className="mr-2" /> Add {currentNode ? 'Sub-Unit' : 'Level 1 Node'}
                      </button>
                    </div>
                  </td>
                </tr>
              ) : (
                nodes.map(node => (
                  <tr 
                    key={node.id} 
                    className="hover-trigger cursor-pointer"
                    onClick={() => pushNavigation(node)}
                    style={{ transition: 'background-color 0.2s' }}
                  >
                    <td className="text-mono text-xs text-gray-500">{node.node_code}</td>
                    <td>
                      <div className="font-semibold text-gray-900" style={{ fontSize: '1rem' }}>
                        {node.name}
                      </div>
                    </td>
                    <td>
                      <span className={`badge ${node.assigned_module === 'chittha' ? 'badge-info' : 'badge-success'}`}>
                        {node.assigned_module || 'attendance'}
                      </span>
                      {node.is_fixed && <span className="badge badge-warning ml-2">Fixed</span>}
                    </td>
                    <td onClick={(e) => e.stopPropagation()}>
                      <div className="actions justify-end" style={{ paddingRight: '20px' }}>
                        {!node.is_fixed && (
                          <>
                            <button className="btn btn-ghost btn-icon btn-sm" onClick={() => openNodeModal(node)}>
                              <Edit size={15} />
                            </button>
                            <button className="btn btn-ghost btn-icon btn-sm text-danger" 
                              onClick={() => setDeleteModal({ id: node.id, name: node.name })}>
                              <Trash2 size={15} />
                            </button>
                          </>
                        )}
                        <ChevronRight size={18} className="text-gray-300 ml-2" />
                      </div>
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
      </div>

      {/* Node Modal */}
      {showNodeModal && (
        <div className="modal-backdrop">
          <div className="modal-content" style={{ maxWidth: '400px' }}>
            <div className="modal-header">
              <h3>{editingNode ? 'Edit Node' : `Add to ${currentNode?.name || 'Root'}`}</h3>
              <button className="btn-close" onClick={() => setShowNodeModal(false)}><X size={20} /></button>
            </div>
            <div className="modal-body">
              <div className="form-group">
                <label className="form-label">Node Name</label>
                <input 
                  type="text" 
                  className="form-control" 
                  value={nodeForm.name}
                  onChange={e => setNodeForm({ ...nodeForm, name: e.target.value })}
                  placeholder="e.g. CIA-1, Headquarters, etc."
                  autoFocus
                />
              </div>
              <div className="form-group">
                <label className="form-label">Assigned Module</label>
                <select 
                  className="form-select"
                  value={nodeForm.assignedModule}
                  onChange={e => setNodeForm({ ...nodeForm, assignedModule: e.target.value })}
                >
                  <option value="attendance">Attendance Register</option>
                  <option value="chittha">Chittha / Duty Management</option>
                </select>
              </div>
            </div>
            <div className="modal-footer">
              <button className="btn btn-secondary" onClick={() => setShowNodeModal(false)}>Cancel</button>
              <button className="btn btn-primary" onClick={saveNode} disabled={saving}>
                {saving ? 'Saving...' : editingNode ? 'Update Node' : 'Create Node'}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Delete Modal */}
      {deleteModal && (
        <div className="modal-backdrop">
          <div className="modal-content" style={{ maxWidth: '400px' }}>
            <div className="modal-header" style={{ color: 'var(--danger-600)' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                <AlertTriangle size={20} />
                <h3>Delete Node?</h3>
              </div>
            </div>
            <div className="modal-body">
              <p>Are you sure you want to delete <strong>{deleteModal.name}</strong>?</p>
              <p className="text-sm text-gray-500 mt-2">This will remove the node but will NOT delete children automatically. Please ensure children are moved or deleted first to avoid orphans.</p>
            </div>
            <div className="modal-footer">
              <button className="btn btn-secondary" onClick={() => setDeleteModal(null)}>Cancel</button>
              <button className="btn btn-danger" onClick={handleDelete} disabled={saving}>
                {saving ? 'Deleting...' : 'Confirm Delete'}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
