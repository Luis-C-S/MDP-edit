//assets/components/javascript/exportToCSV.js

const exportToCsv = (colDefs, gridApi, selectedTable = "datos") => {
  const headers = colDefs.map(col => col.headerName || col.field);
  const fields = colDefs.map(col => col.field);

  let csvContent = headers.join(";") + "\n";

  gridApi.forEachNodeAfterFilter(node => {
    const row = fields.map(field => {
      const value = node.data[field];
      return value != null ? value : ""; // sin comillas, incluso si es string
    });
    csvContent += row.join(";") + "\n";
  });

  const blob = new Blob([csvContent], { type: "text/csv;charset=utf-8;" });

  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = `${selectedTable}.csv`;
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  URL.revokeObjectURL(url);
};

export default exportToCsv;