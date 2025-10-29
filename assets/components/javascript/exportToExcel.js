import ExcelJS from "exceljs";

const exportToExcel = async (colDefs, gridApi, selectedTable = "datos") => {
  const workbook = new ExcelJS.Workbook();
  const worksheet = workbook.addWorksheet("Datos");

  worksheet.columns = colDefs.map(col => ({
    header: col.headerName || col.field,
    key: col.field,
    width: 20,
  }));

  // Solo filas filtradas
  gridApi.forEachNodeAfterFilter(node => {
    worksheet.addRow(node.data);
  });

  const buffer = await workbook.xlsx.writeBuffer();
  const blob = new Blob([buffer], {
    type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
  });

  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = `${selectedTable}.xlsx`;
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  URL.revokeObjectURL(url);
};

export default exportToExcel;