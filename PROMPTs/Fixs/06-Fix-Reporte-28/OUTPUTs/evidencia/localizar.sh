#!/usr/bin/env bash
# Localiza las ocurrencias de un término por sección y por archivo. No decide nada.
# uso: localizar.sh 'término' archivo...   (sin distinguir mayúsculas; los títulos dentro de cercos no abren sección)
t=$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]'); shift
for f in "$@"; do
  awk -v t="$t" -v f="$f" '
    BEGIN { s="(antes del primer título)" }
    /^```/ { cerco = !cerco }
    !cerco && /^#{1,6} / { s = $0 }
    { l = tolower($0); c = 0
      while ((i = index(l, t)) > 0) { c++; l = substr(l, i + length(t)) }
      if (c) { if (!(s in n)) { k++; nom[k] = s }; n[s] += c; tot += c } }
    END { for (j = 1; j <= k; j++) printf "%s\t%s\t%d\n", f, nom[j], n[nom[j]]
          printf "%s\t(archivo)\t%d\n", f, tot + 0 }' "$f"
done
