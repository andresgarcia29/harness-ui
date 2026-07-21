#!/usr/bin/env bash
# Invariantes de estructura del panel: las vistas y el wizard de init existen,
# el router tiene la ruta init y el snapshot tipa init. Migrado desde el
# tests/run.sh de harness-installer al extraer harness-ui (ADR-0003): estas son
# invariantes de la UI, no del installer. Corre desde la raíz del repo.
set -u
cd "$(dirname "$0")/.."
fail=0
err() { echo "✗ $1"; fail=1; }

for v in dash tasks task-detail sessions session-detail costs new-task connections docs tools terminals; do
  [ -f "src/views/$v.tsx" ] || err "vista perdida: $v"
done
for v in index stepper step-shell log-tail; do
  [ -f "src/views/init/$v.tsx" ] || err "init perdido: $v"
done
for v in welcome github clone requirements discover agents mcps sessions done browse-dialog placeholder; do
  [ -f "src/views/init/steps/$v.tsx" ] || err "paso de init perdido: $v"
done
grep -q '"init"' src/lib/router.ts || err "la ruta init no está en el router"
grep -q 'init?: InitState' src/lib/harness.ts || err "el snapshot no tipa init"

[ "$fail" = 0 ] && echo "── estructura: 11 vistas + wizard init (9 pantallas) + router/tipos ✓"
exit $fail
