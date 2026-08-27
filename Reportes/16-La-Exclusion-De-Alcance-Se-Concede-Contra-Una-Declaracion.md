# Reporte 16 — La exclusión de alcance se concede contra una declaración, no contra una evidencia

| Campo | Valor |
|---|---|
| Reporte | 16 |
| Fecha | 2026-08-27 |
| Origen | Ocho rondas de auditoría sobre la migración normativa **9.18 → 13.3** de un destino real, más un ciclo de mesa evaluadora multiagente. Las rondas 5, 6, 7 y 8 nombraron **la misma causa raíz** y las cuatro fueron RECHAZADO |
| Versión del framework evaluada | SDD **13.3** (`Master-Prompt.md` §10.0 y §10.1) |
| Artefactos del framework alcanzados | `SDD/Devs/Orchestrator/Master-Prompt.md` §10.0 |
| Naturaleza | Un hueco de método **en el acto de conceder**, no en la compuerta. §10.0 le quita alcance al auditor a cambio de lo que la compuerta **declara**, sin exigir ninguna evidencia de que lo declarado sea lo medido |
| Estado | **Para evaluación.** Ninguna modificación aplicada sobre el framework |
| Reportes relacionados | `12`, cuya decisión —que el framework **no** distribuye un verificador— este reporte **no reabre**: lo que propone es una condición sobre el verificador que cada destino escribe. Y `09`, que separó lo enumerable de lo interpretativo y creó esta compuerta |

## Tabla de contenido

- [1. Resumen](#1-resumen)
- [2. Lo que el framework ya resuelve bien](#2-lo-que-el-framework-ya-resuelve-bien)
- [3. La evidencia](#3-la-evidencia)
- [4. La causa raíz](#4-la-causa-raíz)
- [5. El patrón, enunciado](#5-el-patrón-enunciado)
- [6. Propuestas de intervención](#6-propuestas-de-intervención)
- [7. Cómo verificar que la corrección funcionó](#7-cómo-verificar-que-la-corrección-funcionó)
- [8. Dos hallazgos menores del mismo origen](#8-dos-hallazgos-menores-del-mismo-origen)

## 1. Resumen

**`Master-Prompt.md` §10.0 declara que lo que la compuerta mecánica verifica queda excluido del
alcance del auditor.** Es una buena idea y es la que hace que §10.1 pueda existir: sin ella, cada
ronda gasta su atención en lo enumerable y nunca llega a lo interpretativo.

**Lo que el método no exige es ninguna evidencia de que la compuerta mida lo que declara medir.** La
exclusión se concede contra una declaración. Y una declaración es barata: sale de una línea de
`print`.

**Medido en un destino real, ocho rondas de auditoría.** En la séptima, **seis de trece
comprobaciones declaraban una cobertura que no tenían**. Una imprimía «ancho: todas las familias»
eximiendo a treinta y seis; otra decía «ningún huérfano en los siete eslabones» y cuatro de los siete
**no podían producir un huérfano nunca**; otra tomaba una versión del nombre del archivo, de modo que
renombrarlo era literalmente la operación que la ponía en verde.

**Y lo que da la medida no es eso: es lo que pasó al corregirlas.** Cuatro pull requests consecutivos
repararon la compuerta, y **los cuatro dejaron un defecto nuevo en la comprobación que reparaban**.
La octava ronda los encontró inyectando el defecto que cada comprobación dice cubrir; los tres `P0`
estaban **a una inyección de distancia**.

**El hueco es de una línea de método**, y el destino ya escribió la corrección: un banco de inyección
con un caso por comprobación y por recorte declarado. Lo que falta es que el método lo pida.

## 2. Lo que el framework ya resuelve bien

**Esto no es una crítica a §10.0, que resuelve bien lo difícil.** Conviene delimitarlo, para que la
intervención no reescriba lo que funciona:

- **La separación entre enumerable e interpretativo es correcta** y es lo que hace productiva a la
  auditoría. Es el aporte del reporte `09` y no se toca.
- **§10.0 ya obliga a la compuerta a declarar qué no mira**: *«la compuerta declara qué no mira»*. La
  obligación existe. Lo que no existe es cómo se comprueba que la declaración sea completa.
- **La decisión del reporte `12` —que el framework no distribuye un verificador ejecutable— sigue
  siendo correcta**, y este reporte no la reabre. Un verificador del framework reimplementaría las
  condiciones, que es la duplicación que `Migracion-Rules.md` §3 rechaza. Lo que se propone acá es
  una **condición sobre el verificador que cada destino escribe**, no un verificador central.
- **§10.1 ya prevé que las rondas no converjan**: a las cuatro, la decisión sube al humano. Ese
  mecanismo funcionó.

## 3. La evidencia

### 3.1 Seis de trece comprobaciones declaraban lo que no medían

Medido en la séptima y octava ronda, cada caso **probado inyectando el defecto y corriendo**:

| Comprobación | Qué imprimía | Qué medía |
|---|---|---|
| Identificadores | «ancho: **todas** las familias» | Eximía a 36. La unicidad se decidía sobre **dos archivos** |
| Cadena de trazabilidad | «ningún huérfano en **los siete eslabones**» | Cuatro de los siete **no podían producir un huérfano**: el conjunto «aguas abajo» incluía el documento que define el ítem |
| Ítems diferidos | «N declarados **en forma de §12.2**» | Sólo abría documentos que **ya citaban `§12.2`**, de modo que el único caso que no podía ver era el que §10.0 llama peligroso: la promesa sin marca |
| Política de archivado | «versión anterior a la del vigente» | Tomaba la versión **del nombre del archivo**, nunca del cuerpo |
| Enlaces y anclas · Anclaje | «sin roturas», «todas» | Recortaban una carpeta entera sin declararlo |
| Línea de cierre | «N **comprobaciones** fallaron» | Sumaba hallazgos, salvo en una donde sumaba 1 fijo |

### 3.2 Y la corrección reprodujo el defecto cuatro veces seguidas

**Éste es el incidente que importa.** Cuatro PR consecutivos, cada uno con el mandato explícito de
reparar el instrumento:

| PR | Qué venía a cerrar | Qué dejó |
|---|---|---|
| 1 | Copias archivadas con la versión pisada | Renombró **57 copias ya archivadas**, dejándolas declarando una versión que su cuerpo desmiente |
| 2 | Los 57 renombres, y la comprobación que no los vio | La comprobación siguió leyendo **la versión del nombre**: el defecto se declaró cerrado y su mecanismo quedó intacto |
| 3 | Las seis comprobaciones que sobredeclaraban | Reparó **dos** de los cuatro eslabones de trazabilidad y **declaró los siete**; y dejó una variable calculada y **nunca usada** detrás de una línea de alcance que prometía usarla |
| 4 | La línea de cierre | El contador de comprobaciones en rojo quedó alimentado en **4 de 13**: la compuerta llegó a imprimir «0 comprobaciones en rojo, 10 hallazgos en total» |

**Ninguno de los cuatro fue descuido.** Los cuatro corrieron la compuerta después de reparar, los
cuatro la vieron en verde, y los cuatro escribieron en su mensaje de commit que el defecto quedaba
cerrado. **El verde no era evidencia de nada**, y no había forma de saberlo sin inyectar.

### 3.3 La medición que lo cierra

La octava ronda declaró, por primera vez en ocho, la **proporción de hallazgos detectables por
guion** que `Master-Prompt.md` §10 exige en la estructura del informe: **9 de 12, un 75 %**, contra
un ~50 % estimado en la anterior.

**Y su lectura del número es la que vale**, más que el número: *«seis de mis nueve detectables por
guion son defectos del guion mismo. La compuerta no está dejando pasar defectos del árbol por falta
de comprobaciones; está declarando cobertura que no tiene»*. §10 dice que si la proporción no baja
ronda a ronda, la compuerta no cubre lo que debería. **Mientras el instrumento sobredeclare, esa
proporción no puede bajar**: cada ronda que lo audite va a encontrar más de lo mismo, y la métrica
mide el instrumento en vez del árbol.

## 4. La causa raíz

**El método concede una exclusión de alcance a cambio de una declaración, y no exige evidencia de
que la declaración sea verdadera.**

Los tres eslabones, y el defecto está en el tercero:

1. La compuerta corre y **declara** qué verificó y qué no. *(§10.0 lo obliga: bien.)*
2. El despacho del auditor **recibe esa declaración** como alcance ya cubierto. *(§10.0 lo obliga: es lo que hace productiva a la ronda.)*
3. **Nada, en ningún punto, comprueba que lo declarado sea lo medido.**

La consecuencia no es que la compuerta falle: es que **su falla es invisible por construcción**. Una
comprobación que sobredeclara produce exactamente la misma salida verde que una correcta, y el único
lector que podría notarlo —el auditor— es precisamente a quien el método le dijo que no mire ahí.

**Por eso reaparece después de cada corrección.** Un defecto que sólo puede detectar quien tiene
prohibido mirarlo no se corrige por atención ni por experiencia: se corrige cambiando quién lo mira.

**Y hay una asimetría que lo agrava.** La compuerta tiene un instrumento que verifica el árbol; el
árbol no tiene ninguno que verifique la compuerta. Cuanto más confía el método en la compuerta —y
§10.0 le confía nada menos que el alcance del auditor—, más caro sale que nadie la verifique.

## 5. El patrón, enunciado

> **Cuando un método concede una exclusión de alcance a cambio de una declaración del instrumento que
> la sustenta, la declaración se vuelve la superficie más barata de satisfacer y la más cara de
> auditar: el instrumento que sobredeclara produce la misma salida que el correcto, y el único lector
> capaz de notarlo es aquel a quien la exclusión se lo prohíbe.**
>
> **El corolario operativo:** un instrumento que se corrige sin una prueba que **falle antes y pase
> después** va a volver a declarar lo que no mide, y la reincidencia va a parecer descuido cuando es
> estructural.

**Se enuncia en forma general a propósito.** No es sobre compuertas: es sobre cualquier lugar donde
el método acepte «este instrumento cubre X» sin pedir la prueba de que lo cubre. Se aplica igual a
los generadores que emiten artefactos derivados y a los criterios de aceptación que declaran haberse
corrido.

## 6. Propuestas de intervención

**Punto de partida, no decisión tomada.**

### 6.1 §10.0 exige que la compuerta traiga su banco de inyección

Una comprobación entra a la compuerta **con un caso que la ejerce**: aplica sobre una copia el
defecto que la comprobación dice cubrir, corre, y verifica que lo reporte. Y **un caso por cada
recorte declarado**, que exige lo contrario: que el defecto no se reporte **y** que la salida declare
que ahí no mira.

**Costo:** una obligación de una línea en §10.0, y del lado del destino un archivo. En la corrida
medida, el banco son 17 casos y ~200 líneas; corrió en menos de dos minutos y encontró los tres `P0`
antes de que nadie los buscara.

**Por qué esto y no «revisar mejor»:** los cuatro PR fallidos tuvieron revisión. Lo que no tuvieron
fue una prueba que fallara.

### 6.2 La declaración de alcance viaja al despacho del auditor como lista, no como prosa

Hoy §10.0 dice que la compuerta declara qué no mira, y esa declaración termina siendo una frase. Si
viajara como **lista enumerada de recortes**, el despacho del auditor podría decir *«esto queda fuera
de tu alcance; esto otro la compuerta declara no haberlo mirado, y es tuyo»* — que es la mitad que
hoy se pierde.

### 6.3 El estado «declarado cerrado» de un hallazgo de compuerta exige su caso

Es la corrección más chica y la que habría evitado el segundo PR: un hallazgo sobre el instrumento no
se declara cerrado sin el caso que lo ejerce. En la corrida medida, un hallazgo estuvo **declarado
cerrado durante dos rondas con su mecanismo intacto**.

### 6.4 Lo que **no** conviene hacer

**Distribuir un banco desde el framework.** Cae en la decisión del reporte `12` por el mismo motivo:
los casos dependen de las comprobaciones que cada destino escribió, y un banco central
reimplementaría condiciones que el destino ya declara. **La obligación es del método; el banco es del
destino.**

**Pedir cobertura completa.** El punto no es que la compuerta mida todo: es que **declare con
precisión lo que mide**. Un recorte declarado y probado es conforme; lo que no lo es, es un recorte
callado.

## 7. Cómo verificar que la corrección funcionó

Cuatro criterios, los cuatro enumerables:

1. **Toda comprobación de la compuerta de un destino tiene al menos un caso** que la ejerce, y el
   banco corre en verde. Se cuenta: casos ≥ comprobaciones.
2. **Todo recorte declarado tiene su caso** de la clase inversa. Se cuenta: casos de recorte = líneas
   de alcance que declaran una exclusión.
3. **Un hallazgo sobre el instrumento no pasa a «cerrado» sin su caso.** Se verifica sobre el informe
   de la ronda que lo cierra.
4. **La proporción de hallazgos detectables por guion que §10 §6.2 exige se declara en cada informe.**
   En la corrida medida, **ninguna de las ocho rondas la declaró hasta que se la pidió explícitamente**
   — lo cual es, por sí solo, evidencia de que la estructura del informe de §10 no se está cumpliendo
   entera.

## 8. Dos hallazgos menores del mismo origen

Se anotan acá porque salieron de la misma corrida y son chicos; no justifican reporte propio.

### 8.1 §10.0 cuenta mal el catálogo, y queda una regla atrasado

§10.0 dice «**97 de las 202** situaciones que el método cataloga». `Catalogo-De-Criterios.md` §4
declara **100 / 108 / 208**. Medido sobre los diecinueve archivos de regla: **100** anti-patrones
`[enumerable]` —97 con la marca al final de fila, más 3 en `Rules-Base-Conocimiento.md`, que la
escribe dentro de la primera celda— y **108** interpretativos.

**La diferencia es exactamente `Rules-Base-Conocimiento.md`**, incorporada después de que §10.0
fijara su número. El catálogo está bien; el orquestador quedó viejo.

**Es una instancia del reporte `04`** —un recuento derivado escrito a mano que envejece— dentro del
propio framework, y en la sección que gobierna la compuerta.

### 8.2 §5.1 no declara qué hacer cuando el archivado salió mal

§5.1 es terminante: *«Un archivo que ya vive en un `_legacy/` no se toca nunca más: ni sus enlaces,
ni su estado, ni su nombre»*, y agrega que *«etiquetar con una versión un archivo cuyo contenido no
se verificó es una afirmación sin evidencia que viola D9»*.

**No dice qué hacer cuando el snapshot se archivó mal** — un bloque roto, una fecha basura, un sufijo
que no corresponde. El caso es real y previsible, y el método deja **dos salidas, las dos ilegales**:
dejar en pie una afirmación falsa, o corregirla violando la inmutabilidad.

En la corrida medida, esa ambigüedad produjo directamente un `P0`: se eligió corregir, se corrigió
**del lado equivocado** —el nombre en vez del cuerpo— y quedaron 57 archivos afirmando preservar una
versión que su contenido desmiente. El destino lo resolvió con un ADR de apartamiento y propuso la
figura que falta: **una fe de erratas adjunta que no toque el snapshot**.

> **Convergencia con los hallazgos pendientes de otro destino.** El `HM-03` medido en la
> migración de `Lab-Geometria` —todavía sin escribir como reporte— —medido en un destino
> **distinto**— nombra el mismo hueco desde el otro lado: una política de archivado que el destino
> aplica y que §5.1 no contempla. **Dos destinos independientes chocando con la misma sección** es
> mejor evidencia que dos incidentes del mismo. Conviene que las dos mitades se resuelvan juntas.
