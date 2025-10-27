// assets/components/javascript/copyRows.js
import { useCallback } from "react";
import { RowStatus } from "./constants";

export default function useCopyRows(setRowData, gridRef) {
  return useCallback((rowsToCopy) => {
    if (!rowsToCopy || rowsToCopy.length === 0) {
      alert("Selecciona una o más filas para duplicar.");
      return;
    }

    setRowData((prev) => {
      const maxId = prev.length > 0 ? Math.max(...prev.map((r) => r.id)) : 0;

      const hoy = new Date();
      const fechaFormateada = hoy.toISOString().split("T")[0] + " 00:00:00";

      const newRows = rowsToCopy.map((row, i) => {
        const newRow = JSON.parse(JSON.stringify(row));
        newRow.id = maxId + i + 1;
        newRow._rowStatus = RowStatus.NEW;

        for (const key of Object.keys(newRow)) {
          const keyLower = key.toLowerCase();
          if (keyLower === "fec_creacion" || keyLower === "fec_actualizacion") {
            newRow[key] = fechaFormateada;
          }
        }

        return newRow;
      });

      const updated = [...prev, ...newRows];

      // 🟢 Espera a que React actualice el DOM y luego baja el scroll
      setTimeout(() => {
        if (gridRef?.current?.api) {
          const lastIndex = updated.length - 1;
          gridRef.current.api.ensureIndexVisible(lastIndex, "bottom");
        }
      }, 100);

      return updated;
    });
  }, [setRowData, gridRef]);
}
