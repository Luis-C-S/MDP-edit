
// assets/App.jsx
import { Routes, Route } from 'react-router-dom';
import Sidebar from './components/Sidebar';
import FieldInspector from './components/FieldInspector';
import InfoProducto from './components/InfoProducto';
import WorldMap from './components/WorldMap'; 

const App = () => {
  return (
    <div style={{ display: 'flex' }}>
      <Sidebar />
      <div style={{ flex: 1, paddingLeft: '0.5rem' }}>
        <Routes>
          <Route path="/field-inspector" element={<FieldInspector />} />
          <Route path="/info-producto" element={<InfoProducto />} />
          <Route path="/mapa-mundial" element={<WorldMap />} /> 
        </Routes>
      </div>
    </div>
  );
};

export default App;