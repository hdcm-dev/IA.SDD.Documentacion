# Reporte 19 — El apartamiento declara la regla hacia adelante, y nadie barre el corpus que deja atrás

| Campo | Valor |
|---|---|
| Reporte | 19 |
| Fecha | 2026-08-29 |
| Origen | **Dos ciclos de la mesa de evaluación** sobre el destino `Lab-Geometria`, el 2026-08-29, a partir de una pregunta del Product Owner sobre el ancho de un identificador. El ciclo 1 emitió un apartamiento; el ciclo 2 **intentó reparar lo que ese apartamiento dejaba abierto y encontró que el método no tiene con qué** |
| Versión del framework evaluada | SDD **13.8** (`Root-Rules.md` 8.6 §11, `Migracion-Rules.md` 3.19 §4.7) |
| Artefactos del framework alcanzados | `SDD/Devs/Rules/Root-Rules.md` §11 y §9.5 · `SDD/Devs/Rules/Migracion-Rules.md` §4.7 · `SDD/Devs/Rules/Mesa-Rules.md` §6.5 |
| Naturaleza | Un hueco **en el alcance de una figura, no en la figura**. El apartamiento está bien diseñado para lo que declara —una decisión y su ciclo de vida— y **no declara nada sobre el corpus que la decisión vuelve no conforme el día que se emite** |
| Estado | **Abierto** |
| Reportes relacionados | `01`, que este reporte **no reabre**: aquél pedía que el framework declarara el **ámbito** de sus identificadores y la 7.0 lo resolvió. Éste es sobre lo que pasa cuando **un destino** declara un ámbito por apartamiento y el corpus ya escrito no lo cumple |

---

## 1. Resumen

**Un apartamiento declarado (`Root-Rules.md` §11) fija una regla local hacia adelante. El corpus
escrito antes de él no la cumple, y el método no tiene ninguna etapa que lo barra.**

§11 exige **seis campos** a todo apartamiento: qué obligación no se cumple, por qué no aplica, las
alternativas descartadas, los disparadores que lo superarían, su estado y los saltos de versión que
sobrevivió. **Los seis son sobre la decisión.** Ninguno pregunta qué queda en el árbol sin cumplir la
regla que el propio apartamiento acaba de declarar.

La única revisión posterior, `Migracion-Rules.md` §4.7, tiene tres resultados —absorbido, contradicho,
no contemplado— y **los tres miran el ADR contra la normativa vigente**. Ninguno lo mira contra el
corpus que gobierna.

**La consecuencia observada:** un apartamiento que declara el ámbito de dos familias de identificadores
dejó **289 citas ambiguas** en el árbol vivo, y la única forma que el ADR tuvo de no perderlas fue
**pedir prestada una figura ajena** —el ítem diferido de §12.2, que existe para diferir una decisión a
un evento futuro y no para registrar un barrido pendiente—.

---

## 2. Lo que el framework ya resuelve bien

**Esto no es un reporte contra §11**, y conviene delimitarlo porque casi todo lo que §11 hace está bien:

- **El estado del apartamiento**, con su conjunto cerrado de cuatro. Resuelve el problema real de que
  un ADR viejo, uno absorbido y uno contradicho **se veían iguales**.
- **El contador de saltos sobrevividos**, que es un disparador mecánico y no una obligación de que
  alguien se acuerde. Es un buen diseño y este reporte no lo toca.
- **La distinción entre apartamiento y flag** —«un apartamiento usado para evadir una condición que ya
  existe es un anti-patrón»—, que cierra la vía de escape más obvia.
- **§4.7 de `Migracion-Rules.md`**, que le dio a la revisión su insumo objetivo: el campo 4 del propio
  ADR, y no una interpretación.
- **`Mesa-Rules.md` §6.5**, la compuerta de capa de origen, que **sí** obliga a reparar donde nació el
  defecto. Existe para los parches de la mesa y **no está conectada con §11**.

**El framework tiene, por separado, todas las piezas del mecanismo que falta.** Lo que no tiene es el
cable entre el apartamiento y ellas.

---

## 3. La evidencia

### 3.1 El incidente

El **2026-08-29**, el Product Owner de `Lab-Geometria` preguntó por qué un identificador se llamaba
`QG-03` y no `QG-00003`. El ciclo 1 de la mesa fue a buscar la respuesta y encontró que **`QG`, `CV` y
`PT` son familias que el destino acuñó sin declarar prefijo, forma ni ámbito**, contra `Root-Rules.md`
§9.5. Emitió `ADR-14005`, que declara el ámbito y conserva el ancho.

**Y el ADR tuvo que declarar, en su propio texto, que no repara lo que encuentra:**

> *«**Lo que este ADR NO hace, y hay que decirlo.** No repara las citas ambiguas que ya existen.»*

### 3.2 El tamaño de lo que quedó sin reparar, medido

El ciclo 2 lo midió sobre el árbol vivo:

| Medición | Ocurrencias |
|---|---|
| Citas de las dos familias alcanzadas | 1005 |
| Desambiguadas por su propia línea | −546 |
| Desambiguadas por su sección envolvente | −170 |
| **Ambiguas, que el apartamiento vuelve no conformes y no repara** | **289**, en 56 documentos |

**El apartamiento se emitió y en el mismo acto volvió no conformes 289 citas** que hasta ese día no lo
eran, porque hasta ese día no había regla que incumplir. Nada en el método toma nota de eso.

### 3.3 La figura prestada, que es el síntoma más claro

El ADR necesitaba que las 289 no se perdieran y **usó un ítem diferido de `Root-Rules.md` §12.2**, con
sus cuatro campos y su evento de cierre.

**No es la figura correcta y el propio §12 lo dice.** Un ítem diferido es *«una decisión atada a un
evento futuro»*: existe porque **falta un dato o una decisión**. Acá no falta ninguna de las dos —la
decisión está tomada, es el ADR— : lo que falta es **ejecutar un barrido**. Registrar trabajo pendiente
como si fuera decisión pendiente hace que la reanudación lo cuente entre los ítems diferidos y que su
tabla de escalamiento lo trate como tal.

**Es un uso indebido inducido por la ausencia de la figura correcta**, y por eso vale como evidencia
en lugar de como defecto del destino.

### 3.4 El mismo patrón, trece días antes, en el mismo destino

`ADR-14002` (2026-08-16) resolvió la misma clase de pregunta para **once familias del intake**. Partió
en dos: `RN` **se renumeró** —porque el árbol ya la numeraba con cinco dígitos y convivían dos números
para la misma regla— y las otras diez conservaron su ancho.

**El caso de `RN` es el que hay que mirar**, porque ahí el destino **sí barrió**: reconectó **377
citas** desde registro. Lo hizo porque la migración estaba corriendo y tenía la maquinaria a mano — **no
porque §11 lo pidiera**. Trece días y siete migraciones después, el apartamiento siguiente no tuvo esa
suerte y no tuvo quién lo obligara.

### 3.5 El destino ya construyó a mano el mecanismo que falta

**Y es la evidencia más fuerte de que el hueco existe.**
`SDD/Docs/Producto/Norma-De-Nomenclatura.md` del mismo destino tiene, en su §8, **un plan de renombre
con siete tramos** —`R-1` a `R-5`— y **siete controles de verificación** —`V-1` a `V-7`—, con la
población medida, la clasificación de cada ocurrencia en cinco formas —cita textual, reporte de fuente,
registro histórico, otro concepto con el mismo nombre, uso propio— y la regla de qué hace el renombre
con cada una.

**Eso es exactamente el barrido que §11 no tiene**: el mecanismo que toma una regla declarada hacia
adelante y la aplica al corpus que la precede, sin falsificar lo que no debe tocarse.

**Y no está conectado con nada.** Se construyó para la norma de nomenclatura, vive en un documento del
destino, y **el apartamiento siguiente del mismo producto no lo usó** — ni podía saber que existía.

---

## 4. La causa raíz

**§11 modela el apartamiento como una decisión y no como un cambio de norma.**

Una decisión tiene fundamento, alternativas, estado y vigencia — y §11 los pide todos. Pero un
apartamiento **también es una regla nueva**: dice «acá rige esto otro». Y toda regla nueva tiene una
población que la precede.

El método sabe esto en otros lados y no acá:

- La **migración normativa** existe entera porque una regla nueva del framework deja un corpus que no
  la cumple. Tiene fases, plan, registro de reconexión y audit.
- El **renombre de la norma del destino** existe por lo mismo, y tiene tramos y controles.
- **El apartamiento no tiene nada**, y es el único de los tres donde la regla nueva la escribe el propio
  destino, sobre su propio corpus, sabiendo exactamente qué acaba de volver no conforme.

**La asimetría es lo que hace al hueco costoso:** cuando la regla viene de arriba, el método barre;
cuando la escribe el destino, no.

---

## 5. El patrón, enunciado

> **Toda regla nueva tiene una población que la precede, y el método sólo barre las que vienen de
> arriba.**
>
> Cuando una regla nace en el framework, la migración normativa la propaga al corpus con plan, registro
> y audit. Cuando nace en el destino —por apartamiento declarado— el corpus que la incumple **queda sin
> inventariar, sin plan y sin evento**, y la única forma de no perderlo es registrarlo con una figura
> que existe para otra cosa.
>
> **El síntoma con el que se reconoce**: un ADR de apartamiento que declara, en su propio texto, qué es
> lo que no repara. Es el autor del ADR intentando cerrar con prosa un hueco que la figura no le deja
> cerrar con estructura.

---

## 6. Propuestas de intervención

**Ninguna es una decisión tomada.** Van de la más chica a la más grande.

### 6.1 Un séptimo campo en §11: la población alcanzada

Que todo apartamiento declare, con su recuento y su medición, **qué queda en el corpus sin cumplir la
regla que el ADR declara**, y en qué estado: `barrida`, `barrido pendiente con evento` o `no aplica —
la regla no tiene población previa`.

**A favor:** es el cambio más chico y ataca el síntoma exacto. El tercer valor importa: la mayoría de
los apartamientos omite un artefacto y **no tiene población previa**, y obligarlos a declararlo cuesta
una línea.
**En contra:** un campo más no obliga a barrer. Convierte el olvido en omisión detectable, que ya es
bastante, pero no cierra el ciclo.

### 6.2 Conectar §11 con la compuerta de capa de origen de `Mesa-Rules.md` §6.5

Que un apartamiento con población previa **entre al contrato de entrada de la mesa** como hallazgo con
ancla `E4`, de modo que su barrido se planifique con parches, verificación y reversión, que es la
maquinaria que la mesa ya tiene.

**A favor:** no inventa mecanismo. Reusa el que existe y que ya corre en las reanudaciones y en las
migraciones.
**En contra:** ata el barrido a que haya mesa. Un destino que emite un apartamiento fuera de una
reanudación no la tiene.

### 6.3 Elevar el plan de renombre a figura del método

Tomar lo que `Norma-De-Nomenclatura.md` §8 hizo a mano —tramos, población medida, clasificación de la
ocurrencia en cinco formas, controles de verificación— y **declararlo como la figura del método para
propagar una regla nueva a un corpus existente**, sea la regla del framework o del destino.

**A favor:** es la corrección de fondo, y **el instrumento ya existe y ya se probó**: corrió en tres
tramos de ese destino con sus controles cuadrando. La clasificación en cinco formas es lo que impide
que un barrido corrija unas ocurrencias y **falsifique** otras — un acta de auditoría o una cita
textual renombradas son peores que la ambigüedad original.
**En contra:** es la intervención más grande, y toca `Migracion-Rules.md` además de `Root-Rules.md`.

### 6.4 Lo que conviene NO hacer

**Obligar a barrer antes de emitir el apartamiento.** Convertiría en bloqueante lo que muchas veces es
un trabajo grande y postergable, y el efecto probable es que **el apartamiento no se declare** —que es
peor que declararlo con su población pendiente—. La figura tiene que admitir «barrido pendiente» como
estado legítimo.

---

## 7. Cómo verificar que la corrección funcionó

1. **Sobre el caso que originó el reporte**: `ADR-14005` de `Lab-Geometria` declara su población
   alcanzada —**289 citas en 56 documentos**— en un campo de la figura, y no en prosa ni en un ítem
   diferido prestado.
2. **Sobre el corpus del propio framework**: correr la comprobación sobre todos los ADR de apartamiento
   vigentes de un destino con historia y verificar que **cada uno declara su población o declara que no
   tiene**. En `Lab-Geometria` son cinco: `ADR-14001` a `ADR-14005`.
3. **Sobre la figura**: un apartamiento con `barrido pendiente` y sin evento de cierre **es hallazgo**,
   con la misma forma con que §12.2 trata al ítem diferido sin evento.
4. **Contra el falso positivo**: un apartamiento que omite un artefacto que nunca se emitió declara `no
   aplica` y **no genera trabajo**. Si la corrección hace que estos tengan que inventar una población
   vacía, está mal cableada.

---

## 8. Un hallazgo menor del mismo origen

**`Root-Rules.md` §9.5 exige que toda familia declare prefijo, forma y ámbito «en la regla que la
acuña», y no dice qué pasa cuando la acuña el destino.** Las tres familias del incidente —`QG`, `CV`,
`PT`— no las acuña ninguna regla del framework ni el intake: las acuñó el destino sobre la marcha, y
§9.5 no tiene dónde alojarlas. `Migracion-Rules.md` §4.3.1 pasada 1.b **sí** contempla «toda familia
que el destino acuñe», pero sólo **durante una migración**: una familia acuñada fuera de una migración
no pasa por ahí nunca.

**Es del mismo patrón** —el método cablea el mecanismo al momento donde nació y no a la condición que
lo hace necesario— y por eso se anota acá en vez de abrir reporte propio. Es literalmente lo que el
**reporte `18`** enunció, aplicado a otra familia de casos.
