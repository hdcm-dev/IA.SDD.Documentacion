**Comisión: Formal** (lógica, conjuntos cerrados, decidibilidad) · siglas `M9-FOR` · **fecha 2026-09-13**

**Base leída.** Contrato de entrada `mesa/00-contrato-de-entrada.md`; borrador `plan/Expediente-Rules.md` 1.0 (360 líneas) entero; `plan/20-Plan-De-Aplicacion.md` entero; folio 016 entero, 014 (R-02, R-11) y 015 (R-02, R-11, Q2, Q5, Q11, D-5) por sección; `ev-07` (1486 bytes, sin salto final); norma 13.17 en `IA.SDD-i09` (`a501857`, rama `intervencion/09-reporte-31`): `Master-Prompt.md` §7.0, §8.1, §9 enteros; `Mesa-Rules.md` §0.0, §4, §5.5, §6.1, §7, §7.1; `Root-Rules.md` §10, §12.2; `Master-Prompt-Migracion.md` l.46 y l.291; `Master-Prompt-Reanudacion.md` §3.1 l.235; `README.md` D3. Evidencia `ev-01`, `ev-02`, `ev-03`. Caso de prueba `scratchpad/caso/` (3 commits en `main`). Casos construidos en `scratchpad/mesa/tmp-for/` (copias del caso: `c1`…`c18`, `a8/`). Destinos sólo por `git ls-tree`/`git show`. **Fuentes externas:** ninguna.

---

## Hallazgos

### M9-FOR-01 · P1 · E3 + E2 — El mapeo de §3.2 y la regla de corrección de S1 se contradicen: toda errata posterior a una `resolucion` o a un `archivo` cambia el estado del expediente

S1 (l.245-246) obliga: «Una corrección es un folio nuevo con `Corrige: NNN`». §3.2 deriva el estado del **tipo del último folio**. Los dos juntos: una `constancia` que corrige una errata de la resolución deja el expediente **en trámite**, y si corrige un `archivo`, además le exige pase (A6).

Caso construido `c17` = caso base + folio `003-constancia-errata.md` (`Tipo | constancia`, `Corrige | 002`, texto «El folio 002 dice “fila 1.15”; es la fila 1.16»):

```
$ bash a1a10.sh tmp-for/c17 SDD/Expedientes/00001-Enlace-Roto-En-Roadmap
== A1 … == A10   (sólo A7 imprime, por el commit «borro evidencia» del caso base)
```
A1–A10 pasan; por la tabla de §3.2 l.175 el estado es «en trámite» aunque nada del caso se reabrió. Con `[presentacion, resolucion, archivo, constancia Corrige 003]` el resultado es el mismo y A6 exige `Sigue:` a un expediente archivado. `Master-Prompt-Reanudacion.md` R0 paso 4 (plan, cambio 4) lo listaría como pendiente vivo.

**Impacto:** el estado derivado —la pieza que el dictamen Q5 vendió como «nunca se escribe a mano»— es falso en el caso más frecuente después de la fusión, que es la errata. **Dirección:** definir la función de estado sobre la secuencia y no sobre el último folio a secas: el folio con `Corrige` hereda el estado del folio que corrige (o: se ignora para el estado), y decirlo en §3.2 junto con la tabla.

### M9-FOR-02 · P2 · E2 + E3 — «Reabierto» tiene dos definiciones no equivalentes, la secuencia después de `archivo` no está definida, y el levantamiento de la suspensión es implícito

- **Dos definiciones.** Tabla l.175: `presentacion` → «reabierto si antes hay un folio `resolucion`» (cualquier `presentacion`, con cualquier `Corrige`). Prosa l.185: «**Reabrir** es un folio `presentacion` que nombra en `Corrige` la resolución que reabre, y sólo con un ancla E1 o E2». Caso: `[presentacion, resolucion, presentacion(Corrige —)]` —una segunda parte presenta algo sobre el mismo caso—: por la tabla el estado es «reabierto»; por la prosa no hubo reapertura. Ningún A lo detecta (A5 sólo comprueba que el folio nombrado exista).
- **Después de `archivo`.** La regla dice que `archivo` «cierra» y «no lleva pase», y nada prohíbe foliar después. `[presentacion, resolucion, archivo, presentacion]` → «reabierto» (hay resolución antes), pero `Corrige` debería nombrar ¿la resolución (l.185) o el archivo que cerró? `[presentacion, archivo(desistido), presentacion]` → «abierto», idéntico a un caso nuevo, y la reapertura por la prosa es **imposible** (no hay resolución que nombrar). Estado definido, contrato no definido.
- **Suspensión.** `[…, constancia con Suspende hasta:, constancia sin la línea]` → «en trámite». Es funcional, pero la regla no dice que cualquier folio posterior levanta la suspensión; el lector de la reanudación mira sólo el último folio (plan, cambio 4) y una suspensión que sigue vigente de hecho desaparece por una `constancia` de incorporación de antecedentes.
- **La frase «se deriva del tipo del último folio» (l.97, l.171) es literalmente falsa** para «reabierto» (exige recorrer la historia) y para «suspendido» (exige leer el cuerpo, no el tipo). La función existe y es total (ver «está bien» 1), pero su dominio es la secuencia entera más una línea de cuerpo, y así hay que declararlo.

**Impacto:** dos lecturas legítimas del mismo estado; la reanudación y una persona pueden discrepar sin que ningún criterio lo muestre. **Dirección:** una sola definición de reapertura (la de `Corrige`), declarar qué puede seguir a un `archivo` (nada, o sólo `presentacion` con `Corrige` = ese archivo), y una oración sobre hasta cuándo rige `Suspende hasta:`.

### M9-FOR-03 · P1 · E3 + E2 — La condición de apertura de §1 no es una función: las dos listas se intersecan sin precedencia declarada, y el caso de prueba del propio plan cae en la intersección

§1 l.42-59: «Se abre … cuando se cumple **una** de las dos» (1: atraviesa corridas o repositorios; 2: «entra al árbol material externo … un testimonio que funda una decisión y no tiene fila donde asentarse») y «**No se abre** … lo que **se contesta con un comando** y una cita del árbol». No hay «salvo que», «aunque» ni orden de evaluación.

Caso: el de `scratchpad/caso/`. Folio 001: testimonio «che el link del roadmap a la etapa k esta roto, arreglalo». Un enlace roto se contesta con un comando y una cita (`Root-Rules.md` §10 R5: «una ruta que no resuelve … se **recalcula**»): exclusión 4 → no se abre. Entró un testimonio que funda la decisión de la fila 1.15 → rama 2 → se abre. Y «Ante la duda, no se abre» (l.66) más el último párrafo de §1 (la custodia del testimonio «rige donde el testimonio se asiente») empujan a **no abrir**: el ejemplar con el que el contrato mide R4 (dieciocho campos) viola I1 por la letra de §1. No es un defecto del ejemplar: es que §1 no decide.

Segundo: rama 1 define «atraviesa más de una corrida» como «el hecho nació en otra corrida (otra base, otra rama)» (l.45-46). Es el mismo predicado que `Master-Prompt.md` §8.1 llama **«ajeno a la corrida»** («están en la base sin cambios, o … las cambió un commit que no es de esta corrida»). Todo hecho ajeno cumple rama 1; la mayoría de ellos cumple también «detención que sale en el lote» o «se contesta con un comando». La intersección no es marginal: es el caso general.

**No es predicción** (la objeción de 014 R-02 está resuelta: las dos ramas se observan al abrir), pero **no es funcional**. **Impacto:** la trampa que la intervención declara —un expediente por cada cosa— o su inversa, según quién lea; I1 queda interpretativo donde podía ser enumerable. **Dirección:** una oración de precedencia («se abre si (1 o 2) **y ninguna** exclusión aplica») y estrechar rama 1 a su segunda mitad («la presentación pide un acto que esta corrida no puede ejecutar»), que sí es observable y no coincide con «ajeno».

### M9-FOR-04 · P1 · E1 — A7 y A1 no deciden lo que enuncian sobre los repositorios reales: A7 «pasa» antes de la fusión en vez de «no evaluarse», y A1 no puede dar `0` ni en `IA.SDD` ni en `Lab-Geometria`

**A7.** La regla (l.306) dice «Antes de la fusión no se evalúa, y se declara». El comando no tiene salida para «no evaluable». Caso `c18`: rama `caso/00002` con un expediente nuevo **no fusionado** y un commit que edita su README:

```
$ git checkout -b caso/00002 … ; git commit -m "abre 00002" ; sed -i s/abc1234/zzz9999/ …/README.md ; git commit -am "edita README antes de fusionar"
$ m=$(git log --first-parent --format=%h --diff-filter=A main -- "$X/README.md" | tail -1); echo "m='$m'"
m=''
$ git log -M --diff-filter=MDR --format='%h %s' "$m..main" -- "$X"
(vacío)
```
`m` vacío convierte el rango en `HEAD..main`, que está vacío en una rama adelantada: **el mismo «vacío» que significa «nada cambió»**. Un expediente editado antes de fusionar pasa A7 igual que uno inmutable. Además `main` está cableado en el comando; los dos destinos usan `main` (`git -C RPI.VideoControl branch --show-current` → `main`; `Lab-Geometria` `main` `d12fb1c`), pero la regla habla de «rama principal».

**A1.** `ev-03` sobre los repositorios reales:
```
## IA.SDD main a501857          == A1 → 1
## Lab-Geometria main d12fb1c   == A1 → 1
```
Las carpetas `0001-…` de cuatro dígitos son forma histórica (§5.1) y «no se les exige los criterios de §6», pero A1 no es un criterio por expediente: corre sobre el directorio entero y pide `→ 0`. Con un expediente nuevo `00002-…` al lado, A1 seguirá dando `1` para siempre en los dos repositorios que hoy existen. El criterio es inalcanzable en su dominio real.

**Impacto:** dos de los diez enumerables no distinguen conforme de no conforme donde más importa. **Dirección:** A7: `[ -n "$m" ] || echo "NO EVALUABLE: sin fusión"` (o equivalente) y «rama principal» parametrizada; A1: dominio explícito —contar sólo lo que no es forma histórica, p. ej. excluir `^[0-9]{4}-`— o declararlo «→ igual al número de expedientes históricos».

### M9-FOR-05 · P2 · E1 + E3 + E2 — A8: la huella del bloque no es la huella del original (pregunta 4), y el comando da falso positivo con dos bloques y con `Huella` sin backticks, y falso negativo con CRLF

**Pregunta 4, medida con `ev-07`** (que no termina en salto de línea: `tail -c 20 | od -c` termina en `e m i a` sin `\n`; 1486 bytes):
```
$ sha256sum ev-07-presentacion-original.txt | cut -c1-64
cb39bbd64dd919e3bb7ad484779c4215af473892cf02de5b797c76046f63dd1c
$ { echo '```testimonio'; cat ev-07…; echo; echo '```'; } > a8/folio.md
$ awk '/^```testimonio$/{f=1;next} /^```$/{f=0} f' a8/folio.md | sha256sum | cut -c1-64
074f174f6a1d2359dd46556401c5b0e68e71b4ca85bb86876b4b4d6d39fa25be
$ { cat ev-07…; echo; } | sha256sum | cut -c1-64
074f174f6a1d2359dd46556401c5b0e68e71b4ca85bb86876b4b4d6d39fa25be        (1487 bytes)
```
La regla **no lo declara**: §3.3 l.2 define `Huella` como «el SHA-256 del bloque, obtenido con el comando de A8» (coherente consigo misma) pero exige a la vez «bloque literal, **byte a byte**» y «si el original es un archivo, va además a `evidencia/` y el folio lo cita». El primer testimonio real del framework tiene `SHA256SUMS-ev-07` = `cb39…`, y su asiento como bloque daría `074f…`: dos huellas «del mismo testimonio» que no coinciden, sin que ninguna línea diga por qué. **Qué debería decir:** que la huella del folio es la del bloque *tal como lo extrae A8* (líneas terminadas en LF, salto final incluido), que la huella del archivo original es otra y vive en la cabecera de la pieza de `evidencia/`, y que las dos difieren cuando el original no termina en LF (o usa CRLF).

**Falsos positivos.** `c4`, dos bloques `testimonio` en el mismo folio, cada uno con su `Huella` correcta: `== A8 → HUELLA …001-presentacion-enlace-roto.md` (el `awk` concatena los dos bloques y busca una sola huella). `c15`, `Huella` sin backticks: `== A8 → HUELLA …` — §3.3 no exige backticks; los exige el `grep "^| Huella | \`$h\`"`.
**Falso negativo.** `c14`, folio con CRLF: `grep -l '^```testimonio$'` no encuentra el archivo y **A8 no verifica nada** (salida vacía = pasa).

**Dirección:** un bloque por folio (o una huella por bloque, extraídos de a uno), forma exacta de la fila `Huella` en §3.3, y declarar LF como normalización.

### M9-FOR-06 · P2 · E3 — A5, A4, A9 y A2 tienen falsos negativos que la forma mínima no debería permitir

Casos construidos y salida de `a1a10.sh` (sin ninguna línea de error salvo A7 del caso base):

| Caso | Qué se rompió | Criterio | Salida |
|---|---|---|---|
| `c1` | `Corrige \| 0012` (cuatro dígitos, folio inexistente) | A5 | vacío: `[0-9]{3}` toma `001`, que existe |
| `c11` | folio 001 `Corrige 002` (posterior) y 002 `Corrige 002` (a sí mismo) | A5 | vacío |
| `c12` | `Tipo \| no-es-resolucion` | A4 | `0`: la alternancia sin anclas acepta subcadenas |
| `c7` | `evidencia/001-arbol.txt` sin Método/Base/Quién | A9 | vacío para el `.txt`; sólo flagueó `002-log.out` |
| `c6` | README con dos filas `Base` de valores distintos | A2 | vacío |

A9 es **vacuo para todo `.txt`**: `[ -e "${f%.*}.txt" ]` evaluado sobre `001-arbol.txt` es `[ -e 001-arbol.txt ]`, siempre verdadero; y de las tres líneas que enuncia («método, base y quién») el comando comprueba una. A5 no pide que el folio corregido sea anterior ni distinto. A4 debería usar `^\| Tipo \| (presentacion|…|archivo) \|$`. Sobre «un `README.md` con un campo repetido»: la regla no dice que las cinco filas sean únicas, y A2 tampoco.

**Impacto:** el «se verifica enumerando» del contrato (R4) vale menos de lo que promete. **Dirección:** anclar las expresiones (`^…$`), excluir al propio archivo del hermano `.txt`, comprobar las tres líneas, y `Corrige` < folio actual.

### M9-FOR-07 · P2 · E3 + E1 + E2 — A10 flaguea títulos con punto y la forma de cita calificada que el dictamen fijó

Caso `c16`: fila nueva en `Roadmap-Producto.md` que cita `SDD/Expedientes/00002-Migracion-A-13.18/` (carpeta existente) y `Lab-Geometria SDD/Expedientes/00009-Ajeno/`:
```
== A10
SDD/Expedientes/00002-Migracion-A-13
SDD/Expedientes/00009-Ajeno
```
Los dos son falsos positivos. El primero porque `[A-Za-z0-9-]+` corta en el punto, y los títulos con versión existen en la práctica: `git -C Lab-Geometria ls-tree --name-only main SDD/Expedientes/` → `SDD/Expedientes/0001-Migracion-Normativa-A-13.16` (D3 prohíbe «caracteres especiales» sin decir si el punto lo es; A10 decide por su cuenta que sí). El segundo porque el dictamen 016 Q4 fija la cita externa como «`<repositorio> <carpeta>`» (con espacio) y la regla l.162 la fija como `Lab-Geometria/SDD/Expedientes/…` (con barra); A10 reconoce sólo la barra (`[^/…]` delante) y trata la forma del dictamen como cita local rota. Además A10 corre sobre `-- SDD Expedientes`, y el plan pone citas en `CHANGELOG.md` (cambio 17) y `Conocimiento/` (cambio 13), fuera del alcance del comando.

**Dirección:** alfabeto del título declarado en §3.1 y usado idéntico en A1 y A10; una sola forma de cita calificada (regla y dictamen), y que A10 la excluya por esa forma; pathspec que cubra donde el plan escribe citas.

### M9-FOR-08 · P1 · E2 + E3 — El orden de cinco pasos de Q11 no es una secuencia: el paso 5 vacía el paso 3 para una de las dos familias, «cumple §0.0» no es evaluable a mitad de fase, y la mesa puede devolver la detención que la abrió

Texto que se ataca: 016 Q11 (que el plan, cambio 2, lleva a `Master-Prompt.md` §8.1): «ninguna detención de esas dos familias sale sin este orden: (1) origen del hecho; (2) …; (3) lo que sobrevive y cumple `Mesa-Rules.md` §0.0 → una mesa por lote de fase; (4) lo que sale de la mesa → lote de §7.0; (5) sólo salen en el momento los bloqueantes de §7.0 y los disparadores 2 y 3».

- **Paso 5 contra paso 3.** `Master-Prompt.md` l.640: «**Lo bloqueante son dos casos, y sólo dos.** El **arbitraje de este mismo §7.0** … Esas salen en el momento». **Todo** arbitraje es bloqueante. Entonces todo arbitraje sale por el paso 5 sin pasar por el 3, y «las dos familias» del orden son en realidad una: la ambigüedad. El texto afirma dos y la norma que cita sólo deja una; según se lea el paso 5 como excepción o como paso, un arbitraje espera al lote de fase (contra l.640) o no pasa por mesa (contra la frase «ninguna detención … sale sin este orden»).
- **«Cumple §0.0» no es decidible con lo que hay a mitad de fase.** §0.0 exige «el estado ya está leído y disponible con la forma del contrato de entrada de §4», y §4 saca `objeto`, `estado` y `pendientes_declarados` de R0/M0 (`Master-Prompt-Reanudacion.md` l.235: «**Antes no puede.** El contrato de entrada … es la salida de R0»). En el bucle de fases de `Master-Prompt.md` no hay R0. O la condición es siempre falsa (paso 3 vacío, Q11 se reduce al lote de §7.0 que ya existe) o el orquestador tiene que producir un contrato —un paso que el plan no cuenta contra el presupuesto de nueve—. El plan no dice cuál.
- **Sin punto fijo.** Los disparadores de `Mesa-Rules.md` §7 son *salidas de la mesa*, no detenciones de entrada: el 1 es «ambigüedad de intención» → familia §9. Una ambigüedad → mesa (paso 3) → la mesa la escala por disparador 1 → es una detención de familia §9 → «no sale sin este orden» → mesa. El paso 4 lo corta sólo si se declara que lo que sale de la mesa **no reingresa**; no está declarado. Y hay dos lotes con la misma forma (§7.1 al cierre de mesa, §7.0 al cierre de fase) sin decir en cuál termina.
- **Los bloqueantes de §7.0 y los disparadores 2 y 3 quedan excluidos** del orden por el paso 5, pero mezclando dominios: los bloqueantes son detenciones de entrada; 2 y 3 son escaladas de una mesa ya convocada, que §7.1 ya saca «en el momento». Nombrarlas en el orden de entrada no las excluye de nada: no estaban.

**Impacto:** el cableado del cambio 2 y del cambio 3 (M4 y l.46) va a los tres orquestadores con un procedimiento que dos lectores ejecutan distinto. **Dirección:** reescribirlo como: primero la excepción (bloqueante de §7.0 → sale ya, forma §8.1, sin mesa); después, para la ambigüedad §9 no bloqueante: origen del hecho → autocorrección/pregunta previa → si hay contrato (decir quién lo arma y con qué) mesa una vez por lote → sus escaladas van al lote de §7.0 y **no reingresan**.

---

## Respuestas al mandato

**1. §3.2, seis tipos → estado.** Enumeración de la función tal como está escrita, con su dominio real (no «el tipo del último folio» sino la terna *tipo del último, ¿hay `resolucion` antes?, ¿lleva `Suspende hasta:`?*):

| Último folio | ¿resolucion previa? | ¿`Suspende hasta:`? | Estado |
|---|---|---|---|
| presentacion | no | — | abierto |
| presentacion | sí | — | reabierto |
| providencia | — | — | en trámite |
| informe | — | — | en trámite |
| constancia | — | no | en trámite |
| constancia | — | sí | suspendido |
| resolucion | — | — | resuelto |
| archivo | — | — | archivado |

**Total: sí** (las ocho filas cubren los seis tipos; las dos condiciones son binarias). **Funcional: sí** (las condiciones de cada tipo son excluyentes). Los tres casos pedidos: `presentacion` tras `resolucion`+`archivo` → **reabierto**, definido, pero con el contrato de `Corrige` indefinido y sin que nada diga que se puede foliar después de `archivo` (FOR-02); `constancia` con `Suspende hasta:` seguida de `constancia` sin la línea → **en trámite**, definido, levantamiento implícito no declarado (FOR-02); `archivo` seguido de `presentacion` sin resolución previa → **abierto**, definido, indistinguible de un caso nuevo y con reapertura imposible por la prosa (FOR-02). Lo que **sí** rompe la función en la práctica es FOR-01: la corrección obligatoria de S1 muda el estado.

**2. §1, decidible al abrir.** Las dos ramas son observables al abrir (no hay predicción; R-02 y 015 Q2 4-1 quedan satisfechos en eso). Pero las listas de «abre» y «no abre» **se intersecan sin precedencia** y el caso de prueba del propio plan es el contraejemplo (FOR-03). Rama 1 con la lectura «nació en otra corrida» coincide con «ajeno a la corrida» de §8.1 y abarca el caso general.

**3. §6, A1–A10, criterio por criterio.** Corrí el guion sobre el caso (pasa todo salvo A7, por diseño del caso: `1d6a3dc borro evidencia`) y sobre `ev-03`. Por criterio: **A1** decide cinco dígitos y duplicados, pero es inalcanzable en los dos repos reales (FOR-04); seis dígitos → `1`, detectado (`c5`). **A2** decide presencia, no unicidad (`c6`). **A3** decide contigüidad; con un archivo sin folio en `actuaciones/` (`c13`: `README.md`, `.gitkeep`) aborta con «valor demasiado grande para la base» en vez de flaguear. **A4** decide presencia y **no** decide el conjunto cerrado (`c12`); `Presentacion` con mayúscula sí lo detecta (`c2` → `1`). **A5** no decide lo que enuncia (`c1`, `c11`). **A6** decide sólo el último folio; los pases de los folios anteriores, que la forma mínima cuenta (4+1 por folio), no los verifica nadie; la línea vacía final da `SIN PASE` (`c3`), que es lo que la letra «como última línea» dice, pero es frágil frente a editores que agregan una línea. **A7** no distingue «no evaluable» de «conforme» (FOR-04). **A8** FOR-05. **A9** vacuo para `.txt` y comprueba una de tres líneas (FOR-06). **A10** FOR-07.

**4. A8 y el salto final.** No, la regla no lo declara; con `ev-07` la huella del bloque (`074f…`) no es la del archivo (`cb39…`), y el mismo expediente 0001 tiene sellada la segunda. Lo que debería decir está en FOR-05.

**5. Q11.** No es una secuencia bien definida: el paso 5 es una excepción que vacía el paso 3 para la familia arbitraje; «cumple §0.0» depende de un contrato de entrada que a mitad de fase no existe y nadie está asignado a armar; y la salida de la mesa por disparador 1 reingresa al orden si no se declara punto fijo. Los bloqueantes de §7.0 quedan excluidos; los disparadores 2 y 3 no eran del dominio del orden y nombrarlos confunde dos niveles (FOR-08).

**Recuento de campos de la forma mínima** sobre `scratchpad/caso/`:
```
$ { grep -hE '^\| [^|]+ \| ' $X/README.md $X/actuaciones/*.md | grep -vE '^\| Campo \|'; grep -hE '^Sigue:' $X/actuaciones/*.md; } | wc -l
18
   (5 README · 8 folio 001 [4 cabecera + 3 testimonio + 1 pase] · 5 folio 002 [4 + 1])
$ git ls-tree -r --name-only main -- $X | wc -l     → 3
$ git log --format=%h main -- $X | wc -l            → 3   (no «un commit»: el caso lleva dos más para hacer fallar A7)
```
**Son dieciocho.**

**Fuera de mi competencia:** si conviene que toda intervención sobre el framework abra expediente (rama 1 «más de un repositorio» lo implica para todo reporte de `IA.SDD.Documentacion`); si el `.txt` hermano es buen diseño; la seguridad de S2.

---

## Lo que revisé y está bien

1. **La totalidad del mapeo de §3.2 por enumeración** (tabla de arriba): con la lectura «tipo + dos condiciones binarias», todo folio deja exactamente un estado; R-11 está resuelto en lo que atacaba (no hay tipo sin estado).
2. **Las dos ramas de §1 no son predicción**: «nació en otra corrida», «pide un acto que esta corrida no puede ejecutar» y «entra material externo» se observan con lo que la presentación trae. El defecto es de precedencia, no de decidibilidad.
3. **Los dieciocho campos se cuentan con un comando** y ninguno es derivable del árbol o de git (número, título, apertura, origen y base no están en la ruta ni en el log del caso, salvo que se fije que `Base` sea un commit real, cosa que el caso no hace: `abc1234`).

## Solicitudes de convocatoria

- **Trazabilidad documental (D-6):** la forma de cita calificada difiere entre el dictamen 016 Q4 («`<repositorio> <carpeta>`», espacio) y la regla §3.1 l.162 (`Lab-Geometria/SDD/Expedientes/…`, barra), y A10 sólo reconoce una (FOR-07). Es una decisión de identificadores, no formal.
- **Presidente / diseño del método:** si con FOR-03 la rama 1 debe leerse como «pide un acto que esta corrida no puede ejecutar» solamente, hay que decidir si toda intervención del framework (reporte en un repositorio, norma en otro) abre expediente por construcción; el plan (cambio 9, «abrir un expediente del framework») lo asume y §1 no lo dice.
