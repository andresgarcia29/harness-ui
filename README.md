# harness-ui — el panel del harness corvux

Cliente **fleet** del harness: una UI que se conecta a N daemons (`harness-daemon`)
por puertos SSH-forwardeados (herdr). Es un frontend Vite/React independiente.

> Antes de modificar la interfaz de Corvux, lee y aplica [style.md](./style.md). Incluye el sistema visual, el proceso obligatorio de mejora y el checklist de validación.

## Arquitectura (ADR-0003 del workspace corvux)

- **Fuente de verdad de la UI del panel.** Extraído de `harness-installer/templates/ui/web`
  vía `git subtree split` (historia preservada).
- **Consumidores** (dirección `creator → daemon → ui`): `harness-daemon` embebe el
  `dist/` compilado y lo sirve en `127.0.0.1`; `harness-installer` lo copia a sus
  templates para materializarlo en cada workspace.
- **Contrato de tipos daemon→UI:** `src/lib/contract.gen.ts` se genera desde los
  structs Go del daemon (`harness-daemon/contract`, vía tygo). El daemon es la
  fuente de verdad del wire. Resync: `scripts/sync-contract.sh`. Detalle en
  `src/lib/contract.README.md`.
- **Auth:** ninguna a nivel app — las llaves SSH (herdr) son la auth; el daemon
  sigue `127.0.0.1-only`.

## Build

`npm ci && npm run build` → `dist/` (artefacto, gitignoreado). Node es herramienta
de build, no de runtime: el usuario final nunca lo necesita.

---

This project provides a setup to get React working in Vite with HMR and some Oxlint rules.

Currently, two official plugins are available:

- [@vitejs/plugin-react](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react) uses [Oxc](https://oxc.rs)
- [@vitejs/plugin-react-swc](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react-swc) uses [SWC](https://swc.rs/)

## React Compiler

The React Compiler is not enabled on this template because of its impact on dev & build performances. To add it, see [this documentation](https://react.dev/learn/react-compiler/installation).

## Expanding the Oxlint configuration

If you are developing a production application, we recommend enabling type-aware lint rules by installing `oxlint-tsgolint` and editing `.oxlintrc.json`:

```json
{
  "$schema": "./node_modules/oxlint/configuration_schema.json",
  "plugins": ["react", "typescript", "oxc"],
  "options": {
    "typeAware": true
  },
  "rules": {
    "react/rules-of-hooks": "error",
    "react/only-export-components": ["warn", { "allowConstantExport": true }]
  }
}
```

See the [Oxlint rules documentation](https://oxc.rs/docs/guide/usage/linter/rules) for the full list of rules and categories.
