# Informe del Refutador: mesa de la intervención 09 (reporte 31)

## Cabecera

| Campo | Valor |
|---|---|
| Comisión | Refutador (núcleo permanente, `Mesa-Rules.md` §5.1). Siglas `M9-REF-NN`. Entro último, con los seis informes del panel a la vista (M9-SEG, M9-FOR, M9-TRZ, M9-REQ, M9-VER, M9-LEC) |
| Fecha | 2026-09-13 |
| Modo | Sólo lectura en todos los repositorios. Carpeta de temporales creada: `scratchpad/mesa/tmp-ref/`, que quedó vacía porque todo lo medí sobre commits |
| Base leída, mesa | Contrato de entrada; `plan/Expediente-Rules.md` 1.0 entero; `plan/20-Plan-De-Aplicacion.md` entero; los seis informes enteros |
| Base leída, expediente 0001 | `IA.SDD-i09` `main` `a501857`. Folio 014 entero; folio 015 §4, §6 y §7; los folios 016 y 018, en lo que citan los informes |
| Base leída, norma 13.17 | Por sección: `SDD-Development-Guide.md` Parte IV (l.620-640) y §VI.3 comprobación 10; `Master-Prompt.md` estructura de §8.1 (l.878-1096); `Master-Prompt-Reanudacion.md` §2 R0 (l.115-155); `Master-Prompt-Migracion.md` l.46; `Mesa-Rules.md` §2.2 (contenido del registro); `Root-Rules.md` §9.2 (l.428-513); `Conocimiento/Knowledge-Mesa-De-Expertos-A-Pedido.md` (índice, §0 l.40-47, §8); `CHANGELOG.md` (bloques de impacto) |
| Destinos | `Lab-Geometria` `main` `d12fb1c` y `RPI.VideoControl` `HEAD` `9aabe5c`, sólo con `git show` y `git grep` |
| Fuentes externas | Ninguna |

**Qué ya está probado y no repito.** El conteo de 18 campos en el caso de dos folios (M9-REQ, M9-VER, M9-FOR). Los defectos de los comandos A1, A4, A7, A8, A9 y A10 (M9-VER-01 a 06, M9-FOR-04 a 07, M9-TRZ-01 y 02, M9-LEC-01 y 02). El comando de S2 que no detecta la fuga (M9-SEG-02). La autoridad sobre E-3 (M9-REQ-01). La incoherencia del orden de Q11 (M9-FOR-08, M9-LEC-05 a 07). El estado que muda con cada errata (M9-FOR-01). Acá mido otra cosa: **cuánto cuesta aplicar y sostener** el plan.

---

## Hallazgos

### M9-REF-01 · P1 · E2 + E3: en un destino, la regla pide dos cosas incompatibles sobre los informes de una mesa, y cualquiera de las dos lecturas cambia el costo por un factor de seis

**Las dos órdenes que chocan.**
- §3 de la regla, «Lo que se asienta verbatim»: *«Un informe de comisión, de refutador, de jurado o de auditor entra como folio `informe` **sin editar**»*.
- §5 de la regla: *«`Audit/` sigue siendo la fuente de cada acto, y el expediente lo folia **por enlace** […] No los copia»*.
- §7, anti-patrón: *«Se copia el registro de mesa o un informe de `Audit/` dentro del expediente»*.
- Y el registro de mesa ya guarda esos informes:

```
$ sed -n 152,198p SDD/Devs/Rules/Mesa-Rules.md | grep -nE '^[0-9]+\. '
32:4. Informes del panel, uno por especialista, con sus hallazgos y su bloque «lo que revisé y está bien».
```

**Qué pasa en un destino.** El registro de `Audit/` ya contiene cada informe. Si la regla se aplica al pie de la letra (§3), cada informe se copia como folio y eso es el anti-patrón de §7. Si se aplica §5, los folios `informe` no existen y todo el panel se reduce a una constancia `ruta@commit`. Ninguno de los seis informes lo señaló. Sólo en el framework, que no tiene `Audit/`, las dos órdenes coinciden.

**El caso que pide el mandato, contado con la regla al pie de la letra.** Un caso que atraviesa corridas y convoca una mesa: seis comisiones, un refutador, un jurado y tres escaladas contestadas en un mismo mensaje del Product Owner.

| Pieza | Lectura §3 (verbatim como folio) | Lectura §5 (por enlace) |
|---|---|---|
| README | 5 campos | 5 campos |
| 001 `presentacion` con testimonio | 4 + 1 + 3 | 4 + 1 + 3 |
| Providencias que despachan: panel, refutador y jurado entran en momentos distintos | 3 × (4 + 1) + 3 × 4 extras de forma completa (insumos, qué se invalida, despachos abiertos, escaladas) = 27 | 1 × 5 (convoca, remite al registro) |
| Cartas en `evidencia/` antes de despachar | 8 × 3 = 24 | 8 × 3 = 24, porque el registro de `Mesa-Rules.md` §2.2 no guarda las cartas |
| Folios `informe` | 8 × 5 = 40 | 0 |
| Constancia `ruta@commit` del registro | 5 | 5 |
| Respuesta a las escaladas, como testimonio | 4 + 1 + 3, más la «pregunta exacta» × 3 | igual: 8 + 3 |
| `resolucion` con veredicto por criterio | 5 + k criterios | 5 + k |
| `archivo` con `Motivo:` | 4 + 1 | 4 + 1 |
| **Total** | **~16 folios, 8 cartas, 25 archivos, ~127 campos + k** | **6 folios, 8 cartas, 15 archivos, ~66 campos + k** |

Si las tres escaladas se contestan en tres mensajes, la lectura §3 llega a 18 folios, que es el tamaño real del 0001 (`git ls-tree -r --name-only main Expedientes | wc -l` → `63`: 18 folios y 44 piezas de evidencia).

**Impacto si no se corrige.** Los «dieciocho campos» son ciertos sólo para el caso que no convoca mesa. En el caso que motivó la figura, el costo depende de qué sección lea el orquestador, y la diferencia es de unos 60 campos y 10 archivos por mesa. Además la lectura cara incumple su propio anti-patrón.

**Dirección de la corrección.** Declarar en §3 que «verbatim como folio» rige sólo **donde no hay registro de `Audit/`**, es decir, en el framework. En un destino, el panel se folia con **una** constancia `ruta@commit` del registro. Las cartas siguen en `evidencia/`, porque el registro no las aloja.

---

### M9-REF-02 · P1 · E2 + E3: un caso con mesa, al pie de la letra, son catorce actos sin momento de uso declarado; el presupuesto de nueve pasos se pasa y la regla no parte el procedimiento

**Ancla.**

```
$ sed -n 630,633p SDD/Guides/SDD-Development-Guide.md
- ¿El procedimiento pasa de **nueve pasos**? Entonces o **se parte en dos puntos de parada** con
  momentos de uso distintos, o **el ítem de menor daño vuelve a prosa**. Agrandarlo no es una opción.
- ¿Está declarado **cuándo se corre**? Un procedimiento sin momento de uso se ejecuta cuando alguien se
```

**Los actos que el caso de M9-REF-01 exige, en orden:**
1. Evaluar §1.
2. Crear la carpeta y el README.
3. Asentar el testimonio y calcular su huella.
4. Asentar la carta antes de despachar.
5. Escribir la providencia con el pase de despacho.
6. Despachar.
7. Comprobar que el despacho anterior terminó.
8. Asentar los informes (o la constancia).
9. Repetir del 4 al 8 para el refutador y para el jurado.
10. Foliar `Audit/` por `ruta@commit`.
11. Asentar la respuesta a las escaladas, con huella y pregunta exacta.
12. Escribir la resolución con veredicto por criterio.
13. Correr S2 antes del push.
14. Correr A1 a A10, y archivar después de aplicar.

Son **catorce actos**. La regla no los enumera. El prompt-snippet de §8 los lleva en prosa (`sed -n 338,352p Expediente-Rules.md | wc -w` → `186` palabras). M9-REQ (pregunta 5) consideró correcta esa forma para lo que «se lee decidiendo». Pero los actos 4, 7 y 13 cumplen las tres condiciones del paso de la guía (l.620-627): se leen ejecutando, su omisión hace daño y se olvidan. De hecho, el 0001 los olvidó (M9-SEG-01: S2 tardía; el 014 y el 017: cartas tardías y doble despacho).

**Impacto si no se corrige.** Los tres actos que ya fallaron una vez quedan como prosa dentro de 186 palabras, que es la «advertencia como bullet» que originó la Parte IV (guía, fila 1.18). La trampa que declara la intervención se cumple en el caso grande y no en el chico.

**Dirección de la corrección.** Declarar **tres momentos de uso** con pasos cortos, cada uno muy por debajo de nueve:
- **abrir**: condición, carpeta, testimonio;
- **despachar**: carta asentada, pase con despachos abiertos, comprobar antes de repetir;
- **publicar o cerrar**: S2 sobre el rango, A1 a A10, `archivo`.

El resto queda en prosa. No suma texto: reordena el que ya está en §3.5, §4 y §8.

---

### M9-REF-03 · P1 · E1: S2 cuesta cuarenta milisegundos, pero la regla la pide sólo «antes del primer push», y un expediente se publica en varios

**Lo medido, con el comando de M9-SEG-02 sobre el squash del 0001.**

```
$ git show --stat --format= 650053e | tail -1
 63 files changed, 6840 insertions(+)
$ time (git log -p --format= 650053e^..650053e -- Expedientes | grep -ciE "^\+.*((/|-)home[/-][a-z0-9]+|/Users/|$(id -un))")
4
real	0m0,046s
```

**Qué costaría y dónde está mal puesto.** Sobre un expediente de 63 archivos y 6840 líneas, el costo de máquina es nulo. El costo real está en otro lado:
- **Quién la corre:** la regla no lo dice. S2 está en §4 como prosa y en el snippet como «Antes del primer push: S2».
- **Con qué comando:** el de §7 no funciona (M9-SEG-02) y ningún criterio A la contiene.
- **Cuándo:** la letra dice «**primer** push». Un expediente acumula folios durante semanas y a lo largo de varias corridas; es su condición de apertura (§1.1). Así que el segundo push y los siguientes quedan sin compuerta. En el 0001, las cuatro piezas con el usuario del host (M9-SEG-02) entraron por cartas y réplicas asentadas **después** del primer commit.

**Impacto si no se corrige.** La compuerta más barata del plan cubre sólo la apertura, que es justo el momento con menos material. Lo que se asienta después, sobre todo informes y cartas verbatim (M9-SEG-08), sale sin revisar.

**Dirección de la corrección.** Tres cambios:
- S2 como **paso del momento «publicar»** de M9-REF-02, «antes de **cada** push que toque la carpeta», con fundamento pegado.
- Su comando sobre el rango `<base>..HEAD`, el de M9-SEG-02, como criterio **A11** `[enumerable]`.
- Quien la corre es el orquestador que empuja.

Cuesta una línea y cuarenta milisegundos.

---

### M9-REF-04 · P1 · E1: la custodia «donde se asiente» es una obligación transversal escondida en una regla de expedientes; los dos destinos tienen 127 líneas que la incumplen desde el día uno, y ninguna regla de esos artefactos la trae

**Ancla.** Último bloque de §1 de la regla: *«La forma de §3.3 rige donde el testimonio se asiente: en un folio, en el registro de mesa, en `Decisiones-Pendientes.md` o en una bitácora de validación»*. El plan (cambio 5) cablea esa forma sólo en `Mesa-Rules.md` §7.1. No edita `Root-Rules.md` §12.2 ni las reglas de las bitácoras ni la de `Decisiones-Pendientes.md`.

**Medido en los destinos, fuera de `Expedientes/` y de `_legacy/`.**

```
$ git -C Lab-Geometria grep -nE '(Product Owner|PO)\b[^|]{0,80}(«|“)' main -- SDD ':!SDD/Expedientes' ':!*_legacy*' | wc -l
112
  (entre ellos: Alcance-Producto.md, Roadmap-Producto.md, Vision-Producto.md, NB-00002, y ocho informes de Audit/)
$ git -C Lab-Geometria grep -nE 'ok de la fase' main -- ':!SDD/Expedientes' ':!*_legacy*' | grep changelog
main:changelog.md:1698:  Owner, 2026-09-13: «tenés el ok de la fase K». …          ← normalizado: el original dice «tenes el ok de la fase K,»
$ git -C RPI.VideoControl grep -nE '(Product Owner|PO)\b[^|]{0,80}(«|“)' HEAD -- SDD ':!*_legacy*' | wc -l
15
  (entre ellos: Mesa-2026-08-29/30/31.md, PRODUCT-INTAKE, Vision-Producto.md)
$ git -C <cada destino> grep -c '^```testimonio' <rama> | wc -l
0          (en los dos)
$ git -C RPI.VideoControl show HEAD:SDD/Docs/Producto/Decisiones-Pendientes.md | grep -ciE 'respond|aprob|product owner'
16
```

**¿Los vuelve incumplidos?** Por la letra, sí: «rige donde el testimonio se asiente», sin fecha de inicio. Hay 127 líneas con palabras entrecomilladas del Product Owner en tres registros de mesa, un intake, el roadmap y un `changelog.md` que ya normalizó un «ok» (lo mismo que M9-REQ encontró en el folio 002 de `EXP-0001`). Ninguna tiene bloque, canal, fecha-hora ni huella. Y quien escribe `Decisiones-Pendientes.md` o una bitácora lee su propia regla, no `Expediente-Rules.md`. Además, M9-LEC-03 mostró que una fila de control de cambios no puede alojar el bloque.

**Impacto si no se corrige.** O la próxima auditoría de migración lo cuenta como hallazgo en cada destino, o nadie lo aplica fuera de los expedientes porque la regla que lo manda no está en el camino de ejecución (guía §III.8). El bloque se vuelve prosa muerta.

**Dirección de la corrección.**
- Acotar la custodia a **los dos lugares donde la aprobación se produce**: la respuesta al lote de `Master-Prompt.md` §7.0 y la respuesta a una escalada de `Mesa-Rules.md` §7.1. En cada uno, una remisión a §3.3.
- Sacar de la lista «`Decisiones-Pendientes.md`» y «bitácora».
- Declarar en el bloque de impacto del `CHANGELOG.md` que **no es retroactiva**: las 127 líneas existentes no se reescriben.

---

### M9-REF-05 · P2 · E1: E-3 cuesta un major que no compra nada medible, y la opción B tampoco vuelve incumplido nada; la opción C de M9-REQ-01 es la más barata

**Lo que costaría la opción A.** Un major sobre D9. El plan lo presenta con un «impacto medido cero». Medido:

```
$ git -C RPI.VideoControl grep -hoE '\[EV-[0-9]+ *\| *humano[^]]*\]' HEAD -- SDD ':!*_legacy*' | wc -l
5
$ … | grep -ciE 'chat|conversaci|mensaje|ok|testimonio'
0
$ git -C Lab-Geometria grep -hoE '\[EV-[0-9]+ *\| *humano[^]]*\]' main -- SDD ':!*_legacy*' | wc -l
0          (con ese patrón de cita; M9-TRZ midió 118 ocurrencias de EV- en otra forma, que no clasifiqué)
```

Ninguna cita D9 de tipo `humano` de los destinos se apoya hoy en una aprobación por conversación. El major no cambia el estatus de nada escrito. Además, el `CHANGELOG.md` evita justamente declarar «ninguno»:

```
$ grep -n 'Impacto sobre destinos existentes' CHANGELOG.md | wc -l
26
$ grep -n -A2 'Impacto sobre destinos existentes' CHANGELOG.md | grep -iE 'ningun|nada' | cut -c1-60
212-**No es «ninguno», y hay un destino que lo consume …
300-**Nada retroactivo, y no es «ninguno».** …
366-**Nada retroactivo, y no es «ninguno».** …
439-**Nada retroactivo, y no es «ninguno».** …
575-**Ninguno forzado por la publicación, y no es una migración.** …
```

Un major con «Impacto: ninguno» rompe la costumbre del propio catálogo y le enseña al lector que el bloque de impacto puede ser vacío. Tiene un costo más: todo destino que migre cruza un major (`Migracion-Rules.md`) para una oración que no le exige nada.

**Lo que costaría la opción B en el caso real.** La fase `k` se cerró con un OK por chat:

```
$ git -C Lab-Geometria show -s --format='%h %ci %s' 7864428
7864428 2026-09-13 12:19:30 -0300 docs(expediente): abre EXP-0001 y asienta el OK del Product Owner a la fase k
$ git -C Lab-Geometria grep -nE 'humano' main -- SDD/Docs/00-Contexto/Roadmap-Producto.md SDD/Docs/Unidades-Entrega/GeometriaFactory-Api/07-Plan-Sprint/Mini-Plan.md
(vacío)
```

El cierre de `k` (Roadmap 1.13, Mini-Plan l.470) no es una cita D9. B no vuelve incumplido nada. Su costo es de requisitos: contradice R5 (M9-REQ pregunta 2), no de aplicación.

**Impacto si no se corrige.** Se paga un major, una fila en `Deriva-Rules.md`, un bloque de impacto vacío y una decisión que no le toca a esta mesa (M9-REQ-01), para obtener lo mismo que C.

**Dirección de la corrección.** Sacar el cambio 15. Queda la opción C: §3.3 de la regla ya dice que el asiento con original, canal, fecha-hora y huella **es** «la aprobación explícita registrada con fecha». Es minor y no toca `Deriva-Rules.md`. La opción A queda como parche condicionado a lo que responda el Product Owner.

---

### M9-REF-06 · P1 · E1: la reanudación va a listar para siempre como abierto el único expediente histórico de destino, y cerrarlo exige lo que la regla y esta mesa prohíben

**Ancla.** Plan, cambio 4: R0 paso 4 suma *«los expedientes de `SDD/Expedientes/` cuyo último folio no es `archivo`»*. La reanudación mira destinos, así que el caso es `Lab-Geometria`:

```
$ git -C Lab-Geometria ls-tree --name-only main SDD/Expedientes/0001-Migracion-Normativa-A-13.16/actuaciones/ | tail -1
…/013-resolucion-final.md
$ git -C Lab-Geometria show main:…/013-resolucion-final.md | head -4
# EXP-0001 · Actuación 013 — Resolución: migración completa y cierre del expediente
**Expediente:** [EXP-0001](../README.md)
**Tipo:** `resolucion`
$ … | grep -c '^Sigue:'
0
```

**El costo de leer.** No es de máquina. A1 a A10 sobre el 0001, con sus 63 archivos, tardan `real 0m0,280s`. Con veinte expedientes, R0 paso 4 son veinte `tail` y veinte lecturas de pase. El costo está en los falsos pendientes:
1. El `EXP-0001` se titula «cierre del expediente», pero su último folio es `resolucion` y no `archivo`. Por la letra del cambio 4 queda **abierto en cada reanudación, para siempre**.
2. Su cabecera va en negritas y no en tabla, y no tiene `Sigue:`. El «pase del último folio» que el cambio 4 manda leer no existe, y el tipo sólo se puede leer del nombre del archivo (M9-TRZ-05).
3. Para cerrarlo hace falta un folio `archivo` en un destino. Esta mesa no puede escribir ahí (R6). §5.1 declara la forma histórica «como está». Y un folio nuevo en el README de un histórico ya choca con A7 (M9-VER, pregunta 5 y caso `p18`).

A esto se suman las erratas que dejan «en trámite» a un expediente resuelto (M9-FOR-01) y los pases ya cumplidos que nada cierra (M9-LEC-04). Cada resolución sin `archivo` es un pendiente falso más.

**Impacto si no se corrige.** La primera reanudación de `Lab-Geometria` bajo la 13.18 publica un pendiente falso, sin pase legible. Todo destino con resoluciones sin archivar acumula uno por expediente. R1 pierde confianza, que es lo que el paso 4 existe para dar.

**Dirección de la corrección.**
- R0 paso 4 lee **sólo los expedientes de forma vigente**.
- Los de forma histórica se nombran una vez en R1, como «histórico, sin pase legible», y no cuentan como pendientes.
- «Abierto» a efectos de R0 = último folio de tipo `presentacion`, `providencia`, `informe` o `constancia`. Una `resolucion` cuenta sólo si su pase nombra un evento de cierre no cumplido (M9-LEC-04).

---

### M9-REF-07 · P2 · E1: los cinco dígitos no los exige ninguna regla para una familia excluida, y son lo que produce dos formas vivas por repositorio y la excepción permanente de A1

**Ancla.**

```
$ sed -n 428,513p SDD/Devs/Rules/Root-Rules.md | grep -nE 'excluid|no la usan'
60:uso y **no estaba declarada en ninguna parte**. **Las familias excluidas no la usan**: escriben el marcador
61:con su propia forma —`FA-NN`, `Sprint-XX`—, que es lo que las hace reconocibles como excluidas.
```

El plan (cambio 7) excluye el número de expediente de §9.2. Una familia excluida **no usa** el ancho de cinco dígitos. Nada obliga a `00001`.

**Lo que cuesta el ancho de cinco.**
- A1 da `1` para siempre en `IA.SDD` y en `Lab-Geometria` (M9-VER-03, M9-FOR-04, `ev-03`). Hay que declararle una excepción o dejarlo en rojo.
- Nadie sabe si después de `0001-` sigue `00001` o `00002` (M9-VER-03).
- Cada uno de los dos repositorios queda con **dos formas de nombre de carpeta vivas para siempre**: `0001-` y `0000N-`.

**Sobre el ataque 10 (prohibir `EXP-`).** La prohibición se sostiene: no crea la segunda forma, la crea el ancho. Lo que no se sostiene es su detección, que penaliza citar `EXP-0001` (M9-TRZ-08 a).

**Impacto si no se corrige.** Una excepción permanente en un criterio `[enumerable]`, una regla de arranque de numeración por escribir y dos formas vivas. Todo eso por un ancho que la regla de identificadores no pide.

**Dirección de la corrección.** Número local de **cuatro dígitos** (`NNNN-<Titulo>`), declarado en la fila de exclusión de §9.2 como marcador de forma propia.
- Las dos carpetas históricas quedan conformes **en nombre**, aunque no en contenido.
- A1 da `0` en los dos repositorios sin excepción.
- La numeración sigue en `0002`.

Reabre el ancho de Q4, y tiene el ancla que se necesita para eso: E1 de M9-VER-03 contra §5.1.

---

### M9-REF-08 · P2 · E1 + E2: de los 18 artefactos, once alcanzan para que la figura funcione mañana; la alineación de la 13.17 reescribe el 26 % de un documento publicado hace horas cuando su propio texto ya se somete a la regla

**Una corrección al mandato.** «Un snapshot más» por archivo no es cierto:

```
$ ls _legacy/13.17
Conocimiento  Examples  PROMPTS  README.md  SDD  Templates
```

El snapshot es uno por versión y copia el conjunto entero, se toquen 3 archivos o 18. El costo por archivo tocado es otro: la fila de control de cambios, la cabecera igual a la mayor fila (`SDD-Development-Guide.md` l.742, comprobación 10) y su parte en el barrido de la nota de coherencia.

**La 13.17.**

```
$ git log -1 --format='%h %ci' main -- Conocimiento/Knowledge-Mesa-De-Expertos-A-Pedido.md
cab03ed 2026-09-13 12:21:08 -0300
$ awk '…' Knowledge-Mesa-De-Expertos-A-Pedido.md      (§2.3, §3.2, §5.2, §5.3, §6)
2.3: 18  3.2: 15  5.2+5.3: 33  6: 14  total: 80        (de 312 líneas)
$ sed -n 45p Conocimiento/Knowledge-Mesa-De-Expertos-A-Pedido.md
| La forma normativa de un expediente de caso | **Ninguna regla la fija todavía.** §2.3 describe la práctica; si el framework adopta una norma de expedientes, esa norma gobierna y este documento se alinea |
```

§8 del mismo documento dice: *«Si una mesa normativa encontrara contradicción entre este documento y `Mesa-Rules.md`, manda la regla»*. La precedencia ya está escrita. Reescribir §5.3 con «el árbol de la regla» deja **dos copias del árbol** que hay que mantener sincronizadas, que es la clase de dato duplicado que la propia regla combate. La única contradicción que no se resuelve por precedencia es §3.2, «testimonio … E4» (M9-TRZ pregunta 6, 014 R-07).

**El folio 019 (cambio 18).** Agregar una fila al índice del README del 0001 es editar después de la fusión una pieza sellada (M9-VER, pregunta 5). El folio basta sin la fila.

**Impacto si no se corrige.** Dieciocho filas de control de cambios, dieciocho cabeceras y un barrido que crece con cada una. Seis de esos artefactos no participan en la ejecución (M9-REQ pregunta 5 los clasificó como propagación). Además, una segunda copia del árbol en `Conocimiento/`.

**Dirección de la corrección.** Tres grupos, y el detalle por cambio está en la tabla de cierre:
- **Imprescindibles mañana (11):** 1, 2 (§3.5 y un párrafo en §8.1, ver ataque 4), 3, 4, 5 (§8 criterio 1 y §7.1), 6, 7, 8 (§VI.5), 9 (l.152 y anatomía), 16 y 17.
- **Con una remisión en vez de reescritura:** el 13, que corrige la oración E4 de §3.2 y reemplaza §2.3, §5.3 y el primer criterio de §6 por «rige `Expediente-Rules.md`».
- **Prosa en la regla o próxima etapa:** 10, 11, 12 y 14. El 15 sale (M9-REF-05). El 18 va sin tocar el README.

---

## Respuestas a las preguntas del mandato

**1. Los 18 campos en un caso que no es el ideal.** Mesa de seis comisiones, refutador, jurado y tres escaladas, con la regla al pie de la letra:
- Lectura §3: ~16 folios, 8 cartas, 25 archivos, ~127 campos más los criterios de la resolución.
- Lectura §5: 6 folios, 15 archivos, ~66 campos (M9-REF-01).
- Pasos: catorce actos, que pasan el presupuesto de nueve (M9-REF-02).
- Folios inevitables en un destino: seis (presentación, providencia, constancia de `Audit/`, testimonio de la respuesta, resolución, archivo), más una carta por despacho. Los folios `informe` son evitables en un destino y no deberían existir ahí.

**2. El costo de S2 antes del push.** Máquina: 0,046 s sobre 63 archivos y 6840 líneas. Quién la corre: la regla no lo dice; debe ser el orquestador que empuja. Con qué comando: el de M9-SEG-02 sobre `<base>..HEAD`, porque el de §7 no sirve. Hoy está como prosa y como «primer push»; tiene que ser paso, «antes de cada push», con criterio A11 (M9-REF-03).

**3. La custodia «donde se asiente».** Sí, es una obligación transversal escondida en una regla de expedientes. Medido: 112 líneas en `Lab-Geometria` y 15 en `RPI.VideoControl` con palabras entrecomilladas del Product Owner fuera de `Expedientes/`, y cero bloques `testimonio`. Por la letra quedan incumplidas sin fecha de inicio. Hay que acotarla a §7.0 y §7.1 y declararla no retroactiva (M9-REF-04).

**4. Q11 en `Master-Prompt.md` §8.1.**
- §8.1 no tiene hoy ningún paso numerado: `sed -n 878,1096p … | grep -cE '^[0-9]+\. '` → `0`. Son cinco subsecciones en prosa.
- Los cinco pasos no pasan de nueve, pero los pasos 1 y 2 (origen del hecho, autocorrección) ya están en §8.1 como prosa. Lo nuevo son tres.
- Por la guía l.620 («se lee decidiendo cuál ejecutar → prosa»), el orden de Q11 es decisión y va como **un párrafo con fundamento**, no como procedimiento numerado.
- Qué es «lote de fase» en M4, que corta por categoría: ya lo mostró M9-LEC-06. No es decidible, y la salida barata es «una vez por corte de M4, que ya tiene audit».
- La incoherencia interna del orden es de M9-FOR-08 y M9-LEC-05; no la repito.

**5. E-3.** A cuesta un major con un impacto que el propio `CHANGELOG.md` evita declarar vacío. Las citas D9 `humano` que se apoyan en chat son 0 en los dos destinos. B no vuelve incumplido nada: el cierre de `k` en `7864428` no es cita D9, pero B choca con R5. C es minor y sin edición de `Deriva-Rules.md` (M9-REF-05, M9-REQ-01).

**6. Los 18 artefactos.** Once imprescindibles; uno (13) mejor por remisión; cuatro (10, 11, 12, 14) pueden esperar como prosa o etapa siguiente; uno (15) sale; el 18 va sin fila de README. El snapshot no crece por archivo (M9-REF-08).

**7. El README que remite y no indexa.** Resiste.
- `ls actuaciones/` ya da folio, tipo y slug, tres de las cinco columnas de un índice. Fecha y autor cuestan un `grep -h '^| Fecha \|^| Autor ' actuaciones/*.md`.
- Los dos ejemplares con tabla muestran lo que esa tabla cuesta: el 0001 tiene 18 filas escritas a mano y tuvo dos huellas falsas (folio 017). El README de `EXP-0001` tiene 80 filas de tabla y 32 huellas de 64 caracteres (`git show …/README.md | grep -cE '[0-9a-f]{64}'` → `32`).
- Para 44 piezas de evidencia, `head -3 evidencia/*` es el índice que A9 ya garantiza, cuando se corrija M9-VER-01.
- Mejora barata: que la línea de remisión del README lleve esos dos comandos.

**8. `Suspende hasta:` y la reanudación.** El tiempo de máquina es despreciable (A1 a A10: 0,28 s sobre 63 archivos). El costo es de falsos pendientes. El histórico de `Lab-Geometria` no tiene pase y termina en `resolucion`, así que queda abierto para siempre y no se puede cerrar sin escribir en un destino (M9-REF-06). `Suspende hasta:` en sí no agrega costo. Su levantamiento implícito es de M9-FOR-02.

**9. La 13.17 alineada.** Hoy no hace falta la reescritura de cinco secciones (80 de 312 líneas): §0 l.45 y §8 ya subordinan el documento a la norma que se adopte. Sólo la oración E4 de §3.2 exige edición. D-3 se cierra con una fila 1.1 que registre la remisión. Si el presidente entiende que el evento de cierre de D-3 («alineación de esas cinco secciones») exige texto propio en cada una, eso es interpretación de la deuda y le toca decidirlo a él (M9-REF-08).

**10. El prefijo `EXP-`.** La prohibición se sostiene; la detección de §7 no (M9-TRZ-08). Las dos formas vivas no las produce la prohibición sino el ancho de cinco dígitos, que ninguna regla exige a una familia excluida (M9-REF-07).

---

## Lo que revisé y está bien

1. **El README que remite en vez de indexar.** Contra los dos ejemplares, la tabla a mano costó 18 y 80 filas y produjo huellas falsas; la remisión cuesta un `ls` y un `grep` (pregunta 7).
2. **El costo de máquina de toda la verificación es despreciable.** S2 tarda 0,046 s y A1 a A10 tardan 0,28 s sobre el expediente más grande que existe. El presupuesto que hay que cuidar es el de la persona (actos y momentos), no el del comando. Por eso R3 (ningún verificador aparte) se puede sostener.
3. **Excluir el número del sistema de identificadores y no acuñar `EXP-`** es la decisión barata correcta. Evita tocar D3 y §9.1, y hasta habilita el ancho propio de M9-REF-07.

---

## Solicitudes de convocatoria

- **Orquestación de reanudación.** M9-REF-06: cómo trata R0 paso 4 un expediente histórico sin pase legible en un destino. Ubicación: plan, cambio 4; `Lab-Geometria` `SDD/Expedientes/0001-…/actuaciones/013-resolucion-final.md`.
- **Presidente.** M9-REF-08 y pregunta 9: si el evento de cierre de D-3 (folio 015 §6) se cumple con una remisión o exige texto en cada una de las cinco secciones. M9-REF-07: el ancho de Q4 se reabre con ancla E1 (M9-VER-03), y la decisión de reabrirlo es del presidente y el jurado.

---

## Tabla de impacto

**Por pregunta de la forma aprobada (folio 015 §4), mirada desde el costo.**

| Q | Veredicto | Motivo |
|---|---|---|
| Q1 | resiste | Una exclusión y una reformulación declarada; costo de una fila |
| Q2 | cambiar | La custodia «donde se asiente» es transversal y retroactiva por la letra (M9-REF-04); la precedencia, en M9-FOR-03 |
| Q3 | cambiar | 18 campos sólo sin mesa; con mesa, 66 o 127 según la lectura, porque «verbatim como folio» choca con «por enlace» en destino (M9-REF-01); los actos sin momento de uso pasan de nueve (M9-REF-02) |
| Q4 | cambiar | El ancho de cinco no es exigible a una excluida y produce la excepción de A1 y dos formas vivas (M9-REF-07) |
| Q5 | resiste con las correcciones de M9-FOR-01 y 02 | Costo nulo de aplicación |
| Q6 | resiste | S1 y S3 no agregan actos; los defectos de A7 son de M9-VER y M9-FOR |
| Q7 | cambiar | S2 «antes de cada push», como paso y como A11 (M9-REF-03) |
| Q8 | resiste con M9-TRZ-03 | Una vía; la cadena de dos saltos no cuesta actos nuevos |
| Q9 | cambiar | En destino, el panel se folia con una constancia y no con folios `informe` (M9-REF-01) |
| Q10 | cambiar | Los históricos, fuera de R0 paso 4 (M9-REF-06) |
| Q11 | cambiar | Un párrafo en §8.1 y no un procedimiento numerado; «lote» = corte en M4 |
| Q12 | cambiar | El pase de una `resolucion` sin evento de cierre no cuenta como pendiente (M9-REF-06, M9-LEC-04) |
| E-3 | cambiar | C, minor; A preparada para el Product Owner (M9-REF-05) |

**Por cambio del plan.**

| # | Artefacto | Veredicto | Motivo |
|---|---|---|---|
| 1 | `Expediente-Rules.md` | resiste, con cambios | M9-REF-01, 02, 03, 04 y 07 |
| 2 | `Master-Prompt.md` | cambiar | §3.5 y §12.1 T1 resisten; §8.1 un párrafo y no cinco pasos; §15 puede esperar |
| 3 | `Master-Prompt-Migracion.md` | resiste, con cambio | l.46 declarada; «lote» = corte de M4 |
| 4 | `Master-Prompt-Reanudacion.md` | cambiar | Sólo expedientes de forma vigente (M9-REF-06) |
| 5 | `Mesa-Rules.md` | cambiar | §8 criterio 1 y §7.1 resisten; la nota de §2.1 y §0.0 pueden esperar |
| 6 | `Migracion-Rules.md` | resiste | Una fila |
| 7 | `Root-Rules.md` §9.2 | cambiar | Fila de exclusión con ancho propio (M9-REF-07) |
| 8 | Guía | cambiar | §VI.5 resiste; §III.8, §VI.3 comprobación 2 y l.145 pueden esperar |
| 9 | `README.md` | cambiar | l.152 y anatomía resisten; el resto puede esperar |
| 10 | `_legacy/README.md` | sacar de esta etapa | Repite §VI.5 |
| 11 | `SDD-User-Guide.md` | sacar de esta etapa | Declarada como etapa 2 |
| 12 | `Catalogo-De-Criterios.md` | sacar de esta etapa | Índice que no participa en la ejecución |
| 13 | `Knowledge-Mesa-De-Expertos-A-Pedido.md` | cambiar | Remisión y oración E4, no reescritura de 80 líneas (M9-REF-08) |
| 14 | `Index-Knowledge.md` | sacar de esta etapa | Una celda de versión; va con el 13 si el 13 sube |
| 15 | `Deriva-Rules.md` | sacar | M9-REF-05 |
| 16 | Nota de coherencia | resiste | `README.md` l.147 |
| 17 | `CHANGELOG.md` | cambiar | Impacto: custodia no retroactiva (M9-REF-04), minor |
| 18 | Folio 019 del 0001 | cambiar | Sin editar el README del 0001 |

---

## La forma más barata que sigue cumpliendo el dictamen

Nueve artefactos tocados en lugar de 18, sin major, con la forma mínima intacta y con los tres actos que ya fallaron una vez convertidos en pasos.

1. **La regla nueva**, con estos cambios sobre el borrador:
   - **Número local de cuatro dígitos**, excluido en §9.2 con forma propia. Los dos históricos quedan conformes en nombre y A1 da `0` sin excepción.
   - **En destino, el panel se folia por una constancia `ruta@commit`** del registro de mesa. «Verbatim como folio» rige sólo en el framework. Las cartas, siempre en `evidencia/`.
   - **Tres momentos de uso con sus pasos**:
     - *abrir*: condición de §1; carpeta y README de cinco campos; testimonio con huella.
     - *despachar*: carta asentada; pase con despachos abiertos; comprobar antes de repetir.
     - *publicar o cerrar*: S2 sobre `<base>..HEAD` antes de **cada** push, como A11; A1 a A10; `archivo` al aplicar.
   - **Custodia del testimonio** acotada a la respuesta al lote (§7.0) y a la escalada (§7.1), no retroactiva.
   - **E-3 por la opción C**: la frase de §3.3 que ya está; A queda como parche para el Product Owner.
2. **`Master-Prompt.md`**: §3.5 (una línea), §8.1 (un párrafo con el orden de Q11 como prosa con fundamento) y §12.1 T1 (una oración sobre S3).
3. **`Master-Prompt-Migracion.md`**: l.46 declarada; en M4, «una vez por corte».
4. **`Master-Prompt-Reanudacion.md`**: R0 paso 4 lee sólo expedientes de forma vigente cuyo último folio no es `resolucion` ni `archivo`, salvo que el pase nombre un evento de cierre no cumplido.
5. **`Mesa-Rules.md`**: §8 criterio 1 y §7.1.
6. **`Migracion-Rules.md`** §2.2 y **`Root-Rules.md`** §9.2: una fila cada uno.
7. **Guía** §VI.5 y **`README.md`** l.152 y anatomía.
8. **`Knowledge-Mesa-De-Expertos-A-Pedido.md`** 1.1 por remisión, con la oración E4 corregida.
9. **Nota de coherencia y `CHANGELOG.md`** `[13.18]` minor, con un impacto que no es «ninguno»: la custodia rige hacia adelante y los históricos no cuentan en R0.

Lo demás (`_legacy/README.md`, guía de usuario, catálogo, índice de conocimiento, §15, las notas de `Mesa-Rules.md` §0.0 y §2.1) va en una segunda etapa con su nota, como la guía recomienda cuando se tocan más de tres o cuatro archivos. El folio 019 del 0001 se asienta sin editar su README.
