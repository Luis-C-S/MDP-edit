import React, { useState, useEffect } from "react";
import Select from "react-select";

const InfoProducto = () => {
    const [productos, setProductos] = useState([]);
    const [selectedProducto, setSelectedProducto] = useState(null);
    const [perfiles, setPerfiles] = useState([]);
    const [selectedPerfil, setSelectedPerfil] = useState(null);
    const [modalidades, setModalidades] = useState([]);
    const [selectedModalidad, setSelectedModalidad] = useState(null);

    // Cargar productos al montar
    useEffect(() => {
        fetch("/api/producto")
            .then(response => {
                if (!response.ok) throw new Error("Error al obtener productos");
                return response.json();
            })
            .then(data => setProductos(data))
            .catch(error => console.error("Error al cargar productos:", error));
    }, []);

    // Cargar perfiles cuando se selecciona un producto
    useEffect(() => {
        if (selectedProducto?.value) {
            fetch(`/api/perfil/${selectedProducto.value}`)
                .then(response => {
                    if (!response.ok) throw new Error("Error al obtener perfiles");
                    return response.json();
                })
                .then(data => setPerfiles(data))
                .catch(error => console.error("Error al cargar perfiles:", error));
        } else {
            setPerfiles([]);
            setSelectedPerfil(null);
        }
    }, [selectedProducto]);

    // Cargar modalidades cuando se selecciona un producto
    useEffect(() => {
        if (selectedProducto?.value && selectedPerfil?.value) {
            fetch(`/api/modalidad/${selectedProducto.value}/${selectedPerfil.value}`)
                .then(response => {
                    if (!response.ok) throw new Error("Error al obtener modalidades");
                    return response.json();
                })
                .then(data => setModalidades(data))
                .catch(error => console.error("Error al cargar modalidades:", error));
        } else {
            setModalidades([]);
            setSelectedModalidad(null);
        }
    }, [selectedProducto, selectedPerfil]);


    return (
        <div className="container mt-1" style={{ paddingBottom: "2rem" }}>
            <h1>Información de producto</h1>
            <div
                className="info-producto-panel"
                style={{
                    width: "25%",
                    minWidth: "250px",
                    display: "flex",
                    flexDirection: "column",
                    gap: "0.5rem",
                }}
            >
                <div style={{ display: "flex", flexDirection: "column" }}>
                    <label htmlFor="producto" style={{ marginBottom: "0.2rem" }}>
                        Producto
                    </label>
                    <Select
                        id="producto"
                        options={productos}
                        value={selectedProducto}
                        onChange={setSelectedProducto}
                        placeholder="Selecciona un producto"
                        isClearable
                        closeMenuOnSelect
                        blurInputOnSelect
                        filterOption={(option, inputValue) =>
                            option.label.toLowerCase().includes(inputValue.toLowerCase())
                        }
                    />
                </div>

                <div style={{ display: "flex", flexDirection: "column", marginTop: "0.5rem" }}>
                    <label htmlFor="perfil" style={{ marginBottom: "0.2rem" }}>
                        Perfil
                    </label>
                    <Select
                        id="perfil"
                        options={perfiles}
                        value={selectedPerfil}
                        onChange={setSelectedPerfil}
                        placeholder="Selecciona un perfil"
                        isClearable
                        closeMenuOnSelect
                        blurInputOnSelect
                        isDisabled={!selectedProducto}
                        filterOption={(option, inputValue) =>
                            option.label.toLowerCase().includes(inputValue.toLowerCase())
                        }
                    />
                </div>
                <div style={{ display: "flex", flexDirection: "column", marginTop: "0.5rem" }}>
                    <label htmlFor="modalidad" style={{ marginBottom: "0.2rem" }}>
                        Modalidad
                    </label>
                    <Select
                        id="modalidad"
                        options={modalidades}
                        value={selectedModalidad}
                        onChange={setSelectedModalidad}
                        placeholder="Selecciona una modalidad"
                        isClearable
                        closeMenuOnSelect
                        blurInputOnSelect
                        isDisabled={!selectedProducto || !selectedPerfil}
                        filterOption={(option, inputValue) =>
                            option.label.toLowerCase().includes(inputValue.toLowerCase())
                        }
                    />
                </div>
            </div>
        </div>
    );
};

export default InfoProducto;