// assets/components/javascript/copyRows.js
import { useCallback } from "react";
import { RowStatus } from "./constants";

export default function useCopyRows(setRowData) {
  return useCallback((rowsToCopy) => {
    if (!rowsToCopy || rowsToCopy.length === 0) {
      alert("Selecciona una o más filas para duplicar.");
      return;
    }

    setRowData((prev) => {
      const maxId = prev.length > 0 ? Math.max(...prev.map((r) => r.id)) : 0;

      // 📅 Fecha actual formateada
      const hoy = new Date();
      const fechaFormateada = hoy.toISOString().split("T")[0] + " 00:00:00";

      const newRows = rowsToCopy.map((row, i) => {
        // 🆕 Copiamos TODO, incluidos los metadatos (_meta_)
        const newRow = JSON.parse(JSON.stringify(row));




        // Asignamos nuevo ID y estado
        newRow.id = maxId + i + 1;
        newRow._rowStatus = RowStatus.NEW;

        // 🔁 Actualizamos campos de fecha
        for (const key of Object.keys(newRow)) {
          const keyLower = key.toLowerCase();
          if (keyLower === "fec_creacion" || keyLower === "fec_actualizacion") {
            newRow[key] = fechaFormateada;
            console.log(`✅ Campo ${key} actualizado a ${fechaFormateada}`);
          }
        }

        return newRow;
      });

      console.log("🆕 Filas copiadas (con metadatos):", newRows);
      return [...prev, ...newRows];
    });
  }, [setRowData]);
}