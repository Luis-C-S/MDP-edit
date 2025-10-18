// assets/components/javascript/copyRows.js  
// Hook personalizado para copiar filas seleccionadas en una tabla

import { useCallback } from "react";

export default function useCopyRows(setRowData) {
  return useCallback((rowsToCopy) => {
    if (!rowsToCopy || rowsToCopy.length === 0) {
      alert("Selecciona una o más filas para duplicar.");
      return;
    }

    setRowData(prev => {
      const maxId = prev.length > 0 ? Math.max(...prev.map(r => r.id)) : 0;
      const newRows = rowsToCopy.map((row, i) => ({
        ...row,
        id: maxId + i + 1,
      }));
      return [...prev, ...newRows];
    });
  }, [setRowData]);
}



