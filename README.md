# harness-ui

[![license](https://img.shields.io/github/license/andresgarcia29/harness-ui)](LICENSE)
![React](https://img.shields.io/badge/React-20232a?logo=react&logoColor=61dafb)
![TypeScript](https://img.shields.io/badge/TypeScript-3178c6?logo=typescript&logoColor=white)
![Vite](https://img.shields.io/badge/Vite-646cff?logo=vite&logoColor=white)

**One dashboard for a fleet of coding agents: what's running, what's waiting on you, and what it costs.**

`harness-ui` is the web panel of the harness. It connects to any number of
[`harness-daemon`](https://github.com/andresgarcia29/harness-daemon) instances, local or on remote machines
over SSH-forwarded ports, and shows every agent session, task, phase, gate and dollar in one place.

## Highlights

- **Fleet view.** One UI, N daemons. Switch machines and the whole page follows the selected host.
- **Live terminals.** Agent panes rendered with ANSI colour, with interrupt and close controls.
- **Typed contract.** `src/lib/contract.gen.ts` is generated from the daemon's Go structs (via tygo), so the wire
  format has a single source of truth. Resync with `scripts/sync-contract.sh`; details in `src/lib/contract.README.md`.
- **No app-level auth by design.** SSH keys are the auth; daemons only listen on `127.0.0.1`.
- **Zero runtime dependencies for users.** Node is a build tool only: the daemon embeds the compiled `dist/` and serves it.

## How it fits

```
harness-creator  ──►  harness-daemon  ──►  harness-ui
(installer)          (Go collector + API,   (this repo: the panel the
                      embeds dist/)          daemon serves)
```

## Build

```bash
npm ci
npm run build   # → dist/ (build artifact, gitignored)
npm run dev     # local development with HMR
```

Before changing the interface, read [style.md](./style.md): the visual system, the improvement process and the
validation checklist.

## License

[MIT](LICENSE)
