# Informe de la comisión de Verificación (N2, núcleo permanente) — mesa de la intervención 09

**Comisión:** Verificación (N2). Siglas `M9-VER-NN`.
**Fecha:** 2026-09-13.
**Base leída:** contrato de entrada; `plan/Expediente-Rules.md` 1.0 (borrador, mtime 14:56:51) y `plan/20-Plan-De-Aplicacion.md`; folio 016 del expediente 0001 (`IA.SDD-i09`, rama `intervencion/09-reporte-31`); `SDD-Development-Guide.md` §II.7 y Parte V l.691; reporte 31 §7 (`IA.SDD.Documentacion-i09/Reportes/31-…`); `ev-01`, `ev-02`, `ev-03`; el caso de prueba `scratchpad/caso` (git, `main` `1d6a3dc`) y el guion `a1a10.sh`. Destinos sólo por `git ls-tree`/`git grep`/`git show`: `Lab-Geometria` `main`, `RPI.VideoControl`, `IA.SDD-i09` `main`.
**Fuentes externas:** CommonMark spec §6.1 (code spans) — no la consulté en línea; apliqué de memoria la regla «un span cierra con una corrida de backticks de igual longitud y los escapes `\` no actúan dentro», simulada con un guion propio (M9-VER-05). Si la mesa quiere ancla E1 sobre eso, hace falta un renderizador (no hay `pandoc`, `cmark` ni `markdown` en el host).
**Dónde trabajé:** copias del caso bajo `scratchpad/mesa/tmp-ver/` (`f1`…`f7e`, `g1`…`g3b`, `h1`…`h7`, `k1`, `k2`, `p18`). No modifiqué `scratchpad/caso/` ni ningún repositorio.

---

## Hallazgos

### M9-VER-01 · A9 no puede fallar para ninguna pieza `.txt` — P1 · E3

**Qué.** El comando de A9 acepta una pieza si abre con `Método|Comando|Medio` **o** si existe `"${f%.*}.txt"`. Para una pieza cuyo propio nombre termina en `.txt`, `"${f%.*}.txt"` es **la pieza misma**: la condición es verdadera siempre. Y como el `.txt` hermano de un binario es a su vez una pieza `.txt`, tampoco se lo verifica nunca. Además, el comando sólo mira **uno** de los tres campos que la regla exige (§3.4: Método/Comando, Base o Fecha-hora, Quién).

**Prueba (copia `f6`, `f6e`, `f6c`):**
```
$ printf 'hola\n' > $X/evidencia/001-arbol.txt            # sin ninguna de las tres líneas
== A9
                                                           # ← vacío: pasa
$ printf '\x89PNG' > $X/evidencia/002-captura.png; printf 'nada\n' > $X/evidencia/002-captura.txt
== A9
                                                           # ← vacío: pasa
$ printf 'Comando: git ls-tree main\nsalida...\n' > $X/evidencia/001-arbol.out   # sin Base ni Quién
== A9
                                                           # ← vacío: pasa
```
Contraste: la misma pieza sin las tres líneas pero con extensión `.out` sí falla (`f6b` → `…/evidencia/001-arbol.out`). El hueco es por extensión, no por contenido. La forma de evidencia más común del expediente real es justamente `.txt` (`ev-07-presentacion-original.txt`, `.meta.txt`; en `Lab-Geometria` 25 de 37 piezas no-md son `.txt`: `git -C Lab-Geometria ls-tree -r --name-only main SDD/Expedientes | grep -v '\.md$' | sed -E 's/.*\.//' | sort | uniq -c` → `7 diff, 3 py, 2 sh, 25 txt`).

**Impacto.** El criterio 1 del reporte 31 §7 («los diez criterios corren con su comando dentro de la regla») no se cumple para A9: es un criterio que verifica sólo por nombre de archivo. La evidencia queda sin procedencia y A9 dice que está bien.

**Dirección.** Que la excepción del hermano sea `[ "${f##*.}" != txt ] && [ -e "${f%.*}.txt" ]` (o equivalente), y que el `.txt` hermano se verifique él mismo; y que A9 compruebe las tres líneas (`head -3 | grep -c` de los tres rótulos → 3) o la regla diga expresamente que A9 verifica sólo la primera y las otras dos son I4.

---

### M9-VER-02 · A4 acepta tipos fuera del conjunto cerrado por coincidencia de subcadena — P1 · E3

**Qué.** El segundo comando de A4 filtra con `grep -vcE 'presentacion|providencia|informe|constancia|resolucion|archivo'` sin anclas: cualquier valor que **contenga** uno de los seis pasa.

**Prueba (copia `f2b`):**
```
$ grep -h '^| Tipo' $X/actuaciones/*.md
| Tipo | no-presentacion |
| Tipo | archivos |
== A4
0                                                          # ← pasa con dos tipos que no existen
```
Contraste: `| Tipo | dictamen |` (`f2`) sí da `1`, y `| Tipo | Resolucion |` (`f2c`) da `1` (distingue mayúsculas: correcto).

**Impacto.** §3.2 dice que el mapeo tipo→estado es **total** y se deriva del último folio; con `archivos` o `no-presentacion` el estado derivado no existe y A4 dice `0`. Un `informe-preliminar` inventado por un orquestador pasa la compuerta.

**Dirección.** Anclar el patrón al valor de la celda: `grep -vcE '^\| Tipo \| (presentacion|providencia|informe|constancia|resolucion|archivo) \|$'`.

---

### M9-VER-03 · A1 es de alcance repositorio y falla de forma permanente en los dos repositorios reales; §5.1 no lo exime porque A1 no toma `$X` — P1 · E1

**Qué.** §5.1 dice que a los dos expedientes históricos «no se les exige los criterios de §6». Pero A1 no se corre sobre un expediente: se corre sobre la carpeta `SDD/Expedientes`/`Expedientes` entera, y la carpeta de cuatro dígitos cuenta.

**Comando y salida (sobre los commits, no sobre el árbol):**
```
$ cd IA.SDD-i09; git ls-tree --name-only main Expedientes/ | sed 's#Expedientes/##' | grep -vcE '^[0-9]{5}-'
1
$ cd Lab-Geometria; git ls-tree --name-only main SDD/Expedientes/ | sed 's#SDD/Expedientes/##' | grep -vcE '^[0-9]{5}-'
1
```
Coincide con `ev-03` (`== A1` → `1` en los dos). Reproducido además en `g1`: una carpeta `0001-Historico` al lado de `00001-…` da `1`.

**Impacto.** Desde el día en que se aplique el plan, ningún auditor puede obtener A1 → `0` en `IA.SDD` ni en `Lab-Geometria`, y la regla no le dice que ese `1` es esperado. O se ignora A1 (y deja de ser compuerta) o se renombra el histórico (rompe S1 y §5.1). Queda además sin declarar qué número sigue en un repositorio con `0001-…` histórico: ¿`00001` o `00002`? «Nunca reciclado» (§3.1) no lo resuelve porque `0001` y `00001` son el mismo entero.

**Dirección.** A1 tiene que excluir por comando lo que §5.1 declara: p. ej. `ls SDD/Expedientes | grep -vE '^[0-9]{4}-' | grep -vcE '^[0-9]{5}-'` → `0`, con la frase «las carpetas de cuatro dígitos son forma histórica (§5.1) y A1 las omite»; y §3.1 o §5.1 tienen que decir con qué número arranca la serie de cinco dígitos donde ya hay un histórico.

---

### M9-VER-04 · A7 fija `main` por nombre y no ve los renombres que S1 dice cubrir — P2 · E3

**Qué.** (a) El comando tiene `main` escrito dos veces. La norma no fija el nombre de la rama principal (`git grep -nE '\bmain\b|rama principal' main -- SDD/Devs/Rules SDD/Devs/Orchestrator SDD/Guides` → sólo `Master-Prompt.md` l.1653 y l.1747 hablan de «rama principal» sin nombrarla; `Rules-Devops.md` l.269/402/452 son ejemplos de destino). Los tres repositorios medidos sí usan `main` (`git symbolic-ref refs/remotes/origin/HEAD` → `refs/remotes/origin/main` en los tres), así que hoy no muerde; en un destino con `master` el criterio aborta:
```
(h5, rama master) $ m=$(git log --first-parent --format=%h --diff-filter=A main -- "$X/README.md" | tail -1); …
fatal: bad revision 'main'
(fusión: )
fatal: bad revision '..main'
```
(b) §4 S1: «El control cubre la carpeta entera **y los renombres**». Pero `m` se calcula con `--diff-filter=A` sin `-M` sobre `README.md`, de modo que un renombre del README o de la carpeta entera **es** el commit `m`, y `m..main` lo excluye:
```
(h4, readme.md → README.md, luego borro un folio)
(fusión: 9692f8d)            ← 9692f8d es «renombra a README.md», no la apertura
799ae78 borro folio          ← lo posterior sí; el renombre, no
(h4b, 00001-Enlace-Roto → 00001-Enlace-Roto-En-Roadmap)
(fusión: b605bc3)            ← el commit del renombre
                             ← vacío: el renombre de la carpeta es invisible
$ git log -M --diff-filter=MDR --name-status --format='%h %s' main -- SDD/Expedientes
b605bc3 renombra carpeta
R100 SDD/Expedientes/00001-Enlace-Roto/README.md  SDD/Expedientes/00001-Enlace-Roto-En-Roadmap/README.md
R100 …/actuaciones/001-presentacion-enlace-roto.md  …
```
(c) `tail -1` toma el commit **más viejo** en que apareció el README; si el README se borró y se volvió a agregar (`h7`), el borrado sí aparece (`5e8bb7b borra README`), así que ese caso está bien.

**Impacto.** Un título «precisado» por renombre de carpeta (que §3.1 prohíbe implícitamente: «un título que se precisa después no cambia el número», pero no dice que no cambia la carpeta) pasa A7 limpio. En un destino con otra rama principal, A7 no corre.

**Dirección.** Calcular `m` sobre la carpeta y con `-M` (`git log --first-parent -M --diff-filter=A --format=%h <principal> -- "$X" | tail -1`) o, mejor, medir renombres sobre `SDD/Expedientes` entero y no sobre `$X`; y parametrizar la rama (`B=$(git symbolic-ref --short refs/remotes/origin/HEAD | sed 's#origin/##')` o declarar en §6 «`main` es la rama principal; si se llama distinto, se reemplaza»). §3.1 debería decir que la carpeta no se renombra.

---

### M9-VER-05 · A8 pasa en silencio si la cerca no es exactamente ```` ```testimonio ```` y su comando se parte al renderizar la regla — P2 · E3

**Qué.** (a) A8 busca `^```testimonio$`. Un espacio al final de la cerca, una cerca `~~~testimonio` o un atributo hacen que el folio **no se considere testimonio** y A8 quede vacío sin verificar nada:
```
(f5d) $ sed -i 's/^```testimonio$/```testimonio /' …/001-presentacion-enlace-roto.md
== A8
                                                           # ← vacío: no verificó la huella
```
Contraste: huella cambiada (`f5`), testimonio alterado con huella vieja (`f5b`) y campo `Huella` ausente (`f5c`) sí dan `HUELLA …`.
(b) La línea 307 de la regla escribe el comando dentro de un span de un backtick y contiene `\`$h\``. Un renderizador CommonMark no procesa escapes dentro de un span, de modo que el primer `\`` **cierra** el span; simulado sobre la línea:
```
SPAN: `for f in $(grep -l '^```testimonio$' …; grep -q "^| Huella | \`
(prosa) $h\
SPAN: `" "$f" || echo "HUELLA $f"; done`
```
En texto crudo el comando funciona (lo corrí con `\`` tal cual: rc=0). Copiado de una vista renderizada, no.

**Impacto.** (a) el único criterio que sostiene «el original es la pieza» (§3.3) se puede eludir sin querer con un espacio; (b) el criterio que la regla dice que «no necesita un guion aparte» sólo es copiable desde el fuente, no desde la regla leída.

**Dirección.** (a) que A8 cuente primero cuántos folios llevan `Huella` o `Canal` y exija que coincida con los que tienen la cerca exacta, o que busque la cerca con `^```testimonio *$` y la regla declare la cerca como única forma; (b) escribir el `grep` de la huella sin backticks (`grep -q "^| Huella | .$h"` o comparar con `awk`), o poner el bloque A8 en una cerca de código de varias líneas.

---

### M9-VER-06 · A10: el alcance, las citas calificadas y los ejemplos concretos no están declarados y el resultado depende de accidentes del regex — P2 · E1/E3

**Qué.** Sobre el framework real, hoy:
```
$ cd IA.SDD-i09; git grep -ohE '(^|[^/A-Za-z0-9.-])(SDD/)?Expedientes/[0-9]{5}-[A-Za-z0-9-]+' main -- SDD Expedientes
(vacío, rc=1)
$ git grep -ohE '(SDD/)?Expedientes/[0-9]+-[A-Za-z0-9-]+' main | sort | uniq -c
      1 Expedientes/0001-Expedientes-Como-Comportamiento-Del-Framework
     18 SDD/Expedientes/0001-Expedientes-Como-Comportamiento-Del-Framework   ← ruta inexistente en el framework, 4 dígitos: A10 no la ve
      4 SDD/Expedientes/0001-Migracion-Normativa-A-13
```
Sobre el borrador de la regla, las cinco rutas ilustrativas (l.160, 161, 162, 270, 272) **no** matchean, pero por accidente: `[A-Za-z0-9-]+` exige al menos un carácter tras el guion y `<`, `…` y `'` no lo son. Probado con cadenas sueltas:
```
ver `SDD/Expedientes/00002-<Titulo>/`                                         -> []
ver SDD/Expedientes/00002-…                                                   -> []
ver Lab-Geometria SDD/Expedientes/00009-Ajeno/  (forma del dictamen Q4)        -> [SDD/Expedientes/00009-Ajeno]   ← marcada no resuelta
ver Lab-Geometria/SDD/Expedientes/00009-Ajeno/  (forma de la regla §3.1)       -> []
el caso de prueba SDD/Expedientes/00001-Enlace-Roto-En-Roadmap (nota #16)     -> [SDD/Expedientes/00001-Enlace-Roto-En-Roadmap]  ← marcada
SDD/Expedientes/00004-Con.Punto                                               -> [SDD/Expedientes/00004-Con]  ← truncada
```
Además el pathspec `-- SDD Expedientes` deja fuera, en el framework, `README.md`, `CHANGELOG.md` y `Conocimiento/` (cambios 9, 13 y 17 del plan); probado en `f7d`: una cita rota en el `README.md` raíz no se reporta. Y una cita rota que sólo está en el árbol de trabajo sin `git add` tampoco (`f7e`), lo que es coherente con §3.4 pero no está dicho.

**Impacto.** Después de aplicar el plan, la nota de coherencia (#16), la guía de usuario F-17 (#11) y el catálogo (#12) viven bajo `SDD/`: cualquier ejemplo **concreto** que escriban (`00001-Enlace-Roto-En-Roadmap`, el caso de prueba) hará fallar A10 en el framework para siempre; y cualquier pieza de `evidencia/` que registre una corrida fallida de A10 también. La forma calificada del dictamen Q4 (`<repositorio> <carpeta>`, con espacio) se marca como rota; la regla la cambió a `<repositorio>/…` sin decir que lo hizo por esto.

**Dirección.** Declarar en §3.1/§6: (i) toda ruta ilustrativa lleva `<Titulo>` o `…`, nunca un título concreto; (ii) la cita calificada es `<repositorio>/SDD/Expedientes/…` con barra y sin espacio, y por eso A10 la omite; (iii) el pathspec de A10 en el framework incluye `README.md CHANGELOG.md Conocimiento` o se declara que sólo se mira `SDD` y `Expedientes`; (iv) si se quiere que `evidencia/` pueda registrar salidas con rutas rotas, excluirla (`:!*/evidencia/*`).

---

### M9-VER-07 · El guion `a1a10.sh` no es idéntico a §6 y `ev-03` se midió con una versión anterior de los comandos — P2 · E1

**Qué.** (a) Diferencias entre `a1a10.sh` y la regla, extraídas por comparación de cadenas:
```
A1  regla: ls SDD/Expedientes | grep -vcE '^[0-9]{5}-'; ls SDD/Expedientes | cut -c1-5 | sort | uniq -d   (y «ls Expedientes» en el framework)
    guion: ls "$P" | …   con P="${3:-SDD/Expedientes}"                         ← parametrizado
A7  regla: m=$(…); git log -M …
    guion: m=$(…); echo "(fusión: $m)"; git log -M …                          ← eco intercalado
A2–A6, A8 (tras desescapar \`), A9, A10: idénticos
```
Ninguna cambia el resultado, pero el mandato dice que toda diferencia es hallazgo y el criterio 1 del reporte 31 dice «si hace falta un script aparte, no alcanzó»: el presidente verificó con un guion, no con la regla.
(b) `ev-03` (mtime `14:56:29`) es anterior a `a1a10.sh` y a `Expediente-Rules.md` (`14:56:51`), y su salida no puede provenir del A9 de la regla:
```
ev-03 l.31 ss.:  head: error al leer '…/evidencia/ev-06-segunda-convocatoria': Es un directorio
```
`find -type f` no entrega directorios; ese error viene de un `for f in $X/evidencia/*`. Con el A9 de la regla, sobre la misma base, la lista es distinta: entran las 33 piezas de `ev-06/` y `ev-08/` (subcarpetas), y `ev-07-presentacion-original.txt` pasa por M9-VER-01.

**Impacto.** La evidencia con la que el contrato de entrada afirma «E-3 = insumo», «los dos expedientes reales dan tal cosa» no reproduce contra la regla que la mesa evalúa. Es exactamente la clase de desincronización que §II.7 de la guía quiere evitar.

**Dirección.** Volver a tomar `ev-03` con los comandos de §6 tal como queden después de esta mesa, sin guion intermedio (o con el guion asentado como evidencia con su comando adentro), y fechar la pieza después de la regla.

---

### M9-VER-08 · `Expedientes/` del framework contiene cinco ejecutables y ninguna comprobación lo alcanza; la regla no declara el hueco de la Parte V — P2 · E1

**Qué.**
```
$ cd IA.SDD-i09; git ls-tree -r --name-only main SDD | grep -v '\.md$' | wc -l        → 0     (Parte V, l.691: cumple)
$ git ls-tree -r --name-only main Expedientes | grep -v '\.md$' | sed -E 's/.*\.//' | sort | uniq -c
      5 out   5 sh   2 txt   (+4 SHA256SUMS sin extensión)
$ git ls-tree -r main Expedientes | grep -c '^100755'                                    → 5
$ grep -nE '\.sh|ejecutable|-not -name' plan/Expediente-Rules.md
36: | **No distribuye código** | Cada comando de verificación vive en §6 … La evidencia lleva su comando dentro del archivo |
```
La regla dice «no distribuye código» pensando en los verificadores (§6) y en el guion aparte; no dice qué es un `.sh` con bit de ejecución en `evidencia/`, ni qué comando lo controla. El plan (#8) toca §VI.5 y §VI.3 comprobación 2 de la guía, pero no la Parte V l.691 ni §II.7, donde vive la comprobación `find SDD -type f -not -name '*.md'`.

**Impacto.** El criterio «el framework no distribuye código ejecutable» (§II.7) queda verdadero por la letra (`find SDD`) y falso por el árbol (`Expedientes/*.sh`, modo `100755`). Quien lo señale tiene con qué; quien lo defienda, no.

**Dirección.** Declarar en §2 (tercera exclusión) o §3.4 que `evidencia/` es registro y admite `.sh`, `.out`, `.txt` como piezas **no ejecutables**, y dar la comprobación: `git ls-tree -r <principal> Expedientes | grep -vc '^100644 blob'` → `0` (sin bit de ejecución, sin enlaces simbólicos), o `find Expedientes -type f -perm -u+x` → vacío; y que el plan #8 sume a §II.7/Parte V l.691 la frase «`Expedientes/` está fuera del conjunto normativo; su control es el de `Expediente-Rules.md` §6/§7». Los cinco `100755` del 0001 quedan como forma histórica y se nombran.

---

## Respuestas a las preguntas del mandato

**1. ¿Los comandos del guion son idénticos a §6?** Corrí el guion sobre el caso (`bash a1a10.sh …/caso SDD/Expedientes/00001-Enlace-Roto-En-Roadmap`): A1 `0`, A2–A6 vacíos, A7 `(fusión: b621d58)` + `1d6a3dc borro evidencia`, A8–A10 vacíos. Diferencias: A1 parametrizado con `"$P"`, A7 con un `echo` intercalado; A8 idéntico una vez desescapado `\``; el resto byte a byte igual (M9-VER-07).

**2. Cada criterio fallando.** Fallan cuando deben: salto de folio (A3 → `SALTO 003-…`), tipo `dictamen` (A4 → `1`), `Corrige | 007` (A5 → `007`), pase ausente (A6 → `SIN PASE 002-…`), huella cambiada / testimonio alterado / sin campo Huella (A8 → `HUELLA …`), evidencia `.out` sin sus tres líneas (A9 → la lista), cita a `00002-No-Existe` (A10 → la lista), borrado en `evidencia/` después de la fusión (A7 → `1d6a3dc borro evidencia`: **el criterio 4 del reporte 31 §7 se cumple**). No fallan cuando deberían: evidencia `.txt` sin las tres líneas (M9-VER-01, P1), tipo por subcadena (M9-VER-02, P1), cerca con espacio (M9-VER-05). Fallan cuando no deberían: A6 con una línea vacía final después de `Sigue:` (`f4b` → `SIN PASE`; la regla dice «última línea», así que es por la letra, pero cualquier editor que agregue una línea vacía tumba el criterio — P3, no numerado). Observaciones P3 sin numerar: A6 no comprueba que un `archivo` **no** lleve pase (`k2`: archivo con pase → pasa); A3 cuenta todo archivo de `actuaciones/` (`003-nota.txt` cuenta como folio) mientras A4 sólo mira `*.md` (`k1`), así que un folio sin `.md` pasa A4 sin cabecera.

**3. A7.** Merge commit (`h1`): `m` = el merge, la edición en rama antes de fusionar no se ve, el borrado posterior sí — correcto. Squash (`h2`): `m` = el squash, la edición posterior se ve — correcto. Directo en `main` sin rama (`h3`): `m` = el primer commit con README, y **una edición en el segundo commit antes de cualquier push se marca**; lo mismo con fusión fast-forward o rebase-and-merge (`h6`: `2a5bb39 edita folio en rama antes de fusionar` aparece). No es falso en sentido estricto (está en la rama principal), pero contradice la frase de §4 «antes de la fusión la inmutabilidad se declara no observable»: con ff o commit directo **sí es observable y A7 la cuenta**; la regla tiene que decirlo (P3, dirección: «con fast-forward o commit directo la historia previa cuenta como publicada»). README renombrado y carpeta renombrada: invisibles (M9-VER-04). Rama que no se llama `main`: aborta (M9-VER-04).

**4. A10 sobre el framework real.** Devuelve vacío (rc=1): no hay ninguna cita de cinco dígitos en `main`. Las rutas ilustrativas `SDD/Expedientes/00002-<Titulo>/`, `Expedientes/00002-<Titulo>/`, `00002-…` y `'Expedientes/00002-'` **no** las marca, porque `<`, `…` y `'` no entran en `[A-Za-z0-9-]+`; es un accidente del regex, no una decisión escrita. Para que no dependa del accidente, la regla tiene que declarar que toda ruta ilustrativa lleva `<Titulo>` o `…` y que un título concreto en prosa normativa es una cita (M9-VER-06). El riesgo concreto está en los cambios 11, 12 y 16 del plan, que viven bajo `SDD/` y van a querer citar el caso de prueba `00001-Enlace-Roto-En-Roadmap`.

**5. Los dos expedientes reales y §5.1.** «No se les exige los criterios de §6» exime por expediente, pero A1 y A10 son de alcance repositorio: A1 da `1` en `IA.SDD` y en `Lab-Geometria` por la carpeta de cuatro dígitos, y la regla no dice que ese `1` es el histórico (M9-VER-03). Un auditor que corra A1 lo cuenta como hallazgo. Falta además el número con que arranca la serie de cinco dígitos donde hay un `0001-`. `_legacy/13.17/`: `ls` → `Conocimiento Examples PROMPTS README.md SDD Templates`; `ls _legacy/13.17 | grep -c Expedientes` → `0`; 133 archivos, igual que el `git ls-tree` sin `Expedientes/` que declara el plan. **El criterio 2 del reporte 31 §7 se cumple en la mitad medible** (el snapshot no lo contiene); la otra mitad (la línea de §VI.5 lo nombra) es texto que todavía no está escrito.

**6. Parte V.** La regla no declara el hueco: `find SDD -type f -not -name '*.md'` → 0 en `main`, pero `Expedientes/` trae 5 `.sh` (modo `100755`), 5 `.out`, 2 `.txt` y 4 `SHA256SUMS`. Comprobación que cubre el hueco sin distribuir código: `git ls-tree -r <principal> Expedientes | grep -vc '^100644 blob'` → `0` (sólo archivos regulares sin bit de ejecución), declarada en `Expediente-Rules.md` §7 como anti-patrón «evidencia ejecutable» y citada desde §II.7 (M9-VER-08).

**Sobre el criterio decisivo (reporte 31 §7 (1)).** Conté los campos del caso: README 5 (`Número, Título, Apertura, Origen, Base`), folio 001 `Tipo, Fecha, Autor, Corrige` + `Sigue` + `Canal, Fecha-hora, Huella` = 8, folio 002 = 5: **dieciocho**, sin dato derivado a mano — se cumple. «Los diez criterios corren con su comando dentro de la regla»: corren, pero **A9 y A4 no verifican lo que dicen verificar** (P1) y A1 no puede dar `0` en ningún repositorio real (P1). Mi respuesta a la pregunta única del mandato es: **la forma mínima se verifica enumerando en siete de los diez; el criterio decisivo no se cumple hasta que se corrijan A1, A4 y A9.** Los P2 no lo bloquean pero lo erosionan.

**Fuera de mi competencia, que señalo:** el cambio 18 del plan agrega el folio 019 y una fila al README del expediente 0001 **después de su fusión** (`650053e`). §5.1 lo exime de A7, pero el 0001 sigue recibiendo folios, es decir está vivo, y §5.1 dice que un caso vivo con antecedentes previos abre expediente nuevo con constancia de incorporación. Simulado en `p18`: modificar el README después de `m` aparece en A7 (`M …/README.md`). Es del Presidente o de Trazabilidad decidir si el 0001 se cierra con `archivo` y el resto sigue en un `00001-` nuevo.

---

## Lo que revisé y está bien

1. **A7 ve la evidencia** (criterio 4 del reporte 31 §7): el borrado de `evidencia/001-arbol.txt` en `1d6a3dc`, posterior a `b621d58`, aparece; y el mismo criterio funciona con merge commit y con squash (`h1`, `h2`).
2. **A2, A3, A5 y A8 (con cerca exacta)** fallan en cada caso construido y sólo en ésos: `FALTA Base`, `FALTA Número` (distingue acento, como la regla exige), `SALTO 003-…`, `007`, `HUELLA …` en las tres variantes.
3. **El snapshot** `_legacy/13.17/` no contiene `Expedientes/` (133 archivos, seis entradas en la raíz), y el regex de A10 respeta la forma calificada con barra (`Lab-Geometria/SDD/Expedientes/…` no se marca) y la de placeholder `<Titulo>`.

---

## Solicitudes de convocatoria

- **Trazabilidad documental (D-6):** el plan #18 folia sobre un expediente que la regla declara histórico y sellado; señal en `plan/20-Plan-De-Aplicacion.md` l.34 y en `Expediente-Rules.md` §5.1 l.285–291. Ver arriba.
- **Formal (D-5):** A4 acepta valores fuera del conjunto y el mapeo total de §3.2 se declara «total» sin que ningún criterio lo sostenga; señal en `Expediente-Rules.md` l.303 y l.168–182.
- **Presidente / Seguridad (D-2):** `ev-03` no reproduce contra la regla que se evalúa (M9-VER-07); antes de que la mesa cierre, la evidencia del plan tiene que volver a tomarse con los comandos definitivos, o el ciclo dictamina sobre una medición que ya no existe.
