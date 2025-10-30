//assets/components/javascript/importToBBDD.js

const importToBBDD = async (event, selectedTable, onSuccess) => {
    const file = event.target.files[0];
    if (!file) return;

    const text = await file.text();
    const lines = text.split("\n").filter((line) => line.trim() !== "");
    const headers = lines[0].split(";").map((h) => h.trim());

    const data = lines.slice(1).map((line) => {
        const values = line.split(";").map((v) => v.trim());
        const row = {};
        headers.forEach((header, index) => {
            row[header] = values[index] || "";
        });
        return row;
    });

    try {
        const response = await fetch(`/api/import/${selectedTable}`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(data),
        });

        const result = await response.json();

        if (!response.ok || result.status !== "ok") {
            throw new Error(result.mensaje || "Error desconocido");
        }

        alert(
            `✅ Se han importado ${result.insertados} registros en ${result.tabla}`
        );

        if (onSuccess) onSuccess(result); // aquí se llama a reloadGrid desde FieldInspector
    } catch (error) {
        console.error("Error en la importación:", error);
        alert("❌ Error al importar los datos: " + error.message);
    }
};

export default importToBBDD;
