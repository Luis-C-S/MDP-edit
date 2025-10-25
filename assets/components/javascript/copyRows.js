// assets/components/javascript/copyRows.js
import { RowStatus } from "./constants";

/**
 * Copia las filas seleccionadas en el grid.
 * - Mantiene metadatos (_meta_*).
 * - Asigna _rowStatus NEW a las copias.
 * - Genera un _meta_id temporal único para nuevas filas (no colisiona con BBDD).
 */
export default function copyRows(rowsToCopy, existingRows) {
  // 🔹 Encontrar el máximo _meta_id actual para nuevas filas temporales
  const maxMetaId = existingRows.reduce((max, row) => {
    const id = row._meta_id || 0;
    return id > max ? id : max;
  }, 0);

  const newRows = rowsToCopy.map((row, i) => {
    // 🔹 Copiamos toda la fila, incluidos los metadatos
    const newRow = JSON.parse(JSON.stringify(row));

    // 🔹 Asignar nuevo _meta_id temporal único y marcar como NEW
    newRow._meta_id = maxMetaId + i + 1;
    newRow._rowStatus = RowStatus.NEW;

    return newRow;
  });

  return newRows;
}
