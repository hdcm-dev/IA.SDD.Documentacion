cd /home/fernando/workspaces/workspace-dev/IA/SDD/IA.SDD
run(){ echo; echo "\$ $*"; eval "$@"; }
echo "### Colisión de los nombres candidatos — árbol vivo, sin _legacy/"
for t in "origen del hecho" "base de la corrida" "procedencia" "origen"; do printf '%5d  «%s»\n' "$(grep -rniow --include='*.md' --exclude-dir=_legacy -- "$t" . | wc -l)" "$t"; done
echo; echo "### «procedencia» y «origen» dentro de las secciones que la intervención toca (contexto de lectura: la sección, Vocabulario-Rules §9.2)"
SEC='BEGIN{IGNORECASE=1} /^#+ /{s=$0; sub(/^#+ /,"",s); s=substr(s,1,50)} { if (s ~ WANT) { l=$0; n=gsub(PAT,"",l); if(n) printf "%s:%d  [%s]  %s\n", FILENAME, NR, s, substr($0,1,150) } }'
MP=SDD/Devs/Orchestrator/Master-Prompt.md
for PAT in '[Pp]rocedencia' '[Oo]rigen\\b'; do
 echo "--- $PAT"
 awk -v PAT="$PAT" -v WANT='^§7.0|^§8 |^§8.1|^Qué lleva|^La autocorrección|^El cierre de unidad|^§9 |^T0|^§15' "$SEC" $MP
 awk -v PAT="$PAT" -v WANT='^7\\. Escalada|^7\\.1|^8\\. Criterios' "$SEC" SDD/Devs/Rules/Mesa-Rules.md
 awk -v PAT="$PAT" -v WANT='^§2 R0|^§3 R1|^§6 Criterios' "$SEC" SDD/Devs/Orchestrator/Master-Prompt-Reanudacion.md
 awk -v PAT="$PAT" -v WANT='^§8 M4' "$SEC" SDD/Devs/Orchestrator/Master-Prompt-Migracion.md
done
echo; run "grep -n '^## §8 M4\|^## §7 M3\|^## §9 M5' SDD/Devs/Orchestrator/Master-Prompt-Migracion.md"
