// assets/components/FieldInspector.jsx
import React, { useState, useCallback } from "react";
import Select from "react-select";
import { AgGridReact } from "ag-grid-react";
import "ag-grid-community/styles/ag-theme-quartz.css";
import { ModuleRegistry, AllCommunityModule } from "ag-grid-community";
import loadFields from "./javascript/loadFields";
import loadTables from "./javascript/loadTables";
import loadTabledata from "./javascript/loadTabledata";
import useCopyRows from "./javascript/copyRows";
import useDeleteRows from "./javascript/deleteRows";
import { RowStatus } from "./javascript/constants";
import updateBBDD from "./javascript/updateBBDD";

// Registro de módulos de AG Grid
ModuleRegistry.registerModules([AllCommunityModule]);

const FieldInspector = () => {
  const fields = loadFields();
  const [selectedField, setSelectedField] = useState(null);
  const { tables } = loadTables(selectedField);
  const [selectedTable, setSelectedTable] = useState(null);

  // 🔹 Hook de datos del grid
  const { rowData, setRowData, colDefs, showCodes, toggleShowCodes, reloadGrid } =
    loadTabledata(selectedTable);

  const onInsertOne = useCopyRows(setRowData);
  const onDeleteRows = useDeleteRows(setRowData);
  const [selectedRows, setSelectedRows] = useState([]);

  const getRowId = useCallback((params) => String(params.data.id));

  return (
    <div className="container mt-4">
      <h1>Inspector de Campos</h1>

      {/* Selector de campo */}
      <div className="mb-3" style={{ position: "relative", zIndex: 9999 }}>
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

      {/* Listado de tablas */}
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

      {/* Grid de contenido */}
      {selectedTable && (
        <>
          <h3>Contenido de la tabla: {selectedTable}</h3>

          <div className="ag-theme-quartz" style={{ height: 500, width: "100%" }}>
            {/* Botones de acción */}
            <div style={{ marginBottom: "0.5rem", display: "flex", gap: "1rem" }}>
              <button onClick={() => onInsertOne(selectedRows)}>➕ Insertar Fila</button>
              <button onClick={() => onDeleteRows(selectedRows)}>🗑️ Borrar/Restaurar Filas</button>

              <button onClick={toggleShowCodes}>
                {showCodes ? "🔤 Mostrar nombres descriptivos" : "🔢 Mostrar códigos"}
              </button>

              {/* Actualiza BBDD y recarga desde el servidor */}
              <button onClick={() => updateBBDD(selectedTable, rowData, setRowData, reloadGrid)}>
                💾 Actualizar BBDD
              </button>
            </div>

            <AgGridReact
              getRowId={getRowId}
              rowData={rowData}
              rowSelection="multiple"
              columnDefs={colDefs}
              defaultColDef={{ resizable: true, editable: true }}
              onSelectionChanged={(e) => setSelectedRows(e.api.getSelectedRows())}
              onCellValueChanged={(params) => {
                const { data, oldValue, newValue } = params;
                if (oldValue !== newValue && data._rowStatus !== RowStatus.NEW) {
                  data._rowStatus = RowStatus.MODIFIED;
                  params.api.applyTransaction({ update: [data] });
                }
              }}
              getRowStyle={(params) => {
                if (params.data?._rowStatus === RowStatus.NEW)
                  return { backgroundColor: "#d4f8d4" };
                if (params.data?._rowStatus === RowStatus.MODIFIED)
                  return { backgroundColor: "#ffe4b3" };
                if (params.data?._rowStatus === RowStatus.DELETED)
                  return { backgroundColor: "#f8d4d4", textDecoration: "line-through" };
                return null;
              }}
            />
          </div>
        </>
      )}
    </div>
  );
};

export default FieldInspector;
