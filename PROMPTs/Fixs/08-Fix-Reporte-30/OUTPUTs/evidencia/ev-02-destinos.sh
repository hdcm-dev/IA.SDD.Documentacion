#!/usr/bin/env bash
# Solicitud 2: alcance real. Destinos del workspace con SDD/Docs, y por cada uno: ecosistemas en la construcción y samples no compilables.
W=/home/fernando/workspaces/workspace-dev
echo '### find -type d -path "*/SDD/Docs" -not -path "*/_legacy/*"'
find $W -type d -path "*/SDD/Docs" -not -path "*/_legacy/*" 2>/dev/null | sort
echo; echo '### repositorio al que pertenece cada ruta (git-common-dir)'
for p in $(find $W -type d -path "*/SDD/Docs" -not -path "*/_legacy/*" 2>/dev/null | sort); do r=${p%/SDD/Docs}; echo "$r -> $(git -C $r rev-parse --path-format=absolute --git-common-dir 2>/dev/null) @ $(git -C $r rev-parse --short HEAD 2>/dev/null) [$(git -C $r rev-parse --abbrev-ref HEAD 2>/dev/null)]"; done
for r in $W/PROG2/Geometria/Lab-Geometria $W/Repos-RPIs/RPI.VideoControl $W/DEV/SAI.Service.Core $W/DEV/SelfHosted.Service.Core; do
  echo; echo "======== $r (HEAD $(git -C $r rev-parse --short HEAD))"
  echo "-- archivos de proyecto por ecosistema (commiteados, sin node_modules):"
  git -C $r ls-files | grep -v node_modules | grep -E '(\.csproj|\.sln|package\.json|pyproject\.toml|Cargo\.toml|pom\.xml|go\.mod)$' | grep -v '^samples/' | sed -E 's#.*\.(csproj|sln)$#dotnet: &#; s#.*package\.json$#node: &#' 
  echo "-- carpetas de samples (samples/<seg>/<NN>) y cuáles no tienen .csproj:"
  if git -C $r ls-files samples | grep -q .; then
    for x in $(git -C $r ls-files samples | awk -F/ 'NF>=4{print $1"/"$2"/"$3}' | sort -u); do git -C $r ls-files $x | grep -q '\.csproj$' && echo "  compila  $x" || echo "  NO-COMP  $x"; done
  else echo "  (sin samples/ commiteado)"; fi
done
echo; echo '### RPI.VideoControl: el proyecto PinMap corre la cadena de JavaScript dentro de su construcción'
git -C $W/Repos-RPIs/RPI.VideoControl show HEAD:src/VideoControl.PinMap/VideoControl.PinMap.csproj | grep -n '<Target Name\|<Exec Command\|<Error '
git -C $W/Repos-RPIs/RPI.VideoControl show HEAD:SDD/Intake/PRODUCT-MANIFEST-Videocontrol-De-Camaras-Y-Actuadores.md | grep -n "^| \`VideoControl-PinMap\`"
