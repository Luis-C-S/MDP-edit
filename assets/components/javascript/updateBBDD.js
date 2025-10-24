// assets/components/javascript/updateBBDD.js
// Envía a la BBDD las filas modificadas, nuevas o eliminadas,
import { RowStatus } from "./constants";

/**
 * Envía a la BBDD las filas modificadas, nuevas o eliminadas,
 * asegurando que los campos con metadatos código/descripción siempre se envíen como código.
 */
export default async function updateBBDD(selectedTable, rowData, setRowData) {
    if (!selectedTable) {
        alert("Selecciona una tabla primero.");
        return;
    }

    // Filtrar filas por estado
    const rowsToDelete = rowData.filter(r => r._rowStatus === RowStatus.DELETED);
    const rowsToUpdate = rowData.filter(r => r._rowStatus === RowStatus.MODIFIED);
    const rowsToInsert = rowData.filter(r => r._rowStatus === RowStatus.NEW);

    const totalChanges = rowsToDelete.length + rowsToUpdate.length + rowsToInsert.length;

    if (totalChanges === 0) {
        alert("No hay cambios pendientes para enviar.");
        return;
    }

    // 🔹 Construir mensaje de confirmación con detalle de cambios
    let message = "⚠️ Atención, vas a realizar los siguientes cambios en la BBDD:\n\n";
    if (rowsToDelete.length) message += `Borrar ${rowsToDelete.length} fila/s\n`;
    if (rowsToUpdate.length) message += `Modificar ${rowsToUpdate.length} fila/s\n`;
    if (rowsToInsert.length) message += `Añadir ${rowsToInsert.length} fila/s\n`;
    message += "\n¿Deseas continuar?";

    if (!window.confirm(message)) return;

    // 🔹 Función auxiliar para preparar fila antes de enviarla
    const prepareRow = (row) => {
        const newRow = { ...row };

        // Reemplazar campos lookup por el código
        Object.keys(newRow).forEach(key => {
            if (key.startsWith("_meta_") && key.endsWith("_code")) {
                const field = key.replace("_meta_", "").replace("_code", "");
                if (field in newRow) {
                    newRow[field] = newRow[key]; // siempre enviamos el código
                }
            }
        });

        // Eliminar campos meta, id y _rowStatus
        Object.keys(newRow)
            .filter(k => k.startsWith("_meta_") || k === "_rowStatus" || k === "id")
            .forEach(k => delete newRow[k]);

        return newRow;
    };

    // 🔹 Función para mostrar errores largos en modal
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
        const response = await fetch(`http://localhost:8080/api/update-table/${selectedTable}`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                delete: rowsToDelete.map(prepareRow),
                update: rowsToUpdate.map(prepareRow),
                insert: rowsToInsert.map(prepareRow),
            }),
        });

        const result = await response.json();

        if (response.ok) {
            alert("✅ Base de datos actualizada correctamente");
            setRowData(result.updatedData || []);
        } else {
            showErrorModal(result.error || "Error desconocido");
        }
    } catch (err) {
        console.error("Error al actualizar la BBDD:", err);
        showErrorModal("❌ No se pudo conectar con el servidor.\n" + err.message);
    }
}
