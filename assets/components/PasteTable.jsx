import React, { useState, useEffect, useCallback } from "react";
import { AgGridReact } from "ag-grid-react";
import "ag-grid-community/styles/ag-theme-quartz.css";
import { ModuleRegistry, AllCommunityModule } from "ag-grid-community";

ModuleRegistry.registerModules([AllCommunityModule]);

const PasteTable = ({ tableName }) => {
  const [rowData, setRowData] = useState([]);
  const [colDefs, setColDefs] = useState([]);

  // 🔹 Cargar datos desde el backend
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
            editable: true, // 👈 habilitar edición en todas las columnas
          }));
          setColDefs(dynamicCols);
        }
      })
      .catch((err) => console.error("Error cargando tabla:", err));
  }, [tableName]);

  // 🔹 Cuando se edita una celda, enviar el cambio al backend
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
    <div className="ag-theme-quartz" style={{ height: 500, width: "100%" }}>
      <AgGridReact
        rowData={rowData}
        columnDefs={colDefs}
        defaultColDef={{ resizable: true }}
        editType="fullRow"
        readOnlyEdit={false}
        stopEditingWhenCellsLoseFocus={true}
        onCellEditRequest={onCellEditRequest} // 👈 manejador para edición
      />
    </div>
  );
};

export default PasteTable;

