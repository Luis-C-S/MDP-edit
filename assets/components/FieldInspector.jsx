// assets/components/FieldInspector.jsx
import React, { useState, useCallback, useRef } from "react";
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

ModuleRegistry.registerModules([AllCommunityModule]);

const FieldInspector = () => {
  const fields = loadFields();
  const [selectedField, setSelectedField] = useState(null);
  const { tables } = loadTables(selectedField);
  const [selectedTable, setSelectedTable] = useState(null);

  const { rowData, setRowData, colDefs, showCodes, toggleShowCodes, reloadGrid } =
    loadTabledata(selectedTable);

  const onInsertOne = useCopyRows(setRowData, gridRef);
  const onDeleteRows = useDeleteRows(setRowData);
  const [selectedRows, setSelectedRows] = useState([]);

  const getRowId = useCallback((params) => String(params.data.id));
  const gridRef = useRef(null);
  const handleRowDataUpdated = useCallback(() => {
    if (gridRef?.current?.api) {
      const lastIndex = gridRef.current.api.getDisplayedRowCount() - 1;
      if (lastIndex >= 0) {
        gridRef.current.api.ensureIndexVisible(lastIndex, "bottom");
      }
    }
  }, []);


  return (
    <div
      className="container mt-4"
      style={{
        paddingBottom: "2rem", // 🔹 margen inferior total reducido (antes 4rem)
      }}
    >
      <h1>Editor Maestro de Productos</h1>

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

          {/* 🔹 Marco blanco envolvente */}
          <div
            style={{
              backgroundColor: "white",
              border: "1px solid #ddd",
              borderRadius: "0.5rem",
              padding: "1rem", // mantiene simetría
              marginBottom: "1.5rem", // margen externo más corto
              boxShadow: "0 2px 6px rgba(0,0,0,0.05)",
            }}
          >
            {/* Botones de acción */}
            <div
              style={{
                marginBottom: "0.75rem",
                display: "flex",
                gap: "1rem",
              }}
            >
              <button onClick={() => onInsertOne(selectedRows)}>➕ Insertar Fila</button>
              <button onClick={() => onDeleteRows(selectedRows)}>🗑️ Borrar/Restaurar Filas</button>

              <button onClick={toggleShowCodes}>
                {showCodes ? "🔤 Mostrar nombres descriptivos" : "🔢 Mostrar códigos"}
              </button>

              <button
                onClick={() => {
                  if (gridRef?.current?.api) {
                    gridRef.current.api.stopEditing(); // 👈 cierra la edición actual
                  }
                  updateBBDD(selectedTable, rowData, setRowData, reloadGrid);
                }}
              >
                💾 Actualizar BBDD
              </button>
            </div>

            {/* Grid */}
            <div
              className="ag-theme-quartz"
              style={{
                height: 650, // 🔹 aumentado (antes 500)
                width: "100%",
              }}
            >
              <AgGridReact
                ref={gridRef}
                getRowId={getRowId}
                rowData={rowData}
                rowSelection="multiple"
                columnDefs={colDefs}
                defaultColDef={{ resizable: true, editable: true }}
                onSelectionChanged={(e) => setSelectedRows(e.api.getSelectedRows())}
                onRowDataUpdated={handleRowDataUpdated}
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
          </div>
        </>
      )}
    </div>
  );
};

export default FieldInspector;
