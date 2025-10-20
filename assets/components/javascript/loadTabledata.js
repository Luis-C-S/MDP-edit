// assets/components/javascript/loadTabledata.js
// Carga contenido de la tabla seleccionada y permite alternar entre mostrar códigos o nombres

import { useState, useEffect } from "react";
import { RowStatus } from "./constants";

export default function loadTabledata(selectedTable) {
  const [rowData, setRowData] = useState([]);
  const [colDefs, setColDefs] = useState([]);
  const [showCodes, setShowCodes] = useState(false); // 👈 Nuevo estado para alternar vista

  useEffect(() => {
    if (!selectedTable) return;

    // 1️⃣ Cargar datos y lookups en paralelo
    const fetchTable = fetch(`/tabla/${selectedTable}`).then((res) => res.json());
    const fetchLookups = fetch(`/api/lookups/${selectedTable}`).then((res) => res.json());

    Promise.all([fetchTable, fetchLookups])
      .then(([data, lookups]) => {
        if (!Array.isArray(data)) {
          console.error("Respuesta inesperada:", data);
          return;
        }

        // 2️⃣ Reemplazar los códigos por nombres y guardar ambos
        const enhancedRows = data.map((row, index) => {
          const newRow = { id: index + 1, _rowStatus: RowStatus.ORIGINAL, ...row };

          Object.keys(lookups).forEach((field) => {
            const lookupList = lookups[field];
            const codeValue = row[field];

            if (lookupList && codeValue !== undefined) {
              const found = lookupList.find((l) => l[field] === codeValue);

              if (found) {
                const descField = Object.keys(found).find((k) => k !== field);
                if (descField) {
                  // Guardamos los dos valores
                  newRow[`_meta_${field}_code`] = codeValue;
                  newRow[`_meta_${field}_desc`] = found[descField];
                }
              }
            }
          });

          return newRow;
        });

        // 3️⃣ Configurar columnas dinámicas
        if (enhancedRows.length > 0) {
          const dynamicCols = Object.keys(enhancedRows[0])
            .filter((key) => key !== "id" && key !== "_rowStatus" && !key.startsWith("_meta_"))
            .map((key) => ({
              field: key,
              headerName: key,
              sortable: true,
              filter: true,
              resizable: true,
              valueGetter: (params) => {
                const metaDesc = params.data[`_meta_${key}_desc`];
                const metaCode = params.data[`_meta_${key}_code`];
                if (metaDesc && metaCode) {
                  return showCodes ? metaCode : metaDesc;
                }
                return params.data[key];
              },
            }));

          setColDefs(dynamicCols);
        } else {
          setColDefs([]);
        }

        setRowData(enhancedRows);
      })
      .catch((err) => console.error("Error cargando datos o lookups:", err));
  }, [selectedTable, showCodes]); // 👈 se actualiza al cambiar el modo de vista

  // 👇 función pública que puedes usar desde otro componente (por ejemplo un botón)
  const toggleShowCodes = () => setShowCodes((prev) => !prev);

  return { rowData, setRowData, colDefs, showCodes, toggleShowCodes };
}
