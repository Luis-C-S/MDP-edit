import { useState, useEffect } from "react";
import fieldOrder from "./fieldOrder";

export default function loadTables(selectedField) {
  const [tables, setTables] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    if (!selectedField) {
      setTables([]);
      return;
    }

    setLoading(true);
    fetch(`/api/tables/${selectedField.value}`)
      .then((res) => res.json())
      .then((data) => {
        // Ordenar según fieldOrder
        const ordered = data.slice().sort((a, b) => {
          const indexA = fieldOrder.indexOf(a);
          const indexB = fieldOrder.indexOf(b);
          return (indexA === -1 ? Infinity : indexA) - (indexB === -1 ? Infinity : indexB);
        });
        setTables(ordered);
        setError(null);
      })
      .catch((err) => {
        console.error("Error cargando tablas:", err);
        setError(err);
      })
      .finally(() => setLoading(false));
  }, [selectedField]);

  return { tables, loading, error };
}
