# 10 — La decisión de fondo (§5.1) y las cinco preguntas de §5 (solicitudes 3 a 6)

Colisiones medidas en `evidencia/ev-03-colision.{sh,out}`. **No hubo detención**: todo lo que se decidió
tiene respuesta en el árbol del framework, en la especificación o en el destino (§8.1). La pregunta de fondo
**no requiere intención de producto**: es una pregunta de modelo del método, y la contesta la frontera con que
`Vocabulario-Rules.md` §2 define la solución de código, contrastada contra un árbol real.

## 0. La segunda trampa, primero: ¿la degradación de P-8 fue correcta, y se puede usar P-1 a P-7 como fuente?

**La mitad de P-8 que niega un documento de `Conocimiento/` es correcta** y se sostiene: P-5 y P-7 son
método —qué sample produce la categoría 10 y cómo entra al agrupador— y `Rules-Base-Conocimiento.md` §0.1
(«Describe el artefacto, no el método») y §4.5 («Conocimiento disfrazado de regla») lo excluyen.

**La mitad que cierra la vía al framework parte de una premisa que la norma no dice**: «el único canal es un
ADR de apartamiento con dos saltos». Medido en `OUTPUTs/00` §1: «único» no está en `Migracion-Rules.md` §4.7
ni en `Root-Rules.md` §11, y la comprobación 13 de la guía nombra un reporte como origen legítimo. **El
reporte tiene razón en que la degradación fue correcta dentro de su consigna** —no modificar el framework— y
en que el canal es el reporte.

**Por eso P-1 a P-7 se usan como fuente, con dos filtros**: se toman como **mediciones** —las reproducciones
de la mesa, las alternativas descartadas con su costo—, no como decisiones; y **de cada una se retira todo lo
que nombra una herramienta**, que queda en el destino o como candidato a `Conocimiento/`, nunca en una regla.

## 1. §5.1 — La decisión de fondo: **sí**, con una frontera precisa

**El método reconoce un proyecto de código cuyo ecosistema difiere del de la solución de código que lo
agrupa, cuando un proyecto de esa solución toma su artefacto como insumo de construcción. Si ninguno lo toma,
es su propia solución de código.** Que el agrupador lo muestre es forma del repositorio y no pertenencia.

**Fundamento, en el orden en que decide:**

1. **La frontera de la solución de código es el comando de construcción** (`Vocabulario-Rules.md` §2, l.33:
   «El comando de construcción que la toma como entrada única»), no el ecosistema. En el caso medido ese
   comando **genera el artefacto del visor**: `dotnet build GeometriaFactory.sln` construye `Web`, y el target
   `BuildVisor` de `Web` construye el bundle (`ADR-10008`, `Web.csproj` l.77). **El visor está dentro de la
   frontera que define la solución.**
2. **La respuesta negativa contradiría el árbol.** Si el visor fuera su propia solución, la arista `Visor → Web`
   caería bajo `PRODUCT-MANIFEST-template.md` §3 —«una dependencia de compilación entre soluciones distintas
   […] es un consumo de artefacto publicado»—, y **el bundle no se publica**: se genera en el mismo comando.
   El «no» obligaría a declarar publicado algo que no lo es.
3. **El modelo de dos ejes ya lo permitía y no lo decía.** §2.B lleva `Stack` por fila y agrupa por solución
   sin exigir un ecosistema por solución; lo único que ata una solución a un ecosistema es el **ejemplo** de
   `Vocabulario-Rules.md` §2 («el archivo de solución en .NET, el POM agregador…»), que ilustra y no restringe.
   Por eso **`Vocabulario-Rules.md` no se modifica**: su definición por frontera sigue siendo exacta.
4. **El «no» tiene su lugar y se conserva**: un proyecto de otro ecosistema que ningún miembro consume es su
   propia solución, y ahí rige §3 del manifiesto sin cambios.

**Dónde vive la regla**: `Intake-Rules.md` §4, que es donde el método ya valida la columna «Solución de código»
y el grafo de compilación al derivar el manifiesto. Formato en `PRODUCT-MANIFEST-template.md` §2.B y §3.

## 2. §5.2 — La arista de construcción entre ecosistemas: **sí, una segunda clase**

**El grafo de compilación tiene dos clases de arista: `referencia de proyecto` e `insumo de construcción`.** La
segunda es la única posible entre ecosistemas distintos, tiene **un único generador** —el consumidor cuya
construcción ejecuta la del productor— y se marca en la columna de dependencias:
`<Proyecto> (insumo de construcción)` en el generador y `(insumo de construcción, generado por <Generador>)`
en cualquier otro consumidor. Gobierna `Intake-Rules.md` §4, con cuatro validaciones bloqueantes; lo declaran
el manifiesto (§2.B, §3, §4, §7), la vista de producto (`Rules-Arquitectura-Tecnica.md` §4.8 punto 3) y el
glosario operativo (`Master-Prompt.md` §15).

**El único generador sale de P-3.3 y de `ADR-10008`**: el destino midió cuatro generadores del mismo
artefacto antes de corregirlo, y la alternativa C de P-7 existe sólo para «dos consumidores del mismo bundle».
La regla dice qué pasa con el segundo consumidor sin nombrar el mecanismo.

**El nombre, con su colisión medida** (`ev-03-colision.out`, base `47be07d`, lectores: las dos plantillas,
`Intake-Rules`, `Rules-Arquitectura-Tecnica`, `Rules-Devops`, `Rules-Examples`, `Master-Prompt` y
`Vocabulario-Rules`):

```bash
for f in $R; do git -C $F show main:$f | grep -o -i "insumo de construcci" | wc -l; done   # 0 en los ocho
git -C $F grep -i -c "insumo de construcci" main -- '*.md' | grep -v '^main:_legacy/'     # 0 en el árbol vivo
# ídem "referencia de proyecto" → 0 y 0; "activo de construcci" → 0 y 0
```

**Por qué no se adopta el nombre del destino, «activo de construcción», aunque también da cero como
compuesto.** La forma desnuda **«activo» ya tiene otro sentido en dos de los lectores**: adjetivo y verbo
(`Master-Prompt.md` l.443 «activa el patrón», l.1617 «Flags activos», l.1908 «Se activa»;
`Rules-Examples.md` l.352 «está activa»). Sumarle el sentido de sustantivo —«activo» como *asset*— en el
mismo contexto de lectura es la polisemia que `Vocabulario-Rules.md` §9.1 manda evitar. **«insumo» ya
significa, en esos mismos lectores, lo que el término necesita**: «entrada que alguien consume» (65
ocurrencias en `Master-Prompt.md`, «Insumos de solo lectura», «insumo declarado de cuatro consumidores»); el
compuesto no le agrega un segundo sentido. **El costo lo paga el destino**, que tiene la clase con otro
nombre en **17** lugares de su `main` en `b58dec3` —15 en `1ce1b2c`, contando sólo `SDD`, `visor`, `src`, `deploy`, `scripts` y `.github`— (`OUTPUTs/30` §4): se re-expresa en su próxima migración como apartamiento absorbido.

**Figura nueva, y por qué ninguna existente alcanzaba.** No se agrega columna ni tabla: `Stack` ya declaraba
el ecosistema y «Dependencias de compilación» ya declaraba la arista. Lo único nuevo es la **clase**, y no
había dónde declararla: el «consumo de artefacto publicado» de §3 es entre soluciones y supone publicación, y
`Rules-Devops.md` §4.9 punto 4 («build conjunto en el repositorio») dice cómo se obtiene el artefacto, no qué
arista es en el grafo.

## 3. §5.3 — La cadena de herramientas ausente: **sí, agnóstica**

**`Rules-Devops.md` §4.9, punto 4**, que ya coordinaba cada arista «por referencia al paquete publicado o por
build conjunto en el repositorio», suma: el **único generador** de cada insumo y, **cuando la construcción
necesita la cadena de más de un ecosistema** —por un insumo **o dentro de un mismo proyecto de código**—, en qué
ambientes falta y cómo se construye ahí, con **un modo de construcción explícito y nombrado** que recibe el
artefacto de otra etapa. **Sin ese modo, la construcción falla con un error que nombra la cadena**; nunca
termina bien entregando el consumidor sin su insumo. Dos anti-patrones `[interpretativo]` en §4.8.

**La propiedad no es de un destino: la tienen dos, independientes.** `ADR-10008` §2: «Sin la bandera y sin Node
el target **falla** […] y es lo que debe hacer: nunca callar», contra el estado anterior en que «un clon limpio
construía un front sin visor y sin que nada fallara». `RPI.VideoControl`, `VideoControl.PinMap.csproj`, target
`VerificarNode`: `<Error … Text="No hay entorno de ejecucion de JavaScript en el PATH…">`. Por eso la regla
alcanza también al proyecto con dos cadenas, que el reporte no había visto.

## 4. §5.4 — El sample que no se compila: **sí, `Rules-Examples.md` §3.6**

**Todo sample está en el agrupador, de una de dos formas**: con construcción —el del ecosistema de la
solución, que es como se cumple §3.4— o **sin construcción** —el que no se compila o es de otro ecosistema—,
con la forma concreta a cargo del destino. **La verificación nunca se engancha a la construcción de la
solución** (P-7: `verify` enganchado a `Build` rompe `dotnet build` de toda la solución con `MSB3073`,
reproducido por la mesa). **La cobertura del agrupador se comprueba por enumeración** con un instrumento del
destino: **el reporte `12` no se reabre** —la regla fija la propiedad y su criterio, el mecanismo es del
destino por `SDD-Development-Guide.md` §II.7—.

**La forma del sample de un artefacto que otro proyecto carga**, tomada de P-6 sin sus herramientas: anfitrión
mínimo sobre el artefacto **construido y no copiado**; sólo la superficie pública; datos, salida esperada y
prueba; **sin servidor o servido**; **doble del consumidor** si hay retorno, con la lista derivada de una
sola fuente (P-6 punto 1, la divergencia medida en DEV.Maps); y **la superficie completa cubierta por el
conjunto** (P-6 punto 5).

**Lo que no entra, y por qué**: las dos formas de adaptación de P-2 nombran un framework de front y son
materia de `Conocimiento/` (naturaleza `propio`), no de regla; la convención de segmento de carpeta
(`samples/<segmento>/`) es del destino (`Rules-Examples.md` §2.3 admite carpetas extra); los slugs de D-1 ya
existen.

## 5. §5.5 — §16.1 de la plantilla del intake: **sí, corregida**

La instrucción pasa a «según el tipo D8 de cada unidad de entrega», nombra el proyecto sólo cuando un sample
ejercita uno, y declara la entrada al agrupador. **Barrido por concepto** (`SDD-Development-Guide.md` §VI.3.1):
en los archivos tocados aparecieron **dos residuos más de la misma forma** y se corrigieron —
`Rules-Arquitectura-Tecnica.md` §4.8 punto 2 pedía D8 y `redistribuible` por proyecto, y `Master-Prompt.md`
§11 describía el README raíz «con la tabla de proyectos de código con su D8», contra `Root-Rules.md` §4—.
**Residuos que quedan, declarados** con su motivo en la nota de coherencia: el mecanismo de carga de
conocimiento (`Master-Prompt.md` l.573, `Rules-Base-Conocimiento.md` l.487 y l.495, `SDD-Development-Guide.md` l.500)
evalúa «el tipo D8 del proyecto de código en curso», y corregirlo es decidir la granularidad de la carga de
conocimiento, que es un mecanismo con contrato propio (`AG-00980`) y no el origen de esta intervención; y
`Marco-Teorico-SDD.md` l.1146 es texto teórico, no una instrucción de generación.

## 6. §5.6 — El canal: **P-8 queda superada en su premisa, y la guía no se toca**

1. **La premisa de P-8 no está en la norma** (§0 de este documento).
2. **La admisión ya está escrita**: la comprobación 13 reconoce un reporte como origen de una intervención.
3. **Escribir en la guía que «una especificación de destino con mesa puede alimentar un reporte» rompería la
   autosuficiencia** (comprobación 2): el framework no conoce la serie de reportes ni la carpeta de prompts, que
   viven en otro repositorio.
4. **P-8 se declara superada donde corresponde**: en «Cómo se resolvió» del reporte `30`. La especificación no
   se modifica: es de `PROMPTs/`, del usuario, y no está versionada.
