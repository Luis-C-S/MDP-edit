// assets/components/FieldInspector.jsx
// Componente principal para inspeccionar campos y tablas asociadas

// Importaciones
import React, { useEffect, useState, useCallback } from "react";
import Select from "react-select";
import { AgGridReact } from "ag-grid-react";
import "ag-grid-community/styles/ag-theme-quartz.css";
import { ModuleRegistry, AllCommunityModule } from "ag-grid-community";
import loadFields from "./javascript/loadFields";
import loadTables from "./javascript/loadTables";
import loadTabledata from "./javascript/loadTabledata";
import useCopyRows from "./javascript/copyRows";
import { RowStatus } from "./javascript/constants";
// Registro de módulos de AG Grid
ModuleRegistry.registerModules([AllCommunityModule]);

// Componente principal
const FieldInspector = () => {
  const fields = loadFields()
  const [selectedField, setSelectedField] = useState(null);
  const { tables, loading, error } = loadTables(selectedField);
  const [selectedTable, setSelectedTable] = useState(null);
  const { rowData, setRowData, colDefs } = loadTabledata(selectedTable);
  const onInsertOne = useCopyRows(setRowData);
  const [selectedRows, setSelectedRows] = useState([]);
  const getRowId = useCallback(params => {
    return String(params.data.id);
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
              <button onClick={() => onInsertOne(selectedRows)}>Insertar Fila</button>
            </div>
            <AgGridReact
              getRowId={getRowId}
              rowData={rowData}
              rowSelection="multiple"
              getRowStyle={(params) => {
                if (params.data?._rowStatus === RowStatus.NEW) {
                  return { backgroundColor: "#d4f8d4" }; // verde claro
                }
                if (params.data?._rowStatus === RowStatus.MODIFIED) {
                  return { backgroundColor: "#ffe4b3" }; // naranja claro
                }
                return null;
              }}
              columnDefs={colDefs}
              defaultColDef={{
                resizable: true,
                editable: true,
              }}
              onSelectionChanged={(e) => setSelectedRows(e.api.getSelectedRows())}
              onCellValueChanged={(params) => {
                const { data, oldValue, newValue } = params;

                // Si el valor realmente cambió
                if (oldValue !== newValue) {
                  // Solo marcamos como MODIFIED si no es NEW
                  if (data._rowStatus !== RowStatus.NEW) {
                    data._rowStatus = RowStatus.MODIFIED;
                  }

                  // Refrescamos visualmente la fila
                  params.api.applyTransaction({ update: [data] });
                }
              }}
            />
          </div>
        </>
      )}
    </div>
  );
};

export default FieldInspector;