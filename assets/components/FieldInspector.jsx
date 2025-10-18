// assets/components/FieldInspector.jsx
// Componente principal para inspeccionar campos y tablas asociadas

import React, { useEffect, useState, useCallback } from "react";
import Select from "react-select";
import { AgGridReact } from "ag-grid-react";
import "ag-grid-community/styles/ag-theme-quartz.css";
import { ModuleRegistry, AllCommunityModule } from "ag-grid-community";
import loadFields from "./javascript/loadFields";
import loadTables from "./javascript/loadTables";

// Registrar los módulos de AG Grid necesarios

ModuleRegistry.registerModules([AllCommunityModule]);

const FieldInspector = () => {
  const fields = loadFields()
  const [selectedField, setSelectedField] = useState(null);
  const { tables, loading, error } = loadTables(selectedField);
  const [selectedTable, setSelectedTable] = useState(null);
  const [rowData, setRowData] = useState([]);
  const [colDefs, setColDefs] = useState([]);


  // Cargar contenido de la tabla seleccionada
  useEffect(() => {
    if (!selectedTable) return;

    fetch(`http://localhost:8080/tabla/${selectedTable}`)
      .then((res) => res.json())
      .then((data) => {
        // Añadimos un id único a cada fila al cargar
        const withIds = data.map((row, index) => ({
          id: index + 1, // puedes cambiar esto a otro campo si quieres
          ...row,
        }));

        setRowData(withIds);

        if (data.length > 0) {
          const dynamicCols = Object.keys(data[0]).map((key) => ({
            field: key,
            sortable: true,
            filter: true,
            resizable: true,
          }));
          setColDefs(dynamicCols);
        } else {
          setColDefs([]);
        }
      })
      .catch((err) => console.error("Error cargando tabla:", err));
  }, [selectedTable]);

  // Copiar la filas seleccionadas
  const [selectedRows, setSelectedRows] = useState([]);
  const onInsertone = useCallback(() => {
    if (selectedRows.length === 0) {
      alert("Selecciona una o más filas para duplicar.");
      return;
    }

    setRowData((prev) => {
      const maxId = prev.length > 0 ? Math.max(...prev.map(r => r.id)) : 0;

      const newRows = selectedRows.map((row, i) => ({
        ...row,
        id: maxId + i + 1,
      }));

      return [...prev, ...newRows];
    });
  }, [selectedRows]);


  const getRowId = useCallback(params => {
    return params.data.id;
  });



  return (
    <div className="container mt-4">
      <h1>Inspector de Campos</h1>

      <div className="mb-3" style={{ position: 'relative', zIndex: 9999 }}>
        <label htmlFor="field-select" className="form-label">
          Selecciona un campo:
        </label>
        <Select
          id="field-select"
          options={fields}
          value={selectedField}
          onChange={setSelectedField}
          placeholder="Escribe para buscar un campo..."
          isClearable
          closeMenuOnSelect={true}
          blurInputOnSelect={true}
          filterOption={(option, inputValue) =>
            option.label.toLowerCase().includes(inputValue.toLowerCase())
          }
        />
      </div>


      <h3>Tablas que contienen el campo:</h3>
      <ul className="list-group mb-4">
        {tables.map((table) => (
          <li
            key={table}
            className={`list-group-item ${selectedTable === table ? "active" : ""}`}
            style={{ cursor: "pointer" }}
            onClick={() => setSelectedTable(table)}
          >
            {table}
          </li>
        ))}
        {selectedField && tables.length === 0 && (
          <li className="list-group-item text-muted">
            No se encontraron tablas para este campo.
          </li>
        )}
      </ul>



      {selectedTable && (
        <>
          <h3>Contenido de la tabla: {selectedTable}</h3>
          <div
            className="ag-theme-quartz"
            style={{ height: 500, width: "100%" }}
          >
            <div>
              <button onClick={onInsertone}>Insertar Fila</button>
            </div>
            <AgGridReact
              getRowId={getRowId}
              rowData={rowData}
              rowSelection={"multiple"}
              columnDefs={colDefs}
              defaultColDef={{ resizable: true }}
              onSelectionChanged={(e) => setSelectedRows(e.api.getSelectedRows())}
            />
          </div>
        </>
      )}
    </div>
  );
};

export default FieldInspector;