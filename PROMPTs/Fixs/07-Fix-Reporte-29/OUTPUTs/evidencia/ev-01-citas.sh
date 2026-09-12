#!/usr/bin/env bash
# Solicitud 1: reproducir el comando de §2.1 del reporte 29 sobre Rules-Backlog-Tecnico.md,
# antes de tocar el archivo (base: SDD 13.14, Rules-Backlog-Tecnico.md 5.2).
set -e
cd "$(git -C /home/fernando/workspaces/workspace-dev/IA/SDD/IA.SDD rev-parse --show-toplevel 2>/dev/null || echo /home/fernando/workspaces/workspace-dev/IA/SDD/IA.SDD)"
echo "== git show main:.../Rules-Backlog-Tecnico.md, comando literal del reporte (líneas fijas 58,59,107,108,293,314,338,468) =="
git show main:SDD/Devs/Rules/Rules-Backlog-Tecnico.md | python3 -c '
import re,sys
L=sys.stdin.read().splitlines(); s="(cabecera)"
for i,l in enumerate(L,1):
    if re.match(r"^#{2,4} ",l): s=l.strip()
    if i in (58,59,107,108,293,314,338,468): print(i,"|",s[:45],"|",l[:110])'
echo
echo "== version declarada =="
git show main:SDD/Devs/Rules/Rules-Backlog-Tecnico.md | grep -n "Versión de las reglas"
echo
echo "== grep de desempate en el resto del framework (reproduce el 'sin salida' del reporte) =="
git show main:SDD/Devs/Rules/Catalogo-De-Criterios.md > /tmp/cdc.md 2>/dev/null || true
git show main:SDD/Guides/SDD-User-Guide.md > /tmp/sug.md 2>/dev/null || true
git show main:SDD/Devs/Orchestrator/Master-Prompt.md > /tmp/mp.md 2>/dev/null || true
grep -n -i "30 BT\|más de 30\|20 US" /tmp/cdc.md /tmp/sug.md /tmp/mp.md || echo "(sin salida)"
