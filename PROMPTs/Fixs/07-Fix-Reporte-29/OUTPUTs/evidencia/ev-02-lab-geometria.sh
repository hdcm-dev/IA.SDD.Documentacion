#!/usr/bin/env bash
# Solicitud 2: reproducir los recuentos de BT y de US en Lab-Geometria, por bloque (proyecto de
# código) y por unidad de entrega, sobre objetos commiteados (no se lee el disco: otro agente
# escribe en el árbol de trabajo).
set -e
cd <workspace>/PROG2/Geometria/Lab-Geometria
echo "== SHA de main y de fase-k/backlog-tecnico-v2 =="
git rev-parse main
git rev-parse fase-k/backlog-tecnico-v2

for REV in main fase-k/backlog-tecnico-v2; do
  echo
  echo "== BT por bloque, unidad GeometriaFactory-Api ($REV) =="
  git show "$REV":SDD/Docs/Unidades-Entrega/GeometriaFactory-Api/06-Backlog-Tecnico/Backlog-Tecnico.md \
    | grep -o -E "^\| BT-[0-9]{5} \|" | sort -u \
    | awk '{n=substr($2,4)+0; c[int(n/1000)]++} END{for(b in c) print b, c[b]}'
done

echo
echo "== BT por bloque, unidad GeometriaFactory-Web (main) =="
git show main:SDD/Docs/Unidades-Entrega/GeometriaFactory-Web/06-Backlog-Tecnico/Backlog-Tecnico.md \
  | grep -o -E "^\| BT-[0-9]{5} \|" | sort -u \
  | awk '{n=substr($2,4)+0; c[int(n/1000)]++} END{for(b in c) print b, c[b]}'

echo
echo "== carpetas tareas-tecnicas/ e historias-usuario/ existentes en cada rama =="
for REV in main fase-k/backlog-tecnico-v2; do
  echo "-- $REV --"
  git ls-tree -r --name-only "$REV" | grep -oE "Unidades-Entrega/[^/]+/06-Backlog-Tecnico/(tareas-tecnicas|historias-usuario)/" | sort -u
done

echo
echo "== US por bloque, Product-Backlog de GeometriaFactory-Api (main, todas las menciones únicas) =="
git show main:SDD/Docs/Unidades-Entrega/GeometriaFactory-Api/06-Backlog-Tecnico/Product-Backlog.md \
  | grep -o -E "US-[0-9]{5}" | sort -u \
  | awk '{n=substr($1,4)+0; c[int(n/1000)]++; t++} END{for(b in c) print b, c[b]; print "total", t}'

echo
echo "== US por bloque, Product-Backlog de GeometriaFactory-Web (main) =="
git show main:SDD/Docs/Unidades-Entrega/GeometriaFactory-Web/06-Backlog-Tecnico/Product-Backlog.md \
  | grep -o -E "US-[0-9]{5}" | sort -u \
  | awk '{n=substr($1,4)+0; c[int(n/1000)]++; t++} END{for(b in c) print b, c[b]; print "total", t}'

echo
echo "== US con archivo individual bajo historias-usuario/, por proyecto (bloque), main =="
git ls-tree -r --name-only main | grep -E "historias-usuario/US-[0-9]{5}" \
  | grep -oE "US-[0-9]{5}" | sort -u \
  | awk '{n=substr($1,4)+0; c[int(n/1000)]++; t++} END{for(b in c) print b, c[b]; print "total", t}'

echo
echo "== archivos tareas-tecnicas/ en fase-k (¿ya movió la API sus 35 BT?) =="
git ls-tree -r --name-only fase-k/backlog-tecnico-v2 | grep -c "tareas-tecnicas/BT-000[0-3][0-9]" || true
