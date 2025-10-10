import React, { useEffect, useState } from "react";
import Select from "react-select";
import { AgGridReact } from "ag-grid-react";
import "ag-grid-community/styles/ag-theme-quartz.css";
import { ModuleRegistry, AllCommunityModule } from "ag-grid-community";

ModuleRegistry.registerModules([AllCommunityModule]);

const FieldInspector = () => {
  const [fields, setFields] = useState([]);
  const [selectedField, setSelectedField] = useState(null);
  const [tables, setTables] = useState([]);
  const [selectedTable, setSelectedTable] = useState(null);
  const [rowData, setRowData] = useState([]);
  const [colDefs, setColDefs] = useState([]);

  // Cargar lista de campos al montar
  useEffect(() => {
    fetch("/api/fields")
      .then((res) => res.json())
      .then((data) => {
        const uniqueSortedFields = Array.from(new Set(data)).sort((a, b) =>
          a.localeCompare(b)
        );
        const options = uniqueSortedFields.map((field) => ({
          value: field,
          label: field,
        }));
        setFields(options);
      })
      .catch((err) => console.error("Error cargando campos:", err));
  }, []);

  // Cargar tablas que contienen el campo seleccionado
  useEffect(() => {
    if (selectedField) {
      fetch(`/api/tables/${selectedField.value}`)
        .then((res) => res.json())
        .then((data) => setTables(data))
        .catch((err) => console.error("Error cargando tablas:", err));
    } else {
      setTables([]);
      setSelectedTable(null);
      setRowData([]);
    }
  }, [selectedField]);

  // Cargar contenido de la tabla seleccionada
  useEffect(() => {
    if (!selectedTable) return;

    fetch(`http://localhost:8080/tabla/${selectedTable}`)
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
        } else {
          setColDefs([]);
        }
      })
      .catch((err) => console.error("Error cargando tabla:", err));
  }, [selectedTable]);

  return (
    <div className="container mt-4">
      <h1>Inspector de Campos</h1>

      <div className="mb-3">
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
            className={`list-group-item ${
              selectedTable === table ? "active" : ""
            }`}
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
            <AgGridReact
              rowData={rowData}
              columnDefs={colDefs}
              defaultColDef={{ resizable: true }}
            />
          </div>
        </>
      )}
    </div>
  );
};

export default FieldInspector;
