// assets/components/WorldMap.jsx

import React, { useState, useEffect, useRef } from "react";
import Select from "react-select";
import { ComposableMap, Geographies, Geography } from '@vnedyalk0v/react19-simple-maps';
import geoData from '../data/world-countries.json';
import { geoCentroid } from "d3-geo";
import { Marker } from "@vnedyalk0v/react19-simple-maps";

const WorldMap = () => {

  const [productos, setProductos] = useState([]);
  const [selectedProducto, setSelectedProducto] = useState(null);
  const [perfiles, setPerfiles] = useState([]);
  const [selectedPerfil, setSelectedPerfil] = useState(null);
  const [modalidades, setModalidades] = useState([]);
  const [selectedModalidad, setSelectedModalidad] = useState(null);
  const [ambitos, setAmbitos] = useState([]);
  const [selectedAmbito, setSelectedAmbito] = useState(null);
  const [zonas, setZonas] = useState([]);
  const [selectedZona, setSelectedZona] = useState(null);
  const [paises, setPaises] = useState([]);
  const [hoveredCountry, setHoveredCountry] = useState(null);

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

  // Cargar zonas
  useEffect(() => {
    if (selectedProducto && selectedPerfil && selectedModalidad && selectedAmbito) {
      const codProductoComercial = `${selectedProducto.value}${selectedPerfil.value}`;
      const codModalidad = selectedModalidad ? selectedModalidad.value : null;
      const codAmbito = selectedAmbito ? selectedAmbito.value : null;
      fetch(`/api/zonas?cod_producto_comercial=${codProductoComercial}&cod_modalidad=${codModalidad}&cod_ambito=${codAmbito}`)
        .then((res) => res.json())
        .then((data) => {
          console.log("Zonas recibidas:", data);
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

  // Cargar paises
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
          console.log("Paises recibidos:", data);
          const paises = data.map(({ cod_pais }) => cod_pais);
          setPaises(paises);
          // Si necesitas también los nombres de zona tarifaria:
          const zonas = [...new Set(data.map(({ nom_zona_tarif }) => nom_zona_tarif))];
          console.log("Zonas tarifarias:", zonas);
          // Puedes guardar zonas en otro estado si lo necesitas
        })
        .catch((err) => console.error("Error al cargar países:", err));
    } else {
      setPaises([]);
    }
  }, [selectedZona, selectedProducto, selectedPerfil, selectedModalidad, selectedAmbito]);



  return (
    <div
      style={{
        display: 'flex',
        width: '85%',
        margin: '0 auto',
      }}
    >
      <div
        className="info-producto-panel"
        style={{
          paddingTop: "2rem",
          width: "300px",
          display: "flex",
          flexDirection: "column",
          gap: "0.6rem",
          paddingRight: "1rem",
        }}
      >
        <div className="p-3 mb-4 border rounded shadow-sm bg-light">
          <label htmlFor="producto">Producto 1</label>
          <div className="mb-2">
            <Select
              id="producto"
              options={productos}
              value={selectedProducto}
              onChange={setSelectedProducto}
              placeholder="Selecciona un producto"
              isClearable
            />
          </div>

          <div className="mb-2">

            {/* <label htmlFor="perfil">Perfil</label> */}
            <Select
              id="perfil"
              options={perfiles}
              value={selectedPerfil}
              onChange={setSelectedPerfil}
              placeholder="Selecciona un perfil"
              isClearable
              isDisabled={!selectedProducto}
            />
          </div>

          <div className="mb-2">
            {/* <label htmlFor="modalidad">Modalidad</label> */}
            <Select
              id="modalidad"
              options={modalidades}
              value={selectedModalidad}
              onChange={setSelectedModalidad}
              placeholder="Selecciona modalidad"
              isClearable
              isDisabled={!selectedProducto || !selectedPerfil}
            />
          </div>

          <div className="mb-2">
            {/* <label htmlFor="ambito">Ámbito</label> */}
            <Select
              id="ambito"
              options={ambitos}
              value={selectedAmbito}
              onChange={setSelectedAmbito}
              placeholder="Selecciona un ámbito"
              isClearable
              isDisabled={!selectedProducto || !selectedPerfil || !selectedModalidad}
            />
          </div>

          <div className="mb-2">
            {/* <label htmlFor="zona">Zona</label> */}
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
        </div>
      </div>


      <div style={{ flex: 1, backgroundColor: "#cce6ff" }}>
        <ComposableMap projection="geoEqualEarth" projectionConfig={{ scale: 150 }}>
          <Geographies geography={geoData}>
            {({ geographies }) => {
              console.log('Geographies:', geographies.length);
              return geographies.map((geo, i) => (

                <Geography
                  key={geo.properties?.iso_a3_eh ?? `geo-${i}`}
                  geography={geo}
                  onMouseEnter={() => {
                    const iso = geo.properties?.iso_a3_eh;
                    const name = geo.properties?.name;
                    const centroid = geoCentroid(geo);
                    setHoveredCountry({ iso, name, coordinates: centroid });
                  }}
                  onMouseLeave={() => {
                    setHoveredCountry(null);
                  }}
                  style={{
                    default: {
                      fill: paises?.includes(geo.properties?.iso_a3_eh) ? '#4CAF50' : '#d2b48c',
                      stroke: '#835212ff',
                      strokeWidth: 0.5,
                      outline: 'none',
                    },
                    hover: {
                      fill: paises.includes(geo.properties?.iso_a3_eh) ? '#66BB6A' : 'transparent',
                      stroke: '#F53',
                      strokeWidth: 1,
                      outline: 'none',
                    },
                    pressed: {
                      fill: paises.includes(geo.properties?.iso_a3_eh) ? '#388E3C' : 'transparent',
                      stroke: '#E42',
                      strokeWidth: 1,
                      outline: 'none',
                    },
                  }}
                />

              ));
            }}
          </Geographies>
          {hoveredCountry && (
            <Marker coordinates={hoveredCountry.coordinates}>
              <text
                textAnchor="middle"
                style={{
                  fontFamily: "Arial",
                  fontSize: 10,
                  fill: "#333",
                  pointerEvents: "none",
                  background: "#fff",
                }}
              >
                {hoveredCountry.iso} - {hoveredCountry.name}
              </text>
            </Marker>
          )}
        </ComposableMap>
      </div>
    </div >
  );
};

export default WorldMap;