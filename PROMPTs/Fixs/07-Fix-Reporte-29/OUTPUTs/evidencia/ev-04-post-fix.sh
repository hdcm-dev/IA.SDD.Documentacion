#!/usr/bin/env bash
# Verificación del plan aplicado (solicitud 9 y 10), sobre el árbol de trabajo de IA.SDD ya editado.
set -e
cd <workspace>/IA/SDD/IA.SDD
echo "== versión de las reglas =="
grep -n "Versión de las reglas" SDD/Devs/Rules/Rules-Backlog-Tecnico.md

echo
echo "== criterio 1 de §7: las seis/siete menciones dicen lo mismo (por texto, no por línea fija) =="
grep -n "más de 20 US\|más de 30 BT\|10 a 20 US\|15 a 30 BT\|supera 20 US\|supera 30 BT\|supere 20 US\|supere 30 BT" SDD/Devs/Rules/Rules-Backlog-Tecnico.md
echo "-- ninguna mención sobreviviente de 'unidad de entrega' pegada a un umbral de US/BT --"
grep -n "unidad de entrega" SDD/Devs/Rules/Rules-Backlog-Tecnico.md | grep -i "20 US\|30 BT\|supera\|supere" || echo "(sin salida: correcto)"

echo
echo "== criterio 2 de §7: §6 marcado [enumerable] con comando =="
grep -n "\[enumerable\].*proyecto de código de la unidad" SDD/Devs/Rules/Rules-Backlog-Tecnico.md

echo
echo "== criterio 4 de §7: el caso mixto está contemplado =="
grep -n "mixto" SDD/Devs/Rules/Rules-Backlog-Tecnico.md

echo
echo "== grep de desempate en el resto del framework, otra vez, después del fix =="
grep -rn -i "30 BT\|más de 30\|20 US" SDD/Devs/Rules/Catalogo-De-Criterios.md SDD/Guides/SDD-User-Guide.md SDD/Devs/Orchestrator/Master-Prompt.md || echo "(sin salida)"

echo
echo "== rama y diff del único archivo tocado =="
git branch --show-current
git status --short
git diff --stat SDD/Devs/Rules/Rules-Backlog-Tecnico.md
