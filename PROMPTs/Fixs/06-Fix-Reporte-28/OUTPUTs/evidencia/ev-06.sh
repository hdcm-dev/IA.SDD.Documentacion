#!/usr/bin/env bash
# Evidencia de las solicitudes 1 y 2 de la intervención 06. Corre contra dos commits, nunca contra el árbol de trabajo.
R=/home/fernando/workspaces/workspace-dev/IA/SDD/IA.SDD
E=$(cd "$(dirname "$0")" && pwd)
B=$(mktemp -d)
git -C "$R" archive 476f927 SDD | tar -x -C "$B" && mv "$B/SDD" "$B/v1310"
git -C "$R" archive 9dc8ded SDD | tar -x -C "$B" && mv "$B/SDD" "$B/v1311"
V=$B/v1311; W=$B/v1310
sec() { awk -v a="$2" -v b="$3" '$0 ~ a {p=1} p && $0 ~ b && !($0 ~ a) {exit} p' "$1"; }

echo "### S1 — citas contra 13.11 (9dc8ded). Cada grep -n devuelve la línea literal, o nada"
echo "## S1.a Vocabulario cabecera"; grep -n 'Archivo target:\*\* todo artefacto del framework y toda documentación que el framework genera' $V/Devs/Rules/Vocabulario-Rules.md
echo "## S1.b Vocabulario §1"; grep -n 'Fija \*\*qué designa cada término del framework\*\*' $V/Devs/Rules/Vocabulario-Rules.md
echo "## S1.c Vocabulario §8 — título de la sección y dónde está el párrafo de alcance"; grep -n '^## §8\|Alcance de esta regla, declarado\|No gobierna el resto del vocabulario propio\|vive en el glosario operativo de' $V/Devs/Rules/Vocabulario-Rules.md
echo "## S1.d Vocabulario §9.1 a §9.6 — títulos y frases citadas"; grep -n '^### §9\.\|el contexto de lectura de un subagente es la sección, no el documento\|No se declara una invariante de desambiguación sin haber verificado\|El patrón queda primado\|\*\*R1\*\* | La intervención\|\*\*R2\*\* | Las migraciones\|\*\*R3\*\* | Llevar un destino' $V/Devs/Rules/Vocabulario-Rules.md
echo "## S1.e Vocabulario §10 — criterio de invariante y total de criterios"; grep -n 'Toda invariante de desambiguación declarada cita la verificación de colisión que la justifica' $V/Devs/Rules/Vocabulario-Rules.md; sec $V/Devs/Rules/Vocabulario-Rules.md '^## §10' '^## §11' | grep -c '^- \[ \]'
echo "## S1.f Vocabulario §9 intro — alcance de §9 en su propia letra"; grep -n 'Esta fija cómo se decide, en cualquier documentación que el framework genere, si un término con más de un referente' $V/Devs/Rules/Vocabulario-Rules.md
echo "## S1.g Vocabulario §4 R6 — regla de uso sobre un término que no es de los seis"; grep -n '^\*\*R6\.' $V/Devs/Rules/Vocabulario-Rules.md | cut -c1-120
echo "## S1.h Vocabulario §11 — fechas de §9.6 (2.1) y del párrafo de alcance de §8 (2.2)"; grep -n '^| 2\.1 | \|^| 2\.2 | ' $V/Devs/Rules/Vocabulario-Rules.md | cut -c1-60
echo "## S1.i Master-Prompt §10.0 — las seis comprobaciones transversales"; sec $V/Devs/Orchestrator/Master-Prompt.md '^### §10.0' '^### §10.1' | grep -n '^[1-6]\. \*\*' | cut -c1-60
echo "## S1.j Master-Prompt §15 — línea de inicio y fin"; grep -n '^## §15\|^## §16' $V/Devs/Orchestrator/Master-Prompt.md
echo "## S1.k Migracion-Rules cabecera"; grep -n 'Dentro de este archivo «migración» se usa en forma desnuda.*en este contexto de lectura no hay otro referente' $V/Devs/Rules/Migracion-Rules.md | cut -c1-80
echo "## S1.l Master-Prompt-Migracion insumos"; grep -n 'Migracion-Rules.md`, íntegra. Es la regla que gobierna esta corrida\|Mesa-Rules.md`, íntegra\|El archivo de reglas de cada categoría cuyos documentos se migren' $V/Devs/Orchestrator/Master-Prompt-Migracion.md
echo "## S1.m Root-Rules §13 — el criterio literal y la detención"; grep -n 'Una regla que viaja en la lista de insumos obligatorios de todo despacho\|desplaza a una que no viaja, cuando las dos alcanzan\|el conflicto se detiene' $V/Devs/Rules/Root-Rules.md
echo "## S1.n Guía §VI.3.1 punto 1"; grep -n 'Enumerar el concepto, no los archivos.\*\* Buscar el término y sus formas en \*\*todo el árbol' $V/Guides/SDD-Development-Guide.md

echo; echo "### S2 — los tres recuentos del reporte, en 13.10 (el que evaluó) y en 13.11"
for X in v1310 v1311; do
  echo "## S2.a §2.1 en $X — el comando del reporte, literal"
  ( cd $B/$X/.. && mkdir -p _c && rm -rf _c/SDD && cp -r $X _c/SDD && cd _c && for f in SDD/Devs/Rules/*.md; do
    e=$(grep -Ec '^\s*- \[ \] `?\[enumerable\]`?' "$f")
    i=$(grep -Ec '^\s*- \[ \] `?\[interpretativo\]`?' "$f")
    [ $((e+i)) -gt 0 ] && printf "%-34s enum=%-3s interp=%s\n" "$(basename $f)" "$e" "$i"
  done | awk '{print} /enum=0 /{z++} {n++} END{print "reglas con el esquema: " n "; con enum=0: " z}' )
  echo "## S2.b §2.6 en $X — el comando del reporte (grep -o | wc -l), y grep -c e -i al lado"
  for f in Devs/Rules/Migracion-Rules.md Devs/Orchestrator/Master-Prompt-Migracion.md; do
    printf "%-45s grep -o|wc -l=%s  grep -c=%s  grep -oi|wc -l=%s\n" "$f" "$(grep -o procedencia $B/$X/$f | wc -l)" "$(grep -c procedencia $B/$X/$f)" "$(grep -oi procedencia $B/$X/$f | wc -l)"
  done
  echo "## S2.c §2.5 en $X — procedencia dentro de §15 (sección acotada por título)"
  sec $B/$X/Devs/Orchestrator/Master-Prompt.md '^## §15' '^## §16' | grep -oi procedencia | wc -l
done

echo; echo "### S3 — la medición con que la 04 descartó «procedencia», reproducida (13.11 nota §2.4 y CHANGELOG 13.11)"
echo "## S3.a por sección, en la base de la 04 (13.10)"; $E/localizar.sh procedencia $W/Devs/Orchestrator/Master-Prompt.md $W/Devs/Orchestrator/Master-Prompt-Reanudacion.md | sed "s|$B/||"
echo "## S3.b la frase de la 04, tal como quedó publicada"; grep -n 'colisiona en secciones que esta intervención toca\|colisiona en tres secciones que esta versión toca' $V/Devs/Guides/Coherencia-Origen-Del-Hecho.md $B/../CHANGELOG.13.11 2>/dev/null | cut -c1-160; git -C "$R" show 9dc8ded:CHANGELOG.md | grep -n 'colisiona en tres secciones que esta versión toca' | cut -c1-140

echo; echo "### S4 — qué recibe cada lector, leído de sus insumos (13.11)"
echo "## S4.a Master-Prompt §8, despacho: qué se nombra por sección y qué por ruta"; sec $V/Devs/Orchestrator/Master-Prompt.md '^## Insumos a leer obligatoriamente' '^## Documentos a producir' | grep -n '^- '
echo "## S4.b Master-Prompt §10, perfil del auditor"; grep -n 'Lee solo los entregables de la fase, los insumos upstream que cita y los archivos de reglas correspondientes' $V/Devs/Orchestrator/Master-Prompt.md | cut -c1-40
echo "## S4.c Master-Prompt, orquestador de generación: intake íntegro"; grep -n 'Leer `PRODUCT-INTAKE-<Slug-Producto>.md` íntegro' $V/Devs/Orchestrator/Master-Prompt.md | cut -c1-60
echo "## S4.d Mesa-Rules §10, snippet del especialista"; grep -n 'Insumos: {{LISTA}}, `Vocabulario-Rules.md`, y el contrato de entrada de la mesa' $V/Devs/Rules/Mesa-Rules.md
echo "## S4.e Reanudación R0: lee el árbol y no abre categorías para juzgar contenido"; grep -n 'ya lee el\|No se abre ninguna categoría documental para juzgar su contenido' $V/Devs/Orchestrator/Master-Prompt-Reanudacion.md | cut -c1-90
echo "## S4.f §15 Contexto de lectura"; grep -n '^| Contexto de lectura |' $V/Devs/Orchestrator/Master-Prompt.md | cut -c1-150
echo "## S4.g Vocabulario §9.6: R3 contra R2 se declaró disjunto aunque el orquestador de migración recibe las dos reglas íntegras"; grep -n '^| R3 contra R2 | \*\*Nada\*\*' $V/Devs/Rules/Vocabulario-Rules.md | cut -c1-60; grep -c 'igraci' $V/Devs/Rules/Rules-Devops.md

echo; echo "### S5 — volumen del localizador sobre el árbol vivo de 13.11 (121 .md), sin _legacy"
cd $B/.. && N=$(find $V -name '*.md' | wc -l); L=$(cat $(find $V -name '*.md') | wc -l); echo "archivos .md bajo SDD/: $N · líneas: $L"
for t in 'base de la corrida' 'origen del hecho' 'lote de la fase' 'procedencia'; do s=$(date +%s%N); o=$(grep -rnoiF --include='*.md' "$t" $V | wc -l); a=$(grep -rliF --include='*.md' "$t" $V | wc -l); ms=$(( ($(date +%s%N)-s)/1000000 )); echo "término declarado «$t»: $o ocurrencias en $a archivos, ${ms} ms"; done
for t in estado registro; do echo "palabra común «$t» (palabra entera): $(grep -rnowiF --include='*.md' "$t" $V | wc -l) ocurrencias en $(grep -rlwiF --include='*.md' "$t" $V | wc -l) archivos"; done
rm -rf "$B"
