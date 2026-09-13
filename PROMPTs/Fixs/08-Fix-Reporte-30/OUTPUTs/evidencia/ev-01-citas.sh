#!/usr/bin/env bash
# Solicitud 1: citas del reporte 30 contra la base (main) de IA.SDD y de Lab-Geometria. Sólo objetos commiteados.
F=<workspace>/IA/SDD/IA.SDD
L=<workspace>/PROG2/Geometria/Lab-Geometria
echo "## base IA.SDD main = $(git -C $F rev-parse main)"
echo "## base Lab-Geometria main = $(git -C $L rev-parse main)"
s(){ git -C $F show "main:$1"; }
echo; echo '### (a) §16.1 — grep -n "tipo D8 de cada proyecto de código" PRODUCT-INTAKE-template.md'
s SDD/Devs/Intake/PRODUCT-INTAKE-template.md | grep -n "tipo D8 de cada proyecto de código"
echo '### (a) fila 3.0 del control de cambios de la plantilla'
s SDD/Devs/Intake/PRODUCT-INTAKE-template.md | grep -n "^| 3.0 |" | cut -c1-260
echo '### (a) la especificación F20 dice que §18 también lo dice: ocurrencias de "D8" en §18'
s SDD/Devs/Intake/PRODUCT-INTAKE-template.md | awk '/^## §18/,/^# Parte D/' | grep -c "D8"
echo; echo '### (b) grep -rn -i "activo de construcci" SDD --include=*.md | grep -v _legacy'
git -C $F grep -n -i "activo de construcci" main -- 'SDD/*.md' | grep -v _legacy; echo "(exit: vacío si no hay líneas arriba)"
echo; echo '### (c) PRODUCT-MANIFEST-template l.155 y columna Stack'
s SDD/Devs/Intake/PRODUCT-MANIFEST-template.md | grep -n "agnóstica de stack a propósito\|| Stack |"
echo '### (c) ejemplo de identidad con forma npm (minúscula-guion) en la plantilla del manifiesto: identidades en backticks'
s SDD/Devs/Intake/PRODUCT-MANIFEST-template.md | grep -o -E '`[a-z]+(-[a-z]+)+`' | sort -u
echo; echo '### (d) Vocabulario-Rules.md §2, solución de código'
s SDD/Devs/Rules/Vocabulario-Rules.md | grep -n "^| \*\*Solución de código"
echo '### (d) grep -rn -i -E "otro stack|stack distinto|dos stacks|más de un ecosistema|ecosistemas distintos" SDD'
git -C $F grep -n -i -E "otro stack|stack distinto|dos stacks|más de un ecosistema|ecosistemas distintos" main -- 'SDD/*.md' | grep -v _legacy; echo "(vacío si no hay líneas arriba)"
echo; echo '### (e) Rules-Examples.md §1.2 rest-api'
s SDD/Devs/Rules/Rules-Examples.md | grep -n "^| rest-api | Sample Engineer + API Demo"
echo '### (e) Rules-Examples.md: ¿dice si un sample entra al agrupador?'
s SDD/Devs/Rules/Rules-Examples.md | grep -n -i "agrupador\|solución de código"; echo "(vacío si no hay líneas arriba)"
echo; echo '### §2.3 del reporte: Rules-Base-Conocimiento.md §0.1 y §4.5'
s SDD/Devs/Rules/Rules-Base-Conocimiento.md | grep -n "Describe el artefacto, no el método\|Conocimiento disfrazado de regla"
echo '### P-8 dice «el único canal es un ADR»: ¿«único» en Migracion-Rules §4.7 o Root-Rules §11?'
s SDD/Devs/Rules/Migracion-Rules.md | awk '/^### 4.7/,/^### 4.8/' | grep -n -i "únic"
s SDD/Devs/Rules/Root-Rules.md | awk '/^## 11\./,/^## 12\./' | grep -n -i "únic"; echo "(sólo «Lo único que cambia», ajeno)"
echo '### comprobación 13 de la guía: el origen de una intervención puede ser un reporte, un incidente, un pedido'
s SDD/Guides/SDD-Development-Guide.md | grep -n "^| 13 |" | cut -c1-200
echo; echo '### Rules-Devops.md: paquete-npm como canal genérico de library'
s SDD/Devs/Rules/Rules-Devops.md | grep -n "^| library | paquete del gestor" | cut -c1-200
echo; echo '### Pipeline-Producto §4.9 punto 4: build conjunto en el repositorio'
s SDD/Devs/Rules/Rules-Devops.md | grep -n "^4. Coordinación inter-proyecto" | cut -c1-300
echo; echo '### Criterio 5, antes: grep -rn -i "NoTargets\|csproj\|webpack" SDD/Devs/Rules'
git -C $F grep -n -i "NoTargets\|csproj\|webpack" main -- SDD/Devs/Rules; echo "exit=$? (1 = vacío)"
echo; echo '======== DESTINO Lab-Geometria (main) ========'
d(){ git -C $L show "main:$1"; }
echo '### PRODUCT-MANIFEST fila GeometriaFactory-Visor'
d SDD/Intake/PRODUCT-MANIFEST-Fabrica-De-Geometria.md | grep -n "^| \`GeometriaFactory-Visor\`"
echo '### Vista-Producto: "activo de construcción"'
d SDD/Docs/Producto/Vista-Producto.md | grep -n "activo de construcción"
echo '### Vista-Producto: la frase citada «Aristas de compilación: 8, de dos clases»'
d SDD/Docs/Producto/Vista-Producto.md | grep -n -i "aristas de compilación: \*\*8\*\*"; echo "(vacío si no hay líneas arriba)"
echo '### ADR-10008 cabecera'
d SDD/Docs/Unidades-Entrega/GeometriaFactory-Web/05-Arquitectura-Tecnica/Adrs/ADR-10008-El-Bundle-Del-Visor-Lo-Genera-El-Proyecto-Del-Front.md | sed -n 1,6p
echo '### GeometriaFactory.Web.csproj targets'
d src/GeometriaFactory.Web/GeometriaFactory.Web.csproj | grep -n "<Target Name"
echo '### SkipVisorBuild en deploy/Dockerfile.web'
d deploy/Dockerfile.web | grep -n "SkipVisorBuild"
echo '### visor/geometriafactory-visor.csproj Sdk'
d visor/geometriafactory-visor.csproj | head -1
echo '### samples sin .csproj (reporte: 11)'
for x in $(git -C $L ls-tree -r main --name-only samples | awk -F/ 'NF>=4{print $1"/"$2"/"$3}' | sort -u); do git -C $L ls-tree -r main --name-only $x | grep -q '\.csproj$' || echo $x; done | tee /tmp/claude-1000/nc.txt; echo "total: $(wc -l < /tmp/claude-1000/nc.txt)"
echo '### grep -c samples\\(visor|api|contracts|web) GeometriaFactory.sln (reporte: 0)'
d GeometriaFactory.sln | grep -c 'samples\\\(visor\|api\|contracts\|web\)'
echo '### fecha de alta de samples/api/04-cliente-http-basico'
git -C $L log --diff-filter=A --format='%h %ad' main -- samples/api/04-cliente-http-basico | tail -1
echo '### fecha de alta del resto de los no compilables'
for x in $(cat /tmp/claude-1000/nc.txt); do echo "$x $(git -C $L log --diff-filter=A --format='%ad' --date=short main -- $x | tail -1)"; done
