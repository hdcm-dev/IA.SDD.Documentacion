#!/usr/bin/env bash
# Solicitud 2 ampliada: todos los destinos del workspace con SDD/Docs/, carpetas tareas-tecnicas/
# e historias-usuario/, y recuentos de BT/US donde la categoría 06 existe. Disco (no hay otro
# agente escribiendo en estos tres).
set -e
echo "== destinos con SDD/Docs (excluye _legacy y node_modules) =="
find /home/fernando/workspaces/workspace-dev -type d -path "*/SDD/Docs" -not -path "*/_legacy/*" -not -path "*/node_modules/*"

echo
echo "== carpetas tareas-tecnicas/ en TODO el workspace (reproduce el comando del reporte, §2.4) =="
find /home/fernando/workspaces/workspace-dev -type d -name tareas-tecnicas -not -path "*/_legacy/*" -not -path "*/node_modules/*"
echo "(el de arriba es el de Lab-Geometria en fase-k; en el resto del workspace: sin salida antes de esta corrida)"

echo
echo "== carpetas historias-usuario/ en TODO el workspace (ampliación de la solicitud 2) =="
find /home/fernando/workspaces/workspace-dev -type d -name historias-usuario -not -path "*/_legacy/*" -not -path "*/node_modules/*"

echo
echo "---- RPI.VideoControl (una unidad, cinco proyectos de código, pre-8.0: sin Unidades-Entrega/) ----"
F=/home/fernando/workspaces/workspace-dev/Repos-RPIs/RPI.VideoControl/SDD/Docs/06-Backlog-Tecnico/Product-Backlog.md
head -12 "$F"
echo "BT totales:"
grep -o -E "BT-[0-9]{5}" /home/fernando/workspaces/workspace-dev/Repos-RPIs/RPI.VideoControl/SDD/Docs/06-Backlog-Tecnico/Backlog-Tecnico.md | sort -u | wc -l
echo "US por proyecto de código, según los rangos que el propio Product-Backlog.md declara (PRODUCT-INTAKE §13.4):"
python3 -c "
import re
ids = sorted(set(int(x) for x in re.findall(r'US-(\d{5})', open('$F').read())))
ranges = {'Web':(1,29),'Domain':(31,39),'PinMap':(41,49),'Application':(51,69),'Infrastructure':(71,89)}
tot=0
for name,(a,b) in ranges.items():
    c=[i for i in ids if a<=i<=b]
    tot+=len(c)
    print(name, len(c))
print('total unidad', tot)
"
echo "US con archivo individual bajo historias-usuario/:"
find /home/fernando/workspaces/workspace-dev/Repos-RPIs/RPI.VideoControl/SDD/Docs/06-Backlog-Tecnico/historias-usuario -name "US-*.md" | wc -l
echo "tareas-tecnicas/ existe:"
find /home/fernando/workspaces/workspace-dev/Repos-RPIs/RPI.VideoControl -iname "tareas-tecnicas" -type d || echo "(no existe)"

echo
echo "---- SAI.Service.Core (una unidad = un proyecto, convención pre-Unidades-Entrega, sufijo -v1.0) ----"
BT=/home/fernando/workspaces/workspace-dev/DEV/SAI.Service.Core/SDD/Docs/06-Backlog-Tecnico/Backlog-Tecnico-v1.0.md
echo "BT totales:"; grep -o -E "BT-[0-9]+" "$BT" | sort -u | wc -l
echo "US con archivo individual:"; find /home/fernando/workspaces/workspace-dev/DEV/SAI.Service.Core/SDD/Docs/06-Backlog-Tecnico/historias-usuario -name "US-*.md" | wc -l
echo "US mencionadas en Product-Backlog-v1.0.md:"; grep -o -E "US-[0-9]+" /home/fernando/workspaces/workspace-dev/DEV/SAI.Service.Core/SDD/Docs/06-Backlog-Tecnico/Product-Backlog-v1.0.md | sort -u | wc -l
echo "tareas-tecnicas/ existe:"; find /home/fernando/workspaces/workspace-dev/DEV/SAI.Service.Core -iname "tareas-tecnicas" -type d || echo "(no existe)"

echo
echo "---- SelfHosted.Service.Core (sin categoría 06 generada aún) ----"
find /home/fernando/workspaces/workspace-dev/DEV/SelfHosted.Service.Core/SDD/Docs -maxdepth 1 -type d
