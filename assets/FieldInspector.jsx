// assets/FieldInspector.jsx
import React, { useEffect, useState } from "react";

const FieldInspector = () => {
  const [fields, setFields] = useState([]);
  const [selectedField, setSelectedField] = useState("");
  const [tables, setTables] = useState([]);

  // Debug: para ver si el componente se monta varias veces
  useEffect(() => {
    console.log("FieldInspector montado");
  }, []);

  // Cargar los campos al montar el componente
  useEffect(() => {
    fetch("/api/fields")
      .then((res) => res.json())
      .then((data) => setFields(data))
      .catch((err) => console.error("Error cargando campos:", err));
  }, []);

  // Cargar las tablas cuando cambia el campo seleccionado
  useEffect(() => {
    if (selectedField) {
      fetch(`/api/tables/${selectedField}`)
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

      {/* Evitar que un form padre haga submit */}
      <div className="mb-3">
        <label htmlFor="field-select" className="form-label">
          Selecciona un campo:
        </label>
        <select
          id="field-select"
          className="form-select"
          value={selectedField}
          onChange={(e) => setSelectedField(e.target.value)}
        >
          <option value="">-- Selecciona un campo --</option>
          {fields.map((field) => (
            <option key={field} value={field}>
              {field}
            </option>
          ))}
        </select>
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