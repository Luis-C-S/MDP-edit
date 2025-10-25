// assets/components/javascript/updateBBDD.js
import { RowStatus } from "./constants";

/**
 * Envía a la BBDD las filas modificadas, nuevas o eliminadas,
 * asegurando que los campos con metadatos código/descripción siempre se envíen como código.
 * Usa _meta_id como identificador real de la fila en la BBDD.
 */
export default async function updateBBDD(selectedTable, rowData, setRowData) {
  if (!selectedTable) {
    alert("Selecciona una tabla primero.");
    return;
  }

  // Filtrar filas por estado
  const rowsToDelete = rowData.filter((r) => r._rowStatus === RowStatus.DELETED);
  const rowsToUpdate = rowData.filter((r) => r._rowStatus === RowStatus.MODIFIED);
  const rowsToInsert = rowData.filter((r) => r._rowStatus === RowStatus.NEW);

  const totalChanges = rowsToDelete.length + rowsToUpdate.length + rowsToInsert.length;

  if (totalChanges === 0) {
    alert("No hay cambios pendientes para enviar.");
    return;
  }

  // Confirmación
  let message = "⚠️ Atención, vas a realizar los siguientes cambios en la BBDD:\n\n";
  if (rowsToDelete.length) message += `Borrar ${rowsToDelete.length} fila/s\n`;
  if (rowsToUpdate.length) message += `Modificar ${rowsToUpdate.length} fila/s\n`;
  if (rowsToInsert.length) message += `Añadir ${rowsToInsert.length} fila/s\n`;
  message += "\n¿Deseas continuar?";
  if (!window.confirm(message)) return;

  // Prepara una fila para enviar: reemplaza lookup por código y limpia metadatos (conservar _meta_id)
  const prepareRow = (row) => {
    const newRow = { ...row };

    // 1) Reemplazar campos lookup por el código: usamos _meta_<field>_code si existe
    Object.keys(newRow).forEach((key) => {
      if (key.startsWith("_meta_") && key.endsWith("_code")) {
        const field = key.replace("_meta_", "").replace("_code", "");
        if (field in newRow) {
          newRow[field] = newRow[key]; // siempre enviamos el código
        }
      }
    });

    // 2) Eliminar todos los _meta_* excepto _meta_id, y eliminar _rowStatus
    Object.keys(newRow)
      .filter((k) => {
        if (k === "_rowStatus") return true;
        if (k.startsWith("_meta_") && k !== "_meta_id") return true;
        return false;
      })
      .forEach((k) => delete newRow[k]);

    // 3) Para update/delete añadimos id real (desde _meta_id). Para NEW no añadimos id.
    if (row._rowStatus !== RowStatus.NEW) {
      newRow.id = row._meta_id;
    }

    return newRow;
  };

  // Modal de errores largos
  const showErrorModal = (errorMessage) => {
    console.error("Error completo:", errorMessage);

    const modal = document.createElement("div");
    modal.style.position = "fixed";
    modal.style.top = "0";
    modal.style.left = "0";
    modal.style.width = "100%";
    modal.style.height = "100%";
    modal.style.backgroundColor = "rgba(0,0,0,0.5)";
    modal.style.zIndex = 9999;
    modal.innerHTML = `
      <div style="background:#fff;padding:1rem;margin:5% auto;width:80%;max-height:80%;overflow:auto;border-radius:8px;">
        <h3>Error al actualizar la BBDD</h3>
        <pre style="white-space: pre-wrap;">${errorMessage}</pre>
        <button id="closeModal" style="margin-top:1rem;padding:0.5rem 1rem;">Cerrar</button>
      </div>
    `;
    document.body.appendChild(modal);
    document.getElementById("closeModal").onclick = () => document.body.removeChild(modal);
  };

  try {
    const payload = {
      delete: rowsToDelete.map(prepareRow),
      update: rowsToUpdate.map(prepareRow),
      insert: rowsToInsert.map(prepareRow),
    };

    // DEBUG: ver el payload real que se envía
    console.log("Payload a enviar:", JSON.stringify(payload, null, 2));

    const response = await fetch(
      `http://localhost:8080/api/update-table/${selectedTable}`,
      {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
      }
    );

    const result = await response.json();

    if (!response.ok) {
      showErrorModal(result.error || "Error desconocido");
      return;
    }

    alert("✅ Base de datos actualizada correctamente");

    // result puede devolver:
    // - updatedData: array de filas nuevas/actualizadas con sus id reales (recomendado)
    // - deletedIds: array de ids eliminados (opcional, recomendado)
    // Si backend devuelve TODO el dataset, se puede reemplazar por completo.
    const updatedRows = result.updatedData || [];
    const deletedIds = result.deletedIds || [];

    // Hacemos merge: actualizamos prev rowData con los cambios recibidos
    setRowData((prev) => {
      // Mapa por _meta_id (para gestionar merges)
      const map = new Map(prev.map((r) => [r._meta_id, { ...r }]));

      // Aplicar borrados si vienen
      if (Array.isArray(deletedIds) && deletedIds.length) {
        deletedIds.forEach((id) => map.delete(id));
      }

      // Aplicar/añadir filas actualizadas o insertadas
      updatedRows.forEach((r) => {
        const meta = r.id; // id real devuelto por backend
        if (!meta && meta !== 0) return; // defensivo
        const existing = map.get(meta) || {};
        // Reemplazamos y normalizamos: guardamos id en _meta_id y marcamos ORIGINAL
        map.set(meta, {
          ...existing,
          ...r,
          _meta_id: r.id,
          _rowStatus: RowStatus.ORIGINAL,
        });
      });

      // Retornar array en orden: 
      // Mantengo orden de prev (filas que quedaron) y luego agrego nuevas que no estaban
      const resultArray = [];

      const prevIdsSeen = new Set();
      prev.forEach((p) => {
        const key = p._meta_id;
        if (map.has(key)) {
          resultArray.push(map.get(key));
          prevIdsSeen.add(key);
        }
      });

      // Añadir las filas nuevas que no estaban en prev (por ejemplo insert recientes)
      Array.from(map.entries()).forEach(([k, v]) => {
        if (!prevIdsSeen.has(k)) resultArray.push(v);
      });

      return resultArray;
    });
  } catch (err) {
    console.error("Error al actualizar la BBDD:", err);
    showErrorModal("❌ No se pudo conectar con el servidor.\n" + err.message);
  }
}
