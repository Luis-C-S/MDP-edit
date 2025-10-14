import React, { useState, useEffect, useCallback } from "react";
import { AgGridReact } from "ag-grid-react";
import "ag-grid-community/styles/ag-theme-quartz.css";
import { ModuleRegistry, AllCommunityModule } from "ag-grid-community";

ModuleRegistry.registerModules([AllCommunityModule]);

const PasteTable = ({ tableName }) => {
  const [rowData, setRowData] = useState([]);
  const [colDefs, setColDefs] = useState([]);

  useEffect(() => {
    if (!tableName) return;

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
            editable: true,
          }));
          setColDefs(dynamicCols);
        }
      })
      .catch((err) => console.error("Error cargando tabla:", err));
  }, [tableName]);

  const onCellEditRequest = useCallback(
    async (event) => {
      const updatedRow = { ...event.data, [event.colDef.field]: event.newValue };

      try {
        const response = await fetch(`http://localhost:8080/tabla/${tableName}`, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ action: "update", row: updatedRow }),
        });

        const result = await response.json();
        if (!result.ok) {
          console.error("Error actualizando:", result.error);
          alert("❌ Error al actualizar el registro.");
        } else {
          console.log("✅ Actualizado correctamente:", updatedRow);
        }
      } catch (err) {
        console.error("Error al guardar:", err);
      }
    },
    [tableName]
  );

  return (
    <div style={{ height: "500px", width: "100%", overflow: "auto", position: "relative", zIndex: 1 }}>
      <div className="ag-theme-quartz" style={{ minHeight: "100%", width: "100%" }}>
        <AgGridReact
          rowData={rowData}
          columnDefs={colDefs}
          defaultColDef={{ resizable: true }}
          editType="fullRow"
          stopEditingWhenCellsLoseFocus={true}
          onCellEditRequest={onCellEditRequest}
        />
      </div>
    </div>
  );
};

export default PasteTable;
