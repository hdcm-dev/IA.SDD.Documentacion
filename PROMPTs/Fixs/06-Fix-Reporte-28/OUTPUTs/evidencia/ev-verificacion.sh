#!/usr/bin/env bash
# Verificación de lo aplicado, contra el árbol de trabajo de la rama intervencion/06-reporte-28 de IA.SDD.
R=<workspace>/IA/SDD/IA.SDD; cd "$R"
BASE=9dc8ded
TOC="SDD/Devs/Rules/Vocabulario-Rules.md SDD/Devs/Orchestrator/Master-Prompt.md SDD/Devs/Rules/Mesa-Rules.md SDD/Guides/SDD-Development-Guide.md SDD/Guides/SDD-User-Guide.md SDD/Devs/Rules/Catalogo-De-Criterios.md"
sec() { awk -v a="$2" -v b="$3" '$0 ~ a {p=1} p && $0 ~ b && !($0 ~ a) {exit} p' "$1"; }

echo "### C1 — el recuento de §2.1, con el comando del reporte"
for f in SDD/Devs/Rules/*.md; do e=$(grep -Ec '^\s*- \[ \] `?\[enumerable\]`?' "$f"); i=$(grep -Ec '^\s*- \[ \] `?\[interpretativo\]`?' "$f"); [ $((e+i)) -gt 0 ] && printf "%-34s enum=%-3s interp=%s\n" "$(basename $f)" "$e" "$i"; done | grep 'Vocabulario\|Mesa'

echo; echo "### C2 — cabecera, §8 y §9.6 leídos juntos"
grep -n 'Archivo target' SDD/Devs/Rules/Vocabulario-Rules.md
sec SDD/Devs/Rules/Vocabulario-Rules.md '^## §8' '^## §9' | grep -n 'Todo término\|Los seis de §2\|§15 \*\*define\*\*\|acotaba también §9'
grep -n 'se usa en forma desnuda\|^\*\*Forma desnuda admitida' SDD/Devs/Rules/Vocabulario-Rules.md SDD/Devs/Rules/Migracion-Rules.md | cut -c1-110
echo "residuo de la acotación vieja (esperado: vacío fuera del control de cambios):"; grep -n 'No gobierna el resto del vocabulario propio\|gobierna seis palabras' SDD/Devs/Rules/Vocabulario-Rules.md | grep -v '^[0-9]*:| '

echo; echo "### C3 — la comprobación 14 aplicada a una afirmación real sin comando: la nota y la entrada de la 13.11"
for src in "SDD/Devs/Guides/Coherencia-Origen-Del-Hecho.md" "CHANGELOG.md"; do
  if [ "$src" = CHANGELOG.md ]; then txt=$(awk '/^## \[13.11\]/,/^## \[13.10\]/' CHANGELOG.md); else txt=$(cat "$src"); fi
  printf '%s\n' "$txt" | awk -v src="$src" 'BEGIN{RS=""} /colisi|disjunt|polisem/ { cmd = ($0 ~ /grep|wc -l|awk |```/) ? "CON comando" : "SIN comando → hallazgo"; gsub(/\n/," "); printf "%s · %s · %.150s…\n", src, cmd, $0 }'
done

echo; echo "### C4 — el costo de calificar un sentido nuevo en un archivo que se lee íntegro, sin refutador"
grep -n '^| Orquestador de migración |' SDD/Devs/Rules/Vocabulario-Rules.md | cut -c1-160
grep -n 'el costo de una familia calificada se mide igual' SDD/Devs/Rules/Vocabulario-Rules.md | cut -c1-40
L=<workspace>/IA/SDD/IA.SDD.Documentacion/PROMPTs/Fixs/06-Fix-Reporte-28/OUTPUTs/evidencia/localizar.sh
$L procedencia SDD/Devs/Rules/Migracion-Rules.md SDD/Devs/Orchestrator/Master-Prompt-Migracion.md | grep '(archivo)'

echo; echo "### C5 — la compuerta localiza sin decidir: el comando publicado en §10.0, extraído y corrido"
sec SDD/Devs/Orchestrator/Master-Prompt.md '^7\. \*\*Localización de los términos declarados' '^   \*\*Qué hace el auditor' | awk '/^   ```bash/{p=1;next} /^   ```$/{p=0} p' | sed 's/^   //' > /tmp/claude-1000/comp7.sh
echo "comando extraído: $(wc -l < /tmp/claude-1000/comp7.sh) líneas"
echo "términos declarados por la 13.11, calculados contra su base (476f927), no declarados aparte:"
git diff 476f927 $BASE -- SDD/Devs/Orchestrator/Master-Prompt.md | grep -E '^\+\| [A-ZÁÉÍÓÚ][^|]* \| ' | awk -F' \\| ' '{sub(/^\+\| /,"",$1); print $1}' | grep -v '^[0-9]' | tee /tmp/claude-1000/terminos.txt
while read -r T; do echo "== T=«$T»"; T="$T" ARBOL=SDD bash /tmp/claude-1000/comp7.sh; done < /tmp/claude-1000/terminos.txt > /tmp/claude-1000/c5.out
cat /tmp/claude-1000/c5.out
echo "líneas de salida con palabra de veredicto (colisi|disjunt|hallazgo): $(grep -ciE 'colisi|disjunt|hallazgo' /tmp/claude-1000/c5.out)"
echo "caso inverso — un término no declarado no se pide y no aparece:"; grep -c 'sonda' /tmp/claude-1000/c5.out

echo; echo "### C6 — criterio negativo: «migración» en contextos disjuntos"
T='migración' ARBOL='SDD/Devs/Rules/Rules-Devops.md SDD/Devs/Rules/Migracion-Rules.md' bash /tmp/claude-1000/comp7.sh | grep '(archivo)'
grep -n '^| R3 contra R2 | \*\*Nada\*\*' SDD/Devs/Rules/Vocabulario-Rules.md | cut -c1-120
grep -n 'la suma de lo que un lector recibe' SDD/Devs/Rules/Vocabulario-Rules.md | cut -c1-120

echo; echo "### Comprobación 10 — cabecera igual a la mayor fila, en orden, sin repetidas"
for f in $TOC SDD/Devs/Guides/Coherencia-Colision-Lexica.md; do [ -f "$f" ] || { echo "$f: (todavía no existe)"; continue; }
  h=$(grep -m1 -oE '(Versión( de las reglas)?:\**|^Versión:) *[0-9]+\.[0-9]+' "$f" | grep -oE '[0-9]+\.[0-9]+$')
  rows=$(grep -oE '^\| [0-9]+\.[0-9]+ \| 20' "$f" | grep -oE '[0-9]+\.[0-9]+')
  ord=$(printf '%s\n' "$rows" | sort -t. -k1,1n -k2,2n | tr '\n' ' '); act=$(printf '%s\n' "$rows" | tr '\n' ' ')
  rep=$(printf '%s\n' "$rows" | sort | uniq -d | tr '\n' ' ')
  last=$(printf '%s\n' "$rows" | tail -1)
  echo "$f: cabecera=$h última=$last ordenada=$([ "$ord" = "$act" ] && echo sí || echo NO) repetidas=[${rep}]"
done

echo; echo "### Filas reordenadas: toda fila fechada quitada reaparece idéntica"
git diff $BASE -- $TOC | grep -E '^-\| [0-9]+\.[0-9]+ \| 20' | sed 's/^-//' | sort > /tmp/claude-1000/q.txt
git diff $BASE -- $TOC | grep -E '^\+\| [0-9]+\.[0-9]+ \| 20' | sed 's/^+//' | sort > /tmp/claude-1000/a.txt
echo "quitadas: $(wc -l < /tmp/claude-1000/q.txt) · agregadas: $(wc -l < /tmp/claude-1000/a.txt) · quitadas que no reaparecen: $(comm -23 /tmp/claude-1000/q.txt /tmp/claude-1000/a.txt | wc -l)"
echo "agregadas nuevas:"; comm -13 /tmp/claude-1000/q.txt /tmp/claude-1000/a.txt | cut -c1-24

echo; echo "### Barrido §VI.3.2 — formas anteriores sobre el árbol vivo, cercos incluidos"
for p in 'es la sección, no el documento' 'para un subagente es la sección' 'trece comprobaciones' 'gobierna seis palabras' 'No gobierna el resto del vocabulario propio'; do
  echo "== «$p»"; grep -rnF --include='*.md' --exclude-dir=_legacy "$p" . | cut -c1-150
done

echo; echo "### Snapshot — _legacy/13.11 conserva las versiones anteriores de lo tocado"
for f in $TOC; do printf "%-45s %s\n" "$f" "$(grep -m1 -oE '(Versión( de las reglas)?:\**|^Versión:) *[0-9]+\.[0-9]+' _legacy/13.11/$f)"; done

echo; echo "### Autosuficiencia — líneas agregadas que nombran algo fuera de este repositorio"
git diff $BASE -- $TOC | grep '^+' | grep -ciE 'Reporte `?[0-9]|IA\.SDD\.Documentacion|Lab-Geometria|PROMPTs/'
echo "### Código ejecutable distribuido"; find SDD -type f -not -name '*.md' | wc -l

echo; echo "### Regla 4 sobre el texto propio — afirmaciones de colisión en las líneas agregadas"
git diff $BASE -- $TOC | grep '^+' | grep -iE 'colisi|disjunt|polisem' | cut -c1-170
