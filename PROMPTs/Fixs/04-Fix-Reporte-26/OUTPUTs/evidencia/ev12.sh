#!/usr/bin/env bash
# Evidencia de las solicitudes 1 y 2 — intervención 04 sobre el reporte 26
F=<workspace>/IA/SDD/IA.SDD
D=<workspace>/IA/SDD/IA.SDD.Documentacion
MP=SDD/Devs/Orchestrator/Master-Prompt.md
MR=SDD/Devs/Rules/Mesa-Rules.md
RE=SDD/Devs/Orchestrator/Master-Prompt-Reanudacion.md
MI=SDD/Devs/Orchestrator/Master-Prompt-Migracion.md
cd "$F"
run(){ echo; echo "\$ $*"; eval "$@"; }
echo "### Base"; run "git -C $F rev-parse HEAD"; run "git -C $F status --short | wc -l"
echo; echo "### S1.a  §7.0 — qué entra al registro y cuándo se exhibe"
run "grep -n 'Entran: ambigüedades de §9 que el humano difirió' $MP"
run "grep -n 'El orquestador lo exhibe al cerrar cada fase' $MP"
echo; echo "### S1.b  §8 — la cláusula del snapshot, literal"
run "grep -nF 'Si al abrir el entregable encontrás contenido que el snapshot no refleja, detenete y devolvelo como ambigüedad según §9, sin editar.' $MP"
echo; echo "### S1.c  §8 — cuándo se toma el snapshot"
run "grep -n 'antes de construir este despacho' $MP"
run "grep -n 'el orquestador toma el snapshot en ese momento' $MP"
echo; echo "### S1.d  §8.1 — la pregunta previa, la tabla de dos filas y «ante la duda»"
run "grep -n '¿Esto tiene respuesta en el árbol?' $MP"
run "awk '/^### La autocorrección/{f=1} f && /^\| \*\*/{print NR\": \"substr(\$0,1,90)} /^\*\*Y la contraparte/{f=0}' $MP"
run "grep -n '^\*\*Ante la duda, se detiene.\*\*' $MP"
echo; echo "### S1.e  §9 — campos del bloque de ambigüedad"
run "awk '/^   AMBIGÜEDAD DETECTADA/{f=1} f{print NR\": \"\$0} f && /Qué pasa si no se responde/{f=0}' $MP"
echo; echo "### S1.f  Mesa-Rules §0.0, §0.1, §0.2"
run "grep -n 'La mesa se convoca cuando se cumplen las tres' $MR"
run "grep -n 'tres no eran del Product Owner' $MR"
run "grep -n 'Tres mediciones del framework' $MR"
run "grep -n '^| | Auditoría entre fases' $MR"
echo; echo "### S1.g  Mesa-Rules §7 — filas de disparadores, cita de la inversión, §7.1"
run "awk '/^## 7\. Escalada/{f=1} /^### 7\.1/{f=0} f && /^\| [0-9] \|/' $MR | wc -l"
run "tr '\n' ' ' < $MR | grep -o 'una consulta de *más en un lote de veinte entrena a firmar el lote sin leerlo' "
run "grep -n 'Las escaladas se entregan agrupadas al cierre del ciclo, no de a una' $MR"
run "grep -n '^  SI NO RESPONDÉS' $MR"
echo; echo "### S1.h  Reanudación §6 — el criterio de la lista cerrada"
run "grep -n 'Toda consulta que R2 le hizo al humano es una escalada' $RE"
echo; echo "### S1.i  Memoria de antecedentes §2.2"
run "grep -n 'hubo que abrir los cinco y cruzarlos a mano\|tres no eran lo que decían\|Los cuatro «enlaces rotos» viajaron tres informes' $D/Informes/Memoria-De-Antecedentes-Casos-Resueltos.md"
echo; echo "### S1.j  «procedencia» por sección (ocurrencias y líneas)"
AWK='/^#+ /{s=$0; sub(/^#+ /,"",s); s=substr(s,1,45)} {l=$0; n=gsub(/[Pp]rocedencia/,"",l); if(n){o[s]+=n; c[s]++; t+=n; tl++}} END{for(k in o) printf "%3d occ %3d lín | %s\n",o[k],c[k],k; printf "TOTAL %d occ en %d líneas\n",t,tl}'
run "awk '$AWK' $MP | sort -t'|' -k2"
run "awk '$AWK' SDD/Devs/Rules/Migracion-Rules.md | sort -t'|' -k2"
echo; echo "### S1.k  La misma cláusula del snapshot, en el orquestador de migración"
run "grep -n 'contenido que el snapshot no refleja' $MI $MP SDD/Devs/Rules/Migracion-Rules.md"
echo; echo "### S1.l  T0 — el formato de salida no lleva commit"
run "awk '/^COMPUERTA DE ARRANQUE/{f=1} f{print NR\": \"\$0} f && /Veredicto:/{f=0}' $MP"
run "git -C <workspace>/PROG2/Geometria/Lab-Geometria show archivo/reanudacion-6-2026-09-12:SDD/Docs/Audit/Estado-Del-Destino-2026-09-12.md | grep -n 'Revisión leída'"
echo; echo "### S1.m  §5 — política de archivado: ruta por fecha, sufijo por versión, correcciones sin subir"
run "grep -n '_legacy/<YYYY-MM-DD>/\`, donde recibe el sufijo de la versión' $MP"
run "grep -n 'se absorben dentro de la versión en curso, sin subir' $MP"
run "grep -n 'Un despacho de corrección posterior a un audit es siempre \`EXISTENTE\`' $MP"
run "grep -n 'La regla de §8 que obliga al orquestador a archivar el estado previo antes de despachar \*\*no rige acá\*\*' $MP"
echo; echo "### S1.n  El propio reporte: «cuarta» y «tercera»"
run "grep -n 'es una cuarta\|es una tercera\|\*\*tercera\*\*' $D/Reportes/26-La-Pregunta-Previa-No-Distingue-Quien-Genero-La-Situacion.md"
run "grep -n 'Pero corre en puntos fijos\|ni existe fuera de la mesa el campo' $D/Reportes/26-La-Pregunta-Previa-No-Distingue-Quien-Genero-La-Situacion.md"
echo; echo "### S2.a  Búsqueda por ausencia — términos, sobre todo el árbol vivo (sin _legacy/)"
for t in "a medias" "dejó a medias" "estado a medias" "sin cerrar" "estado propio" "propio agente" "que el agente produjo" "produjo y no cerró" "generó el propio" "de esta corrida" "de la corrida" "origen del hecho" "procedencia del hecho" "preexistente" "autoinformad" "quién produjo" "quién generó"; do
  n=$(grep -rniw --include='*.md' --exclude-dir=_legacy -- "$t" . | wc -l); printf '%4d  «%s»\n' "$n" "$t"; done
echo; echo "--- líneas de los términos con ocurrencias, para clasificar su sentido"
for t in "a medias" "sin cerrar" "estado propio" "de esta corrida" "de la corrida" "preexistente"; do echo "== «$t»"; grep -rniw --include='*.md' --exclude-dir=_legacy -- "$t" . | cut -c1-170; done
echo; echo "### S2.b  Formatos de detención y de presentación — ¿alguno tiene campo de procedencia u origen?"
for b in "DETENCIÓN — {{familia}}" "CIERRE DE UNIDAD — " "   AMBIGÜEDAD DETECTADA" "PEDIDO DE CONOCIMIENTO" "TRABAJO ENTREGADO — " "COMPUERTA DE ARRANQUE — " ; do
  echo "== bloque «$b» ($MP)"; awk -v B="$b" 'index($0,B)==1{f=1} f{print} f && /^ *```/{if(++k==1){} } f && /^```$/{f=0;k=0}' $MP | grep -ni 'procedencia\|origen\|preexist\|propio\|quién' || echo "   (sin campo de procedencia u origen)"; done
echo "== bloque de escalada de mesa ($MR §7.1)"; awk '/^### 7\.1/{f=1} /^## 8\./{f=0} f' $MR | grep -ni 'procedencia\|origen\|preexist\|propio' || echo "   (sin campo de procedencia u origen)"
echo "== bloque «Estado del destino» ($RE §3)"; awk '/^Estado del destino:/{f=1} f{print} /^LO QUE SIGUE/{f=0}' $RE | grep -ni 'procedencia\|origen\|preexist\|propio'
echo "== bloque «RECOMENDACIÓN» ($RE §4.0)"; awk '/^RECOMENDACIÓN —/{f=1} f{print} /Escaladas al humano/{f=0}' $RE | grep -ni 'procedencia\|origen\|preexist\|propio' || echo "   (sin campo de procedencia u origen)"
echo "== fila del registro de decisiones pendientes ($MP §7.0)"; grep -n 'Una fila por decisión, con:' -A2 $MP
