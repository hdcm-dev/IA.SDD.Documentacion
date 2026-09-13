#!/usr/bin/env bash
# Verificación del plan aplicado — intervención 04 (SDD 13.11)
cd <workspace>/IA/SDD/IA.SDD
B=476f927
MP=SDD/Devs/Orchestrator/Master-Prompt.md; MR=SDD/Devs/Rules/Mesa-Rules.md; RE=SDD/Devs/Orchestrator/Master-Prompt-Reanudacion.md
MI=SDD/Devs/Orchestrator/Master-Prompt-Migracion.md; CA=SDD/Devs/Rules/Catalogo-De-Criterios.md
ALC="$MP $MR $RE $MI $CA CHANGELOG.md"
run(){ echo; echo "\$ $*"; eval "$@"; }
echo "### V0  Qué se tocó (comprobación 7)"
run "git diff --stat $B -- . ':(exclude)_legacy'"
run "git status --short --untracked-files=all | grep -v '^ M' | sed 's#/[^/]*\$##' | sort | uniq -c | head"
echo; echo "### V1  Integridad del registro (comprobación 10): cabecera = mayor fila, en orden, sin repetidas"
python3 - <<'PY'
import re
for p in ['SDD/Devs/Orchestrator/Master-Prompt.md','SDD/Devs/Rules/Mesa-Rules.md','SDD/Devs/Orchestrator/Master-Prompt-Reanudacion.md','SDD/Devs/Orchestrator/Master-Prompt-Migracion.md','SDD/Devs/Rules/Catalogo-De-Criterios.md']:
    s=open(p,encoding='utf-8').read()
    cab=re.search(r'\*\*Versión(?: de las reglas)?:\*\* (\d+\.\d+)',s).group(1)
    vs=[tuple(map(int,m.groups())) for m in re.finditer(r'^\| (\d+)\.(\d+) \| 20',s,re.M)]
    mx='%d.%d'%max(vs)
    print(f"{p}: cabecera {cab} · mayor fila {mx} · filas {len(vs)} · en orden {vs==sorted(vs)} · repetidas {len(vs)-len(set(vs))} · termina en salto {s.endswith(chr(10))}")
PY
echo; echo "### V2  Corrida contra la base (§VI.3.2): ninguna fila fechada alterada por el reordenamiento"
run "git diff $B -- $ALC | grep -cE '^-\| [0-9]+\.[0-9]+ \| 20'"
python3 - <<'PY'
import subprocess,re
d=subprocess.run(['git','diff','476f927','--','SDD/Devs/Orchestrator/Master-Prompt.md','SDD/Devs/Rules/Mesa-Rules.md','SDD/Devs/Orchestrator/Master-Prompt-Reanudacion.md','SDD/Devs/Orchestrator/Master-Prompt-Migracion.md','SDD/Devs/Rules/Catalogo-De-Criterios.md','CHANGELOG.md'],capture_output=True,text=True).stdout.split('\n')
rem=[l[1:] for l in d if re.match(r'^-\| \d+\.\d+ \| 20',l)]
add=[l[1:] for l in d if re.match(r'^\+\| \d+\.\d+ \| 20',l)]
print('filas quitadas:',len(rem),'· agregadas:',len(add),'· quitadas que no reaparecen idénticas:',len([r for r in rem if r not in add]))
print('filas agregadas que son nuevas:',[a[:12] for a in add if a not in rem])
PY
echo; echo "### V3  Barrido por concepto (§VI.3.2): formas anteriores, árbol vivo con bloques cercados"
for pat in 'Hay que separar dos' 'no agrega ninguna detención ni quita ninguna' 'devuelve la lista de ambigüedades al usuario'; do
 echo; echo "\$ grep -rn --include='*.md' --exclude-dir=_legacy -- '$pat' ."; grep -rn --include='*.md' --exclude-dir=_legacy -- "$pat" . | cut -c1-170; echo "(total: $(grep -rn --include='*.md' --exclude-dir=_legacy -- "$pat" . | wc -l))"; done
run "grep -c 'COMPUERTA DE ARRANQUE — {{' $MP"
run "grep -c '^  Base:            {{' $MP"
run "grep -c '^  Base de la corrida:      {{' $RE"
run "grep -rn --include='*.md' --exclude-dir=_legacy 'contenido que el snapshot no refleja' . | grep -c 'origen del hecho'"
run "grep -rn --include='*.md' --exclude-dir=_legacy 'contenido que el snapshot no refleja' . | wc -l"
echo; echo "### V4  Presencia de la forma vigente, por archivo"
for t in 'origen del hecho' 'base de la corrida' 'lote de la fase' 'ajeno a la corrida'; do echo "== «$t»"; grep -rlic --include='*.md' --exclude-dir=_legacy -- "$t" . >/dev/null; grep -ric --include='*.md' --exclude-dir=_legacy -- "$t" . | grep -v ':0$'; done
echo; echo "### V5  Regla 4 sobre el texto propio: «origen» suelto en líneas agregadas"
run "git diff -U0 $B -- SDD | grep '^+' | grep -v '^+++' | grep -oE '.{0,40}[Oo]rigen([^a-zA-Z]|\$).{0,25}' | grep -v 'rigen del hecho'"
run "git diff -U0 $B -- SDD | grep '^+' | grep -v '^+++' | grep -ci 'procedencia'"
echo; echo "### V6  Autosuficiencia (comprobación 2): el texto agregado a las reglas no cita afuera del repositorio"
run "git diff -U0 $B -- SDD | grep '^+' | grep -v '^+++' | grep -ciE 'Lab-Geometria|IA\.SDD\.Documentacion|reporte .?2[0-9]'"
echo; echo "### V7  Referencias internas nuevas (comprobación 3)"
run "grep -n '^### 7.1 Forma de la escalada' $MR"
run "grep -n '^### T0 \|^### T5 ' $MP"
run "grep -n '^## §5.1 R4' $RE"
run "grep -n '^### §7.0 \|^## §8.1 \|^## §12.1 \|^## §9 \|^## §15 ' $MP"
echo; echo "### V8  Coherencia interna (comprobación 9): la tabla de autocorrección tiene tres filas y «Qué no cambia» ya no niega que se quiten detenciones"
run "awk '/^### La autocorrección/{f=1} f && /^\| \*\*/{c++} /^\*\*Y la contraparte/{f=0} END{print c}' $MP"
run "grep -n 'Hay que separar tres' $MP"
run "grep -n 'Esta sección no agrega ninguna detención' $MP"
run "grep -n 'Ante la duda, se detiene\*\* —sobre un hecho ajeno a la corrida—' $MP"
echo; echo "### V9  Catálogo (comprobación 12): filas de §3 y total de §4"
run "awk '/^## 3\./{f=1} /^## 4\./{f=0} f && /^\| / && !/^\| Situación/ && !/^\|---/' $CA | wc -l"
run "git show $B:$CA | awk '/^## 3\./{f=1} /^## 4\./{f=0} f && /^\| / && !/^\| Situación/ && !/^\|---/' | wc -l"
run "grep -n '^| \*\*Total\*\* | \*\*222\*\*' $CA"
echo; echo "### V10  Snapshot _legacy/13.10 (§VI.5)"
run "grep -h '^\*\*Versión' _legacy/13.10/$MP _legacy/13.10/$MR _legacy/13.10/$RE _legacy/13.10/$MI _legacy/13.10/$CA"
run "find _legacy/13.10 -type f | wc -l"
run "git ls-tree -r --name-only $B -- Conocimiento Examples PROMPTS README.md SDD Templates | wc -l"
run "ls _legacy/13.10/CHANGELOG.md _legacy/13.10/_legacy 2>&1 | head -2"
run "diff -r <(cd _legacy/13.10 && find . -type f | sort) <(git ls-tree -r --name-only $B -- Conocimiento Examples PROMPTS README.md SDD Templates | sed 's#^#./#' | sort) && echo 'mismos archivos'"
run "for f in \$(cd _legacy/13.10 && find . -type f); do git show $B:\${f#./} | cmp -s - _legacy/13.10/\$f || echo DIFIERE \$f; done | wc -l"
