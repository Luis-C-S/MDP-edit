// assets/index.js
import React from "react";
import { createRoot } from "react-dom/client";
import App from "./App";

// Asegurarse de que el div root existe
let container = document.getElementById("root");
const root = createRoot(container);
root.render(<App />);
