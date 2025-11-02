import React, { useState, useEffect, useRef } from "react";
import Select from "react-select";
import { AgGridReact } from "ag-grid-react";
import "ag-grid-community/styles/ag-theme-quartz.css";
import { ModuleRegistry, AllCommunityModule } from "ag-grid-community";
ModuleRegistry.registerModules([AllCommunityModule]);

const InfoProducto = () => {
    const [productos, setProductos] = useState([]);
    const [selectedProducto, setSelectedProducto] = useState(null);
    const [perfiles, setPerfiles] = useState([]);
    const [selectedPerfil, setSelectedPerfil] = useState(null);
    const [modalidades, setModalidades] = useState([]);
    const [selectedModalidad, setSelectedModalidad] = useState(null);
    const [ambitos, setAmbitos] = useState([]);
    const [selectedAmbito, setSelectedAmbito] = useState(null);
    const [zonas, setZonas] = useState([]);
    const [pesos, setPesos] = useState([]);
    const [rowData, setRowData] = useState([]);

    const gridRef = useRef();

    // Cargar productos
    useEffect(() => {
        fetch("/api/producto")
            .then((res) => res.json())
            .then(setProductos)
            .catch((err) => console.error("Error al cargar productos:", err));
    }, []);

    // Cargar perfiles
    useEffect(() => {
        if (selectedProducto?.value) {
            fetch(`/api/perfil/${selectedProducto.value}`)
                .then((res) => res.json())
                .then(setPerfiles)
                .catch((err) =>
                    console.error("Error al cargar perfiles:", err)
                );
        } else {
            setPerfiles([]);
            setSelectedPerfil(null);
        }
    }, [selectedProducto]);

    // Cargar modalidades
    useEffect(() => {
        if (selectedProducto?.value && selectedPerfil?.value) {
            fetch(
                `/api/modalidad/${selectedProducto.value}/${selectedPerfil.value}`
            )
                .then((res) => res.json())
                .then(setModalidades)
                .catch((err) =>
                    console.error("Error al cargar modalidades:", err)
                );
        } else {
            setModalidades([]);
            setSelectedModalidad(null);
        }
    }, [selectedProducto, selectedPerfil]);

    // Cargar ámbitos
    useEffect(() => {
        if (selectedProducto && selectedPerfil && selectedModalidad) {
            const codProductoComercial = `${selectedProducto.value}${selectedPerfil.value}`;
            const codModalidad = selectedModalidad ? selectedModalidad.value : null;
            fetch(`/api/ambitos?cod_producto_comercial=${codProductoComercial}&cod_modalidad=${codModalidad}`)
                .then((res) => res.json())
                .then((data) => {
                    const opciones = data.map(({ cod_ambito, nom_ambito }) => ({
                        value: cod_ambito,
                        label: nom_ambito,
                    }));
                    setAmbitos(opciones);
                });
        } else {
            setAmbitos([]);
            setSelectedAmbito(null);
        }
    }, [selectedProducto, selectedPerfil, selectedModalidad]);

    // Cargar precios y preparar datos para AG Grid
    useEffect(() => {
        if (
            selectedProducto &&
            selectedPerfil &&
            selectedModalidad &&
            selectedAmbito
        ) {
            fetch(
                `/api/precios?producto=${selectedProducto.value}&perfil=${selectedPerfil.value}&modalidad=${selectedModalidad.value}&ambito=${selectedAmbito.value}`
            )
                .then((res) => res.json())
                .then((data) => {
                    const zonasSet = new Set();
                    const pesosSet = new Set();
                    const preciosMap = {};

                    data.forEach(({ zona, peso, precio }) => {
                        zonasSet.add(zona);
                        pesosSet.add(peso);
                        if (!preciosMap[peso]) preciosMap[peso] = {};
                        preciosMap[peso][zona] = precio;
                    });

                    const zonasArr = Array.from(zonasSet);
                    const pesosArr = Array.from(pesosSet);

                    setZonas(zonasArr);
                    setPesos(pesosArr);

                    // Preparar rowData para AG Grid
                    const rows = pesosArr.map((peso) => {
                        const row = { peso };
                        zonasArr.forEach((zona) => {
                            row[zona] = preciosMap[peso]?.[zona] ?? "-";
                        });
                        return row;
                    });
                    setRowData(rows);
                });
        } else {
            setZonas([]);
            setPesos([]);
            setRowData([]);
        }
    }, [selectedProducto, selectedPerfil, selectedModalidad, selectedAmbito]);

    // Definir columnas para AG Grid
    const colDefs = [
        {
            headerName: "Peso / Zona",
            field: "peso",
            width: 220,
            cellStyle: { fontWeight: "bold", backgroundColor: "#f4f4f4" },
        },
        ...zonas.map((zona) => ({
            headerName: zona,
            field: zona,
            width: 160,
            cellStyle: { textAlign: "center" },
        })),
    ];


    return (
        <div style={{ width: "80%", margin: "0 auto", paddingTop: "1rem", paddingBottom: "2rem" }}>
            <h1>Información de producto</h1>
            <div style={{ display: "flex", alignItems: "flex-start", gap: "1rem" }}>
                {/* Panel izquierdo con selects */}
                <div
                    className="info-producto-panel"
                    style={{
                        width: "300px",
                        display: "flex",
                        flexDirection: "column",
                        gap: "0.6rem",
                    }}
                >
                    <label htmlFor="producto">Producto</label>
                    <Select
                        id="producto"
                        options={productos}
                        value={selectedProducto}
                        onChange={setSelectedProducto}
                        placeholder="Selecciona un producto"
                        isClearable
                    />

                    <label htmlFor="perfil">Perfil</label>
                    <Select
                        id="perfil"
                        options={perfiles}
                        value={selectedPerfil}
                        onChange={setSelectedPerfil}
                        placeholder="Selecciona un perfil"
                        isClearable
                        isDisabled={!selectedProducto}
                    />

                    <label htmlFor="modalidad">Modalidad</label>
                    <Select
                        id="modalidad"
                        options={modalidades}
                        value={selectedModalidad}
                        onChange={setSelectedModalidad}
                        placeholder="Selecciona una modalidad"
                        isClearable
                        isDisabled={!selectedProducto || !selectedPerfil}
                    />

                    <label htmlFor="ambito">Ámbito</label>
                    <Select
                        id="ambito"
                        options={ambitos}
                        value={selectedAmbito}
                        onChange={setSelectedAmbito}
                        placeholder="Selecciona un ámbito"
                        isClearable
                        isDisabled={!selectedProducto || !selectedPerfil}
                    />
                </div>

                {/* Panel derecho con AG Grid */}
                {rowData.length > 0 && (
                    <div style={{ flexGrow: 1 }}>
                        <h3 style={{ marginBottom: "0.8rem" }}>Tabla de precios</h3>
                        <div
                            className="ag-theme-quartz"
                            style={{
                                height: "500px",
                                width: "80%",
                                marginBottom: "3rem",
                                overflow: "auto",
                            }}
                        >
                            <AgGridReact
                                ref={gridRef}
                                rowData={rowData}
                                columnDefs={[
                                    {
                                        ...colDefs[0],
                                        pinned: "left",
                                        wrapHeaderText: true,
                                        autoHeaderHeight: true,
                                        cellStyle: { textAlign: "left", paddingLeft: "0.5rem" },
                                    },
                                    ...colDefs.slice(1).map((col) => ({
                                        ...col,
                                        wrapHeaderText: true,
                                        autoHeaderHeight: true,
                                        cellStyle: {
                                            textAlign: "right",
                                            paddingRight: "0.5rem",
                                        },
                                        valueFormatter: (params) =>
                                            typeof params.value === "number"
                                                ? params.value.toLocaleString("es-ES", {
                                                    style: "currency",
                                                    currency: "EUR",
                                                    minimumFractionDigits: 2,
                                                })
                                                : params.value,
                                    })),
                                ]}
                                domLayout="normal"
                                defaultColDef={{
                                    resizable: true,
                                    autoHeaderHeight: true,
                                }}
                                suppressRowClickSelection={true}
                                rowSelection="none"
                                headerHeight={null}
                                pinnedTopRowData={[]}
                            />
                        </div>
                    </div>
                )}
            </div>
        </div>
    );
};

export default InfoProducto;
