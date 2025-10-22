import { useState, useEffect, useRef } from "react";
import { RowStatus } from "./constants";

export default function loadTabledata(selectedTable) {
  const [rowData, setRowData] = useState([]);
  const [colDefs, setColDefs] = useState([]);
  const [showCodes, setShowCodes] = useState(false);
  const [lookups, setLookups] = useState({});
  const gridApiRef = useRef(null);

  const onGridReady = (params) => {
    gridApiRef.current = params.api;
  };

  useEffect(() => {
    if (!selectedTable) return;

    const fetchTable = fetch(`/tabla/${selectedTable}`).then((res) => res.json());
    const fetchLookups = fetch(`/api/lookups/${selectedTable}`).then((res) => res.json());

    Promise.all([fetchTable, fetchLookups])
      .then(([data, lookups]) => {
        if (!Array.isArray(data)) {
          console.error("Respuesta inesperada:", data);
          return;
        }

        setLookups(lookups);

        const enhancedRows = data.map((row, index) => {
          const newRow = { id: index + 1, _rowStatus: RowStatus.ORIGINAL, ...row };

          Object.keys(lookups).forEach((field) => {
            const lookupList = lookups[field];
            const codeValue = row[field];

            if (lookupList && codeValue !== undefined) {
              const found = lookupList.find((l) => l[field] === codeValue);
              if (found) {
                const descField = Object.keys(found).find((k) => k !== field);
                if (descField) {
                  newRow[`_meta_${field}_code`] = codeValue;
                  newRow[`_meta_${field}_desc`] = found[descField];
                }
              }
            }
          });

          return newRow;
        });

        setRowData(enhancedRows);

        if (enhancedRows.length > 0) {
          const dynamicCols = Object.keys(enhancedRows[0])
            .filter((key) => key !== "id" && key !== "_rowStatus" && !key.startsWith("_meta_"))
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
                      values: lookups[key].map((l) => {
                        const descField = Object.keys(l).find((k) => k !== key);
                        return showCodes ? l[key] : l[descField];
                      }),
                    }
                  : undefined,
                valueGetter: (params) => {
                  const metaDesc = params.data[`_meta_${key}_desc`];
                  const metaCode = params.data[`_meta_${key}_code`];
                  if (metaDesc && metaCode) {
                    return showCodes ? metaCode : metaDesc;
                  }
                  return params.data[key];
                },
                valueSetter: (params) => {
                  const selectedValue = params.newValue;
                  const lookupList = lookups[key];

                  const match =
                    lookupList &&
                    lookupList.find((l) => {
                      const descField = Object.keys(l).find((k) => k !== key);
                      return (
                        l[key] === selectedValue || l[descField] === selectedValue
                      );
                    });

                  if (match) {
                    const code = match[key];
                    const desc = match[Object.keys(match).find((k) => k !== key)];
                    params.data[`_meta_${key}_code`] = code;
                    params.data[`_meta_${key}_desc`] = desc;
                    params.data[key] = code;
                    return true;
                  }
                  return false;
                },
              };
            });

          setColDefs(dynamicCols);
        } else {
          setColDefs([]);
        }
      })
      .catch((err) => console.error("Error cargando datos o lookups:", err));
  }, [selectedTable]);

  useEffect(() => {
    setColDefs((prevCols) =>
      prevCols.map((col) => {
        const isLookup = lookups[col.field];
        if (!isLookup) return col;

        return {
          ...col,
          valueGetter: (params) => {
            const metaDesc = params.data[`_meta_${col.field}_desc`];
            const metaCode = params.data[`_meta_${col.field}_code`];
            if (metaDesc && metaCode) {
              return showCodes ? metaCode : metaDesc;
            }
            return params.data[col.field];
          },
          cellEditorParams: {
            values: lookups[col.field].map((l) => {
              const descField = Object.keys(l).find((k) => k !== col.field);
              return showCodes ? l[col.field] : l[descField];
            }),
          },
        };
      })
    );
  }, [showCodes, lookups]);

  const toggleShowCodes = () => {
    const api = gridApiRef.current;
    if (!api) {
      setShowCodes((prev) => !prev);
      return;
    }

    const currentFilters = api.getFilterModel();
    const newFilters = {};

    Object.entries(currentFilters).forEach(([field, filter]) => {
      const lookupList = lookups[field];
      if (!lookupList || !filter.filter) {
        newFilters[field] = filter;
        return;
      }

      const descField = lookupList.length > 0
        ? Object.keys(lookupList[0]).find((k) => k !== field)
        : null;

      if (!descField) {
        newFilters[field] = filter;
        return;
      }

      const translatedValue = lookupList.find((item) => {
        const code = item[field];
        const desc = item[descField];
        return showCodes
          ? code === filter.filter
          : desc === filter.filter;
      });

      if (translatedValue) {
        const newValue = showCodes
          ? translatedValue[descField]
          : translatedValue[field];

        newFilters[field] = {
          ...filter,
          filter: newValue,
        };
      } else {
        newFilters[field] = filter;
      }
    });

    api.setFilterModel(newFilters);
    setShowCodes((prev) => !prev);
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
