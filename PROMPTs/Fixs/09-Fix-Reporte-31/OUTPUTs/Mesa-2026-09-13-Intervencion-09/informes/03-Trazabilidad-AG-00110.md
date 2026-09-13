# Informe de comisión — Trazabilidad documental (AG-00110)

**Comisión:** Trazabilidad documental (AG-00110), siglas `M9-TRZ`. **Fecha:** 2026-09-13.
**Base leída:** contrato de entrada; `plan/Expediente-Rules.md` 1.0 (borrador) y `plan/20-Plan-De-Aplicacion.md`; folio 016 entero, 013/014/015/018 por sección; `IA.SDD-i09` rama `intervencion/09-reporte-31` = `main` `a501857` (13.17): `Root-Rules.md` §9–§10 entero, `Mesa-Rules.md` §2, §6.1, §8, `Migracion-Rules.md` §2, `SDD-Development-Guide.md` §VI.3–§VI.3.2, `README.md` D3, `Conocimiento/Knowledge-Mesa-De-Expertos-A-Pedido.md` entero, `SDD/Devs/Guides/Coherencia-Mesa-De-Expertos-A-Pedido.md` §1–§4; ev-01, ev-02, ev-03; el caso de dos folios (`caso/`, `a1a10.sh`). Destinos por `git show`/`git grep`/`git ls-tree`/`git log`/`git diff`: `Lab-Geometria` `main` `d12fb1c`, `RPI.VideoControl` `HEAD` `9aabe5c`. Casos construidos en `scratchpad/mesa/tmp-trz/` (clones del caso de prueba; ningún repositorio tocado).
**Fuentes externas:** ninguna consultada en línea. Nombro ISO 15489-1:2016 (gestión de documentos de archivo: un registro conserva sus vínculos y su identificador es estable) sin apartado, como marco y no como ancla; ningún hallazgo depende de ella.

---

## Hallazgos

### M9-TRZ-01 · A10 no distingue la cita calificada de la local por el nombre: la distingue por la barra, y la forma que el dictamen fijó da falso positivo — **P1 · E1**

La regla §3.1 dice que A10 «reconoce las calificadas por el nombre que las precede». El comando no lee ningún nombre: excluye toda cita precedida por `/` (`[^/A-Za-z0-9.-]`) y comprueba todo lo demás. Tres formas reales quedan mal clasificadas. Construido sobre un clon del caso (existe `00003-Caso-X`; no existe `00077-Ajena`):

```
$ cat SDD/Docs/Sub/Trampas.md   (extracto)
1. relativa: ver ../../Expedientes/00002-Migracion-A-13.18/ folio 001
5. calificada con barra: Lab-Geometria/SDD/Expedientes/00003-Caso-X/
6. calificada con espacio (forma del dictamen Q4): Lab-Geometria SDD/Expedientes/00077-Ajena/
15. calificada con dos puntos: Lab-Geometria:SDD/Expedientes/00003-Caso-X/
$ git grep -ohE '(^|[^/A-Za-z0-9.-])(SDD/)?Expedientes/[0-9]{5}-[A-Za-z0-9-]+' -- SDD Expedientes | sed -E 's/^[^SE]*//' | sort -u | while read d; do [ -d "$d" ] || echo "$d"; done
Expedientes/00003-Caso-X
SDD/Expedientes/00002-Migracion-A-13
SDD/Expedientes/00003-Caso
SDD/Expedientes/00003-Caso-
SDD/Expedientes/00009-No-Existe
SDD/Expedientes/00077-Ajena
```

- La forma **con espacio** —la que el folio 016 Q4 y Q8 fijan: «`<repositorio> <carpeta del expediente>`»— es comprobada como local y falla (`00077-Ajena`). La regla cambió la forma del dictamen (barra en vez de espacio) sin declararlo, y el comando sólo sirve para la nueva.
- La forma **con dos puntos** o con backticks (la que el propio 0001 usa: `` `Lab-Geometria` `SDD/Expedientes/0001-…` ``, folio 015 l.231 —`git grep -n 'Expedientes/0001-Migracion' main -- Expedientes`) se comprueba contra el árbol local: si el número coincide con uno local, **resuelve contra el expediente equivocado** y nadie lo ve.
- La **ruta relativa** (`../../Expedientes/00002-…`) nunca entra: A10 la descarta por la barra. Es exactamente la forma que `Root-Rules.md` §10 R5 declara frágil, y la que los tres artefactos de `Audit/` de `Lab-Geometria` usan hoy (`git grep -n -E '^\*\*Expediente:\*\*' main -- SDD/Docs/Audit` → 3 filas, las tres con `(../../Expedientes/…)`).

**Impacto:** el criterio que «comprueba que las citas locales resuelven» no comprueba las relativas y rechaza la forma calificada que el dictamen aprobó; dos repositorios con `00003-` cada uno se cruzan sin aviso.
**Dirección:** una sola forma calificada, declarada con su separador, y que A10 la excluya por ese separador literal y no por «el nombre que la precede»; decidir si la ruta relativa está prohibida (entonces A10 la detecta y la reporta) o admitida (entonces A10 la normaliza); asentar en la regla que la forma del dictamen cambió.

### M9-TRZ-02 · A10 trunca los títulos con punto y reporta como rota una carpeta que existe; el único ejemplar de destino lleva punto — **P1 · E1**

`[A-Za-z0-9-]+` corta en `.`. El caso construido con `00002-Migracion-A-13.18/` (carpeta existente) sale como `SDD/Expedientes/00002-Migracion-A-13` en la salida de arriba: falso positivo. No es hipotético: el ejemplar real es `0001-Migracion-Normativa-A-13.16` (ev-02, «Nombres de carpeta de expediente existentes»), y el mismo defecto ya ocurre sobre el corpus del framework:

```
$ git -C IA.SDD-i09 grep -ohE 'Expedientes/[0-9]+-[A-Za-z0-9-]+' main | sort | uniq -c
     19 Expedientes/0001-Expedientes-Como-Comportamiento-Del-Framework
      4 Expedientes/0001-Migracion-Normativa-A-13
```

D3 (`README.md` l.113) prohíbe «caracteres especiales» sin decir si el punto lo es; el propio destino nombra `Informe-Migracion-13.7-a-13.16.md` con punto bajo la norma vigente. Una migración a 13.18 es el caso más probable de próximo expediente y su título natural lleva punto.

**Impacto:** A10 en rojo permanente sobre un expediente válido, o títulos forzados a `13-18` sin que ninguna regla lo diga. Una comprobación que avisa siempre es una comprobación apagada (`SDD-Development-Guide.md` §VI.3, comprobación 3).
**Dirección:** decidir el alfabeto del título en §3.1 (D3 más punto interno, o sin punto) y que el patrón de A10 sea ese alfabeto; el acento y el guion bajo (probados: `00003-Caso-` y `00003-Caso`) deben seguir fallando, pero con el nombre completo en el mensaje.

### M9-TRZ-03 · La «única vía declarada» no deriva lo que el caso cambió: 13 de 31 artefactos del EXP-0001 no citan el expediente, y la derivación incluye copias de `_legacy/` — **P1 · E1**

§5: «La dirección inversa —qué artefactos cambió el caso— se deriva con `git grep -l 'Expedientes/00002-'` y no se escribe en una tabla a mano». Medido contra el único caso real de destino (PR #205 y #206, `b9675d8..d12fb1c`):

```
$ git -C Lab-Geometria diff --name-only b9675d8 d12fb1c -- . ':!SDD/Expedientes' | grep -vc '_legacy/'
31
$ for f in $(git diff --name-only b9675d8 d12fb1c -- . ':!SDD/Expedientes' | grep -v '_legacy/'); do git grep -qE 'EXP-0001|Expedientes/0001-' main -- "$f" || echo "SIN CITA: $f"; done
SIN CITA: SDD/Docs/Producto/Adrs/ADR-14001-…  ADR-14002-…  ADR-14003-…  ADR-14004-…
SIN CITA: SDD/Docs/Producto/Contratos-Inter-Unidad/CU-08001-…  … CU-08008-…   (ocho)
SIN CITA: SDD/Docs/Producto/Vista-Producto.md
```

Sus filas de control de cambios citan **el plan** de `Audit/` y no el expediente (`git diff b9675d8 d12fb1c -- …/CU-08001-….md | grep '^+'` → «Migración normativa 13.7 → 13.16, fase M4, fila PM-06»); el plan sí cita el expediente. La cadena real es de dos saltos —artefacto → `Plan-Migracion…` → expediente— y `git grep -l` sólo ve uno. La tabla manual §3 del README del EXP-0001 sí los nombra (fila `c14bf3b`: «ocho documentos de 05/06/09, `CU-08001` a `08008`, `ADR-14001` a `14004`»), comprimidos en una fila; contra `git log` la tabla es completa en archivos (31/31, contando la fila comprimida) y omite sólo los 29 snapshots. Y la derivación sí trae lo que no debe:

```
$ git -C Lab-Geometria grep -l 'Expedientes/0001-' main -- . ':!SDD/Expedientes' | wc -l          → 19
$ git -C Lab-Geometria grep -l 'Expedientes/0001-' main -- . ':!SDD/Expedientes' ':!*_legacy*' | wc -l → 18
   (el de más: SDD/Docs/00-Contexto/_legacy/2026-09-13/Roadmap-Producto-v1.13.md)
```

**Impacto:** la regla afirma que la inversa «no se desincroniza» y en el caso que la funda pierde el 42 % (13/31) y suma una copia archivada; una tabla a mano fue más completa que la derivación. Exigir la cita en las 13 filas es la ceremonia que la intervención vigila.
**Dirección:** declarar la cadena de dos saltos como válida (el artefacto cita la fila del plan o del registro de `Audit/`, y ése cita el expediente) y dar el comando de derivación en dos pasos, con `':!*_legacy*'` (`Root-Rules.md` §9.1 saca `_legacy/` del espacio de candidatos); reescribir «no se desincroniza» por lo que sí garantiza (sobrevive al aplastamiento).

### M9-TRZ-04 · `ruta@commit` no tiene forma ni resolutor, y el aplastamiento (S3) deja los commits citados inalcanzables: ya pasó en el 0001 — **P2 · E1**

`git grep -n 'ruta@commit\|@commit\|@<commit' main -- SDD README.md Conocimiento` → sin salida: la forma no existe en la norma ni en el borrador (que la nombra seis veces). Lo que el aplastamiento hace con ella, medido en el propio framework:

```
$ git -C IA.SDD-i09 grep -ohE '`[0-9a-f]{7}`' main -- Expedientes | tr -d '`' | sort -u | while read h; do …; done
3c2f401 EXISTE pero NO alcanzable desde main   7301a8f  8512a45  b92c64b  e8c84d9  (ídem: cinco)
8c55a1e alcanzable   cab03ed alcanzable
7864428 NO EXISTE en este clon   (y otros catorce: son commits de otros repositorios, citados sin calificar)
$ git for-each-ref --contains 8512a45          → (vacío: ninguna rama los contiene)
$ sed -n 32p …/018-providencia-resolucion-del-lote-y-redaccion-s2.md
- **El historial de la rama conserva los originales** (commits `e8c84d9` a `8512a45`). …
```

El folio 018 afirma algo que la fusión por squash (`650053e`) volvió falso: los cinco commits sobreviven sólo como objetos sueltos de este clon. Y el otro ejemplar folia por enlace vivo: `Lab-Geometria` folio 004 l.12 cita «`Mesa-2026-09-13.md` 1.0» con ruta relativa; el archivo va por `1.3` (`git log --format=%h main -- SDD/Docs/Audit/Mesa-2026-09-13.md` → `c6d754e 0f26c2b 5682307`). El mecanismo correcto existe y resuelve aunque el archivo cambie o se archive: `git show 5682307:SDD/Docs/Audit/Mesa-2026-09-13.md | grep -m1 Versión` → `1.0`, con `git merge-base --is-ancestor 5682307 main` → alcanzable.

**Impacto:** la constancia que «folia por enlace» apunta a una versión que nadie puede abrir (enlace vivo) o a un commit que no existe (rama aplastada); desde el framework, catorce commits citados sin repositorio no resuelven en ningún clon.
**Dirección:** definir la forma en §5 con tres piezas —ruta desde la raíz, commit **alcanzable desde la rama principal**, y el repositorio cuando cruza la frontera— más el resolutor (`git show <commit>:<ruta>`) y su comprobación (`git merge-base --is-ancestor`); en S3, decir que después de un squash toda `ruta@commit` a commits de la rama se re-folia al commit de squash con una constancia. La cita inversa desde `Mesa-<fecha>.md` (pregunta 5) va a la cabecera de `Mesa-Rules.md` §2.2 punto 1 —hoy la práctica la tiene sin norma: 3 de 3 artefactos de `Audit/` del caso llevan `**Expediente:**`— y sólo la carpeta, nunca el folio, porque el registro se escribe antes de que el expediente lo folie.

### M9-TRZ-05 · Número y Título de la carátula, y el Tipo del folio, están dos veces; ningún criterio compara, y la divergencia pasa A1–A10 — **P2 · E1 (caso construido y corrido)**

§3: «Nada que se pueda leer del árbol o de git se escribe a mano»; «El expediente y el folio no se declaran en la cabecera: se leen de la ruta». Pero `Número` y `Título` se leen de la carpeta `<NNNNN>-<Titulo>` y se escriben en el README, y `Tipo` está en el nombre `NNN-<tipo>-<slug>.md` y en la cabecera. Clon del caso, README con `00002` y otro título en la carpeta `00001-…`, folio `002-resolucion-…` con cabecera `| Tipo | archivo |`:

```
$ bash a1a10.sh caso2 SDD/Expedientes/00001-Enlace-Roto-En-Roadmap
== A1  0   == A2  (vacío)   == A3  (vacío)   == A4  0   == A5  (vacío)   == A6  (vacío)   … == A10 (vacío)
```

A2 pasa con el número equivocado; A4 pasa con dos tipos distintos; A6 no exige pase porque la cabecera dice `archivo`, y el estado «se deriva del tipo del último folio» sin decir de cuál de los dos. A7 lo ve sólo después de la fusión.

**Impacto:** dos de los dieciocho campos son derivados a mano (`Root-Rules.md` §10) y el estado —el dato que la reanudación lee (plan, cambio 4)— tiene dos fuentes.
**Dirección:** una sola fuente por dato: o el README no lleva Número ni Título (16 campos) o A2 los compara con la carpeta (un `test` más en el mismo comando); para el tipo, elegir nombre de archivo o cabecera como fuente del estado y que A4 compare los dos. Declarar también la forma de cita de la evidencia («evidencia 003»), porque `003` desnudo hoy nombra un folio o una pieza.

### M9-TRZ-06 · El «nombre del repositorio» que califica la cita no tiene fuente declarada; la práctica ya usó tres — **P2 · E1**

§3.1: «la ruta calificada con el nombre del repositorio: `Lab-Geometria/SDD/Expedientes/…`». Ningún artefacto del método declara ese nombre: el manifiesto tiene `Slug-Producto` = `Fabrica-De-Geometria` (`git -C Lab-Geometria show main:SDD/Intake/PRODUCT-MANIFEST-Fabrica-De-Geometria.md | sed -n 14p`), que no es `Lab-Geometria`; `git -C IA.SDD-i09 grep -n -i repositorio main -- Templates/` → sin campo. Lo que el 0001 escribió de hecho:

```
$ git -C IA.SDD-i09 grep -n -E 'Expedientes/0001-Migracion' main -- Expedientes | cut -c1-140
…/013-consolidacion-y-plan-compuesto.md:10: … `Lab-Geometria-mig1316/SDD/Expe…      (nombre del worktree)
…/015-veredicto-del-jurado.md:231:  … `Lab-Geometria` `SDD/Expedientes/0001-…`   (espacio y backticks)
…/ev-08-cartas-despachadas/18-Refutador-del-plan-compuesto.md:7: `/PROG2/Geometria/Lab-Geometria-mig1316…  (ruta absoluta)
```

Con los números locales, dos repositorios ya comparten `0001-` (ev-02); sin calificador estable la cita cruzada no es única, que es lo que `Root-Rules.md` §10 R5 exige de una referencia.
**Impacto:** una cita cruzada resuelve por adivinación; el worktree que la escribió deja de existir y con él el nombre.
**Dirección:** que el calificador sea un dato declarado en un solo lugar (el nombre del repositorio remoto tal como lo da `git remote`, o un campo del manifiesto/README raíz) y que §3.1 lo nombre; prohibir rutas absolutas y nombres de worktree (S2 ya las persigue por otro motivo).

### M9-TRZ-07 · La exclusión en `Root-Rules.md` §9.2 se funda en un motivo que el número no cumple, y le asigna el ámbito que §9.2 niega a las excluidas — **P3 · E2**

§9.2, tabla de excluidas: `FA-NN`, `CA-NN`, `PASO-N` son «una posición dentro de un documento … no cataloga un elemento de una colección», y «**Una familia excluida no toma ámbito de §9.1**». El folio cumple ese motivo (posición dentro del expediente). El número no: cataloga la colección de expedientes del repositorio, es correlativo y nunca reciclado —el dictamen Q4 le aplica «§9.2 ancho, §9.3 estabilidad», propiedades de las alcanzadas—, y el borrador §3.1 escribe «su ámbito es el repositorio, que no es ninguno de los dos ámbitos de §9.1». Cambio 7 del plan repite «local al repositorio». Es una familia con la mitad de las propiedades de las alcanzadas y la etiqueta de las excluidas; §9.5 exige que la clasificación sea por la regla que la acuña, y el motivo escrito no la sostiene. Sobre R5: citar sólo la ruta es admisible **porque** S1 prohíbe renombrar, §2 la saca de la migración y del snapshot, y A1 garantiza la unicidad del prefijo numérico; ese es el motivo que hay que escribir, y falta.
**Impacto:** la próxima lectura de §9.2 encuentra una excluida «con ámbito» y una alcanzada sin prefijo; alguien acuña `EXP-` para arreglarlo.
**Dirección:** en la fila de §9.2 decir que el número no toma ámbito porque **no se cita desnudo** —su identidad es la carpeta, inmutable por S1 y A1, y su calificador cruzado es el de M9-TRZ-06—; borrar «su ámbito es el repositorio» de §3.1. Vale para J-06 opción A sin tocar §9.1 ni D3.

### M9-TRZ-08 · Dos barridos de la regla chocan con S1 y con la forma histórica — **P3 · E1**

(a) Anti-patrón §7: `grep -rcE '\bEXP-[0-9]' actuaciones/ evidencia/` → `0` «en expedientes nuevos». Un expediente nuevo de `Lab-Geometria` que continúe el caso de migración (§5.1, incorporación de antecedentes) tiene que citar el histórico, cuyo título es «EXP-0001»: `git -C Lab-Geometria grep -o 'EXP-[0-9A-Za-z]*' main | wc -l` → 49 en 20 archivos, todas `EXP-0001`. La detección penaliza la cita correcta.
(b) `SDD-Development-Guide.md` §VI.3.2, clases estables de exclusión del barrido: no está `Expedientes/`, y S1 prohíbe editarlo. El barrido del cambio 16 va a encontrarlo:

```
$ git -C IA.SDD-i09 grep -c -F '00-Contrato-De-Entrada' main -- Expedientes | wc -l   → 7
$ git -C IA.SDD-i09 grep -c -F 'evidencia E4' main -- Expedientes | wc -l             → 2
```

El cambio 8 del plan toca §VI.5 y §VI.3 comprobación 2, no §VI.3.2.
**Impacto:** (a) un `[enumerable]` en rojo sobre un expediente correcto; (b) cada intervención futura redescubre la exclusión, que es lo que la tabla de §VI.3.2 existe para evitar.
**Dirección:** (a) acotar la detección a **acuñar** (`EXP-[0-9]{5}` o el propio número en el README) y no a citar; (b) fila `Expedientes/` en la tabla de §VI.3.2 con S1 como motivo, en el cambio 8.

---

## Respuestas a las preguntas del mandato

**1. Colisión, medida.** `git -C Lab-Geometria grep -c 'EXP-' main | wc -l` → **20**; `git -C Lab-Geometria grep -o 'EXP-[0-9A-Za-z]*' main | wc -l` → **49**, una sola forma (`EXP-0001`), 14 de los 20 archivos dentro del propio expediente, los otros seis en `Audit/` (3), roadmap, manifiesto y `propuestas/aplicar-propuestas.sh`. `RPI.VideoControl`: `git grep -c 'EXP-' HEAD | wc -l` → **0**. `EV-` (familia D9): `Lab-Geometria` 12 archivos / 118 ocurrencias; `RPI.VideoControl` 48 / 1717. `ev-NN` en minúscula: **0** archivos en los dos destinos; **42** en `IA.SDD` `main`, todos en `Expedientes/0001-…` (forma histórica). No acuñar `EXP-` es correcto contra ese corpus: `EXP-NNNNN` habría nacido con un `EXP-0001` de cuatro dígitos vivo en 49 lugares. La colisión que la regla **no ve** no es de prefijo: es la del número desnudo entre repositorios —ya hay dos `0001-`— que sólo el calificador resuelve, y el calificador no tiene fuente (M9-TRZ-06). `NNN-<slug>` para la evidencia no colisiona con nada medido; sí observo que el ejemplar de destino usa `E-001…E-024` y `E-n` es la forma de las escaladas de `Mesa-Rules.md` §7 (`E-1`, `E-2`, `E-3` en el folio 016): la regla nueva evita esa colisión y conviene decirlo en §3.4.

**2. A10 y las dos citas.** No las distingue bien: distingue «precedida por barra» de «no precedida por barra» (M9-TRZ-01). Resultados de las trampas: relativa `../../` → no se comprueba (falso negativo); bloque de código → se comprueba y se reporta (correcto, coherente con §VI.3.2 «incluidos los bloques cercados»); acento → se reporta, truncado; cuatro dígitos → no entra (correcto: forma histórica exenta por §5.1); punto en el título → falso positivo (M9-TRZ-02); calificada con barra, `IA.SDD/…`, URL, `_legacy/…`, `SDD/Docs/Expedientes/…` → excluidas; calificada con espacio (forma del dictamen) → falso positivo; con dos puntos → comprobada contra lo local; `Expedientes/…` sin `SDD/` en un destino → reportada (correcto). Además el pathspec `-- SDD Expedientes` no barre `README.md`, `CHANGELOG.md` ni `Conocimiento/` del framework —donde los cambios 9, 13 y 17 van a escribir citas— ni `changelog.md` de un destino, que hoy cita el expediente dos veces (`git -C Lab-Geometria grep -n 'Expedientes/0001-' main -- changelog.md` → l.1700, l.1713). Hoy `git -C IA.SDD-i09 grep -n -E '(SDD/)?Expedientes/[0-9]' main -- README.md CHANGELOG.md Conocimiento Templates PROMPTS` → vacío, así que el hueco está por abrirse, no abierto.

**3. La única vía.** No deriva todo: 13 de 31 artefactos del único caso real citan el plan y no el expediente (M9-TRZ-03); la tabla manual §3 del README del EXP-0001 es completa en archivos contra `git diff b9675d8 d12fb1c` (31/31, con una fila comprimida) y omite los 29 snapshots `_legacy/`; lo que la tabla da y la derivación no: la versión antes → después, el commit y el folio que lo produjo. Lo que se pierde con la vía única, tal como está escrita, es la cadena a través de `Audit/`, que es la que la migración produce por norma (`Migracion-Rules.md`: las filas citan el plan).

**4. §9.2, §9.5 y R5.** No es coherente tal como está redactado (M9-TRZ-07). R5 se satisface sólo por la inmutabilidad de la ruta (S1 + §2 + A1) dentro del repositorio; a través de la frontera exige el calificador, que hoy no existe como dato (M9-TRZ-06).

**5. Folia por enlace.** La forma que resuelve después de cualquier archivado es `<ruta desde la raíz>@<commit>` resuelta con `git show <commit>:<ruta>` —verificado: `5682307:SDD/Docs/Audit/Mesa-2026-09-13.md` devuelve la 1.0 aunque el vivo sea 1.3— con dos condiciones que la regla tiene que escribir: el commit alcanzable desde la rama principal (S3: el 0001 cita cinco que no lo son) y el repositorio nombrado cuando cruza (catorce commits del 0001 no existen en el clon del framework). Nota: los `Audit/` de `Lab-Geometria` no se archivan a `_legacy/` (`git ls-tree --name-only main SDD/Docs/Audit/ | grep -i legacy` → vacío; los `_legacy/<fecha>/<nombre>-v<ver>.md` son por carpeta de categoría), de modo que el riesgo real no es el archivado sino la edición en el lugar (1.0 → 1.3) y el aplastamiento. La cita inversa: carpeta del expediente en la cabecera del registro (`Mesa-Rules.md` §2.2 punto 1), nunca el folio; el cambio 5 del plan no la prevé.

**6. La 13.17 después del cambio 13.** Medido sobre `main` (`git grep -c -F <t> main -- SDD PROMPTS Templates Conocimiento README.md CHANGELOG.md Examples`): `00-Contrato-De-Entrada` → sólo `Knowledge-Mesa-De-Expertos-A-Pedido.md:3`; `NN-Informe-` → ídem `:3`; `NN-Plan-Y-Cierre` → ídem `:3`; `Informe-Refutador` → ídem `:2`; `evidencia E4` → `Knowledge…:1` y **`SDD/Devs/Guides/Coherencia-Mesa-De-Expertos-A-Pedido.md:1`** (l.55). La nota de coherencia es «nota de coherencia anterior», clase estable de exclusión de §VI.3.2: **no se barre, se declara** en la sección de barrido del cambio 16; lo mismo la entrada `[13.17]` del `CHANGELOG.md` (que, medida, no contiene ninguna de esas cadenas literales) y `Expedientes/0001-…` (7, 2, 2 y 2 archivos respectivamente, protegido por S1; ver M9-TRZ-08 b). Lo que el cambio 13 tiene que tocar y el plan no enumera: la fila de §0 l.45 («La forma normativa de un expediente de caso | **Ninguna regla la fija todavía**»), la fila de §3.1 l.140 («El expediente va en `<ruta>`», que contradice la ubicación fija de `Expediente-Rules.md` §2) y el esqueleto §5.1 l.201 (`EXPEDIENTE: {{ruta}}`). `Index-Knowledge.md` l.38 («expediente de la mesa») sigue siendo cierto y no necesita barrido más allá de la versión.

---

## Lo que revisé y está bien

1. **La decisión de no acuñar prefijo y de nombrar la evidencia por posición** está medida y es correcta contra los tres corpus (pregunta 1); `NNN-<slug>` no colisiona con `EV-`, `ev-`, `E-` ni `EXP-`.
2. **A10 sí excluye lo que debe** cuando la cita lleva la barra: calificadas `Lab-Geometria/…`, `IA.SDD/…`, URLs, `_legacy/…` y `SDD/Docs/Expedientes/…`; y sí detecta la forma cruzada equivocada (`Expedientes/…` sin `SDD/` en un destino) y las citas dentro de bloques de código. El borrador de la regla pasa su propio A10 en el framework (los ejemplos usan `<Titulo>`, que el patrón no captura).
3. **El mecanismo `ruta@commit` es el correcto**: `git show 5682307:SDD/Docs/Audit/Mesa-2026-09-13.md` devuelve la versión foliada (1.0) y no la viva (1.3); falta la forma, no el principio.

---

## Solicitudes de convocatoria

- **Formal (D-5, tipos → estado):** el estado se deriva «del tipo del último folio» y el tipo vive en dos lugares (nombre de archivo y cabecera) que A4/A6 no comparan (M9-TRZ-05, caso corrido en `mesa/tmp-trz/caso2`). Fuera de mi competencia decidir cuál es la fuente.
- **Orquestación de migración (`Master-Prompt-Migracion.md`, `Migracion-Rules.md` §2.1):** la cadena real de citas de una migración es artefacto → fila del plan → expediente (M9-TRZ-03, 13 de 31). Si la «única vía» queda como está, la migración tiene que escribir la cita del expediente en cada fila que toca, y eso es procesal, no de trazabilidad.
