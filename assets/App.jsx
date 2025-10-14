import { Routes, Route } from "react-router-dom";
import Sidebar from "./components/Sidebar";
import FieldInspector from "./components/FieldInspector";
import PasteTable from "./components/PasteTable";

const App = () => {
  return (
    <div style={{ display: "flex", height: "100vh", position: "relative" }}>
      <Sidebar />
      <div
        style={{
          flex: 1,
          padding: "1rem",
          overflow: "auto",
          position: "relative",
        }}
      >
        <Routes>
          <Route path="/field-inspector" element={<FieldInspector />} />
          <Route path="/paste-table" element={<PasteTable />} />
        </Routes>
      </div>
    </div>
  );
};

export default App;
