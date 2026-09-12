#!/usr/bin/env bash
# Evidencia de la verificación del plan aplicado (OUTPUTs/30), corrida sobre el árbol de trabajo
set -uo pipefail
cd /home/fernando/workspaces/workspace-dev/IA/SDD/IA.SDD

echo "=== 1. git diff --stat contra main (lo aplicado) ==="
git diff --stat main

echo
echo "=== 2. Fidelidad del snapshot _legacy/13.11/ contra main ==="
total=0; fail=0
for f in $(find _legacy/13.11 -type f); do
  rel=${f#_legacy/13.11/}
  total=$((total+1))
  mainblob=$(git rev-parse main:"$rel" 2>/dev/null) || { echo "MISSING IN MAIN: $rel"; fail=$((fail+1)); continue; }
  fileblob=$(git hash-object "$f")
  [ "$mainblob" != "$fileblob" ] && { echo "DIFFERS: $rel"; fail=$((fail+1)); }
done
echo "total=$total fail=$fail"
echo "archivos de main fuera de exclusiones:"
git ls-tree -r --name-only main | grep -v '^_legacy/' | grep -vE '^(CHANGELOG\.md|\.gitignore|vs\.bat)$' | wc -l

echo
echo "=== 3. Criterio 1 del reporte 28: enum/interp en §10 de Vocabulario-Rules.md (13.12) ==="
awk '/^## §10 Criterios de aceptación/{f=1} /^## §11/{f=0} f' SDD/Devs/Rules/Vocabulario-Rules.md | grep -E '^- \[ \]' | grep -c '\[enumerable\]'
awk '/^## §10 Criterios de aceptación/{f=1} /^## §11/{f=0} f' SDD/Devs/Rules/Vocabulario-Rules.md | grep -E '^- \[ \]' | grep -c '\[interpretativo\]'

echo
echo "=== Mismo recuento contra 13.10 (476f927), para contraste ==="
git show 476f927:SDD/Devs/Rules/Vocabulario-Rules.md | awk '/^## §10 Criterios de aceptación/{f=1} /^## §11/{f=0} f' | grep -E '^- \[ \]' | grep -c '\[enumerable\]'
git show 476f927:SDD/Devs/Rules/Vocabulario-Rules.md | awk '/^## §10 Criterios de aceptación/{f=1} /^## §11/{f=0} f' | grep -E '^- \[ \]' | grep -c '\[interpretativo\]'

echo
echo "=== 4. Criterio 4: costo de calificar en Migracion-Rules.md y Master-Prompt-Migracion.md ==="
grep -o procedencia SDD/Devs/Rules/Migracion-Rules.md | wc -l
grep -o procedencia SDD/Devs/Orchestrator/Master-Prompt-Migracion.md | wc -l

echo
echo "=== 5. Criterio 6: migración disjunta declarada en §9.6 ==="
grep -n 'disjunt' SDD/Devs/Rules/Vocabulario-Rules.md

echo
echo "=== 6. Integridad de registro (comprobación 10) en los seis archivos tocados ==="
for f in SDD/Devs/Rules/Vocabulario-Rules.md SDD/Devs/Orchestrator/Master-Prompt.md SDD/Devs/Rules/Mesa-Rules.md SDD/Guides/SDD-Development-Guide.md SDD/Guides/SDD-User-Guide.md SDD/Devs/Rules/Catalogo-De-Criterios.md; do
  echo "--- $f ---"
  grep -m1 -E '\*\*Versi[oó]n' "$f"
  grep -E '^\| [0-9]+\.[0-9]+ \|' "$f" | tail -1 | cut -c1-120
done

echo
echo "=== 7. No hay artefacto ejecutable nuevo (§II.7) ==="
find SDD -type f -not -name '*.md'

echo
echo "=== 8. Diff completo de archivos tocados, contrastado contra el plan de 20-Plan-De-Aplicacion.md ==="
git diff --stat main -- CHANGELOG.md SDD/Devs/Orchestrator/Master-Prompt.md SDD/Devs/Rules/Catalogo-De-Criterios.md SDD/Devs/Rules/Mesa-Rules.md SDD/Devs/Rules/Vocabulario-Rules.md SDD/Guides/SDD-Development-Guide.md SDD/Guides/SDD-User-Guide.md SDD/Devs/Guides/Coherencia-Colision-Lexica.md
