// assets/components/WorldMap.jsx
import React, { useState } from "react";
import { ComposableMap, Geographies, Geography, Marker } from "@vnedyalk0v/react19-simple-maps";
import geoData from "../data/world-countries.json";
import { geoCentroid } from "d3-geo";
import Selectores from "./Selectores.jsx";

const WorldMap = () => {
  const [hoveredCountry, setHoveredCountry] = useState(null);

  // Estados para el primer bloque de selectores
  const [selectedProducto1, setSelectedProducto1] = useState(null);
  const [selectedPerfil1, setSelectedPerfil1] = useState(null);
  const [selectedModalidad1, setSelectedModalidad1] = useState(null);
  const [selectedAmbito1, setSelectedAmbito1] = useState(null);
  const [selectedZona1, setSelectedZona1] = useState(null);
  const [paises1, setPaises1] = useState([]);

  // Estados para el segundo bloque de selectores
  const [selectedProducto2, setSelectedProducto2] = useState(null);
  const [selectedPerfil2, setSelectedPerfil2] = useState(null);
  const [selectedModalidad2, setSelectedModalidad2] = useState(null);
  const [selectedAmbito2, setSelectedAmbito2] = useState(null);
  const [selectedZona2, setSelectedZona2] = useState(null);
  const [paises2, setPaises2] = useState([]);

  return (
    <div style={{ display: "flex", width: "85%", margin: "0 auto" }}>

      <div
        className="info-producto-panel"
        style={{
          paddingTop: "2rem",
          width: "300px",
          display: "flex",
          flexDirection: "column",
          gap: "1rem",
          paddingRight: "1rem",
        }}
      >
        <div>
          <h4 style={{ marginBottom: "0.5rem" }}>Producto 1</h4>
          <Selectores
            selectedProducto={selectedProducto1}
            setSelectedProducto={setSelectedProducto1}
            selectedPerfil={selectedPerfil1}
            setSelectedPerfil={setSelectedPerfil1}
            selectedModalidad={selectedModalidad1}
            setSelectedModalidad={setSelectedModalidad1}
            selectedAmbito={selectedAmbito1}
            setSelectedAmbito={setSelectedAmbito1}
            selectedZona={selectedZona1}
            setSelectedZona={setSelectedZona1}
            onPaisesChange={setPaises1}
          />
        </div>

        <div>
          <h4 style={{ marginBottom: "0.5rem" }}>Producto 2</h4>
          <Selectores
            selectedProducto={selectedProducto2}
            setSelectedProducto={setSelectedProducto2}
            selectedPerfil={selectedPerfil2}
            setSelectedPerfil={setSelectedPerfil2}
            selectedModalidad={selectedModalidad2}
            setSelectedModalidad={setSelectedModalidad2}
            selectedAmbito={selectedAmbito2}
            setSelectedAmbito={setSelectedAmbito2}
            selectedZona={selectedZona2}
            setSelectedZona={setSelectedZona2}
            onPaisesChange={setPaises2}
          />
        </div>
      </div>

      <div style={{ flex: 1, backgroundColor: "#cce6ff" }}>
        <ComposableMap projection="geoEqualEarth" projectionConfig={{ scale: 150 }}>
          <Geographies geography={geoData}>
            {({ geographies }) =>
              geographies.map((geo, i) => {
                const iso = geo.properties?.iso_a3_eh;

                const inPaises1 = paises1.includes(iso);
                const inPaises2 = paises2.includes(iso);

                let fillColor = "#d2b48c"; // color por defecto

                if (inPaises1 && inPaises2) {
                  fillColor = "#FF0000"; // rojo si está en ambos
                } else if (inPaises2) {
                  fillColor = "#2196F3"; // azul si está solo en el segundo
                } else if (inPaises1) {
                  fillColor = "#4CAF50"; // verde si está solo en el primero
                }

                return (
                  <Geography
                    key={iso ?? `geo-${i}`}
                    geography={geo}
                    onMouseEnter={() => {
                      const name = geo.properties?.name;
                      const centroid = geoCentroid(geo);
                      setHoveredCountry({ iso, name, coordinates: centroid });
                    }}
                    onMouseLeave={() => setHoveredCountry(null)}
                    style={{
                      default: {
                        fill: fillColor,
                        stroke: "#835212ff",
                        strokeWidth: 0.5,
                        outline: "none",
                      },
                      hover: {
                        fill: "#F53",
                        stroke: "#F53",
                        strokeWidth: 1,
                        outline: "none",
                      },
                      pressed: {
                        fill: "#E42",
                        stroke: "#E42",
                        strokeWidth: 1,
                        outline: "none",
                      },
                    }}
                  />
                );
              })
            }
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
                }}
              >
                {hoveredCountry.iso} - {hoveredCountry.name}
              </text>
            </Marker>
          )}
        </ComposableMap>
      </div>
    </div>
  );
};


export default WorldMap;