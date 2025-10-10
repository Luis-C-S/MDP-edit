import React, { useState, useEffect } from "react";
import { AgGridReact } from "ag-grid-react";
import "ag-grid-community/styles/ag-theme-quartz.css";
import { ModuleRegistry, AllCommunityModule } from "ag-grid-community";

ModuleRegistry.registerModules([AllCommunityModule]);

const PasteTable = () => {
  const [rowData, setRowData] = useState([]);
  const [colDefs, setColDefs] = useState([]);

  useEffect(() => {
    const tableName = "producto_idioma"; // 👈 tabla fija para pruebas

    fetch(`http://localhost:8080/tabla/${tableName}`)
      .then((res) => res.json())
      .then((data) => {
        setRowData(data);

        if (data.length > 0) {
          const dynamicCols = Object.keys(data[0]).map((key) => ({
            field: key,
            sortable: true,
            filter: true,
            resizable: true,
          }));
          setColDefs(dynamicCols);
        }
      })
      .catch((err) => console.error("Error cargando tabla:", err));
  }, []);

  return (
    <div
      className="ag-theme-quartz"
      style={{ height: 500, width: "100%", marginTop: 20 }}
    >
      <AgGridReact
        rowData={rowData}
        columnDefs={colDefs}
        defaultColDef={{ resizable: true }}
      />
    </div>
  );
};

export default PasteTable;
