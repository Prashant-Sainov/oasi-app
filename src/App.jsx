import { BrowserRouter, Routes, Route, Navigate, Outlet } from 'react-router-dom';
import AuthProvider, { useAuth } from './contexts/AuthContext';
import ToastProvider from './contexts/ToastContext';
import AppLayout from './components/AppLayout';
import Login from './pages/Login';
import Dashboard from './pages/Dashboard';
import PersonnelList from './pages/personnel/PersonnelList';
import PersonnelForm from './pages/personnel/PersonnelForm';
import ExcelImport from './pages/personnel/ExcelImport';
import UnitSetup from './pages/admin/UnitSetup';
import MasterData from './pages/admin/MasterData';
import AttendanceRegister from './pages/attendance/AttendanceRegister';
import ChitthaList from './pages/chittha/ChitthaList';
import ChitthaEditor from './pages/chittha/ChitthaEditor';
import ChitthaPrintView from './pages/chittha/ChitthaPrintView';
import LeaveRegister from './pages/leave/LeaveRegister';
import LeaveApply from './pages/leave/LeaveApply';
import ReportsDashboard from './pages/reports/ReportsDashboard';
import FIRForm from './pages/reports/FIRForm';
import GrievanceList from './pages/alerts/GrievanceList';
import GrievanceApply from './pages/alerts/GrievanceApply';
import ComingSoon from './components/ComingSoon';

function ProtectedRoute({ children }) {
  const { user, loading } = useAuth();
  if (loading) {
    return (
      <div className="loading-screen">
        <div className="spinner spinner-lg"></div>
        <p>Loading OASI Portal...</p>
      </div>
    );
  }
  if (!user) return <Navigate to="/login" replace />;
  return children || <Outlet />;
}

function PublicRoute({ children }) {
  const { user, loading } = useAuth();
  if (loading) return null;
  if (user) return <Navigate to="/dashboard" replace />;
  return children;
}

// StateAdminRoute remains internal for now as it's simple
function StateAdminRoute({ children }) {
  const { user, loading, isStateAdmin } = useAuth();
  if (loading) return null;
  if (!user || !isStateAdmin) {
    return <Navigate to="/dashboard" replace />;
  }
  return children;
}

export default function App() {
  return (
    <BrowserRouter>
      <AuthProvider>
        <ToastProvider>
          <Routes>
            {/* Public */}
            <Route path="/login" element={<PublicRoute><Login /></PublicRoute>} />

            {/* Protected */}
            <Route element={<ProtectedRoute><AppLayout /></ProtectedRoute>}>
              <Route path="/dashboard" element={<Dashboard />} />

              {/* Personnel */}
              <Route path="/personnel" element={<PersonnelList />} />
              <Route path="/personnel/add" element={<PersonnelForm />} />
              <Route path="/personnel/import" element={<ExcelImport />} />
              <Route path="/personnel/:id" element={<PersonnelForm />} />
              <Route path="/personnel/:id/edit" element={<PersonnelForm />} />

              {/* Unit Setup - Restricted to State Admin/Super Admin */}
              <Route path="/units" element={<StateAdminRoute><UnitSetup /></StateAdminRoute>} />
              <Route path="/master-data" element={<StateAdminRoute><MasterData /></StateAdminRoute>} />

              {/* Phase 2: Attendance & Chittha */}
              <Route path="/attendance" element={<AttendanceRegister />} />
              <Route path="/chitthas" element={<ChitthaList />} />
              <Route path="/chitthas/new" element={<ChitthaEditor />} />
              <Route path="/chitthas/edit/:id" element={<ChitthaEditor />} />
              <Route path="/chitthas/:id" element={<ChitthaPrintView />} />
              <Route path="/chittha" element={<Navigate to="/chitthas" replace />} />

              {/* Phase 3: Leave Management */}
              <Route path="/leave" element={<LeaveRegister />} />
              <Route path="/leave/apply" element={<LeaveApply />} />

              {/* Phase 4: Reports & Analytics */}
              <Route path="/reports/fir" element={<ReportsDashboard />} />
              <Route path="/reports/fir/add" element={<FIRForm />} />

              {/* Phase 5: Alerts & Grievances */}
              <Route path="/grievances" element={<GrievanceList />} />
              <Route path="/grievances/new" element={<GrievanceApply />} />

              {/* Phase 5+ placeholders */}
              <Route path="/admin/roles" element={<ComingSoon title="Role Management" />} />
              <Route path="/admin/settings" element={<ComingSoon title="Settings" />} />
            </Route>

            {/* Redirect root */}
            <Route path="/" element={<Navigate to="/dashboard" replace />} />
            <Route path="*" element={<Navigate to="/dashboard" replace />} />
          </Routes>
        </ToastProvider>
      </AuthProvider>
    </BrowserRouter>
  );
}
