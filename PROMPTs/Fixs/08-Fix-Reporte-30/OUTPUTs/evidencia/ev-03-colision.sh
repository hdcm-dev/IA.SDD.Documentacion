#!/usr/bin/env bash
# §5.2: colisión de los nombres candidatos, por contexto de lectura (Vocabulario-Rules.md §9.2), sobre la base main.
F=<workspace>/IA/SDD/IA.SDD
echo "## base IA.SDD main = $(git -C $F rev-parse main)"
# Lectores de la clase de arista: quien completa el intake, quien deriva y valida el manifiesto,
# AG-00050 (vista de producto), AG-00090 (pipeline de producto), AG-00100 (samples) y el orquestador (glosario §15).
R="SDD/Devs/Intake/PRODUCT-INTAKE-template.md SDD/Devs/Intake/PRODUCT-MANIFEST-template.md SDD/Devs/Rules/Intake-Rules.md SDD/Devs/Rules/Rules-Arquitectura-Tecnica.md SDD/Devs/Rules/Rules-Devops.md SDD/Devs/Rules/Rules-Examples.md SDD/Devs/Orchestrator/Master-Prompt.md SDD/Devs/Rules/Vocabulario-Rules.md"
for t in 'activo de construcci' 'insumo de construcci' 'referencia de proyecto' 'cadena de herramientas' 'otro ecosistema' 'sin construcci'; do
  echo; echo "### compuesto: \"$t\" — en los lectores, y en todo el árbol vivo"
  for f in $R; do c=$(git -C $F show main:$f | grep -o -i "$t" | wc -l); echo "  $c  $f"; done
  echo "  árbol vivo (sin _legacy): $(git -C $F grep -i -c "$t" main -- '*.md' | grep -v '^main:_legacy/' | awk -F: '{s+=$NF} END{print s+0}')"
done
echo; echo '### forma desnuda "activo(s)" en los lectores (sentido que ya tiene)'
for f in $R; do git -C $F show main:$f | grep -n -i -P '\bactiv[oa]s?\b' | sed "s#^#  $f:#" | cut -c1-200; done
echo; echo '### forma desnuda "insumo(s)" en los lectores: recuento y muestra del sentido'
for f in $R; do c=$(git -C $F show main:$f | grep -o -i -P '\binsumos?\b' | wc -l); echo "  $c  $f"; done
git -C $F show main:SDD/Devs/Orchestrator/Master-Prompt.md | grep -n -i -P '\binsumos?\b' | head -5 | cut -c1-200
git -C $F show main:SDD/Devs/Intake/PRODUCT-INTAKE-template.md | grep -n -i -P '\binsumos?\b' | cut -c1-200
