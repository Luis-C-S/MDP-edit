// assets/components/Sidebar.jsx
import React from 'react';
import { Link } from 'react-router-dom';

const Sidebar = () => {
  return (
    <div style={{ width: '200px', background: '#eee', padding: '1rem' }}>
      <nav>
        <ul style={{ listStyle: 'none', padding: 0 }}>
          <li><Link to="/field-inspector">Editor MDP</Link></li>
          <li><Link to="/info-producto">Información Producto</Link></li>
          <li><Link to="/mapa-mundial">Mapa Mundial</Link></li> {/* 👈 Nuevo enlace */}
        </ul>
      </nav>
    </div>
  );
};

export default Sidebar;
