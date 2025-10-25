import { RowStatus } from "./constants";

/**
 * Envía a la BBDD las filas modificadas, nuevas o eliminadas,
 * asegurando que los campos con metadatos código/descripción siempre se envíen como código.
 * Usa id real de la fila en la BBDD.
 * 
 * @param {string} selectedTable - Nombre de la tabla a actualizar
 * @param {Array} rowData - Datos actuales del grid
 * @param {function} setRowData - Setter de rowData
 * @param {function} reloadGrid - Función para recargar datos desde la BBDD (opcional)
 */
export default async function updateBBDD(selectedTable, rowData, setRowData, reloadGrid) {
  if (!selectedTable) return alert("Selecciona una tabla primero.");

  const rowsToDelete = rowData.filter((r) => r._rowStatus === RowStatus.DELETED);
  const rowsToUpdate = rowData.filter((r) => r._rowStatus === RowStatus.MODIFIED);
  const rowsToInsert = rowData.filter((r) => r._rowStatus === RowStatus.NEW);

  const totalChanges = rowsToDelete.length + rowsToUpdate.length + rowsToInsert.length;
  if (totalChanges === 0) return alert("No hay cambios pendientes para enviar.");

  if (!window.confirm(`⚠️ Atención, vas a realizar cambios en la BBDD:
  Borrar: ${rowsToDelete.length}
  Modificar: ${rowsToUpdate.length}
  Añadir: ${rowsToInsert.length}
  
  ¿Deseas continuar?`)) return;

  const prepareRow = (row) => {
    const newRow = { ...row };
    Object.keys(newRow).forEach((key) => {
      if (key.startsWith("_meta_") && key.endsWith("_code")) {
        const field = key.replace("_meta_", "").replace("_code", "");
        if (field in newRow) newRow[field] = newRow[key];
      }
    });
    Object.keys(newRow)
      .filter((k) => k.startsWith("_meta_") || k === "_rowStatus")
      .forEach((k) => delete newRow[k]);
    if (row._rowStatus !== RowStatus.NEW) newRow.id = row.id;
    return newRow;
  };

  try {
    const payload = {
      delete: rowsToDelete.map(prepareRow),
      update: rowsToUpdate.map(prepareRow),
      insert: rowsToInsert.map(prepareRow),
    };

    const response = await fetch(
      `http://localhost:8080/api/update-table/${selectedTable}`,
      { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(payload) }
    );

    const result = await response.json();
    if (!response.ok) throw new Error(result.error || "Error desconocido");

    alert("✅ Base de datos actualizada correctamente");

    // 🔹 En lugar de mezclar rowData, recargamos el grid desde la BBDD
    if (reloadGrid) {
      reloadGrid(selectedTable);
    }
  } catch (err) {
    console.error("Error al actualizar la BBDD:", err);
    alert("❌ No se pudo actualizar la BBDD: " + err.message);
  }
}
