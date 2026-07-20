import path from "path"
import tailwindcss from "@tailwindcss/vite"
import react from "@vitejs/plugin-react"
import { defineConfig } from "vite"

// harness-ui es repo propio (ADR-0003). El build queda en ./dist; los
// consumidores (harness-daemon lo embebe; harness-installer lo copia a sus
// templates) lo toman de aquí. Node es herramienta de build, no de runtime:
// el usuario final nunca lo necesita.
export default defineConfig({
  plugins: [react(), tailwindcss()],
  resolve: { alias: { "@": path.resolve(__dirname, "./src") } },
  build: { outDir: "dist", emptyOutDir: true },
  base: "./",
})
