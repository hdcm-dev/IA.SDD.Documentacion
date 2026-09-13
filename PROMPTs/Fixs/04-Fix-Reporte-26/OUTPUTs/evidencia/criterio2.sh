#!/usr/bin/env bash
# Criterio 2 del reporte 26: el origen del hecho se reproduce contrastando contra la base, sin leer lo que declaró el agente
F=<workspace>/IA/SDD/IA.SDD
L=<workspace>/PROG2/Geometria/Lab-Geometria
REF=${1:-}   # vacío: árbol de trabajo; o un commit de la corrida
run(){ echo; echo "\$ $*"; eval "$@"; }
cd "$F"; B=476f927
MP=SDD/Devs/Orchestrator/Master-Prompt.md; MR=SDD/Devs/Rules/Mesa-Rules.md
echo "### Corrida de la intervención 04 — base $B, comparado contra ${REF:-el árbol de trabajo}"
echo; echo "## H1 · «la autocorrección tiene una fila para el estado a medias de la corrida»"
L1='| **Un estado a medias que produjo esta corrida**'
run "git show $B:$MP | grep -cF '$L1'"
run "git diff $B $REF -- $MP | grep -c '^+.*Un estado a medias que produjo esta corrida'"
echo "=> no está en la base y lo agregó la corrida: DE LA CORRIDA"
echo; echo "## H2 · «el disparador 4 de la mesa es la irreversibilidad con impacto material»"
L2='| 4 | **Irreversibilidad con impacto material**'
run "git show $B:$MR | grep -cF '$L2'"
run "git diff $B $REF -- $MR | grep -c 'Irreversibilidad con impacto material'"
echo "=> está en la base y la corrida no tocó esas líneas: AJENO A LA CORRIDA"
echo; echo "## H3 · «la cláusula del snapshot de §8 manda detener sin editar» — el caso de la línea que estaba y la corrida cambió"
run "git show $B:$MP | grep -c 'contenido que el snapshot no refleja, detenete y devolvelo como ambigüedad según §9, sin editar.\$'"
run "git diff $B $REF -- $MP | grep -c '^-.*contenido que el snapshot no refleja, detenete'"
echo "=> estaba en la base y un cambio de la corrida la reescribió: DE LA CORRIDA"
echo; echo "### Un caso real: la escalada E-04 de Lab-Geometria (2026-09-12), sólo lectura"
run "git -C $L show archivo/reanudacion-6-2026-09-12:SDD/Docs/Audit/Estado-Del-Destino-2026-09-12.md | grep -n 'Revisión leída'"
run "git -C $L show archivo/reanudacion-6-2026-09-12:SDD/Docs/Audit/Mesa-2026-09-12.md | grep -n 'Estrategia-Versionado.md. dice que la regla de etiquetar'"
for u in Api Web; do
 run "git -C $L cat-file -e 5c95dab:SDD/Docs/Unidades-Entrega/GeometriaFactory-$u/09-Devops/Estrategia-Versionado.md && echo existe-en-la-base"
 run "git -C $L diff --stat 5c95dab archivo/reanudacion-6-2026-09-12 -- SDD/Docs/Unidades-Entrega/GeometriaFactory-$u/09-Devops/Estrategia-Versionado.md | wc -l"
done
run "git -C $L show 5c95dab:SDD/Docs/Unidades-Entrega/GeometriaFactory-Api/09-Devops/Estrategia-Versionado.md | grep -n 'fase .i. en adelante' | cut -c1-160"
echo "=> el documento que sostiene el hecho está en la base y la corrida no lo tocó: AJENO A LA CORRIDA. No se leyó ninguna declaración del agente sobre su origen: el registro de mesa no tiene ese campo."
echo; echo "### El caso no calculable: E-05 cita DESPLIEGUE.md"
run "git -C $L ls-tree -r --name-only 5c95dab | grep -ci 'DESPLIEGUE.md'"
echo "=> no vive en el repositorio en la base: NO CALCULABLE, se trata como de la corrida y la detención dice por qué"
