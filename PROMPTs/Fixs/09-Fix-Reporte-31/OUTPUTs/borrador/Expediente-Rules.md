# Reglas constructivas — Expediente de caso

**Carpeta target:** `SDD/Expedientes/` del repositorio destino; `Expedientes/` en la raíz del repositorio del framework
**Nivel de aplicación (`Vocabulario-Rules.md` §4 R3):** Framework
**Agente target:** los tres orquestadores y AG-00970 (Presidente de mesa) en tiempo de ejecución; quien interviene el framework cuando el caso es del framework
**Versión de las reglas:** 1.0

---

## 0. El problema que resuelve, y qué no

**El método tiene un contenedor por artefacto y ninguno para el caso que los atraviesa.** Un ADR guarda
una decisión; un informe de audit, una ronda; el registro de mesa, un ciclo; el informe de estado, una
reanudación; el ítem diferido, un hueco; la fila de control de cambios, una versión de un archivo. Un
**caso** —un pedido, un incidente, una contradicción— atraviesa varios de ésos, a veces varias corridas y a
veces más de un repositorio, y hasta esta versión no tenía dónde quedar entero. Medido sobre un destino
real: reconstruir el estado de una fase exigió abrir **nueve archivos de tres directorios y una rama**,
siguiendo identificadores con `grep` y no por estructura, y el desenlace estaba en el roadmap y no en
`Audit/`. Y el mismo día en que el Product Owner pidió la figura, **dos corridas la inventaron con dos formas
distintas**, y una tercera y una cuarta ya existían en el corpus con otro nombre.

**La evidencia que funda una decisión tampoco tenía dónde quedar con procedencia.** En particular **la
palabra del Product Owner**: el primer expediente del framework presentó como literal un pedido que estaba
normalizado, reordenado y recortado, y lo descubrió una réplica, no la primera lectura. La figura existe
para que eso no pueda pasar sin que se vea.

**Lo que esta regla no hace, y se declara porque cada punto fue atacado y resuelto:**

| No hace | Por qué |
| --- | --- |
| **No muda nada de `SDD/Docs/Audit/`.** El registro de mesa, los informes de migración, de estado y de audit siguen donde `Mesa-Rules.md` §2.1, `Migracion-Rules.md` §2.1 y `Master-Prompt-Reanudacion.md` §5 los ubican | Un segundo registro del mismo acto es el tercer contenedor que `Mesa-Rules.md` §2.1 rechazó para el plan. El expediente **folia por enlace** (§5) |
| **No convierte la evidencia en especificación** | D9 separa lo que se afirma que ya es de lo que se pide (`Deriva-Rules.md` §1). La evidencia **funda** la especificación y el artefacto que cambia la cita (§5) |
| **No toca el ciclo de origen** de `Master-Prompt.md` §8.2 ni `Root-Rules.md` §12 | Se calcula, no se declara. Un campo más ahí sería un dato declarado en un campo calculado |
| **No es una ceremonia.** La forma mínima son **dieciocho campos** en un caso de dos folios (§3), ninguno derivable del árbol o del control de versiones, y se verifica enumerando (§6) | El primer plan de la figura pedía cuarenta y siete campos, cuatro archivos y doce pasos, y **el propio ejemplar que lo proponía no cumplía dos de sus reglas en ninguno de sus commits**. Todo campo que se pueda leer del árbol o de git no se escribe a mano (`Root-Rules.md` §10) |
| **No fija la convención de mensajes de commit** ni exige un commit por folio | El framework no la fija (`Coherencia-Conformacion-Pull-Request-Manual.md` §2), y un commit por folio se pierde con una fusión que aplasta la historia |
| **No distribuye código** | Cada comando de verificación vive en §6, en el texto que lo funda (`SDD-Development-Guide.md` §II.7). La evidencia lleva su comando dentro del archivo |

---

## 1. Cuándo se abre un expediente, y cuándo no

**Es una condición que se observa al abrir, no una lista de puntos ni una predicción.** Se abre un expediente
cuando se cumple **una** de las dos:

1. **El caso atraviesa más de una corrida o más de un repositorio.** Lo que lo presenta ya lo dice: el hecho
   nació en otra corrida (otra base, otra rama) o en otro repositorio que el que lo trata, o la presentación
   pide expresamente un acto que esta corrida no puede ejecutar —una intervención sobre el framework, otra
   migración, una decisión del Product Owner que no llega en esta corrida—.
2. **Entra al árbol material externo que tiene que preservarse y ningún artefacto con casa lo aloja**: un
   testimonio que funda una decisión y no tiene fila donde asentarse, una captura, un archivo que aporta el
   Product Owner o que obtuvo un agente fuera del repositorio.

**No se abre**, porque lo que sigue ya tiene casa y un expediente lo duplicaría:

- una **mesa** que ya tiene su registro en `SDD/Docs/Audit/` (`Mesa-Rules.md` §2.1);
- una **detención** que sale en el lote de `Master-Prompt.md` §7.0 y se contesta ahí;
- una **autocorrección** (`Master-Prompt.md` §8.1), un **audit de fase** (§10), un **ítem diferido** en forma
  (`Root-Rules.md` §12.2);
- lo que **se contesta con un comando** y una cita del árbol.

**La custodia del original de un testimonio no depende de que se abra un expediente.** La forma de §3.3
rige **donde el testimonio se asiente**: en un folio, en el registro de mesa, en `Decisiones-Pendientes.md`
o en una bitácora de validación. Sin esto, la prueba más frecuente del Product Owner —una aprobación dada
en la conversación— quedaría por debajo del umbral y sin custodia.

**Ante la duda, no se abre**: un caso que después resulta atravesar otra corrida abre su expediente en ese
momento, con una constancia de incorporación de antecedentes por `ruta@commit` (§5.1). Un expediente abierto
de más cuesta mantener; uno abierto tarde cuesta una constancia.

---

## 2. Dónde vive

| Repositorio | Carpeta | Por qué ahí |
| --- | --- | --- |
| **Destino** | `SDD/Expedientes/<NNNNN>-<Titulo>/`, hermana de `SDD/Docs/` | Es donde ocurre el caso. Fuera de `SDD/Docs/` porque no es prosa generada por una categoría: es registro, como `SDD/Maquetas/` es material del humano (`Master-Prompt.md` §3.5) |
| **Framework** | `Expedientes/<NNNNN>-<Titulo>/`, en la raíz | Es la ruta que fijó el Product Owner. El framework no tiene `SDD/Docs/`, y su `SDD/` es el conjunto normativo que se archiva entero por versión |

**Tres exclusiones, y ninguna se deduce de la carpeta: se declaran.**

- **Del snapshot `_legacy/<versión>/`** (`SDD-Development-Guide.md` §VI.5): un expediente es acumulativo y su
  historia es su contenido, como el `CHANGELOG.md`, y **no condiciona lo que el orquestador genera**. Que la
  carpeta esté en la raíz no la excluye por sí sola: `Conocimiento/` y `Examples/` están en la raíz y entran.
- **De la migración normativa** (`Migracion-Rules.md` §2.2): un expediente no se migra, no se renumera ni se
  re-expresa. Es un registro de lo que pasó bajo la norma que regía.
- **De la compuerta de fase** (`Master-Prompt.md` §10.0) y del audit: no es un entregable de categoría. Lo
  verifican los criterios de §6.

**Autosuficiencia del framework.** `Expedientes/` del framework **nombra** otros repositorios, ramas y rutas
**como texto**, sin enlaces: es registro de casos y no conjunto normativo, y `README.md` lo declara así.

---

## 3. La forma mínima, y la completa

**Principio.** Nada que se pueda leer del árbol o de git se escribe a mano. **El índice es el listado de
`actuaciones/`; el estado se deriva del tipo del último folio; el punto de continuación es el pase del último
folio.** El `README.md` no los copia: remite.

```text
<NNNNN>-<Titulo>/
├── README.md                          carátula: Número · Título · Apertura · Origen · Base     → 5 campos
│                                      y una línea fija: «Índice: actuaciones/. Estado y qué sigue: el pase del último folio»
├── actuaciones/
│   └── NNN-<tipo>-<slug>.md           cabecera: Tipo · Fecha · Autor · Corrige                 → 4 campos
│                                      última línea, el pase: «Sigue: <acto> · <quién>»           → 1 campo
│                                      si asienta palabras del Product Owner, el bloque literal
│                                      más Canal · Fecha-hora con zona · Huella                   → 3 campos
└── evidencia/                         sólo si hay
    └── NNN-<slug>.<ext>               abre con: Método o comando · Base o fecha-hora · Quién     → 3 campos
```

**Contados sobre un caso de dos folios** —una presentación con el testimonio del Product Owner y una
resolución—: README 5, folio 001 con 4 + 1 + 3, folio 002 con 4 + 1: **dieciocho campos, tres archivos, un
commit.** Se llena en minutos. Lo que no está en esta lista no es obligatorio.

**La carátula.** Cinco filas de una tabla de dos columnas, y **son fijas desde la apertura**: el número, el
título, la fecha de apertura, el origen (quién presentó y por qué vía, con el folio) y la base (el commit
corto del repositorio al abrir). Un título que se precisa después no cambia el número (§3.1). Después de la
tabla, la línea de remisión. Nada más: ni estado, ni índice, ni commit del último folio, ni huellas.

**La actuación.** Un archivo por folio, con cuatro filas de cabecera —`Tipo` de §3.2, `Fecha`, `Autor` y
`Corrige` (el folio que corrige, o `—`)— y, como **última línea**, el pase: `Sigue: <acto> · <quién>`. El
expediente y el folio no se declaran en la cabecera: se leen de la ruta. El pase es el punto de continuación
(`Master-Prompt-Reanudacion.md` §5): quien retoma abre el último folio y sabe qué sigue y quién lo hace. **Un
folio de tipo `archivo` no lleva pase.** Cuando el folio despachó agentes, el pase además nombra los
despachos abiertos y su carta (§3.5), porque **antes de volver a despachar hay que comprobar si el despacho
anterior terminó**: un expediente real despachó dos veces el mismo panel por leer la ausencia de archivos
como ausencia de trabajo.

**Lo que se asienta verbatim.** Un informe de comisión, de refutador, de jurado o de auditor entra como folio
`informe` **sin editar**, con el autor declarado; lo que el presidente agregue va en folio propio. Es lo que
permite distinguir lo que dijo la comisión de lo que entendió quien la convocó.

**La forma completa**, cuando corresponde y sólo entonces:

- la **carta de cada despacho** en `evidencia/`, asentada **antes** de despachar, para que un re-despacho sea
  el mismo despacho y no otro;
- una **constancia** que folia por `ruta@commit` los artefactos de `Audit/` y de las categorías que el caso
  produjo o tocó (§5);
- una **resolución** con un veredicto por criterio del caso, con la forma de la comprobación 13 de
  `SDD-Development-Guide.md` §VI.3;
- en el pase del folio que despachó: los insumos enlazados, qué se invalida si la corrida se corta, y las
  escaladas abiertas con su `SI NO RESPONDÉS`.

### 3.1 Número, folio y cómo se cita

**El número es local al repositorio: cinco dígitos, correlativo, nunca reciclado.** `00001`, `00002`. La
carpeta es `<NNNNN>-<Titulo>` con el título en Título-Con-Guiones (D3). El folio son tres dígitos contiguos
desde `001`, **asignados al incorporar**: el siguiente libre, nunca uno reservado de antemano, porque la
foliatura garantiza el orden de incorporación y nada más.

**No se acuña un prefijo de familia.** El número de expediente y el folio quedan **excluidos** del sistema de
identificadores en `Root-Rules.md` §9.2, con su motivo: el número no se cita desnudo —se cita por la ruta de
la carpeta— y su ámbito es el repositorio, que no es ninguno de los dos ámbitos de §9.1. **Medido antes de
decidirlo**: un prefijo `EXP-` con cuatro dígitos ya vive en un destino real en veinte archivos, y una
familia `EXP-NNNNN` habría nacido inconsistente con él; y `ev-`/`EV-` para la evidencia colisiona con la
familia `EV` de D9 en los dos destinos medidos. La evidencia se nombra `NNN-<slug>` por posición, sin prefijo.

**Cómo se cita.** Desde el mismo repositorio, por la ruta de la carpeta: `SDD/Expedientes/00002-<Titulo>/`
(en el framework, `Expedientes/00002-<Titulo>/`); el folio va en la prosa: «folio 004». Desde otro
repositorio, la ruta **calificada con el nombre del repositorio**: `Lab-Geometria/SDD/Expedientes/00002-…`.
El criterio A10 comprueba que las citas locales resuelven, y reconoce las calificadas por el nombre que las
precede.

### 3.2 Tipos de actuación y estado derivado

**Seis tipos, conjunto cerrado, y el estado se deriva del último folio. Nunca se escribe a mano.**

| Tipo del último folio | Estado del expediente |
| --- | --- |
| `presentacion` | **abierto**; **reabierto** si antes hay un folio `resolucion` |
| `providencia` (impulso del trámite: convoca, despacha, ordena) | **en trámite** |
| `informe` (comisión, refutador, jurado, auditor, orquestador: verbatim y con autor) | **en trámite** |
| `constancia` (un hecho, una corrección propia, una incorporación de antecedentes) | **en trámite**; **suspendido** si lleva la línea `Suspende hasta: <artefacto §sección>` |
| `resolucion` (decide, motivada, con veredicto por criterio) | **resuelto** |
| `archivo` (cierra, con la línea `Motivo: <aplicado y verificado \| cerrado por decisión, con lo abierto enumerado \| desistido>`) | **archivado** |

**Por qué seis y no once.** La refutación y el veredicto son `informe` con autor declarado; la suspensión es
un campo de la constancia y no un tipo, porque un tipo «suspensión» dejaba sin estado a toda constancia que
no suspende; la reapertura es una `presentacion` posterior a una `resolucion` y no un tipo, porque conserva
el número. El mapeo es **total**: todo folio de los seis tipos deja al expediente en exactamente un estado.

**`Suspende hasta:` nombra un artefacto y su sección**, con la forma del punto 4 de `Root-Rules.md` §12.2 —no
un momento—, y la reanudación lo lee como evento de cierre contrastable. **Reabrir** es un folio
`presentacion` que nombra en `Corrige` la resolución que reabre, y sólo con un ancla E1 o E2 de
contradicción (`Mesa-Rules.md` §6.1).

### 3.3 El testimonio del Product Owner, y de cualquier parte

**El original es la pieza; toda versión legible es derivada y declara qué transformó.** Un folio que
asienta palabras del Product Owner —o de cualquier parte cuya palabra funda algo— lleva:

1. el **bloque literal, byte a byte**, entre una línea ` ```testimonio ` y una línea ` ``` `: sin corregir
   la ortografía, sin reordenar, sin recortar. Si el original es un archivo, va además a `evidencia/` y el
   folio lo cita;
2. tres campos: `Canal` (por dónde llegó), `Fecha-hora` con zona horaria, y `Huella`: el SHA-256 del bloque,
   obtenido con el comando de A8;
3. si el testimonio responde a una pregunta, **la pregunta exacta** que se hizo.

**Se clasifica por lo que contiene cada pasaje, no por el canal:**

| El pasaje es… | Qué es para el método |
| --- | --- |
| una **aprobación** («está aprobado», «tenés el OK») | Evidencia de tipo `humano` de D9: «una aprobación explícita registrada con fecha». Con el original preservado, el asiento **es** ese registro |
| un **pedido** o una **intención** | Fuente de intención, fuera de D9 (`Deriva-Rules.md` §1: lo que se pide no necesita evidencia, necesita justificación). Pasa a ancla E4 cuando queda asentado como decisión cerrada o restricción del contrato de entrada de una mesa |
| una **afirmación sobre el estado del sistema** | Ancla `C` hasta que la corrobore un `artefacto` o una `ejecucion`. Prueba que la persona lo dijo, no que sea cierto |

Un testimonio **no es E4 por sí mismo**: E4 es regla declarada (`Mesa-Rules.md` §6.1).

### 3.4 La evidencia

**Dos clases, y no se tratan igual.**

| Clase | Qué es | Qué se le exige |
| --- | --- | --- |
| **Medición** | Una derivación de un commit: `git show`, `git grep`, `git ls-tree` sobre un commit, **nunca sobre el árbol de trabajo** | Reproducible: quien corre el comando contra la misma base obtiene lo mismo (condición 2 de D9) |
| **Observación** | Un estado vivo o una captura: el disco de un momento, un sitio publicado, una pantalla, una lista de worktrees | **No se le exige que reproduzca: se la preserva**, con fecha, hora y zona, y el medio con que se obtuvo (condición 3 de D9) |

Cada pieza de `evidencia/` **abre con tres líneas**: `Método` o `Comando` (o el medio, para una
observación), `Base` (commit) o `Fecha-hora`, y `Quién` la obtuvo. Una pieza que no admite texto al inicio
—una imagen, un binario— lleva al lado `NNN-<slug>.txt` con esas tres líneas.

**Huella sólo para lo que no está versionado o sale del repositorio.** Sobre un archivo versionado, git ya
da integridad y una huella copiada a mano es un dato derivado que se desincroniza: el primer expediente del
framework tuvo dos de cinco huellas mal transcriptas en su índice. El índice **no existe**; un manifiesto de
sumas entra sólo cuando hay piezas custodiadas fuera del repositorio, y entonces la huella va en el
expediente y el objeto donde se custodie.

**Una corrida descartada se conserva.** Un guion corregido no reemplaza a su salida anterior: la nueva se
agrega con su número y la anterior queda, con una constancia que diga por qué se descartó.

### 3.5 La carta de un despacho

Cuando un folio despacha agentes, **el texto que se despacha se asienta en `evidencia/` antes de
despachar**, verbatim. Un despacho que no quedó asentado no se puede repetir igual, y dos paneles que
recibieron cartas distintas no son comparables. Es forma completa, no mínima: sólo aplica cuando hubo
despacho.

---

## 4. Sellado: lo que hace que el expediente sea un registro

**S1 · Nada cambia después de la fusión a la rama principal.** Ninguna pieza de la carpeta —actuación,
evidencia, README— se modifica, se borra ni se renombra después de que la fusión la publicó. Una corrección
es un folio nuevo con `Corrige: NNN`. El control cubre **la carpeta entera y los renombres**, no sólo
`actuaciones/`: el criterio A7 lo comprueba contra la rama principal. Antes de la fusión la inmutabilidad
**se declara no observable**: lo que pasó en el árbol de trabajo no deja rastro que nadie pueda verificar.

**S2 · Antes del primer push corre la compuerta de datos sensibles.** Credenciales, datos personales, rutas
del directorio personal del host, nombres de cuentas: nada de eso se publica. Lo que se redacta deja una
**constancia** con la huella del original y dónde queda custodiado fuera del repositorio; la pieza
publicada es derivada y lo dice. Es la compuerta de `Rules-Base-Conocimiento.md` §2.2, que alcanzaba sólo
a `Conocimiento/`, extendida a `Expedientes/`. **Corre antes del push y no después**, porque retirar algo ya
publicado exige reescribir la historia, y con eso la base de la corrida deja de poder calcularse
(`Master-Prompt.md` §8.1). Medido: el primer expediente del framework selló un nombre de cuenta y rutas de
host en tres commits antes de que nadie lo mirara.

**S3 · La rama que lleva un expediente no se fusiona aplastando la historia**, o se declara que la foja —el
orden de incorporación de los folios— no es observable. S1 no depende de esto: se evalúa después de la
fusión, cualquiera sea su forma. Lo que se pierde con un aplastamiento es el orden y la fecha de cada
incorporación, y quien fusiona decide sabiéndolo (`Master-Prompt.md` §12.1 T1).

---

## 5. El vínculo con la especificación, con `Audit/` y con lo ya escrito

**La evidencia funda la especificación; no se vuelve especificación.** Una decisión que el caso produce
cambia un artefacto normal —un ADR, una regla, el intake, un ítem diferido— y **ese artefacto cita el
expediente en su fila de control de cambios**: `SDD/Expedientes/00002-<Titulo>/`, con el folio en la prosa.
**Es la única vía declarada.** La dirección inversa —qué artefactos cambió el caso— **se deriva** con
`git grep -l 'Expedientes/00002-'` y no se escribe en una tabla a mano: sobrevive a un aplastamiento de
historia y no se desincroniza. Todo patrón que una regla generalice desde un caso declara **cuántos casos lo
sostienen**.

**`Audit/` sigue siendo la fuente de cada acto**, y el expediente lo folia **por enlace**: una constancia con
`ruta@commit` del registro de mesa, del informe de migración, del informe de estado o del de audit. No los
copia. En el repositorio del framework, que no tiene `SDD/Docs/Audit/`, **el expediente es el registro** de
la mesa (`Mesa-Rules.md` §8, criterio 1). En la serie de reportes del repositorio de documentación, el
reporte es **el pase** del caso a la intervención: cita el expediente por su ruta calificada, y el
expediente lo folia por nombre.

### 5.1 Lo ya escrito no se reescribe

Lo que se escribió antes de esta regla **queda donde está y como está**: los informes de `Audit/` de los
destinos, las carpetas `OUTPUTs/` de las intervenciones, y los dos expedientes que se adelantaron a la
norma —el `0001` del framework y el `EXP-0001` de un destino—. Ésos son **forma histórica**: no se
renombran a cinco dígitos, no se les cambia el tipo a ningún folio, y no se les exige los criterios de §6.
Renombrarlos rompería S1 y toda cita que ya los nombra. Un caso **vivo** que cumple §1 y tiene antecedentes
anteriores a esta regla abre su expediente con una constancia de **incorporación de antecedentes** por
`ruta@commit`, que declara que antes de esa fecha no tuvieron custodia.

---

## 6. Criterios de aceptación

Cada comando corre desde la raíz del repositorio; `X` es la carpeta de un expediente. Los diez `[enumerable]`
son la verificación de la forma mínima; ninguno necesita un guion aparte.

- [ ] **A1** `[enumerable]` La carpeta lleva cinco dígitos y ningún número se repite: `ls SDD/Expedientes | grep -vcE '^[0-9]{5}-'` → `0`; `ls SDD/Expedientes | cut -c1-5 | sort | uniq -d` → vacío. (En el framework, `ls Expedientes`.)
- [ ] **A2** `[enumerable]` La carátula tiene sus cinco campos: `for c in Número Título Apertura Origen Base; do grep -q "^| $c |" "$X/README.md" || echo "FALTA $c"; done` → vacío.
- [ ] **A3** `[enumerable]` Foliatura contigua desde `001`: `i=1; for f in $(ls "$X/actuaciones" | sort); do [ $((10#${f%%-*})) -eq $i ] || echo "SALTO $f"; i=$((i+1)); done` → vacío.
- [ ] **A4** `[enumerable]` Cabecera de cuatro campos y tipo del conjunto cerrado: `for f in "$X"/actuaciones/*.md; do for c in Tipo Fecha Autor Corrige; do grep -q "^| $c |" "$f" || echo "FALTA $c $f"; done; done` → vacío, y `grep -h '^| Tipo |' "$X"/actuaciones/*.md | grep -vcE 'presentacion|providencia|informe|constancia|resolucion|archivo'` → `0`.
- [ ] **A5** `[enumerable]` Todo `Corrige` nombra un folio que existe: `grep -hoE '^\| Corrige \| [0-9]{3}' "$X"/actuaciones/*.md | awk '{print $4}' | while read n; do ls "$X/actuaciones/$n"-* >/dev/null 2>&1 || echo "$n"; done` → vacío.
- [ ] **A6** `[enumerable]` El último folio lleva pase, salvo que sea `archivo`: `f=$(ls "$X/actuaciones" | sort | tail -1); tail -1 "$X/actuaciones/$f" | grep -q '^Sigue:' || grep -q '^| Tipo | archivo' "$X/actuaciones/$f" || echo "SIN PASE $f"` → vacío.
- [ ] **A7** `[enumerable]` S1, nada cambió después de la fusión: `m=$(git log --first-parent --format=%h --diff-filter=A main -- "$X/README.md" | tail -1); git log -M --diff-filter=MDR --format='%h %s' "$m..main" -- "$X"` → vacío. Antes de la fusión no se evalúa, y se declara.
- [ ] **A8** `[enumerable]` Todo testimonio verifica su huella: `for f in $(grep -l '^```testimonio$' "$X"/actuaciones/*.md); do h=$(awk '/^```testimonio$/{f=1;next} /^```$/{f=0} f' "$f" | sha256sum | cut -c1-64); grep -q "^| Huella | \`$h\`" "$f" || echo "HUELLA $f"; done` → vacío.
- [ ] **A9** `[enumerable]` Cada evidencia abre con método, base y quién: `find "$X/evidencia" -type f 2>/dev/null | while read f; do head -3 "$f" | grep -qiE '^(#|//)? ?(Método|Comando|Medio)' || [ -e "${f%.*}.txt" ] || echo "$f"; done` → vacío. (Un `.txt` hermano de una pieza binaria cumple por ella; `evidencia/` admite subcarpetas.)
- [ ] **A10** `[enumerable]` Toda cita local a un expediente resuelve: `git grep -ohE '(^|[^/A-Za-z0-9.-])(SDD/)?Expedientes/[0-9]{5}-[A-Za-z0-9-]+' -- SDD Expedientes 2>/dev/null | sed -E 's/^[^SE]*//' | sort -u | while read d; do [ -d "$d" ] || echo "$d"; done` → vacío. Una cita calificada con el nombre de otro repositorio no la comprueba este comando: la lee una persona.
- [ ] **I1** `[interpretativo]` La condición de §1 se aplicó: el caso atraviesa corridas o repositorios, o entró material externo sin casa. Un expediente por cada mesa o por cada detención es el anti-patrón.
- [ ] **I2** `[interpretativo]` El pase del último folio es veraz: nombra el acto que sigue y quién lo hace, y no afirma un acto que ningún folio registra.
- [ ] **I3** `[interpretativo]` El testimonio se clasificó por contenido (§3.3): la aprobación como `humano`, el pedido como intención, la afirmación de estado como `C`.
- [ ] **I4** `[interpretativo]` Cada evidencia es pertinente a la afirmación que la cita: dice lo que quien cita afirma que dice.

---

## 7. Anti-patrones

| Situación | Problema | Solución | Detección |
| --- | --- | --- | --- |
| El `README.md` lleva estado, índice de folios, commit del último folio o huellas | Datos derivados escritos a mano, que se desincronizan sin que nadie lo vea; el primer expediente tuvo dos huellas falsas en su índice | El README remite: índice es `actuaciones/`, estado y pase son del último folio | `[enumerable]`: `grep -cE '^\| (Estado\|Folio) \|' README.md` → `0` |
| Un folio se edita después de publicado | Deja de ser registro | Folio nuevo con `Corrige` | `[enumerable]`: A7 |
| Se abre un expediente por cada mesa, cada ronda de audit o cada detención | Duplica `Audit/` y diluye la unidad «caso» | La condición de §1; lo que tiene casa no abre expediente | `[interpretativo]` |
| La presentación del Product Owner se transcribe «literal» normalizada, reordenada o recortada | El origen del caso deja de ser verificable; pasó en los dos primeros ejemplares | Bloque literal byte a byte con huella; la versión legible declara su transformación | `[enumerable]`: A8 |
| Se copia el registro de mesa o un informe de `Audit/` dentro del expediente | Dos registros del mismo acto con dos historias | Constancia que folia por `ruta@commit` | `[enumerable]`: `grep -rl '^## 2. Contrato de entrada' actuaciones/` → vacío en un destino |
| Se acuña un prefijo para el número de expediente o para la evidencia | Colisiona con familias vivas (`EXP-` de cuatro dígitos, `EV-` de D9) | Número local, cita por ruta, evidencia por posición | `[enumerable]`: `grep -rcE '\bEXP-[0-9]' actuaciones/ evidencia/` → `0` en expedientes nuevos |
| La evidencia se toma con `grep` sobre el árbol de trabajo y se declara reproducible | Reproduce hoy por casualidad y mañana no | Medición sobre un commit; observación preservada con fecha y hora | `[interpretativo]` |
| Se despacha un panel sin asentar la carta | Un re-despacho es otro despacho; ocurrió | La carta en `evidencia/` antes de despachar | `[interpretativo]` |
| Se vuelve a despachar sin comprobar si el despacho anterior terminó | Dos paneles sobre lo mismo; ocurrió | El pase nombra los despachos abiertos, y se comprueba antes de repetir | `[interpretativo]` |
| El expediente entra al snapshot `_legacy/` o a la migración | Se duplica por versión y se renumera | Las tres exclusiones de §2 | `[enumerable]`: `ls _legacy/<N>/ | grep -c Expedientes` → `0` |
| Se selló evidencia con datos personales o rutas de host y se corrige después del push | Reescribir historia rompe la base de la corrida | S2 antes del push, con constancia | `[enumerable]`: `git grep -c '/home/' -- Expedientes` → `0` antes del push |
| El ciclo de origen de un hueco cita el expediente | Un dato declarado en un campo calculado | La fila de control de cambios del artefacto es la única vía | `[interpretativo]` |

---

## 8. Prompt-snippet sugerido

```text
Expediente. Antes de abrir uno, la condición de Expediente-Rules.md §1: ¿el caso atraviesa más de una
corrida o más de un repositorio, o entró material externo que ningún artefacto con casa aloja? Si no,
no se abre: tiene casa en Audit/, en el lote de la fase o en un ítem diferido.

Si se abre: SDD/Expedientes/<NNNNN>-<Titulo>/ con README de cinco campos y la línea de remisión;
actuaciones/NNN-<tipo>-<slug>.md con Tipo, Fecha, Autor, Corrige y el pase «Sigue: <acto> · <quién>»
en la última línea; el folio se asigna al incorporar. Palabras del Product Owner: bloque ```testimonio
byte a byte, Canal, Fecha-hora con zona y Huella. Evidencia sólo si hay, cada pieza abre con Método,
Base o Fecha-hora y Quién. Nada derivado a mano: ni estado, ni índice, ni huellas de lo versionado.

Antes del primer push: S2 (credenciales, datos personales, rutas de host). Después de la fusión: nada
se toca; una corrección es un folio nuevo con Corrige. Los artefactos que el caso cambia citan la
carpeta en su fila de control de cambios; la inversa se deriva con git grep. Verificación: A1 a A10.
```

---

## 9. Control de cambios

| Versión | Fecha | Cambios | Autor |
| --- | --- | --- | --- |
| 1.0 | 2026-09-13 | Emisión inicial (framework 13.18). Regula **el expediente de caso**: la unidad que atraviesa artefactos, corridas y repositorios y que el método no tenía. Nace del expediente `0001` del propio framework —ocho comisiones a ciegas, una réplica independiente del panel, un refutador y un jurado— y de su dictamen (folio 016), verificado y aplicado por la intervención del reporte `31`. Fija **la condición de apertura** observable y sus exclusiones (§1); **dónde vive** en el destino y en el framework, y sus tres exclusiones declaradas (§2); **la forma mínima de dieciocho campos** sin ningún dato derivado a mano, con el índice como listado, el estado derivado del último folio y el pase como punto de continuación (§3); el número local sin prefijo, con la colisión de `EXP-` y `EV-` medida (§3.1); **seis tipos con mapeo total a estado** (§3.2); el testimonio con su original byte a byte, clasificado por contenido (§3.3); las dos clases de evidencia y la huella sólo para lo no versionado (§3.4); **S1, S2 y S3** (§4); la evidencia que funda y no se vuelve especificación, con una sola vía declarada y la inversa derivada (§5); y lo ya escrito como forma histórica (§5.1). Diez criterios enumerables con su comando en el texto (§6). **Rechazó, con medición**: cuarenta y siete campos, un folio por commit, el trailer en el mensaje, el manifiesto de sumas obligatorio, el prefijo `EXP-`, un tercer ámbito en `Root-Rules.md` §9.1 y un dato más en el ciclo de origen. | Intervención del reporte `31` |
