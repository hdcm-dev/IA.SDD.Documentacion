#!/usr/bin/env bash
# Verificación posterior sobre el worktree IA.SDD-i08 (rama intervencion/08-reporte-30), contra la base main.
F=<workspace>/IA/SDD/IA.SDD-i08
L=<workspace>/PROG2/Geometria/Lab-Geometria
cd $F
T="SDD/Devs/Rules/Intake-Rules.md SDD/Devs/Rules/Rules-Devops.md SDD/Devs/Rules/Rules-Examples.md SDD/Devs/Rules/Rules-Arquitectura-Tecnica.md SDD/Devs/Orchestrator/Master-Prompt.md SDD/Devs/Rules/Catalogo-De-Criterios.md SDD/Devs/Intake/PRODUCT-MANIFEST-template.md SDD/Devs/Intake/PRODUCT-INTAKE-template.md"
echo "## base main=$(git rev-parse main)  rama=$(git rev-parse --abbrev-ref HEAD)"
echo; echo "### Versiones: base -> nueva, y la de _legacy/13.15 (tiene que ser la base)"
for f in $T; do rx='\*\*Versión( de las reglas| de la plantilla)?:\*\* [0-9]+\.[0-9]+'; b=$(git show main:$f | grep -m1 -o -E "$rx" | grep -o -E '[0-9]+\.[0-9]+$'); n=$(grep -m1 -o -E "$rx" $f | grep -o -E '[0-9]+\.[0-9]+$'); l=$(grep -m1 -o -E "$rx" _legacy/13.15/$f | grep -o -E '[0-9]+\.[0-9]+$'); echo "  $f  $b -> $n  (legacy $l)"; done
echo; echo "### Comprobación 10: cabecera = última fila, orden, sin repetidas nuevas"
for f in $T; do vs=$(grep -o -E "^\| [0-9]+\.[0-9]+ \|" $f | grep -o -E "[0-9]+\.[0-9]+"); o=$(echo "$vs"|tr '\n' ' '); s=$(echo "$vs"|sort -t. -k1,1n -k2,2n|tr '\n' ' '); echo "  $f última=$(echo "$vs"|tail -1) $([ "$o" = "$s" ] && echo ordenada || echo DESORDENADA) repetidas=[$(echo "$vs"|sort|uniq -d|tr '\n' ' ')]"; done
echo "  (Rules-Examples repite 1.0 en la base: filas de los ejemplos de §7, no del registro)"; git show main:SDD/Devs/Rules/Rules-Examples.md | grep -c -E "^\| 1\.0 \|"
echo; echo "### Criterio 1: grep -n 'tipo D8 de cada proyecto de código' PRODUCT-INTAKE-template.md"
grep -n "tipo D8 de cada proyecto de código" SDD/Devs/Intake/PRODUCT-INTAKE-template.md | cut -c1-90
echo "  instrucción vigente:"; grep -n "^Instrucción: Describir cómo se materializan los samples" SDD/Devs/Intake/PRODUCT-INTAKE-template.md | cut -c1-140
echo; echo "### Criterio 5: grep -rn -i 'NoTargets\|csproj\|webpack' SDD/Devs/Rules"
grep -rn -i "NoTargets\|csproj\|webpack" SDD/Devs/Rules; echo "  exit=$?"
echo; echo "### Criterio 5 ampliado: herramientas o ecosistemas en las líneas agregadas a SDD/Devs/Rules y SDD/Devs/Orchestrator"
git diff main -- SDD/Devs/Rules SDD/Devs/Orchestrator | grep '^+' | grep -v '^+++' | grep -i -E "npm|node\b|\.net|dotnet|\.sln|msbuild|webpack|typescript|javascript|playwright|blazor|wwwroot|nuget|esbuild|curl|postman|docker"; echo "  exit=$? (1 = ninguna)"
echo "### dónde se nombra un ecosistema en lo agregado (sólo plantillas)"
git diff main -- SDD/Devs/Intake | grep '^+' | grep -v '^+++' | grep -n -i -E "npm|\.net|\.sln" | cut -c1-120
echo; echo "### Recuento de anti-patrones contra el catálogo"
for f in Rules-Devops.md Rules-Examples.md; do e=$(grep -c -E '\| *\[enumerable\] *\|$' SDD/Devs/Rules/$f); i=$(grep -c -E '\| *\[interpretativo\] *\|$' SDD/Devs/Rules/$f); echo "  $f $((e+i)) $e $i"; done
grep -n "Rules-Devops.md\`\](../Rules/Rules-Devops.md) |\|Rules-Examples.md\`\](../Rules/Rules-Examples.md) |\|^| \*\*Total\*\*\|226 situaciones" SDD/Devs/Rules/Catalogo-De-Criterios.md | cut -c1-120
echo; echo "### Snapshot _legacy/13.15: blob por blob contra main"
LIST=$(git ls-tree -r main --name-only | grep -v '^_legacy/' | grep -v -x -e '.gitignore' -e 'CHANGELOG.md' -e 'vs.bat'); n=0; bad=0
for p in $LIST; do n=$((n+1)); [ "$(git rev-parse main:$p)" = "$(git hash-object _legacy/13.15/$p)" ] || { echo "  NO CONFORME $p"; bad=$((bad+1)); }; done
echo "  esperados=$n  en_snapshot=$(find _legacy/13.15 -type f | wc -l)  no_conformes=$bad"
echo "  excluidos, como en _legacy/13.14: $(diff <(git ls-tree -r main --name-only | grep -v '^_legacy/') <(git ls-tree -r main --name-only _legacy/13.14 | sed 's#^_legacy/13.14/##') | grep '^<' | tr '\n' ' ')"
echo; echo "### Barrido: D8 atribuido a proyecto de código, árbol vivo"
grep -rn -i -E "D8[^|]{0,60}proyecto de c[oó]digo|proyecto de c[oó]digo[^|]{0,40}(tipo )?D8" SDD PROMPTS README.md Templates Conocimiento --include=*.md | grep -v "_legacy\|no lleva\|No lleva\|no llevan\|sin D8\|Sin valor D8\|sin valor D8\|ningún campo D8\|Ningún campo D8\|Ningún proyecto de código declara\|^[^:]*:[0-9]*:| [0-9]\+\.[0-9]\+ |" | cut -c1-140
echo; echo "### Comprobación 2: el texto agregado a SDD/ no nombra otro repositorio"
git diff main -- SDD | grep '^+' | grep -v '^+++' | grep -i -E "Lab-Geometria|IA\.SDD\.Documentacion|VideoControl|Reportes/|PROMPTs/"; echo "  exit=$? (1 = ninguna)"
echo; echo "### Comprobación 3: secciones citadas en lo agregado existen"
grep -n "^### 3.6 \|^### 3.4 \|^### 3.2 " SDD/Devs/Rules/Rules-Examples.md
grep -n "^### 4.9 \|^### 4.8 " SDD/Devs/Rules/Rules-Devops.md
grep -n "^## §4 " SDD/Devs/Rules/Intake-Rules.md
grep -n "^### II.7 " SDD/Guides/SDD-Development-Guide.md
grep -n "^### §1.2 \|^### §2.1 \|^## §3 " SDD/Devs/Intake/PRODUCT-MANIFEST-template.md
grep -n "^### 2.1 \|^### 4.8 " SDD/Devs/Rules/Rules-Arquitectura-Tecnica.md
grep -n "^## 4\. " SDD/Devs/Rules/Root-Rules.md; grep -n "^2\. Unidades de entrega del producto" SDD/Devs/Rules/Root-Rules.md | cut -c1-60
grep -n "^## §2 \|^### §9.1" SDD/Devs/Rules/Vocabulario-Rules.md
echo; echo "### Colisión posterior: los términos nuevos, por archivo (árbol vivo)"
for t in "insumo de construcción" "referencia de proyecto"; do echo "  -- $t"; grep -rn -i -c "$t" SDD PROMPTS README.md Templates Conocimiento --include=*.md | grep -v "_legacy\|:0$" | sed 's/^/     /'; done
echo; echo "### Criterio 3: las piezas que usa la reproducción, leídas del texto nuevo"
grep -n "^| \*\*Insumo de construcción\*\*\|^| \*\*Referencia de proyecto\*\*" SDD/Devs/Rules/Intake-Rules.md | cut -c1-120
grep -n "Un perfil por ecosistema\|Identidad-Codigo\` del rol \`Visor\`" SDD/Devs/Intake/PRODUCT-MANIFEST-template.md | cut -c1-120
grep -n "Un proyecto de código de otro ecosistema\*\* va en la tabla" SDD/Devs/Intake/PRODUCT-MANIFEST-template.md | cut -c1-120
grep -n "modo de construcción explícito y nombrado" SDD/Devs/Rules/Rules-Devops.md | cut -c1-60
grep -n "No se construye con la solución" SDD/Devs/Rules/Rules-Examples.md | cut -c1-80
echo; echo "======== Qué le exige a Lab-Geometria (main $(git -C $L rev-parse --short main)) ========"
echo "### ocurrencias de «activo de construcción» (fuera de _legacy)"
git -C $L grep -c "activo de construcción" main -- . | grep -v "_legacy" ; echo "  total: $(git -C $L grep -c "activo de construcción" main -- . | grep -v _legacy | awk -F: '{s+=$NF} END{print s}')"
echo "### mapa de Vista-Producto §2 (D8 y redistribuible por proyecto)"
git -C $L show main:SDD/Docs/Producto/Vista-Producto.md | grep -n "^| \`Nombre-Proyecto-Codigo\`"
echo "### intake §16.1 (tabla por proyecto con D8)"
git -C $L show main:SDD/Intake/PRODUCT-INTAKE-Fabrica-De-Geometria.md | grep -n "^| Proyecto de código | Tipo D8 |"
echo "### intake §13.2 fila Web: dependencia del visor sin marca de clase"
git -C $L show main:SDD/Intake/PRODUCT-INTAKE-Fabrica-De-Geometria.md | grep -n "^| \*\*GeometriaFactory-Web\*\*" | cut -c1-200
echo "### excepción de identidad del intake §13.3"
git -C $L show main:SDD/Intake/PRODUCT-INTAKE-Fabrica-De-Geometria.md | grep -n "Excepción declarada para GeometriaFactory-Visor" | cut -c1-90
