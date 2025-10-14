import React from 'react';
import { Link } from 'react-router-dom';

const Sidebar = () => {
  return (
    <div style={{ display: 'flex', position: 'relative', height: '100vh' }}>
      <Sidebar />
      <div style={{ flex: 1, padding: '1rem', overflow: 'auto', position: 'relative' }}>
        <Routes>
          <Route path="/field-inspector" element={<FieldInspector />} />
          <Route path="/paste-table" element={<PasteTable />} />
        </Routes>
      </div>
    </div>
  );
};

export default Sidebar;
