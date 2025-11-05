// assets/components/Selectores.jsx
import React, { useEffect, useState } from "react";
import Select from "react-select";

const Selectores = ({
  selectedProducto,
  setSelectedProducto,
  selectedPerfil,
  setSelectedPerfil,
  selectedModalidad,
  setSelectedModalidad,
  selectedAmbito,
  setSelectedAmbito,
  selectedZona,
  setSelectedZona,
  onPaisesChange, // función para devolver los países al padre
}) => {
  const [productos, setProductos] = useState([]);
  const [perfiles, setPerfiles] = useState([]);
  const [modalidades, setModalidades] = useState([]);
  const [ambitos, setAmbitos] = useState([]);
  const [zonas, setZonas] = useState([]);

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
        .catch((err) => console.error("Error al cargar perfiles:", err));
    } else {
      setPerfiles([]);
      setSelectedPerfil(null);
    }
  }, [selectedProducto]);

  // Cargar modalidades
  useEffect(() => {
    if (selectedProducto?.value && selectedPerfil?.value) {
      fetch(`/api/modalidad/${selectedProducto.value}/${selectedPerfil.value}`)
        .then((res) => res.json())
        .then(setModalidades)
        .catch((err) => console.error("Error al cargar modalidades:", err));
    } else {
      setModalidades([]);
      setSelectedModalidad(null);
    }
  }, [selectedProducto, selectedPerfil]);

  // Cargar ámbitos
  useEffect(() => {
    if (selectedProducto && selectedPerfil && selectedModalidad) {
      const codProductoComercial = `${selectedProducto.value}${selectedPerfil.value}`;
      const codModalidad = selectedModalidad?.value ?? null;
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

  // Cargar zonas
  useEffect(() => {
    if (selectedProducto && selectedPerfil && selectedModalidad && selectedAmbito) {
      const codProductoComercial = `${selectedProducto.value}${selectedPerfil.value}`;
      const codModalidad = selectedModalidad?.value ?? null;
      const codAmbito = selectedAmbito?.value ?? null;
      fetch(`/api/zonas?cod_producto_comercial=${codProductoComercial}&cod_modalidad=${codModalidad}&cod_ambito=${codAmbito}`)
        .then((res) => res.json())
        .then((data) => {
          const opciones = data.map(({ cod_zona_tarif, nom_zona_tarif }) => ({
            value: cod_zona_tarif,
            label: nom_zona_tarif,
          }));
          setZonas(opciones);
        });
    } else {
      setZonas([]);
      setSelectedZona(null);
    }
  }, [selectedProducto, selectedPerfil, selectedModalidad, selectedAmbito]);

  // Cargar países
  useEffect(() => {
    const params = new URLSearchParams();

    if (selectedZona) {
      params.append("cod_zona_tarif", selectedZona.value);
    } else {
      if (selectedProducto) params.append("selectedProducto", selectedProducto.value);
      if (selectedPerfil) params.append("selectedPerfil", selectedPerfil.value);
      if (selectedModalidad) params.append("selectedModalidad", selectedModalidad.value);
      if (selectedAmbito) params.append("selectedAmbito", selectedAmbito.value);
    }

    if (
      selectedZona ||
      (selectedProducto && selectedPerfil && selectedModalidad && selectedAmbito)
    ) {
      fetch(`/api/paises?${params.toString()}`)
        .then((res) => res.json())
        .then((data) => {
          const paises = data.map(({ cod_pais }) => cod_pais);
          onPaisesChange(paises); // enviar países al padre
        })
        .catch((err) => console.error("Error al cargar países:", err));
    } else {
      onPaisesChange([]); // limpiar si no hay selección válida
    }
  }, [selectedZona, selectedProducto, selectedPerfil, selectedModalidad, selectedAmbito]);

  return (
    <div className="p-3 mb-4 border rounded shadow-sm bg-light">
      <Select
        id="producto"
        options={productos}
        value={selectedProducto}
        onChange={setSelectedProducto}
        placeholder="Selecciona un producto"
        isClearable
      />
      <Select
        id="perfil"
        options={perfiles}
        value={selectedPerfil}
        onChange={setSelectedPerfil}
        placeholder="Selecciona un perfil"
        isClearable
        isDisabled={!selectedProducto}
      />
      <Select
        id="modalidad"
        options={modalidades}
        value={selectedModalidad}
        onChange={setSelectedModalidad}
        placeholder="Selecciona modalidad"
        isClearable
        isDisabled={!selectedProducto || !selectedPerfil}
      />
      <Select
        id="ambito"
        options={ambitos}
        value={selectedAmbito}
        onChange={setSelectedAmbito}
        placeholder="Selecciona un ámbito"
        isClearable
        isDisabled={!selectedProducto || !selectedPerfil || !selectedModalidad}
      />
      <Select
        id="zona"
        options={zonas}
        value={selectedZona}
        onChange={setSelectedZona}
        placeholder="Selecciona una zona"
        isClearable
        isDisabled={!selectedProducto || !selectedPerfil || !selectedModalidad || !selectedAmbito}
      />
    </div>
  );
};

export default Selectores;
