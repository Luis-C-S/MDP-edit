import React from 'react';
import { Link } from 'react-router-dom';

const Sidebar = () => {
  return (
    <div style={{ width: '200px', background: '#eee', padding: '1rem' }}>
      <nav>
        <ul style={{ listStyle: 'none', padding: 0 }}>
          <li><Link to="/field-inspector">Field Inspector</Link></li>
          {/* Más enlaces aquí */}
        </ul>
      </nav>
    </div>
  );
};

export default Sidebar;
