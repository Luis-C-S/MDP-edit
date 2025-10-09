import React, { useState } from "react";
import { AgGridReact } from "ag-grid-react";
import "ag-grid-community/styles/ag-theme-quartz.css";
import { ModuleRegistry, AllCommunityModule } from 'ag-grid-community';    
ModuleRegistry.registerModules([ AllCommunityModule ]);

const PasteTable = () => {
  // Datos de ejemplo
  const [rowData] = useState([
    { make: "Tesla", model: "Model Y", price: 64950 },
    { make: "Ford", model: "F-Series", price: 33850 },
    { make: "Toyota", model: "Corolla", price: 29600 },
  ]);

  // Columnas de la tabla
  const [colDefs] = useState([
    { field: "make" },
    { field: "model" },
    { field: "price" },
  ]);

  return (
    <div
      className="ag-theme-quartz"  // 👈 Tema Quartz aplicado aquí
      style={{ height: 400, width: "100%" }}
    >
      <AgGridReact
        rowData={rowData}
        columnDefs={colDefs}
        defaultColDef={{ sortable: true, filter: true }} // Opcional: ordenar y filtrar
      />
    </div>
  );
};

export default PasteTable;
