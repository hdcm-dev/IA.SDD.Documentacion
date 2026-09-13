#!/usr/bin/env bash
# Impacto sobre destinos: sólo lectura. Proxy de afirmaciones de colisión léxica en SDD/Docs, fuera de carpetas archivadas (/_*).
W=<workspace>
for d in Repos-RPIs/RPI.VideoControl DEV/SelfHosted.Service.Core DEV/SAI.Service.Core PROG2/Geometria/Lab-Geometria; do
  tot=$(grep -rniE --include='*.md' 'colisi' $W/$d/SDD/Docs 2>/dev/null | grep -v '/_' | wc -l)
  lex=$(grep -rniE --include='*.md' 'colisi' $W/$d/SDD/Docs 2>/dev/null | grep -v '/_' | grep -ciE 'términ|sentido|referente|polisem|disjunt')
  cmd=$(grep -rniE --include='*.md' 'colisi' $W/$d/SDD/Docs 2>/dev/null | grep -v '/_' | grep -iE 'términ|sentido|referente|polisem|disjunt' | grep -ciE 'grep|wc -l')
  printf "%-32s líneas con colisi=%-4s de ellas léxicas=%-4s con comando en la línea=%s\n" "$d" "$tot" "$lex" "$cmd"
done
