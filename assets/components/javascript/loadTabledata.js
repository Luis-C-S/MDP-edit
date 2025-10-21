// assets/components/javascript/loadTabledata.js
// Carga contenido de la tabla seleccionada y permite alternar entre mostrar códigos o nombres
// Mantiene orden y filtros al cambiar vista; usa un filtro temporal por id para preservar filas visibles.

import { useState, useEffect, useRef } from "react";
import { RowStatus } from "./constants";

export default function loadTabledata(selectedTable) {
  const [rowData, setRowData] = useState([]);
  const [colDefs, setColDefs] = useState([]);
  const [showCodes, setShowCodes] = useState(false);
  const gridApiRef = useRef(null); // referencia al grid API
  const [lookups, setLookups] = useState({});

  // Usar esto en AgGridReact: onGridReady={onGridReady}
  const onGridReady = (params) => {
    gridApiRef.current = params.api;
  };

  // Efecto principal: carga datos y lookups (se ejecuta al cambiar de tabla)
  useEffect(() => {
    if (!selectedTable) {
      setRowData([]);
      setColDefs([]);
      setLookups({});
      return;
    }

    const fetchTable = fetch(`/tabla/${selectedTable}`).then((res) => res.json());
    const fetchLookups = fetch(`/api/lookups/${selectedTable}`).then((res) => res.json());

    Promise.all([fetchTable, fetchLookups])
      .then(([data, lookups]) => {
        if (!Array.isArray(data)) {
          console.error("Respuesta inesperada:", data);
          setRowData([]);
          setColDefs([]);
          setLookups({});
          return;
        }

        setLookups(lookups);

        // 1️⃣ Construir filas con metadatos
        const enhancedRows = data.map((row, index) => {
          const newRow = { id: index + 1, _rowStatus: RowStatus.ORIGINAL, ...row };

          Object.keys(lookups).forEach((field) => {
            const lookupList = lookups[field];
            const codeValue = row[field];

            if (lookupList && codeValue !== undefined) {
              const found = lookupList.find((l) => l[field] === codeValue);
              if (found) {
                const descField = Object.keys(found).find((k) => k !== field);
                newRow[`_meta_${field}_code`] = codeValue;
                newRow[`_meta_${field}_desc`] = found[descField];
              }
            }
          });

          return newRow;
        });

        setRowData(enhancedRows);

        // 2️⃣ Definir columnas dinámicas. Incluimos la columna "id" oculta con agSetColumnFilter
        if (enhancedRows.length > 0) {
          const visibleKeys = Object.keys(enhancedRows[0]).filter(
            (k) => k !== "_rowStatus" && !k.startsWith("_meta_")
          );

          // Creamos una columna oculta 'id' con filtro tipo Set para poder filtrar por id más tarde
          const idCol = {
            field: "id",
            headerName: "id",
            hide: true,
            filter: "agSetColumnFilter",
            sortable: false,
            resizable: false,
          };

          const dynamicCols = [idCol].concat(
            visibleKeys
              .filter((key) => key !== "id")
              .map((key) => {
                const isLookup = Object.keys(lookups).includes(key);

                return {
                  field: key,
                  headerName: key,
                  sortable: true,
                  filter: true,
                  resizable: true,
                  editable: isLookup,
                  cellEditor: isLookup ? "agSelectCellEditor" : undefined,
                  cellEditorParams: isLookup
                    ? {
                        values: lookups[key].map((l) =>
                          showCodes ? l[key] : l[Object.keys(l).find((k) => k !== key)]
                        ),
                      }
                    : undefined,
                  valueGetter: (params) => {
                    const metaDesc = params.data[`_meta_${key}_desc`];
                    const metaCode = params.data[`_meta_${key}_code`];
                    if (metaDesc !== undefined && metaCode !== undefined) {
                      return showCodes ? metaCode : metaDesc;
                    }
                    return params.data[key];
                  },
                  valueSetter: (params) => {
                    const selectedValue = params.newValue;
                    const lookupList = lookups[key];

                    const match = lookupList && lookupList.find((l) => {
                      const descField = Object.keys(l).find((k) => k !== key);
                      return l[key] === selectedValue || l[descField] === selectedValue;
                    });

                    if (match) {
                      const code = match[key];
                      const desc = match[Object.keys(match).find((k) => k !== key)];
                      params.data[`_meta_${key}_code`] = code;
                      params.data[`_meta_${key}_desc`] = desc;
                      // Guardamos el código como valor "real" en la data; valueGetter mostrará lo que toque
                      params.data[key] = code;
                      return true;
                    }
                    return false;
                  },
                };
              })
          );

          setColDefs(dynamicCols);
        } else {
          setColDefs([]);
        }
      })
      .catch((err) => {
        console.error("Error cargando datos o lookups:", err);
        setRowData([]);
        setColDefs([]);
        setLookups({});
      });
  }, [selectedTable]);

  // Efecto secundario: actualiza valueGetter de las columnas cuando cambia showCodes
  useEffect(() => {
    setColDefs((prevCols) =>
      prevCols.map((col) => {
        // no tocar la columna id oculta
        if (col.field === "id") return col;
        return {
          ...col,
          valueGetter: (params) => {
            const metaDesc = params.data[`_meta_${col.field}_desc`];
            const metaCode = params.data[`_meta_${col.field}_code`];
            if (metaDesc !== undefined && metaCode !== undefined) {
              return showCodes ? metaCode : metaDesc;
            }
            return params.data[col.field];
          },
          // Actualizamos también cellEditorParams si es lookup para que muestre la lista correcta
          cellEditorParams:
            col.cellEditor === "agSelectCellEditor" && lookups[col.field]
              ? {
                  values: lookups[col.field].map((l) =>
                    showCodes ? l[col.field] : l[Object.keys(l).find((k) => k !== col.field)]
                  ),
                }
              : col.cellEditorParams,
        };
      })
    );
    // no tocamos rowData; sólo actualizamos las columnas
  }, [showCodes, lookups]);

  // toggleShowCodes: preserva filas visibles, filtro y orden.
  const toggleShowCodes = () => {
    const api = gridApiRef.current;
    if (!api) {
      setShowCodes((s) => !s);
      return;
    }

    // 1) obtener estado actual de orden y filtros
    const sortState = api.getColumnState ? api.getColumnState() : null;
    const filterModel = api.getFilterModel ? api.getFilterModel() : null;

    // 2) obtener lista de ids actualmente visibles (después de filtros y orden)
    const visibleIds = [];
    api.forEachNodeAfterFilterAndSort((node) => {
      if (node.data && node.data.id !== undefined) visibleIds.push(String(node.data.id));
    });

    // 3) alternamos el modo
    setShowCodes((prev) => !prev);

    // 4) después de un pequeño retardo dejamos que React/AGGrid re-rendericen columnas,
    //    luego aplicamos el filtro temporal por id y restauramos sort + filtros.
    setTimeout(() => {
      // Restaurar orden si lo tenemos
      if (sortState && api.applyColumnState) {
        api.applyColumnState({ state: sortState, applyOrder: true });
      }

      // Fusionar el filterModel existente con un filtro en id que incluya visibleIds
      // Si no hay visibleIds (tabla vacía), no aplicamos el id-filter.
      let mergedFilter = filterModel || {};

      if (visibleIds.length > 0) {
        // Añadimos o reemplazamos la entrada 'id' en filterModel.
        mergedFilter = {
          ...mergedFilter,
          id: { values: visibleIds }, // agSetColumnFilter espera { values: [..] }
        };
      }

      // Aplicar filtros
      if (api.setFilterModel) {
        api.setFilterModel(mergedFilter);
      }

      // Opcional: eliminar el filtro temporal de 'id' tras un intervalo para que el usuario pueda seguir filtrando
      // Si prefieres que el id-filter permanezca hasta que el usuario lo quite, comenta las siguientes líneas.
      setTimeout(() => {
        try {
          const currentFilter = api.getFilterModel ? api.getFilterModel() : null;
          if (currentFilter && currentFilter.id) {
            // eliminamos la clave 'id' y dejamos el resto
            const { id, ...rest } = currentFilter;
            api.setFilterModel(rest);
          }
        } catch (e) {
          // no bloquear si falla
          console.warn("No se pudo quitar el filtro temporal por id:", e);
        }
      }, 2000); // 700ms mantiene la visibilidad estable; ajusta si quieres más/menos tiempo
    }, 2000); // 80ms suele ser suficiente para que React actualice columnas; ajustar si hiciera falta
  };

  return {
    rowData,
    setRowData,
    colDefs,
    showCodes,
    toggleShowCodes,
    onGridReady,
  };
}
