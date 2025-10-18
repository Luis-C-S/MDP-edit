// assets/components/javascript/loadTabledata.js
// Carga contenido de la tabla seleccionada

import { useState, useEffect } from "react";

export default function loadTabledata(selectedTable) {
    const [rowData, setRowData] = useState([]);
    const [colDefs, setColDefs] = useState([]);
    useEffect(() => {
        if (!selectedTable) return;

        fetch(`http://localhost:8080/tabla/${selectedTable}`)
            .then((res) => res.json())
            .then((data) => {
                // Añadimos un id único a cada fila al cargar
                const withIds = data.map((row, index) => ({
                    id: index + 1, 
                    ...row,
                }));

                setRowData(withIds);

                if (data.length > 0) {
                    const dynamicCols = Object.keys(data[0]).map((key) => ({
                        field: key,
                        sortable: true,
                        filter: true,
                        resizable: true,
                    }));
                    setColDefs(dynamicCols);
                } else {
                    setColDefs([]);
                }
            })
            .catch((err) => console.error("Error cargando tabla:", err));
    }, [selectedTable]);
    return { rowData, setRowData, colDefs };
}