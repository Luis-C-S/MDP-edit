import React, { useEffect, useState } from "react";
import Select from "react-select";

const FieldInspector = () => {
  const [fields, setFields] = useState([]);
  const [selectedField, setSelectedField] = useState(null);
  const [tables, setTables] = useState([]);

  useEffect(() => {
    console.log("FieldInspector montado");
  }, []);

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

  useEffect(() => {
    if (selectedField) {
      fetch(`/api/tables/${selectedField.value}`)
        .then((res) => res.json())
        .then((data) => setTables(data))
        .catch((err) => console.error("Error cargando tablas:", err));
    } else {
      setTables([]);
    }
  }, [selectedField]);

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
          filterOption={(option, inputValue) => {
            if (!inputValue) return true;
            return option.label.toLowerCase().includes(inputValue.toLowerCase());
          }}
        />
      </div>

      <h3>Tablas que contienen el campo:</h3>
      <ul className="list-group">
        {tables.map((table) => (
          <li key={table} className="list-group-item">
            {table}
          </li>
        ))}
        {selectedField && tables.length === 0 && (
          <li className="list-group-item text-muted">
            No se encontraron tablas para este campo.
          </li>
        )}
      </ul>
    </div>
  );
};

export default FieldInspector;