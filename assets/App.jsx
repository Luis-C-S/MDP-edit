import { Routes, Route } from 'react-router-dom';
import Sidebar from './components/Sidebar';
import FieldInspector from './components/FieldInspector';
import InfoProducto from './components/InfoProducto';

const App = () => {
  return (
    <div style={{ display: 'flex' }}>
      <Sidebar />
      <div style={{ flex: 1, paddingLeft: '0.5rem' }}> {/* 🔹 reducido */}
        <Routes>
          <Route path="/field-inspector" element={<FieldInspector />} />
          <Route path="/info-producto" element={<InfoProducto />} />
        </Routes>
      </div>
    </div>
  );
};

export default App;