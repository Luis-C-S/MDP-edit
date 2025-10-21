// assets/components/javascript/deleteRows.js
import { useCallback } from "react";
import { RowStatus } from "./constants";

/**
 * Hook para borrar o restaurar filas en AG Grid.
 * - NEW: se elimina inmediatamente.
 * - MODIFIED u ORIGINAL: se marca como DELETED.
 * - DELETED: vuelve a ORIGINAL (manteniendo modificaciones si existían)
 * @param {function} setRowData - función de estado de rowData
 * @returns {function} deleteRows - función que recibe las filas seleccionadas
 */
export default function useDeleteRows(setRowData) {
  return useCallback((rowsToToggle) => {
    if (!rowsToToggle || rowsToToggle.length === 0) {
      alert("Selecciona una o más filas para borrar/restaurar.");
      return;
    }

    setRowData((prevRows) => {
      return prevRows
        .map((row) => {
          if (!rowsToToggle.includes(row)) return row;

          switch (row._rowStatus) {
            case RowStatus.NEW:
              // Eliminamos inmediatamente
              return null;
            case RowStatus.DELETED:
              // Restaurar a ORIGINAL
              return { ...row, _rowStatus: RowStatus.ORIGINAL };
            default:
              // Marcar como DELETED
              return { ...row, _rowStatus: RowStatus.DELETED };
          }
        })
        .filter(Boolean); // eliminar filas NEW
    });
  }, [setRowData]);
}
