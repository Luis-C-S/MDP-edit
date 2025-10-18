// assets/components/javascript/loadFields.js
// Carga los campos disponibles desde el servidor y los devuelve como opciones ordenadas

import { useState, useEffect } from "react";

export default function loadFields() {
  const [fields, setFields] = useState([]);

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

  return fields;
}
