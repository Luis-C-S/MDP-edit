import React, { useState } from "react";
import { useTable } from "react-table";

const PasteTable = () => {
  const [data, setData] = useState([]);

  const columns = React.useMemo(
    () => [
      { Header: "Campo 1", accessor: "col1" },
      { Header: "Campo 2", accessor: "col2" },
      { Header: "Campo 3", accessor: "col3" },
    ],
    []
  );

  const handlePaste = (e) => {
    e.preventDefault();
    const clipboardData = e.clipboardData.getData("Text");

    const rows = clipboardData
      .trim()
      .split("\n")
      .map((row) => row.split("\t"));

    const newData = rows.map((cols) => ({
      col1: cols[0] || "",
      col2: cols[1] || "",
      col3: cols[2] || "",
    }));

    setData(newData);
  };

  const { getTableProps, getTableBodyProps, headerGroups, rows, prepareRow } =
    useTable({ columns, data });

  return (
    <div className="container mt-4">
      <h2>Pega datos desde Excel</h2>
      <div
        onPaste={handlePaste}
        tabIndex={0}
        style={{
          border: "2px dashed #ccc",
          padding: "1rem",
          marginBottom: "1rem",
          cursor: "pointer",
        }}
      >
        Haz clic aquí y pega (Ctrl+V) los datos desde Excel
      </div>

      <table {...getTableProps()} className="table table-bordered">
        <thead>
          {headerGroups.map((group) => (
            <tr {...group.getHeaderGroupProps()}>
              {group.headers.map((column) => (
                <th {...column.getHeaderProps()}>{column.render("Header")}</th>
              ))}
            </tr>
          ))}
        </thead>
        <tbody {...getTableBodyProps()}>
          {rows.map((row) => {
            prepareRow(row);
            return (
              <tr {...row.getRowProps()}>
                {row.cells.map((cell) => (
                  <td {...cell.getCellProps()}>{cell.render("Cell")}</td>
                ))}
              </tr>
            );
          })}
        </tbody>
      </table>
    </div>
  );
};

export default PasteTable;