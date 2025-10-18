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
            editable: true,
          }));
          setColDefs(dynamicCols);
        }
      })
      .catch((err) => console.error("Error cargando tabla:", err));
  }, [tableName]);


  const onInsertone = useCallback(() => {
    const selectedNodes = gridRef.current.api.getSelectedNodes();
    if (selectedNodes.length === 0) {
      alert("Selecciona una fila para duplicar.");
      return;
    }

    const selectedData = selectedNodes[0].data;

    // Crear una copia de la fila seleccionada
    const newRow = {
      ...selectedData,
      id: Date.now(), // Asegúrate de que el campo 'id' sea único
    };

    setRowData((prevData) => [...prevData, newRow]);
  }, []);


  const getRowID = useCallback(params => {
    console.log(params);
    return params.data.id;
  });


  return (
    <div className="ag-theme-quartz" style={{ height: 500, width: "100%" }}>
      <div style={{ marginBottom: "1rem", display: "flex", gap: "1rem" }}>
        <button onClick={onInsertone}>Insertar Fila</button>
        <button onClick={onDeleteone}>Eliminar Fila</button>
      </div>
      <AgGridReact
        getRowID={getRowID}
        rowData={rowData}
        animateRows={true}
        rowSelection={multiple}
        columnDefs={colDefs}
      />
    </div>
  );
};

export default PasteTable;

