# Plan — Base de conocimiento del Framework SDD

**Documento:** Plan-Base-Conocimiento-SDD.md
**Versión:** 3.0
**Estado:** Borrador
**Fecha:** 2026-08-23
**Origen:** `PROMPTs/Features/15-RAG/01-Crear-Rag.md`
**Naturaleza:** documento de análisis, debate y plan de trabajo. No es normativo. Su destino es servir de guía a un prompt posterior de intervención sobre el `Framework SDD`.

---

## Tabla de contenido

- [1. Qué se debate](#1-qué-se-debate)
- [2. Lo que el framework ya resuelve](#2-lo-que-el-framework-ya-resuelve)
- [3. Encuadre contra metodologías ágiles, industria y academia](#3-encuadre-contra-metodologías-ágiles-industria-y-academia)
- [4. El debate: nueve decisiones de fondo](#4-el-debate-nueve-decisiones-de-fondo)
- [5. Propuesta de materialización](#5-propuesta-de-materialización)
- [6. Impacto normativo](#6-impacto-normativo)
- [7. Riesgos e implicancias](#7-riesgos-e-implicancias)
- [8. Decisiones cerradas, abiertas y deuda declarada](#8-decisiones-cerradas-abiertas-y-deuda-declarada)
- [9. Plan de trabajo](#9-plan-de-trabajo)
- [10. Evidencia consultada](#10-evidencia-consultada)
- [Control de cambios](#control-de-cambios)

---

## 1. Qué se debate

El planteo es: hoy el `Framework SDD` regula el **comportamiento** de sus subagentes con reglas, y la
idea es sumar una base de documentos markdown que les dé **conocimiento sobre artefactos que el
framework no gobierna** —cómo está construido un template HTML y cómo declara sus variables y sus hojas
de estilo, cómo se arma un asistente de formularios, qué nomenclatura sigue un esquema de base de
datos, qué forma tiene una arquitectura de software concreta—. Ese conocimiento se releva con un prompt
de captura que cita un archivo de reglas de formato, se deposita con un nombre citable, y se invoca
desde el intake diciendo «para este proyecto quiero usar tal template».

El debate tiene una premisa que conviene desarmar antes de empezar, porque cambia el diseño entero:
**el framework ya tiene esa capacidad, construida dos veces, y lo que falta no es inventarla sino
generalizarla**. La sección 2 lo demuestra con evidencia. Lo que este documento debate es cómo se
generaliza sin romper tres propiedades que el método hoy sostiene: la lista cerrada de insumos por
despacho, la neutralidad de dominio (D7) y la reconstrucción de con qué normas exactas se generó un
destino.

Aclaración sobre el nombre, que ordena el resto del documento: acá «RAG» no designa recuperación por
similitud sobre un índice de embeddings, sino un **catálogo curado, indexado y cargado por cita
explícita**. Lo que la práctica de RAG aporta no es el recuperador: es **cómo se escribe un documento
para que un agente lo consuma barato y sin pérdida**, que es lo que §4.1 codifica. En el resto del
documento se lo llama **base de conocimiento**.

---

## 2. Lo que el framework ya resuelve

### 2.1 Ya existe un catálogo de conocimiento, y funciona

`SDD/Devs/References/Design/` es exactamente el mecanismo que el contexto propone, acotado a la
categoría 03. Su índice `Index-Design-Rules.md` declara:

- un **modelo base→especialización**: un documento base agnóstico (`Design-Rules-Web-Generico.md`), dos
  ejes de derivados —especializaciones por stack (`Design-Rules-Blazor-Mudblazor.md`) y extensiones por
  capacidad transversal (`Design-Rules-Config-Esquema.md`, `-Primer-Arranque.md`, `-Acceso-Monousuario.md`,
  `-Identidad-De-Version.md`)— y un roadmap de huecos previstos (§2 y §3);
- un **criterio de selección por condición declarada**, en tabla: qué documento se carga y cuándo,
  leyendo el stack de la Parte C del intake y el tipo D8 del proyecto de código (§4);
- una **regla de conflicto**: manda el base salvo limitación técnica explícita y justificada en el hijo (§4);
- un **orden de apilado de cuatro capas** cuando se suma el tercer eje (§4.1).

Los documentos del catálogo comparten una estructura canónica de §0 a §12 —propósito y alcance,
principio, contrato, patrones de componente, estados, esqueletos de referencia, accesibilidad,
criterios de aceptación, anti-patrones, trazabilidad, control de cambios—, verificable en
`Design-Rules-Primer-Arranque.md`.

### 2.2 Ya existe el eje de conocimiento capturado de la práctica

`SDD/Devs/Modelos-UX-UI/` es la otra mitad, y su índice declara la diferencia de origen y de
obligatoriedad respecto del anterior: `References/Design/` es material metodológico **diseñado** y es
**piso obligatorio**; `Modelos-UX-UI/` es experiencia **extraída de la práctica** y es **opcional**, elegida
por el humano en el paso 1 de la Fase B2 (`Index-Modelos-UX-UI.md` §1).

Trae además, ya resueltos, los cuatro mecanismos que una base de conocimiento alimentada por captura
necesita:

| Mecanismo | Dónde está | Qué fija |
|---|---|---|
| Convención de nombres | `Index-Modelos-UX-UI.md` §3 | `Rules-Design-<Nombre-Modelo>.md`, nombre agnóstico del dominio de origen: `Panel-Operativo-Denso` sí, `Panel-Cliente-Acme` no |
| Plantilla de redacción | `Modelos-UX-UI/Rules-Design-Modelo-Template.md` | Estructura §0 a §16 que todo modelo capturado sigue |
| Procedimiento de alta | `Index-Modelos-UX-UI.md` §4 | Tres escrituras en la misma operación —documento, ejemplo ofuscado, fila en el índice—, con aceptación humana explícita |
| Compuerta de ofuscación | `Index-Modelos-UX-UI.md` §4, `Maqueta-Rules.md` §6 punto 5 | **Bloqueante y previa**: `IA.SDD` es público; ningún modelo puede contener nombres de clientes, datos reales ni assets del origen |

El catálogo hoy está **vacío**: «El catálogo arranca vacío. El primer modelo se registra al cerrar la
primera Fase B2 en la que el humano acepte capitalizar el diseño» (`Index-Modelos-UX-UI.md` §2). Es un
dato relevante para el plan: el eje de captura está normado pero **nunca se ejerció**.

### 2.3 Ya existe el precedente de capturar conocimiento de un proyecto real

Tres de las cuatro extensiones por capacidad del catálogo de diseño «se incorporaron a partir de la
extracción de características de un panel de control monolítico en producción»
(`Index-Design-Rules.md` §2). La nota `Coherencia-Panel-Monolitico.md` registra esa incorporación
completa: qué se creó, qué se editó con su salto de versión, y una verificación de D7 hecha por
búsqueda de términos del servicio y de su tecnología en los tres documentos nuevos, con los falsos
positivos léxicos declarados.

O sea: **el flujo que el contexto propone —tomar un proyecto real, relevarlo, destilarlo en documentos
numerados y neutros, y engancharlos al método— ya se ejecutó una vez, a mano, y quedó auditado**. Lo
que no existe es el prompt reejecutable que lo sistematice.

### 2.4 El defecto que la generalización tiene que corregir

`Master-Prompt.md` §6 lleva **once notas operativas**. **Cinco** mencionan el catálogo de reglas de
diseño y **cuatro** de esas tienen la forma «para proyectos de código con <condición>, el despacho de
AG-00030 suma <documento>, vía el mismo índice» —una por cada extensión por capacidad—, mientras la
quinta cubre de una vez el documento base y la especialización por stack. El índice ya declara esas
mismas condiciones en su §4, en tabla.

O sea: **no hay una nota por documento, pero sí hay duplicación con dueño ambiguo**, y **escala mal por
construcción**: sumar una extensión al catálogo hoy obliga a subir versión del master-prompt, que es un
archivo de alcance global. Con cuatro es una molestia; con treinta —que es el orden de magnitud que el
contexto plantea, «se podría enriquecer la base de conocimientos con muchos documentos con simplemente
copiarlos»— el master-prompt sería el cuello de botella de la extensión.

**Corolario para el diseño, y es el que gobierna esta propuesta**: la base de conocimiento sólo es
viable si **el índice es el único lugar donde se declara qué se carga y cuándo**, y el master-prompt
lleva una regla genérica que lo resuelve. Es exactamente lo que §5.4 propone **para la base**.

**Lo que no se sigue de acá.** Que el catálogo de diseño del framework merezca el mismo tratamiento es
cierto y sigue siendo cierto, pero es un **defecto propio de ese catálogo** y no un obstáculo para esta
capacidad: la base nace con la forma correcta desde el primer día sin necesidad de tocar las notas
existentes. Arreglar las de diseño es una intervención aparte, y §8.3 la registra como deuda.

---

### 2.5 El caso concreto que motiva la capacidad: un solo template, acoplado por regla

Las dos secciones anteriores muestran que el mecanismo existe. Esta muestra **dónde no alcanza**, y es
el caso que el PO puso sobre la mesa. Es la evidencia más fuerte de este documento porque no es una
proyección: es el estado actual, verificable hoy.

**El framework construye toda maqueta y todo código web a partir de un único template.**
`Templates/` contiene una sola carpeta, `Modelo-Generico/` —tres superficies HTML y una hoja de estilos
de 896 líneas— y `Templates/README.md` §2 lo declara sin ambigüedad: «`Modelo-Generico/` no corresponde
a ningún modelo capturado: es el ejemplo de referencia que fija la estructura y el nivel de detalle
esperados. Un template nuevo se deriva de él.» Funciona, y funciona bien.

**Pero el acoplamiento no está en el template: está un nivel más arriba, escrito como norma.**
`Maqueta-Rules.md` §4 fija las reglas constructivas de toda maqueta:

> HTML5 semántico, CSS con tokens del catálogo `SDD/Devs/References/Design/`, **JavaScript vanilla,
> Bootstrap 5.0 por CDN**. **Sin proceso de build, sin gestor de paquetes, sin `node_modules`**: lo que
> se edita es lo que se sirve.

Y `Maqueta-Rules.md` §7 registra la justificación de la decisión de no incorporar un paso de build. Es
una **postura tecnológica concreta**, razonada y explícita, viviendo dentro de un archivo de reglas de
alcance normativo.

#### Por qué el punto de extensión que ya existe no cubre este caso

El framework sí previó extensión, y está en la Fase B2: si el humano acepta capitalizar una maqueta
aprobada, nace un modelo en `Modelos-UX-UI/` y su ejemplo ejecutable en `Templates/`, derivado del
genérico (`Maqueta-Rules.md` §3.7 y §6). **Pero ese eje sólo permite variar el modelo visual** —grilla,
densidad, patrones de superficie—, porque cualquier modelo nuevo sigue obligado por las reglas
constructivas de §4.

De modo que **no hay dónde poner una forma distinta de construir una página web**. Una casa que trabaje
con un framework de componentes, con proceso de build o con otra estrategia de estilos no tiene punto de
enganche: tiene que **editar `Maqueta-Rules.md`**, que es un archivo normativo de alcance global, para
agregar su forma de trabajar. Y el catálogo que iba a absorber la variación **está vacío desde que se
creó** (§2.2).

#### La válvula de escape ya existe, y ya tiene el defecto

`Maqueta-Rules.md` §7.2 cierra con esto, y es la evidencia que convierte lo que §4.9 predice en algo
observable hoy:

> «Si una unidad de entrega futura necesitara compilar para maquetar (por ejemplo, una librería de
> componentes que solo se puede demostrar compilada), **se registra como ADR en 05 del proyecto de
> código** y la maqueta documenta su propio comando de build en su `README.md`. Es la excepción, no el
> camino.»

O sea: el framework **ya contempla apartarse de la decisión de no-build**, y la vía que ofrece es **un
ADR por proyecto de código**. Para el caso que esa cláusula imagina —una librería de componentes, una
vez— está bien dimensionada. Para una casa que construye así **siempre**, produce el mismo ADR en cada
proyecto, con la misma justificación, para siempre. Eso no es una excepción: es una convención de la
organización disfrazada de excepción, y es exactamente el anti-patrón que `Root-Rules.md` §11 nombra
—«un apartamiento usado para evadir una condición que ya existe»— sólo que llegando por el otro lado.

Que la válvula exista es un punto a favor del framework: alguien vio el problema. Lo que falta es la
otra escala: **el apartamiento por proyecto ya está resuelto; el apartamiento por organización no tiene
dónde declararse.** Eso es lo que la base aporta.

**Ese es el hueco, dicho con precisión.** No es que falten templates. Es que el framework no distingue
entre lo que en sus reglas es **método** —criterio de aceptación que no se negocia— y lo que es
**decisión de stack** —una elección razonable que otra casa razonablemente toma distinta—. Mientras las
dos vivan mezcladas en el mismo archivo, la única forma de aportar una variante es modificar el
framework, que es exactamente lo que la base de conocimiento existe para evitar. §4.9 escribe la
distinción.

---

## 3. Encuadre contra metodologías ágiles, industria y academia

Esta sección separa deliberadamente dos planos: lo que el repositorio declara (verificable) y el
encuadre externo (nombres de estándares y prácticas, que se citan como referencia y no como hallazgo
del repositorio).

### 3.1 Lo que el framework ya declara

`Marco-Teorico-SDD.md` ancla el método en un cuerpo amplio y explícito: Scrum por defecto con criterio
de Kanban/Scrumban (§5.1, §5.2), DoR y DoD canónicas (§5.7, §5.8), técnicas de descomposición —vertical
slicing, walking skeleton, story mapping, example mapping, spike, ATDD— con tabla de cuándo usar cada
una (§6), heurísticas de Nielsen y leyes UX (§8.2, §8.3), WCAG 2.2 AA (§8.4), Diátaxis (§8.5), pirámide
de testing e ISO/IEC 25010 (§9.1, §9.3), CALMS, DORA, SemVer 2.0.0, Conventional Commits, GitHub Flow,
SBOM/SLSA (§10), y fundamentación en literatura de prompting: Chain-of-Thought, ReAct, Self-Refine,
colaboración multi-agente y Constitutional AI (§11.6), más una bibliografía en §14.

La conclusión del encuadre es que **el framework no tiene un déficit de estándares**: tiene un déficit
de **capa**. Todo lo anterior está codificado como *regla* —qué debe cumplir un artefacto— y no como
*conocimiento reutilizable* —cómo se hace una cosa concreta bien.

### 3.2 El nombre externo de la capa que falta

En la industria y la academia esa capa tiene nombres establecidos, y conviene usarlos porque traen
criterios ya discutidos:

- **Lenguaje de patrones**: un catálogo de soluciones nombradas a problemas recurrentes en un contexto,
  con fuerzas y consecuencias explícitas. Es la forma canónica de un documento tipo «cómo diseñar un ABM».
- **Activos de proceso de la organización**: el repositorio de plantillas, guías y lecciones aprendidas
  que una organización acumula y reutiliza entre proyectos. Es exactamente lo que el contexto describe.
- **Biblioteca de activos de proceso** en los modelos de mejora de proceso: el mismo concepto con
  gobierno —alta, revisión, versionado y retiro de activos— que es la parte que más suele faltar.

La lección de los tres, y es la que este plan toma: **el problema de una base de conocimiento nunca es
llenarla, es gobernarla**. Un catálogo sin criterio de alta, sin dueño, sin versión y sin criterio de
retiro se degrada a carpeta de documentos que nadie cita.

### 3.3 Sobre el término «RAG» y el estado del arte de agentes

En arquitecturas de agentes actuales conviven dos formas de dar conocimiento a un modelo:

1. **Recuperación por similitud** (RAG propiamente dicho): se indexa el corpus, se recupera por
   cercanía semántica en tiempo de ejecución y se inyecta lo recuperado.
2. **Divulgación progresiva por catálogo curado**: el agente ve un índice liviano con nombre, propósito
   y condición de carga de cada documento, y **carga el documento entero cuando corresponde**.

El framework ya implementa la segunda, y la sección 4.1 argumenta por qué la primera le es
arquitectónicamente incompatible.

---

## 4. El debate: nueve decisiones de fondo

### 4.1 Qué toma el catálogo de la práctica de RAG

**Punto de partida, ya acordado: la carga es por cita explícita, no por recuperación por similitud.**
No es una limitación del método, es lo que lo hace auditable: `Master-Prompt.md` §8 prohíbe «buscar
información fuera del scope de los insumos listados», D9 exige evidencia reproducible y `_legacy/`
promete reconstruir con qué normas exactas se generó un destino. Un índice vectorial no sobrevive a
ninguna de las tres; un árbol de markdown citado por nombre, sí.

**Lo que la práctica de RAG sí aporta, y es lo que hay que codificar en las reglas de formato**, es cómo
se escribe un documento para que un agente lo consuma barato y sin pérdida. Estas son las propiedades
que el archivo de reglas del catálogo tiene que exigir:

| Propiedad | Qué exige | Por qué |
|---|---|---|
| **Un documento, un artefacto** | El documento cubre un artefacto o convención y nada más. Si aparecen dos temas, son dos documentos | Es la versión disciplinada del *chunking* semántico: la unidad de carga y la unidad de sentido coinciden, y no se paga contexto por lo que no se va a usar |
| **Cabecera autodescriptiva** | Qué es, a qué categoría alimenta, cuándo aplica y **qué queda explícitamente afuera** | La selección se resuelve leyendo el índice y la cabecera. Sin el «qué queda afuera», el agente completa el hueco por su cuenta |
| **Secciones autocontenidas** | Cada sección se entiende leída sola, sin depender de contexto no enunciado antes | Es lo que permite que un agente cite una sección puntual sin arrastrar el documento entero |
| **Forma extractiva antes que narrativa** | Tablas, enunciados declarativos, identificadores y rutas literales. La prosa se reserva para el principio y el motivo | Un dato en tabla se consume sin interpretación; el mismo dato en prosa se reconstruye, y reconstruir es donde se pierde |
| **Un hecho, un lugar** | Nada se repite entre documentos del catálogo. Si dos lo necesitan, uno lo declara y el otro lo cita | Duplicar es garantizar deriva: las dos copias se editan en momentos distintos y una queda mintiendo |
| **Forma de contrato** | Lo que hay que saber para **usar** el artefacto: variables, puntos de extensión, layout de archivos, convenciones. No la historia de cómo llegó a ser así | El consumidor es un subagente que va a reproducir o consumir el artefacto, no auditarlo |
| **Techo de tamaño declarado** | El archivo de reglas fija un máximo por documento, y superarlo obliga a partir en dos | Es el «uso optimizado de recursos» hecho verificable. Sin techo, el catálogo se degrada a documentos que nadie carga porque salen caros |

Las dos primeras son, además, lo que hace barata la **divulgación progresiva**: índice liviano primero,
documento entero después y solo cuando corresponde. El framework ya opera así con
`Index-Design-Rules.md`; acá se lo escribe como regla en vez de dejarlo como costumbre.
### 4.2 Conocimiento contra regla: dónde va la frontera

Hay dos fronteras distintas y conviene no mezclarlas.

**Primera frontera, la de contenido: el conocimiento describe el artefacto, no el método.** Es la
distinción más clara que el planteo aporta. Un documento del catálogo caracteriza **algo externo que el
framework no gobierna** —cómo está construido un template HTML, cómo se declaran sus variables y sus
hojas de estilo, qué nomenclatura sigue un esquema de base de datos, cómo se arma un asistente de
formularios, qué forma tiene una arquitectura de software concreta—. El método del framework —qué
artefactos produce una categoría, con qué criterios se aceptan, cómo se numera y se trazan— sigue
viviendo en los dieciocho archivos de reglas y no se toca.

| Va en reglas del framework | Va en la base de conocimiento |
|---|---|
| Qué artefactos produce una categoría y con qué secciones | Cómo está construido un artefacto externo que el proyecto va a usar o reproducir |
| Criterios de aceptación de un entregable | Convenciones, puntos de extensión y contrato de uso de ese artefacto |
| Nomenclatura y trazabilidad de lo que el framework genera | Nomenclatura interna del artefacto caracterizado, por ejemplo la de un esquema de base de datos |
| Gating por tipo D8 y por flags | Condición de aplicabilidad del conocimiento, declarada en su índice |

Un apunte sobre el borde con los glosarios, porque el planteo lo roza al decir que es «algo más que un
simple diccionario»: `Vocabulario-Rules.md` §9 gobierna los glosarios de la documentación **generada**, y
un glosario declara **qué designa un término**. Una convención de nomenclatura de base de datos no
declara términos: declara **cómo se construye un nombre**. Son objetos distintos y no compiten. Vale la
pena escribirlo, porque es el primer choque que alguien va a plantear.

**Segunda frontera, la de precedencia.** `Root-Rules.md` §13 fija el criterio del framework, y es uno
solo: **«Una regla que viaja en la lista de insumos obligatorios de todo despacho (`Master-Prompt.md`
§8) desplaza a una que no viaja, cuando las dos alcanzan al mismo ítem.»** Y agrega: **«Si el criterio no
decide —las dos viajan, o ninguna—, el conflicto se detiene.»**

Consecuencias directas, y son duras:

- Los documentos de conocimiento **no viajan en todo despacho**, viajan por condición o por cita. Frente
  a `Vocabulario-Rules.md` o `Root-Rules.md`, que sí viajan, **siempre pierden**. Bien: es lo que se
  quiere. Un documento que caracteriza un template no puede desplazar al vocabulario normativo.
- Frente a un **archivo de reglas de categoría**, que tampoco viaja en todo despacho, **el criterio no
  decide y el conflicto se detiene**. Eso es una detención por cada choque entre un documento de
  conocimiento y la regla de su categoría, escalada a arbitraje humano. Sin tratamiento, la base de
  conocimiento se vuelve una fábrica de detenciones.

**Propuesta**: el archivo de reglas del catálogo declara su propia regla de subordinación, calcada de la
que `Index-Design-Rules.md` §4 ya usa: **ante conflicto entre un documento de conocimiento y el archivo
de reglas de la categoría que lo consume, manda la regla de categoría, salvo que el documento de
conocimiento documente la desviación con su justificación.** Con eso el conflicto tiene resolución en el
árbol y deja de caer en §13.

**Precisión que §4.9 obliga a agregar, y sin ella las dos secciones se contradicen.** La regla anterior
gobierna el **conflicto**: dos textos que alcanzan al mismo ítem y dicen cosas distintas, sin que nadie
lo haya previsto. La **sustitución** de §4.9 no es un conflicto: es un reemplazo **previsto y
etiquetado** sobre una regla que el framework declaró explícitamente como decisión de stack. La
diferencia operativa importa:

| | **Conflicto** | **Sustitución** |
|---|---|---|
| Cómo se llega | Nadie lo previó; se descubre al chocar | El framework etiquetó la regla como sustituible |
| Quién gana | **La regla de categoría** | **El documento de conocimiento**, en el ítem declarado |
| Qué exige del documento | Documentar la desviación con su justificación | Declarar en el índice qué sustituye (campo `sustituye`, §5.2) |
| Qué pasa si el ítem no está etiquetado | — | **La validación de intake lo rechaza.** No hay sustitución tácita |

Sin la etiqueta, todo vuelve a ser conflicto y manda la regla. **Esa es la propiedad que hace segura a la
sustitución**: no la habilita el que escribe el conocimiento, la habilita el framework por adelantado.

**Anti-patrón a declarar**: un documento de conocimiento que redefine criterios de aceptación,
nomenclatura de artefactos generados o gating. Eso es una regla escrita en el lugar equivocado.
### 4.3 Un catálogo nuevo, o la generalización del que existe

Tres opciones evaluadas:

| Opción | A favor | En contra |
|---|---|---|
| **A. Carpeta `RAG/` nueva e independiente** | Es lo que el contexto pide literalmente; no toca nada existente | Deja tres catálogos con tres gobiernos distintos; `References/Design/` y `Modelos-UX-UI/` quedan como excepciones históricas; duplica plantilla, índice y compuerta de ofuscación |
| **B. Extender `References/Design/`** | No agrega subárbol | Rompe su propósito declarado: es «insumo normativo de la categoría 03» (`Index-Design-Rules.md` §1). Meter ahí «cómo estructurar un proyecto web» o conocimiento de otras categorías lo desnaturaliza |
| **C. Subárbol nuevo `References/Knowledge/`, hermano de `Design/`, con `Design/` y `Modelos-UX-UI/` reencuadrados como sus dos primeros ejes** | Un solo gobierno; el mecanismo probado se conserva entero; el master-prompt se simplifica en vez de crecer | Es la intervención más grande; toca el marco teórico, la guía de usuario y el master-prompt |

**Esta sección quedó superada por §4.8 y se conserva como registro del camino recorrido.** Las tres
opciones comparten un supuesto que resultó falso: que la base vive **dentro** de `IA.SDD`. Con la base
afuera, la pregunta «un catálogo nuevo o la generalización del que existe» se disuelve, porque no hay
catálogo nuevo dentro del framework que gobernar: el framework aporta el formato y el contrato del
índice, y nada más (§5.1). `References/Design/` y `Modelos-UX-UI/` **se quedan exactamente donde
están**, y el reencuadre que la opción C proponía **se retira del plan**.

Lo que sí sobrevive de esta sección es la objeción a la opción B, y conviene retenerla: meter
conocimiento de la casa en `References/Design/` rompe su propósito declarado de «insumo normativo de la
categoría 03» (`Index-Design-Rules.md` §1) y confunde el piso mínimo del framework con la variante de
una organización, que es justamente la distinción que §4.9 escribe.

### 4.4 Cómo entra el conocimiento: el prompt de captura

El contexto lo pide explícitamente: «un prompt base en el que al citarlo se le pueda pedir caracterizar
o relevar tal o cual proyecto». Hay dos ubicaciones posibles y no son equivalentes.

`README.md` del framework declara el modelo de tres repositorios y es taxativo: el `Framework SDD`
«nunca se toca durante una corrida normal», con **una sola excepción**, la captura de la Fase B2, que
«requiere aceptación explícita del humano y la verificación de ofuscación es bloqueante».

- **Si la captura se hace desde una corrida**, hay que abrir una **segunda excepción** al modelo de tres
  repositorios. Es caro y debilita la regla más protectora del método.
- **Si la captura es una intervención fuera de banda** —un tool-prompt que el usuario ejecuta apuntando a
  un proyecto existente, que produce el documento y lo incorpora con su nota de coherencia— **no se abre
  ninguna excepción**. Es el mismo camino por el que se incorporó el arquetipo de panel monolítico
  (`Coherencia-Panel-Monolitico.md`), que fue una intervención sobre el framework, no un paso de una
  corrida.

**Propuesta: fuera de banda.** El prompt de captura vive en la documentación de prompts del usuario y
opera como intervención sobre el framework, con las obligaciones que ya rigen para toda intervención:
nota de coherencia, entrada de CHANGELOG y copia a `_legacy/` (`README.md`, reglas de intervención).

**Sobre la compuerta de ofuscación, y acá §4.8 corrige lo que esta sección proponía**: la captura hacia
la base propia de la organización **no la ejecuta**, porque esa base es privada y D7 no la alcanza. La
compuerta se conserva entera, pero **se mueve al único momento en que hay algo que proteger**: la
promoción de un documento al catálogo público del framework. Ahí vuelve a regir, con la verificación
por búsqueda de términos del dominio y del stack de origen y los falsos positivos declarados, que ya
tiene precedente ejecutado en `Coherencia-Panel-Monolitico.md` §3.

### 4.5 Cómo se cita: el hueco del intake

El contexto pide «especificar en la documentación intake qué metodología o conocimiento se pretende
aplicar». Hoy **ese hueco no existe**. `PRODUCT-INTAKE-template.md` tiene 21 secciones y ninguna lo
cubre; lo más cercano es §17.P.11 «Decisiones técnicas pre-tomadas (pre-ADR)», que es otra cosa.

Hay dos vías de cita y conviene tener las dos:

1. **Cita implícita por condición**, que es como funciona hoy: el índice declara la condición y el
   orquestador la evalúa contra el intake y el tipo D8. No requiere que el usuario sepa que el catálogo
   existe. Es el camino por defecto y **no debe perderse**.
2. **Cita explícita por el usuario**, que es lo que el contexto agrega: una subsección nueva del intake
   donde se nombran los documentos de conocimiento a aplicar. Fuerza la carga aunque la condición no
   dispare, y deja registro de intención de producto.

**Propuesta: las dos, con la explícita ganando sobre la implícita**, y con dos reglas que evitan los
dos modos de falla obvios: nombrar un documento inexistente es **error bloqueante de validación de
intake** —igual que las validaciones de `Intake-Rules.md`—, y el conjunto efectivamente cargado se
registra en el log del orquestador, porque si no queda trazado, la corrida no se puede auditar contra
lo que declaró.

Atención al costo: tocar la plantilla de intake tiene una consecuencia declarada en `README.md`, en las
reglas de intervención: la versión del conjunto normativo «se deriva de la mayor severidad de sus
partes: **major** si alguna regla **o alguna plantilla de intake** sube major». Ver §6.

### 4.6 Identificadores, versionado y archivo

Tres detalles chicos que, si no se deciden, se deciden solos y mal.

**Identificadores.** `Root-Rules.md` §9.2 fija cinco dígitos y enumera las familias alcanzadas: las que
catalogan elementos de un producto, más `AG` del conjunto normativo. Los documentos de
`References/Design/` **no llevan identificador**: se nombran por archivo. La opción de acuñar una familia
nueva —`BC-00001` y siguientes— obliga a tocar `Root-Rules.md` §9, que es alcance transversal, a cambio
de nada que el nombre de archivo no dé ya. **Propuesta: sin familia nueva. Nomenclatura por nombre
lógico**, `Knowledge-<Tema>.md` en Título-Con-Guiones, agnóstico del dominio de origen, con la misma
regla que `Index-Modelos-UX-UI.md` §3 aplica a los modelos.

Queda un cabo: el contexto habla de «documentos numerados». Si lo que se busca es orden de lectura
dentro de un tema, se resuelve con la tabla del índice, no con prefijos numéricos en el nombre, que
envejecen mal al insertar un documento intermedio.

**Versionado.** Rigen D4 y D5 sin excepción: nombre lógico estable, versión en la cabecera, una sola
versión vigente por nombre, copia completa a `_legacy/` antes de sobrescribir.

**Archivo.** El problema es real —un destino generado con conocimiento cargado no se reconstruye sin
él, que es la propiedad que `README.md` le atribuye a `_legacy/`— y con la base anexada **se resuelve
solo**: `Conocimiento/` **entra en el snapshot**, por el criterio de `SDD-Development-Guide.md` §VI.5,
que sólo excluye lo que no condiciona lo que el orquestador genera. El precedente es `Templates/`.
Un destino que declara con qué versión del framework se generó **ya declara con qué conocimiento**.

Este plan sostuvo lo contrario hasta la 2.1, apoyándose en la exclusión de `Examples/`. Era mala
analogía: `Examples/` es material ilustrativo que no entra a ningún despacho.

---

### 4.7 El bibliotecario: qué figura sí, y con qué contrato

**Esta sección revisa la posición que este documento sostenía hasta la 1.6.** El rechazo anterior era
correcto sobre una figura y equivocado sobre la otra, y la distinción la aporta la propia metáfora del
PO: *«una persona necesita ejecutar un procedimiento, sabe el procedimiento base, pero si es más
específico recurre a un bibliotecario y le solicita tal o cual tema y este le provee el libro
adecuado.»*

**Un bibliotecario entrega el libro. No lo lee por vos, no te lo resume, no te cuenta lo que dice.** Ahí
está toda la diferencia, y es la que separa dos figuras que yo había tratado como una sola:

| | **Bibliotecario que resume** | **Bibliotecario que entrega** |
|---|---|---|
| Qué devuelve | Extractos, síntesis, «lo relevante» | **Identificadores**: uno o más alias del índice |
| Quién provee el contenido | Él mismo, parafraseado | El orquestador, **verbatim** |
| Segunda fuente | **Sí.** Es lo que `Master-Prompt.md` §6 punto 1 prohíbe por nombre | **No.** El documento llega intacto |
| Reproducibilidad | Rota: la síntesis no se repite igual | Preservada: pedido y alias resueltos van al log |
| Veredicto | **Rechazado** | **Adoptado** |

Con el segundo contrato, las cuatro objeciones que sostenían el rechazo se caen o se acotan: no hay
paráfrasis, de modo que no hay segunda fuente; el despacho sigue siendo reconstruible porque se registra
qué se pidió y qué alias salieron; el conjunto entregado es un **subconjunto de un catálogo declarado**,
no una construcción libre; y el costo se paga solo cuando hace falta, no en cada despacho.

#### 4.7.1 El rol y su contrato

**AG-00980 — Bibliotecario de conocimiento**, en el bloque `009xx` que `Root-Rules.md` §9.2 reserva a
los roles que no son de categoría. El framework ya tiene el precedente estructural en AG-00031, el
subagente de fase de la B2 con su propio archivo de reglas.

| | |
|---|---|
| **Entrada** | La necesidad en prosa, tal como el subagente la escribió; el índice de la base declarada en el intake, filtrado por consumidor; el tipo D8 y los flags del proyecto de código |
| **Salida** | Una lista de **alias**, cada uno con una línea de fundamento. O vacía, que es una respuesta legítima y hay que declararla como tal |
| **Prohibido** | Devolver texto de los documentos. Proponer un alias que no esté en el índice. Escribir en ningún lado |
| **Quién entrega** | El **orquestador**, que resuelve alias a path e inyecta el documento entero en el despacho de reanudación |
| **Registro** | Pedido y respuesta completos al log del orquestador, que es lo que mantiene la corrida auditable |

Las dos prohibiciones del medio son las que hacen seguro al rol. **No devolver texto** elimina la
paráfrasis. **No proponer fuera del índice** lo vuelve una selección sobre un conjunto cerrado, que es
la misma disciplina con que D8 acota los tipos de proyecto de código: un agente que elige dentro de un
conjunto declarado no deriva, elige.

#### 4.7.2 Cuándo se lo llama, y qué lleva el despacho

**No se lo llama siempre.** El caso común lo sigue resolviendo la inyección por condición y por cita del
intake, que es determinista y gratis. El bibliotecario atiende **el caso que esa vía no cubre**: el
subagente que necesita algo específico y no lo tiene.

Con eso, el despacho **no necesita llevar el índice**. Lleva una línea:

> Existe una base de conocimiento declarada para este producto. Si para resolver tu entregable necesitás
> un procedimiento o una convención específica que tus insumos no cubren, no la inventes ni la busques:
> pedila con el bloque de §9, describiendo la necesidad en tus términos.

Es la metáfora entera y es más barata que cualquier alternativa: el que va a la biblioteca **no lleva
el catálogo encima**, lleva la necesidad. El subagente no carga «todas las formas posibles» ni el índice
de todas ellas; carga la conciencia de que la biblioteca existe.

La secuencia queda:

| Paso | Quién | Qué |
|---|---|---|
| 1 | Subagente | Detecta que le falta un procedimiento específico y se detiene con el bloque de `Master-Prompt.md` §9, con la necesidad en «Qué se necesita» |
| 2 | Orquestador | Despacha a AG-00980 con la necesidad y el índice filtrado |
| 3 | AG-00980 | Devuelve los alias que corresponden, con fundamento. O ninguno |
| 4 | Orquestador | Resuelve alias a path, registra, y **reanuda** el despacho con los documentos sumados enteros, según §9 punto 6 |
| 5 | Subagente | Sigue, con el conocimiento en su lista de insumos |

Si el paso 3 vuelve vacío, la detención escala al humano como cualquier otra ambigüedad de §9. Es
correcto: significa que la base no tiene lo que hacía falta, y **eso es información**, no una falla.

#### 4.7.3 Dos propiedades que conviene aprovechar

**Cada llamada al bibliotecario es evidencia de una condición mal calibrada.** Si AG-00050 pidió el
patrón de acceso a datos de la casa, esa era una condición que el índice debería haber disparado sola.
El catálogo se afina con su propio uso en lugar de con opinión.

**Y el pedido en prosa es más barato que el índice viajando.** El costo deja de crecer con el tamaño del
catálogo: crece con la frecuencia con que un subagente se queda corto, que es lo que se quiere que
tienda a cero a medida que las condiciones se afinan.

#### 4.7.4 Dónde el que busca de verdad sigue estando

Todo lo anterior es del lado del **consumo**, y ahí el bibliotecario no busca: **selecciona sobre un
catálogo declarado**. El agente que busca de verdad —abre un proyecto real, lo recorre, explora— es el
de **captura** de §5.6, y puede hacerlo porque corre fuera de una corrida de generación, su salida pasa
por aceptación humana y produce un artefacto durable en vez de una inyección en runtime.

La simetría a escribir en el archivo de reglas se mantiene, con el matiz que esta revisión agrega:
**se busca al escribir, se selecciona al pedir, se cita al leer.**

### 4.8 Dónde vive la base: una carpeta anexa del framework

**Esta sección se reescribió dos veces y conviene dejar las dos correcciones a la vista, porque el
error del medio es instructivo.** La 1.0 la ponía como subárbol normativo de `IA.SDD`. La 1.5 la sacó
afuera, como cuarto rol de repositorio propiedad de la organización. **Las dos estaban mal, y por el
mismo motivo: confundían el desacoplamiento con la ubicación.**

La versión correcta es `Conocimiento/`, **carpeta anexa del framework**, y el argumento que decide es
operativo: `IA.SDD` es el repositorio **desde el que se lanza** el orquestador. La base tiene que viajar
con lo que se clona, no ser alcanzada.

#### Qué es el desacoplamiento, entonces

No es privacidad. No es ubicación. Es esto, y hay que poder verificarlo:

> **El framework corre con `Conocimiento/` vacía, y su comportamiento base no cambia cuando se llena.**

Lo que lo sostiene es que **ninguna regla nombra un documento de conocimiento**. Lo único que el
framework fija es el formato y el contrato del índice. De ahí que agregar conocimiento **no toque una
sola regla**, que es la definición operativa de «no desfigurar la esencia del SDD».

| | El conjunto normativo | `Conocimiento/` |
|---|---|---|
| Qué es | Reglas, plantillas, orquestadores | Documentos que se consultan |
| Se puede vaciar | No. Sin él no hay método | **Sí.** El framework corre igual |
| Cómo se extiende | Interviniendo el framework | **Agregando documentos** |

**El mecanismo de distribución es el fork.** Quien quiera su propia base forkea, agrega sus documentos y
se lleva el método intacto. No hay segunda raíz que declarar, ni ruta que configurar, ni repositorio
ajeno que alcanzar.

#### Lo que esta ubicación elimina del diseño

Y es bastante, todo peso muerto que las versiones anteriores cargaban:

| Lo que hacía falta con la base afuera | Con la base anexada |
|---|---|
| Un cuarto rol de repositorio | No existe |
| Declarar la raíz de la base en el intake | No se declara |
| Declarar una identidad de versión de la base | **Es la del framework** |
| Un rodeo para no romper la autosuficiencia de `README.md` | El framework referencia su propia carpeta |
| Un criterio propio de reconstrucción | El de siempre: `_legacy/` |

El intake **cita alias, y nada más**.

#### Tres consecuencias que invierten lo que este plan decía

1. **Una captura es una intervención sobre el framework.** Escribe en su repositorio, así que lleva
   entrada en el `CHANGELOG.md`, copia del conjunto superado a `_legacy/` y nota de coherencia si
   alcanza a varios archivos. Las versiones anteriores decían lo contrario.
2. **`Conocimiento/` entra en el snapshot.** `SDD-Development-Guide.md` §VI.5 sólo excluye del snapshot
   lo que **no condiciona lo que el orquestador genera**, y un documento cargado sí lo condiciona. El
   precedente exacto es `Templates/`; `Examples/` **no servía de analogía** y este plan se apoyaba en él.
   La consecuencia es la buena: un destino que declara con qué versión del framework se generó **ya
   declara con qué conocimiento**.
3. **La compuerta de ofuscación corre y es bloqueante.** `IA.SDD` es público —`Maqueta-Rules.md` §310 e
   `Index-Modelos-UX-UI.md` §61 lo declaran—, de modo que ningún documento puede llevar nombres de
   clientes, datos reales ni assets del proyecto de origen. Un fork privado puede guardar lo que quiera
   en su carpeta; este repositorio, no.

**Y una que se conserva**: `References/Design/` y `Modelos-UX-UI/` se quedan donde están. Son material
del método, neutros por construcción, y no se mezclan con el catálogo de oficio.


### 4.9 Método y oficio: el piso mínimo que el framework conserva

Esta sección se agrega a pedido del PO y ordena todo lo anterior, porque nombra la distinción que el
resto del documento venía usando sin decirla.

**El SDD está fundado en metodologías ágiles y gestión** —cómo se especifica, cómo se descompone, cómo
se audita, cómo se planifica—. Su identidad es el proceso. Lo que casi no tiene, y por buenas razones de
diseño, es **oficio**: cómo se codea esto o aquello, según la casa. Y no puede tenerlo en general,
porque el momento en que el framework opine sobre cómo estructurar tu capa de datos, deja de servirle a
la organización de al lado. La base desacoplada es la única forma de que esa capa exista sin comprometer
la neutralidad que hace al framework reutilizable. **El framework aporta el método; la base, el oficio;
y el intake es donde se encuentran.**

#### El piso mínimo, y por qué no se toca

De lo anterior **no** se sigue que el framework deba quedarse con cero oficio, y el PO lo pidió
explícito: el framework conserva, tal como está hoy, un conocimiento mínimo de cómo estructurar código y
cosas por el estilo. Ese piso ya existe y tiene nombre:

| Piso mínimo del framework | Dónde vive hoy | Qué es |
|---|---|---|
| Diseño de interfaz | `References/Design/`, base más especializaciones y extensiones | **Insumo normativo** de la 03, obligatorio cuando su condición dispara (`Index-Design-Rules.md` §1) |
| Modelos capturados de la práctica | `Modelos-UX-UI/` | Opcional, elegido por el humano en la Fase B2 |
| Arquitectura, persistencia, pruebas, entrega | Los archivos de reglas de las categorías 02, 05, 08, 09 | Criterios de aceptación y estructura de los artefactos que el framework genera |

Los tres son **neutros por construcción** y por eso pueden vivir dentro de un repositorio público sin
acoplarlo a nadie. Son el equivalente del procedimiento base de la metáfora del PO: lo que la persona ya
sabe antes de ir a la biblioteca.

#### La regla de composición, que es la parte operativa

De acá sale una regla que hay que escribir en `Rules-Base-Conocimiento.md`, porque sin ella el mecanismo
degenera en cualquiera de las dos direcciones:

> **La base de la organización se apila sobre el piso mínimo del framework; no lo reemplaza.** Un
> documento de conocimiento que contradice el piso declara la desviación con su justificación, del mismo
> modo que una especialización por stack documenta la limitación técnica que la obliga a apartarse del
> base (`Index-Design-Rules.md` §4). Un documento que **borra** el piso sin declarar nada es un
> anti-patrón, y es el mismo que §4.2 marca cuando el conocimiento se disfraza de regla.

##### El piso tiene dos capas, y sólo una es desplazable

La regla anterior, sola, no alcanza —y el caso de §2.5 es el que lo demuestra—. Una casa que construye
con proceso de build contradice `Maqueta-Rules.md` §7 **en cada corrida**, no excepcionalmente. Y una
desviación que se declara siempre no es una desviación: **es una regla mal ubicada**. Si el mecanismo se
apoyara sólo en «declarar el apartamiento», la base se convertiría en una fábrica de ADR que registran
lo mismo una y otra vez, que es el anti-patrón que `Root-Rules.md` §11 nombra por su cuenta.

La salida es distinguir dos capas dentro del piso mínimo:

| Capa | Qué es | Ejemplos verificables hoy | ¿La base puede desplazarla? |
|---|---|---|---|
| **Método** | Criterio de aceptación del artefacto. Es lo que hace que el entregable sirva, independientemente de con qué se lo construya | Toda superficie demuestra los estados vacío, cargando, con datos y error; WCAG 2.2 AA como piso verificable; datos de ejemplo en una fuente única; íconos vectoriales con `currentColor` (`Maqueta-Rules.md` §4) | **No.** Desplazarlo es bajar la calidad, no adaptarla |
| **Decisión de stack** | Una elección razonada entre alternativas legítimas. Es del framework porque alguien tenía que elegir, no porque sea la única correcta | JavaScript vanilla; Bootstrap 5.0 por CDN; sin proceso de build ni gestor de paquetes (`Maqueta-Rules.md` §4 y §7) | **Sí**, declarando qué se adopta en su lugar. Es sustitución, no desviación |

**Hoy las dos capas viven mezcladas en el mismo párrafo de `Maqueta-Rules.md` §4**, y eso es lo que
vuelve imposible aportar una variante sin editar el framework. Separarlas es lo que convierte a la base
en un punto de extensión real. **La separación es trabajo sobre el framework y forma parte de esta
intervención**: no basta con que la base pueda declarar, tiene que haber algo del otro lado que declare
qué es desplazable.

Con eso, la base tiene **tres modos de aportar** y no dos, que es lo que este documento venía asumiendo:

| Modo | Qué hace | Ejemplo |
|---|---|---|
| **Sumar** | Aporta conocimiento sobre algo que el framework no cubre | Una convención de nomenclatura de base de datos |
| **Especializar** | Concreta un documento del piso para una casa, con `hereda-de` | La variante de DAO de la casa sobre el patrón canónico |
| **Sustituir** | Reemplaza una **decisión de stack** declarada del piso, y sólo esas | Construir con componentes y build en vez de vanilla + CDN |

La sustitución es la que faltaba nombrar, es la que el caso de §2.5 exige, y **es la única de las tres
que tiene un límite duro**: alcanza a la capa de decisión de stack y nunca a la de método.

Las dos direcciones en que degenera, si la regla no está escrita:

- **Sin piso**: el framework deja de ser funcional por sí solo. Contradice la premisa que el PO fijó de
  entrada —la identidad y el comportamiento actuales se conservan— y convierte una capacidad opcional en
  un requisito.
- **Sin techo**: la base se vuelve un segundo conjunto normativo que compite con el primero, y el
  framework queda con dos fuentes de verdad sobre lo mismo, que es exactamente lo que `Master-Prompt.md`
  §6 punto 1 prohíbe por nombre.

#### Dónde se nota, y sirve como chequeo de cordura

Las categorías que van a citar conocimiento son las de salida técnica: **02, 03, 05, 08, 09 y 11**. Las
de gestión —06 planificación, 07 backlog— casi no lo van a hacer, porque ahí el framework ya es fuerte y
el oficio no aporta. Es un chequeo barato: **si alguien empieza a escribir un documento de conocimiento
para la 07, lo más probable es que esté escribiendo una regla en el lugar equivocado.**

---

## 5. Propuesta de materialización

### 5.1 Lo que se agrega al framework

Un archivo de reglas y una carpeta. Nada más:

```
SDD/Devs/Rules/
  Rules-Base-Conocimiento.md      formato del documento, contrato del índice, relevamiento, AG-00980
Conocimiento/
  README.md                       qué es la carpeta y la propiedad que hay que preservar
  Index-Knowledge.md              el índice: alias, naturaleza, consumidor, condición de carga, estado
  Knowledge-<Tema>.md             un documento por artefacto o convención caracterizada
```

`Conocimiento/` **no es parte del conjunto normativo**: es una carpeta anexa. La distinción no es
formal. El conjunto normativo no se puede vaciar sin quedarse sin método; `Conocimiento/` sí, y el
framework corre igual.


### 5.2 El índice, y por qué es el corazón del diseño

`Index-Knowledge.md` es el único lugar donde se declara qué existe y cuándo se carga. Su tabla de
catálogo lleva, por documento: nombre de archivo, **alias citable**, naturaleza (`canonico` o `propio`),
tema, **consumidor** —la categoría de 00 a 11, `transversal`, o **un subagente de fase**—, **condición
de carga** (expresada contra campos del intake, flags o tipo D8), `hereda-de` si aplica, **`sustituye`**
si aplica, `compatible-con` y estado.

Dos de esos campos son de esta revisión y cierran huecos que el mecanismo tenía abiertos:

- **`sustituye`** nombra el ítem del piso que el documento reemplaza, con la referencia literal —por
  ejemplo `Maqueta-Rules.md §4.1 · tecnología de construcción`—. Es lo que la validación de intake
  comprueba contra las etiquetas del framework (§4.2, §4.9). Sin este campo la sustitución no se puede
  validar y quedaba declarada pero inejecutable.
- **El consumidor admite subagentes de fase, no sólo categorías.** Es un hueco real y lo destapa el
  propio caso de §2.5: quien construye la maqueta es **AG-00031**, el subagente de la Fase B2, y sus
  insumos están enumerados en `Maqueta-Rules.md` §1 —«02, 03, 00, el catálogo de diseño de
  `References/Design/` y el catálogo de modelos UX-UI de `Modelos-UX-UI/`»—, una lista cerrada donde la
  base **no figura**. Con el consumidor limitado a las doce categorías, el conocimiento sobre cómo
  construir una página web **nunca llegaría al agente que construye la página**.

El **alias** es la pieza que el planteo pide para poder decir «quiero usar tal template»: un nombre
corto y estable, desacoplado del nombre de archivo, que es lo que el intake cita. Desacoplarlos importa
porque un archivo se puede renombrar en una migración y la cita del intake de un producto ya generado
no debería romperse por eso.

#### 5.2.1 Cómo se nombra el conocimiento, y por qué el nombre decide el contenido

**El alias es el nombre establecido de la cosa, cuando la cosa tiene nombre establecido.**
`Clean-Architecture`, `Patron-DAO`, `Patron-Repository`, `CQRS`, `Atomic-Design`. No `Arquitectura-V2`
ni `Template-1`. Un nombre canónico se entiende sin abrir el documento, que es la mitad del trabajo que
un índice tiene que hacer.

De ahí sale una distinción que **no es de nomenclatura sino de contenido**, y es la de mayor impacto en
el costo del catálogo:

| | **Conocimiento canónico** | **Conocimiento propio** |
|---|---|---|
| Ejemplos | DAO, Clean Architecture, CQRS, Repository, Atomic Design | Este template HTML, la nomenclatura de base de datos de la casa, el asistente de formularios propio |
| Nombre | Ya existe. Se adopta, no se inventa | Hay que acuñarlo |
| Qué sabe el agente de antemano | **Mucho.** Es literatura pública y consolidada | **Nada** |
| Qué escribe el documento | **El delta**: qué variante se adopta, qué convenciones locales rigen, qué decisiones ya están tomadas, qué anti-patrones se vieron acá | **Todo**: identidad, estructura, contrato de uso, esqueletos |
| Tamaño esperado | Corto | El que el artefacto necesite, bajo el techo de §4.1 |

**Un documento que reexplica qué es el patrón DAO es exactamente el desperdicio que el planteo quiere
evitar.** El framework ya tiene el instinto escrito para otro caso: `README.md`, en autosuficiencia,
manda que «los estándares de industria **se nombran, no se enlazan**». Acá aplica igual: se nombran, no
se reexplican. Lo que el documento aporta es lo que el nombre **no** dice.

Por eso el índice lleva un campo **naturaleza**, con dos valores, `canonico` y `propio`: es lo que
permite que `Rules-Base-Conocimiento.md` §6 exija un techo de tamaño distinto para cada uno y que la
auditoría pueda marcar como hallazgo un documento canónico que se puso a explicar el canon.

**Tres reglas de nomenclatura para el archivo de reglas §3:**

1. **Forma**: Título-Con-Guiones en ASCII, sin acentos ni eñes, por D3. `Patron-DAO`, no `Patrón DAO`.
2. **Unicidad**: el alias es único **en el índice de la base que lo declara**, y no en el conjunto
   normativo del framework —la base vive afuera (§4.8), de modo que el ámbito que `Root-Rules.md` §9.1
   le da a la familia `AG` no la alcanza—. Dos variantes del mismo canon conviven con alias distintos,
   nunca con el mismo. **Regla de colisión con el framework**: si un alias de la base coincide con el
   nombre de un documento del catálogo de diseño, el documento de la base declara `hereda-de` y se
   resuelve como especialización; si no lo declara, la validación de intake lo rechaza, porque un mismo
   nombre resolviendo a dos documentos es el defecto que el alias existe para evitar.
3. **Honestidad del nombre**: si lo caracterizado se aparta materialmente de lo que el nombre canónico
   designa, **el alias lo dice** —`Clean-Architecture-Simplificada`— o el §0 del documento declara la
   desviación. Un alias canónico sobre contenido que no lo es engaña al que cita sin abrir, que es
   justamente el lector al que el alias sirve. Es la misma disciplina que `Vocabulario-Rules.md` §9
   aplica a las palabras con más de un sentido.

La regla de nombre agnóstico del dominio de origen que `Index-Modelos-UX-UI.md` §3 ya fija sigue
rigiendo y se apila sobre estas tres: `Panel-Operativo-Denso` sí, `Panel-Cliente-Acme` no.

Es lo que permite que el master-prompt lleve **una** nota genérica en lugar de una por documento, y por
lo tanto es lo que hace que el catálogo escale sin tocar archivos de alcance global.

### 5.3 El archivo de reglas, no una plantilla suelta

Acá la propuesta cambia respecto de un borrador previo de este documento, y el cambio lo aporta el
planteo: lo que gobierna el catálogo tiene que ser **un archivo de reglas bajo el patrón de los
dieciocho existentes**, no una plantilla de redacción aislada.

`Rules-Base-Conocimiento.md`, en `SDD/Devs/Rules/`, con la estructura que `Root-Rules.md` y las reglas
de categoría ya usan. La razón es que ese patrón trae, ya resueltas, las cuatro piezas que el prompt de
captura necesita citar:

| Sección del archivo de reglas | Qué aporta al prompt de captura |
|---|---|
| §1 Especialidad asignada | El rol con que el agente releva el artefacto. Distinto para un template de UI que para un esquema de datos |
| §2 Documentos que produce | Qué emite una captura: el documento, su fila en el índice, y el artefacto de referencia si corresponde |
| §3 Nomenclatura y vinculación | `Knowledge-<Tema>.md`, el alias citable y la trazabilidad hacia el índice |
| **§4 Estructura de redacción** | La plantilla propiamente dicha: cabecera obligatoria, secciones obligatorias y opcionales, tablas tipo, anti-patrones. Es donde viven las siete propiedades de §4.1 |
| **§5 Preguntas guía** | **Las tareas de relevamiento**: qué tiene que averiguar el agente sobre el artefacto antes de escribir |
| **§6 Criterios de aceptación** | El auto-chequeo que el prompt de captura corre antes de devolver, incluido el techo de tamaño y la verificación de ofuscación |
| **§8 Prompt-snippet** | El bloque que el prompt de captura **cita literalmente** en lugar de reescribirlo |

Es exactamente el mecanismo que el planteo describe —«esas reglas contenidas en un documento markdown
lo podría citar como reglas desde un prompt»— y es el mismo que `Master-Prompt.md` §6 ya usa para todas
las categorías: el orquestador copia §1, §2, §3, §4, §5, §6 y §8 del archivo de reglas y arma el
despacho. Un prompt de captura que cite `Rules-Base-Conocimiento.md` hereda esa mecánica entera sin
inventar nada.

**Estructura de §4, la plantilla del documento de conocimiento:**

| Sección | Contenido |
|---|---|
| Cabecera | Framework, documento, versión, estado, fecha, autor, **alias citable**, naturaleza, consumidor, condición de carga, `hereda-de`, `sustituye` |
| §0 Propósito y alcance | Qué artefacto caracteriza, qué queda explícitamente afuera y en qué categoría vive lo que queda afuera |
| §1 Identidad del artefacto | Qué es, de qué tipo, sobre qué stack, con qué supuestos |
| §2 Estructura | Cómo está compuesto: layout de archivos, piezas y su rol |
| §3 Contrato de uso | Variables, puntos de extensión, convenciones que hay que respetar para no romperlo |
| §4 Decisiones ya tomadas | Las bifurcaciones que el artefacto resolvió, con el criterio de cada una |
| §5 Esqueletos de referencia | Lo mínimo reproducible |
| §6 Criterios de aceptación | Cómo se verifica que el conocimiento se aplicó bien |
| §7 Anti-patrones | Con su motivo |
| §8 Frontera con las reglas | Qué de este tema es normativo y vive en el archivo de reglas de su categoría |
| §9 Trazabilidad | Índice, documentos hermanos, consumidor, artefacto de referencia si lo hay |
| §10 Control de cambios | |

§8 es la sección que evita el modo de falla de §4.2 y no debería negociarse.

**El artefacto de referencia.** Cuando lo caracterizado es algo ejecutable —un template HTML es el caso
del planteo—, hay que decidir si el artefacto viaja con el framework o solo su caracterización. El
precedente existe y resuelve: `Index-Modelos-UX-UI.md` §4 manda tres escrituras en la misma operación,
documento en `Devs/`, **ejemplo ejecutable ofuscado en `Templates/`** y fila en el índice. La propuesta
es replicarlo, con la compuerta de ofuscación aplicando al artefacto con el mismo rigor que al
documento. Queda como decisión abierta en §8 por su costo en tamaño de repositorio.
### 5.4 El enganche en el master-prompt

**Se agrega una nota operativa. No se toca ninguna de las que están.** El catálogo de diseño de
`References/Design/` y `Conocimiento/` son **dos resoluciones distintas** y no se funden: el primero es
insumo normativo de la 03 y está siempre; el segundo es consultivo y puede estar vacío.

> Si `Conocimiento/Index-Knowledge.md` tiene filas, el orquestador lo abre, evalúa la condición de carga
> de cada una contra el intake, los flags y el tipo D8 del proyecto de código en curso, y suma los
> documentos que corresponden a la lista de insumos del despacho **del consumidor que el índice
> declara** —una categoría o un subagente de fase—. Además suma los citados explícitamente en el intake,
> hayan disparado o no por condición. El conjunto cargado se registra en el log. Los documentos de
> conocimiento son insumo consultivo: ante conflicto con el archivo de reglas de la categoría manda la
> regla, salvo sustitución declarada sobre un ítem rotulado como decisión de stack. **Con el índice sin
> filas esta nota no aplica y el despacho se arma exactamente como hoy.**

En `Master-Prompt.md` §8, el esqueleto de despacho suma `{{LISTA_DOCUMENTOS_DE_CONOCIMIENTO}}` a los
insumos obligatorios, que puede venir vacía. La prohibición de buscar fuera del scope queda intacta: el
conocimiento entra por la lista, no por búsqueda.

**Lo que queda fuera del alcance.** Las versiones anteriores proponían además reemplazar «las seis notas
operativas» de §6 por una genérica. El conteo era falso —son **once** notas, **cinco** mencionan el
catálogo de diseño y **cuatro** tienen esa forma— y el refactor es una mejora del catálogo propio del
framework, no de esta capacidad. Se registra como deuda en §8.3.


### 5.5 El enganche en el intake y la cadena de resolución

**Una sola declaración, y es la más simple que este plan tuvo.** Con la base anexada no hay raíz que
declarar ni identidad de versión que registrar: el intake **cita alias, y nada más**.

Subsección nueva `§17.P.13` al final del bloque repetible de la Parte C, por proyecto de código, con
tres campos: **alias citado**, motivo de la cita y alcance. Sin renumerar nada.

**El subagente no consulta: recibe.** `Master-Prompt.md` §8 le prohíbe buscar fuera de sus insumos, de
modo que la resolución del alias ocurre **entera en el orquestador**, antes del despacho:

| Paso | Quién | Qué hace |
|---|---|---|
| 1 | Humano | Escribe el alias en el intake, con su motivo |
| 2 | Orquestador, en la validación de intake | Resuelve el alias contra `Conocimiento/Index-Knowledge.md`. Si no existe, **bloqueante** |
| 3 | Orquestador, al planificar | Lee del índice el **consumidor** —categoría o subagente de fase— y lo asigna a ese despacho, no a todos |
| 4 | Orquestador, al despachar | Suma el path a `{{LISTA_DOCUMENTOS_DE_CONOCIMIENTO}}` y lo registra en el log |
| 5 | Subagente | Lo lee como un insumo más |

Tres consecuencias de diseño:

1. **El consumidor es lo que evita la inflación de contexto.** Sin él, un alias citado terminaría
   inyectado en los doce despachos. Admite lista, y admite **subagentes de fase**: sin eso, el
   conocimiento sobre cómo construir una página web no llegaría nunca a AG-00031, que es quien la
   construye.
2. **La validación va en la fase de validación de intake, no en runtime.** `Intake-Rules.md` §8 declara
   que esas reglas corren una sola vez antes de la Fase A. Un alias inexistente detectado ahí cuesta una
   corrección del intake; en la Fase B, cuesta la Fase A entera.
3. **Citar algo cuya condición no dispara no es conflicto y no lleva ADR.** La condición es un
   disparador por defecto, no una obligación. `Root-Rules.md` §11 no aplica —su propia cláusula advierte
   que «un apartamiento usado para evadir una condición que ya existe es un anti-patrón»—. El campo
   **motivo** alcanza como registro de intención.


### 5.6 El prompt de captura

Vive en la documentación de prompts del usuario, se ejecuta **fuera de una corrida de generación**, y
produce un documento de conocimiento a partir de un artefacto existente.

1. **Orientación**: qué se captura, de qué artefacto, para qué consumidor, y si es `canonico` o `propio`.
   **Bloqueante**: sin esto la captura produce un resumen del proyecto en lugar de conocimiento
   reutilizable, y el resultado *parece* válido, que es lo que lo vuelve el modo de falla más caro.
2. **Relevamiento**: recorre el artefacto según las preguntas guía del archivo de reglas.
3. **Composición con el piso**: si contradice algo que el framework fija, resuelve si es **sustitución**
   —el ítem está rotulado como decisión de stack— o **desviación justificada** —y entonces manda la
   regla—.
4. **Destilación**: redacta contra §4 del archivo de reglas, bajo el techo de tamaño de su §6.2.
5. **Verificación de ofuscación, bloqueante y previa**: búsqueda de términos del dominio, del cliente y
   del stack de origen, con los falsos positivos léxicos declarados uno por uno.
6. **Aceptación humana explícita**, antes de escribir.
7. **Alta**: documento, fila en `Conocimiento/Index-Knowledge.md`, y las obligaciones de toda
   intervención sobre el framework —`CHANGELOG.md`, copia a `_legacy/` y nota de coherencia si alcanza a
   varios archivos—.

**Los pasos 5 a 7 son la corrección que trajo anexar la carpeta.** Las versiones anteriores de este plan
los daban por innecesarios, con el argumento de que la base era privada y externa. No lo es: es pública
y vive en el repositorio del framework.

El paso 5 no es ceremonia. En su primera ejecución real **encontró dos nombres de entidad del proyecto
de origen** en el documento piloto.


## 6. Impacto normativo

| Archivo | Cambio | Severidad estimada |
|---|---|---|
| `SDD/Devs/Rules/Rules-Base-Conocimiento.md` | Nuevo. Archivo de reglas del catálogo, bajo el patrón de los existentes | — |
| `Conocimiento/` | Nueva. Carpeta anexa con su `README.md` y su `Index-Knowledge.md`. **No es parte del conjunto normativo**, y entra en el snapshot | — |
| `SDD/Devs/Orchestrator/Master-Prompt.md` | §6: **nota operativa nueva**, condicionada a que el índice tenga filas. Ninguna nota existente se toca. §8: línea nueva en el esqueleto de despacho, que puede venir vacía. §9 o sección nueva: el ciclo de pedido a AG-00980 | **Minor.** Los tres cambios son aditivos y sin base declarada el comportamiento es idéntico al actual |
| `SDD/Devs/Intake/PRODUCT-INTAKE-template.md` | `§17.P.13` al final del bloque repetible de la Parte C: alias citado, motivo y alcance. **Sin renumerar y sin sección de nivel producto**: con la base anexada no hay raíz ni versión que declarar | **Minor** |
| `SDD/Devs/Rules/Intake-Rules.md` | Validación de cita de conocimiento | Minor |
| `SDD/Devs/Rules/Maqueta-Rules.md` | §4: rotular **§4.1 Tecnología** como capa de decisión de stack y §4.2 a §4.6 como método, moviendo a método los dos ítems de §4.1 que no son tecnología (iconografía y autonomía sin backend). §1: sumar la base de conocimiento a los insumos de AG-00031, hoy lista cerrada | Minor. El texto de cada regla se conserva y las exigencias sobre una maqueta sin base declarada no cambian; dos ítems cambian de bloque |
| `SDD/Devs/Guides/Marco-Teorico-SDD.md` | §1.5 mapa de carpetas; sección nueva sobre la capa de conocimiento | Edición |
| `SDD/Guides/SDD-User-Guide.md` | §10.2 árbol del plano `Devs/` | Edición |
| `SDD/Guides/SDD-Development-Guide.md` | Eje de extensión nuevo: cómo se incorpora un documento de conocimiento | Minor |
| `SDD/Devs/Rules/Root-Rules.md` | §9.2: alta de **AG-00980** en la tabla de bloques de la familia `AG`. Verificado que el identificador está libre y que el bloque `009xx` hoy sólo nombra a `AG-00990`. **No** se acuña familia nueva de identificadores | Minor. Es una fila de tabla, y ningún documento generado deja de cumplir por ella; pero `Root-Rules.md` §9 declara alcance transversal y viaja en todo despacho, así que no es una edición cosmética |
| `README.md` (framework) | Anatomía del repositorio: fila de `Conocimiento/`, declarada como carpeta anexa | Edición |
| `CHANGELOG.md` + `_legacy/<version>/` | Obligatorio por la regla de publicación | — |

**La versión del conjunto la fija la plantilla de intake.** Por `README.md`, reglas de intervención: si
la plantilla sube major, el conjunto sube major. La forma de evitarlo es agregar la subsección **sin
renumerar** las existentes, y **la evidencia dice que se puede**: la plantilla ya tiene numeración no
monótona en orden de archivo —`§19 Checklist de completitud` aparece **después** de `§20` y de `§21`—,
de modo que agregar `§17.P.13` al final del bloque repetible no rompe ninguna convención que la
plantilla sostenga hoy. **La intervención es minor.**

**Nota sobre el estado de ejecución.** Los dos primeros archivos de esta tabla **ya están aplicados**:
el framework publicó `Rules-Base-Conocimiento.md` y `Conocimiento/` en su **13.0**. El resto es el
Bloque II, todavía sin ejecutar.

Toda la intervención alcanza a varios archivos, de modo que **emite nota de coherencia** siguiendo
`Coherencia-Auditoria-Marco.md`, con alcance, inventario, verificación de invariantes, trazabilidad,
observaciones y veredicto.

---

## 7. Riesgos e implicancias

| Riesgo | Por qué es real | Mitigación propuesta |
|---|---|---|
| **Sustitución tácita** | Un documento que reemplaza una decisión del piso sin declararlo en el índice pasaría inadvertido, y el subagente aplicaría la variante creyendo que aplica el piso | El campo **`sustituye`** es obligatorio para sustituir, y la validación de intake lo comprueba contra las etiquetas del framework. Sin etiqueta no hay sustitución: el caso vuelve a ser conflicto y manda la regla (§4.2) |
| **La sustitución se desborda hacia el método** | Una casa que puede reemplazar el stack va a intentar reemplazar también criterios de aceptación, porque desde afuera las dos cosas se leen igual: «así trabajamos acá» | La separación en dos capas de `Maqueta-Rules.md` §4 hace la frontera **explícita y verificable**: la validación de intake sólo admite sustitución sobre lo etiquetado como decisión de stack (§4.9) |
| **La base borra el piso mínimo** | Un documento de la casa que redefine en silencio lo que `References/Design/` o una regla de categoría ya fijan deja al framework con dos fuentes de verdad sobre lo mismo | Regla de composición de §4.9 escrita en `Rules-Base-Conocimiento.md` §0: se apila, no reemplaza; la contradicción se declara como desviación justificada |
| **El conocimiento se disfraza de regla** | Un documento que declara criterios de aceptación desplaza en la práctica al archivo de reglas, sin haber pasado por su gobierno | §8 obligatoria en la estructura de documento; anti-patrón declarado; regla de subordinación explícita (§4.2) |
| **Detenciones por conflicto** | `Root-Rules.md` §13 no decide entre dos reglas que no viajan, y detiene | La regla de subordinación da resolución en el árbol y saca el caso de §13 |
| **Contaminación de dominio** | `IA.SDD` es público y la captura opera sobre proyectos reales. **El riesgo es permanente, no eventual** | Compuerta de ofuscación **bloqueante y previa a toda captura**, con búsqueda de términos del dominio, del cliente y del stack de origen y los falsos positivos léxicos declarados uno por uno. **Ya encontró material real en su primera corrida** |
| **El subagente no sabe qué existe** | Con condiciones gruesas, o se inyecta de más y se infla el contexto, o de menos y el subagente trabaja sin conocimiento disponible | El despacho avisa que la base existe; lo que falte se pide por detención de `Master-Prompt.md` §9 y lo resuelve AG-00980 devolviendo alias, nunca texto. Cada pedido recalibra una condición (§4.7) |
| **Inflación de contexto** | Un despacho que carga base + especialización + cuatro capacidades + conocimiento puede volverse enorme | Índice liviano primero; condición de carga estricta; documentos de tema único y acotado |
| **Catálogo que nadie cita** | Ya pasó: `Modelos-UX-UI/` está vacío desde su incorporación en la 5.1 | Carga por condición además de por cita explícita, para que el conocimiento se aplique sin que el usuario tenga que saber que existe |
| **Deriva de la base respecto del framework** | Un documento escrito contra una versión vieja de `Rules-Base-Conocimiento.md` queda mintiendo | **Con la base anexada el barrido por concepto de `SDD-Development-Guide.md` §VI.3.1 sí la alcanza**, porque recorre el árbol del repositorio y la carpeta está adentro. El campo `compatible-con` del índice deja además el dato declarado y comparable |
| **Reconstrucción rota** | Un destino generado con conocimiento cargado no se reconstruye si no se sabe con qué conocimiento se generó | **Resuelto sin mecanismo nuevo**: `Conocimiento/` entra en `_legacy/<version>/`, de modo que la versión del framework ya identifica el conocimiento. El log del orquestador registra además qué se cargó en cada despacho (§4.6, §4.8) |

---

## 8. Decisiones cerradas, abiertas y deuda declarada

### 8.1 Cerradas, para que no se reabran sin motivo

| # | Decisión | Dónde |
|---|---|---|
| 1 | La base es **`Conocimiento/`, carpeta anexa del framework**, y el desacoplamiento es que **el framework corre con ella vacía**. El mecanismo de extensión es el **fork** | §4.8 |
| 2 | **La compuerta de ofuscación corre y es bloqueante** en toda captura: el repositorio es público | §4.8, §5.6 |
| 3 | **`Conocimiento/` entra en `_legacy/`**, por el criterio de §VI.5 y el precedente de `Templates/`. El intake **no declara raíz ni versión de base** | §4.6, §4.8 |
| 4 | `References/Design/` y `Modelos-UX-UI/` **se quedan donde están**; el reencuadre se retira | §4.3, §4.8 |
| 5 | El bibliotecario **se adopta con el contrato de entrega**, no de resumen | §4.7 |
| 6 | El framework **conserva su piso mínimo de oficio** y la base se apila sobre él, no lo reemplaza | §4.9 |
| 7 | **La plantilla de intake se amplía sin renumerar**, de modo que la intervención es **minor** | §6 |
| 8 | Los dos catálogos —diseño del framework y base de la organización— **se resuelven por separado** | §5.4, §II.2 |
| 9 | El piso mínimo tiene **dos capas** —método y decisión de stack— y la base puede **sustituir** la segunda, nunca la primera. Separarlas en `Maqueta-Rules.md` §4 **entra en el alcance** de esta intervención | §2.5, §4.9, §II.4 |
| 10 | La sustitución **se habilita desde el framework, no desde el conocimiento**: exige que el ítem esté etiquetado como decisión de stack y que el índice lo declare en `sustituye`. Sin etiqueta, el caso vuelve a ser conflicto y manda la regla | §4.2, §5.2 |
| 11 | El **consumidor** declarado en el índice admite **subagentes de fase**, no sólo las doce categorías. Sin esto el conocimiento no llega a AG-00031, que es el consumidor del caso de §2.5 | §5.2, §5.5 |

Las decisiones 7 y 8 las cerró la evaluación por mesa con evidencia. La **9** la abrió y la cerró el
caso de §2.5. Y **las tres primeras se cerraron al revés de como este plan las traía**: la corrección
la aportó el PO con un argumento operativo —`IA.SDD` es el repositorio desde el que se lanza— y con él
se cayeron el cuarto rol de repositorio, la raíz declarada en el intake y la identidad de versión
propia. **Vale registrar por qué estaban mal**: se confundía el desacoplamiento con la ubicación. El
desacoplamiento es que **ninguna regla nombre un documento**, no que los documentos vivan lejos.

### 8.2 Abiertas al PO

| # | Decisión | Por qué es del PO |
|---|---|---|
| 1 | **Alcance de la cita**: si además de las citas por proyecto de código en `§17.P.13` conviene una lista de nivel producto para el conocimiento que aplica a todos | Es una preferencia de uso, no un problema técnico |
| 2 | **Un archivo de reglas o dos**: si `Rules-Base-Conocimiento.md` cubre también la especificación de AG-00980, o si el bibliotecario lleva el suyo, con el precedente de `Maqueta-Rules.md` para AG-00031 | Costo de mantenimiento contra claridad de dueño |
| 3 | **Cerrada por ejecución.** El piloto capturó `Clean-Architecture-DataManager`, un caso `canonico` que ejercita la regla de mayor riesgo —escribir el delta— y se valida entero dentro del Bloque I. Lo que sigue abierto es **qué se captura después**, y ahí el caso de §2.5 sigue siendo el candidato natural | Ya no bloquea |
| 4 | **Artefacto de referencia**: si una captura sobre algo ejecutable deposita además el artefacto, con el precedente de `Templates/` | Pesa en el tamaño del repositorio, que ya archiva una copia por versión |
| 5 | **Techo de tamaño por documento**. Fijado en **250 líneas** para `canonico` y **600** para `propio`. El piloto entró en **247 sobre 250**, o sea ajustado: hay evidencia de un solo caso | Se confirma o se corrige con dos o tres documentos más |
| 6 | **Cuánto cuesta agregar conocimiento.** Al vivir `Conocimiento/` en el repositorio, cada alta es una intervención con `CHANGELOG.md` y copia a `_legacy/`. Tensiona con el «simplemente copiarlos» del planteo original: conviene decidir si las altas **se agrupan por lote** en vez de publicarse de a una | Es un costo operativo real, y la decisión es de quien mantiene el repositorio |

### 8.3 Deuda declarada

Defectos y trabajos reconocidos que **deliberadamente no se hacen acá**, con su motivo:

| Ítem | Motivo de la postergación |
|---|---|
| **El refactor de las notas operativas del catálogo de diseño** (§2.4). El defecto de escalado es real y sigue en pie | Es una mejora del catálogo propio del framework, no de esta capacidad. Mezclarlas sube la severidad y toca el comportamiento base que se decidió conservar. Va como intervención propia y posterior |
| **La verificación mecánica de `compatible-con`.** El barrido de §VI.3.1 ahora **sí** alcanza a `Conocimiento/`, porque la carpeta está en el árbol, pero nadie comprueba todavía que el valor declarado sea el vigente | No bloquea: con un catálogo chico el dato se compara a ojo. Conviene resolverlo cuando crezca |
| **La separación de capas en las reglas de 02, 05, 08 y 09.** `Maqueta-Rules.md` se separa acá porque es la que bloquea el caso de §2.5; las demás cargan la misma mezcla de método y decisión de stack | No bloquea esta capacidad. Conviene hacerlas cuando una base real necesite sustituir algo de ellas, para separar con un caso concreto en la mano en vez de a priori |
| **El prompt de promoción, que deja de existir como ítem.** Con la base anexada no hay dos catálogos entre los cuales promover: se captura directamente en `Conocimiento/`, con la ofuscación puesta desde el principio | Desaparece con el cambio de modelo. Se registra para que no se reintroduzca |

## 9. Plan de trabajo

El trabajo se parte en **dos bloques**, y la partición no es de conveniencia: son los dos lados del
mecanismo y tienen dueños, tiempos y riesgos distintos.

| | **Bloque I — El ingreso** | **Bloque II — El consumo** |
|---|---|---|
| Pregunta que responde | ¿Cómo entra el conocimiento a la base? | ¿Cómo lo aplica el framework cuando corre? |
| Entrega | El archivo de reglas de formato y el prompt de relevamiento | El contrato del índice, el andamiaje de intake, la mecánica del orquestador y AG-00980 |
| Toca `IA.SDD` | Un archivo de reglas y la carpeta `Conocimiento/` | Master-prompt, plantilla de intake, `Intake-Rules.md`, `Root-Rules.md` §9.2 y `Maqueta-Rules.md` §4 y §1 |
| Severidad | Minor | **Minor.** La plantilla de intake se amplía sin renumerar; `Root-Rules.md` suma una fila. Ver §6 |
| **Vale por sí solo** | **Sí.** Podés empezar a construir tu base ya, aunque el framework todavía no la consuma | No: sin Bloque I no hay qué consumir |

**Esa última fila es lo que de-riesgea la intervención entera.** El Bloque I entrega valor antes de que
exista el Bloque II: el día que esté, ya podés relevar tus templates, tus arquitecturas y tus
nomenclaturas y acumularlos con formato consistente. Si el Bloque II se demora o cambia de forma, nada
de lo capturado se pierde.

---

### Bloque I — El ingreso del conocimiento

#### I.1 `Rules-Base-Conocimiento.md`

El archivo de reglas que el prompt de relevamiento **cita como norma a cumplir**, bajo el patrón de los
dieciocho existentes. Vive en `SDD/Devs/Rules/`. Sus secciones, con lo que aporta cada una:

| Sección | Qué fija |
|---|---|
| §0 Frontera con el piso mínimo | **La regla de composición de §4.9** y sus **tres modos**: sumar, especializar y **sustituir**. La sustitución alcanza sólo a lo que el framework etiquete como **decisión de stack** y nunca a la capa de método; borrar el piso sin declarar nada es anti-patrón |
| §1 Especialidad | El rol con que se releva. Variantes según qué se caracteriza: interfaz, arquitectura, datos |
| §2 Documentos que produce | El documento, su fila en el índice y, si corresponde, el artefacto de referencia |
| §3 Nomenclatura | `Knowledge-<Tema>.md`, el **alias citable** y sus tres reglas de §5.2.1: forma Título-Con-Guiones por D3, unicidad **en el índice de la base** más la regla de colisión con el catálogo del framework, y honestidad del nombre frente al canon |
| §4 Estructura de redacción | La plantilla del documento: cabecera con alias, naturaleza y consumidor; §0 a §10 según §5.3. Acá viven las siete propiedades de formato de §4.1 |
| §5 Preguntas guía | **Las tareas de relevamiento**: qué hay que averiguar antes de escribir, por tipo de artefacto |
| §6 Criterios de aceptación | El auto-chequeo previo a devolver, con el **techo de tamaño** diferenciado entre `canonico` y `propio` |
| §7 Contrato del índice | Las columnas obligatorias que el `Index-Knowledge.md` de una base debe tener para que el orquestador pueda resolverlo: alias, naturaleza, tema, **consumidor** —categoría o subagente de fase—, condición de carga, `hereda-de`, **`sustituye`**, `compatible-con` y estado |
| §8 Prompt-snippet | El bloque que el prompt de relevamiento **cita literalmente** |
| §9 Especificación de AG-00980 | El rol, su contrato de entrada y salida, y sus dos prohibiciones. Sujeto a la decisión 3 de §8 |

**Salida**: el archivo, más nota de coherencia, entrada de CHANGELOG y copia a `_legacy/`.

#### I.2 El prompt de relevamiento

Vive en la documentación de prompts del usuario, no en `IA.SDD`. Cita `Rules-Base-Conocimiento.md` y
ejecuta:

1. **Orientación**: qué conocimiento se quiere capturar y de qué artefacto o proyecto. Sin esto la
   captura produce un resumen del proyecto en lugar de conocimiento reutilizable.
2. **Relevamiento**: recorre el artefacto según las preguntas guía de §5 del archivo de reglas.
3. **Determinación de naturaleza**: `canonico` o `propio`. Decide si el documento escribe **el delta** o
   escribe todo, según §5.2.1.
4. **Destilación**: redacta contra §4, bajo el techo de tamaño de §6.
5. **Alta**: documento en la base, fila en su `Index-Knowledge.md` con alias, naturaleza, tema,
   consumidor y condición de carga.

La compuerta de ofuscación **no corre acá**: la base es tuya y D7 no la alcanza (§4.8). Corre solo si
algún día querés promover un documento al catálogo público del framework.

#### I.3 Piloto

Un documento real contra el archivo de reglas, sobre el tema que la decisión 4 de §8 elija. Su función
es probar que **el archivo de reglas sirve para caracterizar un artefacto externo**, que es algo que
ninguno de los dos catálogos actuales del framework ejerció.

---

### Bloque II — El consumo desde el framework

#### II.1 Andamiaje de intake

**Una sola declaración**, y es lo que el cambio de modelo simplificó: no hay raíz que declarar ni
identidad de versión que registrar.

`§17.P.13` al final del bloque repetible de la Parte C, por proyecto de código, con tres campos: alias
citado, motivo y alcance. Sin renumerar nada, y sin sección de nivel producto salvo que la decisión 1
de §8.2 la confirme.

`Intake-Rules.md` suma **una** validación, **bloqueante** según su §7 y corriendo en la fase previa a la
Fase A según su §8: **todo alias citado resuelve** contra `Conocimiento/Index-Knowledge.md`.

Con el índice sin filas no hay alias que citar, y el framework corre exactamente como hoy.

#### II.2 Mecánica del orquestador

Tres cambios en `Master-Prompt.md`, y los tres son **aditivos**: ninguna nota operativa existente se
toca, ninguna condición vigente cambia de comportamiento. Es lo que hace que el framework siga corriendo
igual que hoy cuando el intake no declara base (§4.9, §5.4).

1. **§6, nota operativa nueva**: la resolución por el `Index-Knowledge.md` de la raíz declarada en el
   intake, condicionada a que esa declaración exista. **El catálogo de diseño de `References/Design/` se
   resuelve como hoy, por sus propias notas, y no se mezcla**: son dos resoluciones distintas, con
   dueños, ubicaciones y obligatoriedad distintas (la tabla de §5.4 las separa).
2. **§8, esqueleto de despacho**: línea nueva `{{LISTA_DOCUMENTOS_DE_CONOCIMIENTO}}` en los insumos
   obligatorios, que puede venir vacía; más el aviso de una línea de §4.7.2 que le dice al subagente que
   la biblioteca existe y cómo pedir. El aviso también viaja vacío si no hay base declarada.
3. **§9 o sección nueva**: el ciclo de pedido. Detención del subagente con la necesidad en prosa,
   despacho a AG-00980 con el índice filtrado por consumidor, resolución a paths, registro en
   el log y reanudación con los documentos sumados **enteros**.

El refactor de las notas del catálogo de diseño —el defecto de escalado de §2.4— **no forma parte de
esta intervención**, por los dos motivos que §5.4 detalla: el conteo que lo fundaba era falso y es una
mejora del catálogo propio del framework, no de esta capacidad. Queda como deuda declarada en §8.

#### II.3 AG-00980, el bibliotecario

Rol nuevo en el bloque `009xx` de `Root-Rules.md` §9.2. **El identificador está verificado libre**: no
hay ninguna aparición de `AG-00980` en el conjunto normativo vigente, y el bloque `009xx` hoy sólo
nombra a `AG-00990`, el titular de nivel producto. El alta es una fila en la tabla de bloques de la
familia `AG`, de severidad minor, pero **no es cosmética**: `Root-Rules.md` §9 declara alcance
transversal y viaja en los insumos obligatorios de todo despacho.

Contrato en §4.7.1: entra la necesidad en prosa y el índice filtrado; sale una lista de alias con
fundamento, o vacía. **No devuelve texto. No propone fuera del índice. No escribe.** El orquestador es
el único que entrega, y entrega verbatim.

Si no hay base declarada en el intake, AG-00980 no se convoca nunca y el aviso de §4.7.2 no viaja.

#### II.4 Separación de capas en el piso mínimo

Es la contrapartida de la base del lado del framework, y sin ella la sustitución de §4.9 no tiene contra
qué validar.

**Y es mucho más barato de lo que este plan estimaba hasta la 2.0**, porque el trabajo está casi hecho:
`Maqueta-Rules.md` §4 **ya está subdividido**, y la subdivisión coincide casi exactamente con las dos
capas.

| Subsección de `Maqueta-Rules.md` §4 | Capa | Observación |
|---|---|---|
| **§4.1 Tecnología** | **Decisión de stack** | Vanilla, Bootstrap 5.0 por CDN, sin build ni gestor de paquetes. Es el bloque sustituible, casi tal cual |
| §4.2 Datos de ejemplo | Método | Fuente única, nada hardcodeado, casos límite de los CU, nada de datos reales del cliente |
| §4.3 Estados y barra de validación | Método | Los cuatro estados, la barra, la recarga automática |
| §4.4 Cobertura mínima por tipo | Método | Superficies mínimas por tipo D8 |
| §4.5 Accesibilidad | Método | WCAG 2.2 AA con mínimos verificables |
| §4.6 Sello de versión | Método | Qué exhibe el pie de cada superficie |

**El trabajo real es sacar de §4.1 los dos ítems que no son stack** y llevarlos a la capa de método,
porque hoy viajan mezclados con los que sí lo son: «íconos SVG inline con `currentColor`, prohibido el
raster» —es una regla de calidad de iconografía, no una elección de tecnología— y «nada de llamadas de
red a servicios reales, la maqueta es autónoma y funciona sin backend» —es lo que define qué **es** una
maqueta—. Ninguno de los dos tendría que poder sustituirse, y hoy están en el bloque que va a quedar
etiquetado como sustituible.

**Corrección de la 2.0, que decía «ninguna regla cambia de contenido: cambian de etiqueta».** Es cierto
para el texto de cada regla, y es lo que hay que verificar ítem por ítem: el conjunto de exigencias
sobre una maqueta generada **sin base declarada** tiene que ser idéntico al de hoy. Pero **dos reglas
cambian de lugar**, y decir que sólo cambian las etiquetas ocultaba justamente la parte que hay que
mirar con cuidado.

**§7.2 se mantiene entero.** Sigue siendo la justificación de por qué el framework eligió no incorporar
un paso de build, y su válvula de escape por ADR sigue sirviendo para el caso que imagina —una unidad de
entrega puntual—. Lo que se agrega es la otra escala: una organización que construye así siempre lo
declara una vez en su base, en vez de un ADR por proyecto (§2.5).

**Y `Maqueta-Rules.md` §1 suma la base a la lista de insumos de AG-00031**, que hoy es cerrada y no la
incluye. Sin ese cambio el conocimiento no llega al agente que construye la maqueta, que es el
consumidor del caso que motiva todo esto.

**Alcance acotado a `Maqueta-Rules.md`.** El mismo trabajo sobre las reglas de 02, 05, 08 y 09 es
razonable y probablemente valga la pena, pero no hace falta para esta capacidad y no se hace acá: se
registra en §8.3.

#### II.5 Cierre normativo

Marco teórico, guía de usuario, guía de desarrollo con el eje de extensión nuevo, README del framework
con el cuarto rol de repositorio, nota de coherencia consolidada, entrada de CHANGELOG y copia del
conjunto superado a `_legacy/<version>/`.

---

### Orden y dependencias

| Paso | Qué | Bloque | Estado | Depende de |
|---|---|---|---|---|
| 0 | Cerrar las decisiones abiertas de §8.2 | — | Parcial | — |
| 1 | `Rules-Base-Conocimiento.md` y `Conocimiento/` | I | **Aplicado** — framework 12.2, corregido en 12.3 y 13.0 | 0 |
| 2 | Prompt de relevamiento | I | **Aplicado** — `Features/16-Relevar-Conocimiento/` | 1 |
| 3 | Piloto | I | **Aplicado** — `Clean-Architecture-DataManager` | 2 |
| 4 | Andamiaje de intake y validaciones | II | Pendiente | 1, y el piloto como prueba de que el contrato del índice sirve |
| 5 | Mecánica del orquestador y AG-00980 | II | Pendiente | 4 |
| 6 | Separación de capas en `Maqueta-Rules.md` §4 y §1 | II | Pendiente | 1 |
| 7 | Cierre normativo y publicación | II | Pendiente | 5, 6 |

El paso 3 era la compuerta real entre bloques, y **se ejerció**: el piloto encontró cuatro defectos en
el archivo de reglas y se corrigieron en el paso 1 antes de tocar el intake, que es lo caro. Los cuatro
vivían en la costura entre el documento y el índice, y ninguno se habría visto releyendo el archivo.
**Veredicto: se pasa.** El Bloque II puede avanzar.

**Un matiz sobre «el Bloque I vale por sí solo», si el piloto es el de sustitución.** Un documento que
sustituye una decisión de stack se puede **escribir y guardar** con sólo el Bloque I, y eso conserva la
propiedad: el trabajo de captura no se pierde. Pero **no se puede ejercer** hasta el paso 6, porque
hasta entonces no hay ninguna etiqueta del framework contra la cual validar el campo `sustituye`. La
propiedad de de-riesgue se mantiene; lo que no se mantiene es la ilusión de que el piloto de sustitución
se valida entero dentro del Bloque I. Si se prefiere validación completa temprana, conviene un piloto que
sólo **sume** —una nomenclatura de base de datos, por ejemplo— y dejar el de sustitución para después
del paso 6.

---

## 10. Evidencia consultada

| Archivo | Qué aporta |
|---|---|
| `IA.SDD/README.md` | Modelo de tres repositorios y su única excepción; invariantes D1 a D9; reglas de intervención y de publicación; propósito de `_legacy/`; autosuficiencia |
| `IA.SDD/SDD/Devs/References/Design/Index-Design-Rules.md` | Modelo base→especialización, extensiones por capacidad, criterio de selección en tabla, regla de conflicto, apilado de cuatro capas |
| `IA.SDD/SDD/Devs/References/Design/Design-Rules-Primer-Arranque.md` | Estructura canónica §0 a §12 de un documento del catálogo |
| `IA.SDD/SDD/Devs/References/Design/Coherencia-Incorporacion.md` | Cómo se incorporó el catálogo y qué se cableó |
| `IA.SDD/SDD/Devs/References/Design/Coherencia-Panel-Monolitico.md` | Precedente de captura desde un proyecto en producción y verificación de D7 por búsqueda de términos |
| `IA.SDD/Templates/README.md` | §2 el catálogo de templates y su única entrada; §3 estructura obligatoria de un template; §4 reglas constructivas heredadas de `Maqueta-Rules.md` |
| `IA.SDD/Templates/Modelo-Generico/` | El único template del framework: tres superficies HTML y una hoja de estilos de 896 líneas |
| `IA.SDD/SDD/Devs/Rules/Maqueta-Rules.md` | §1 lista cerrada de insumos de AG-00031, sin base de conocimiento; §3.7 y §6 captura del modelo y generación del template; §4.1 a §4.6 reglas constructivas ya subdivididas; §7.2 justificación de no incorporar un paso de build y **su válvula de escape por ADR de proyecto** |
| `IA.SDD/SDD/Devs/Modelos-UX-UI/Index-Modelos-UX-UI.md` | Eje de conocimiento capturado; convención de nombres; procedimiento de alta; compuerta de ofuscación bloqueante; catálogo vacío |
| `IA.SDD/SDD/Devs/Modelos-UX-UI/Rules-Design-Modelo-Template.md` | Plantilla de un documento capturado, §0 a §16 |
| `IA.SDD/SDD/Devs/Orchestrator/Master-Prompt.md` | §6 plan de generación y sus once notas operativas, cinco de ellas sobre el catálogo de diseño; §8 esqueleto de despacho y prohibición de buscar fuera del scope; §8.1 trabajo propio contra detención; §10 auditoría entre fases |
| `IA.SDD/SDD/Devs/Rules/Root-Rules.md` | §9.2 ancho y familias de identificadores; §12.2 ítem diferido; §13 criterio de precedencia entre reglas |
| `IA.SDD/SDD/Devs/Intake/PRODUCT-INTAKE-template.md` | Las 21 secciones actuales; ausencia de hueco para declarar conocimiento a aplicar |
| `IA.SDD/SDD/Devs/Guides/Marco-Teorico-SDD.md` | §2.6 limitaciones; §4 catálogo de especialidades; §5, §6, §8, §9, §10 encuadre en estándares; §8.7 catálogo de diseño; §11.6 fundamentación en literatura de prompting; §14 bibliografía |
| `IA.SDD/SDD/Devs/Guides/Coherencia-Renumeracion-AG.md` | §8, ítems diferidos, incluida la exclusión de `Examples/` del snapshot |

---

## Control de cambios

| Versión | Fecha | Cambios |
|---|---|---|
| 3.0 | 2026-08-23 | **Cambia dónde vive la base, y con eso se cae buena parte del andamiaje que este plan venía cargando.** La corrección la aportó el PO con un argumento operativo que decide: `IA.SDD` es **el repositorio desde el que se lanza** el orquestador, de modo que la base tiene que viajar con lo que se clona en vez de ser alcanzada. §4.8 se reescribe por tercera vez y queda en **`Conocimiento/`, carpeta anexa del framework**; se registran las dos versiones equivocadas anteriores porque **las dos fallaban por el mismo motivo: confundir el desacoplamiento con la ubicación**. El desacoplamiento se define ahora de forma verificable —**el framework corre con la carpeta vacía y ninguna regla nombra un documento**— y el mecanismo de distribución es el **fork**. Se cae el cuarto rol de repositorio, la raíz declarada en el intake, la identidad de versión propia de la base y el rodeo por autosuficiencia: **el intake cita alias y nada más**. Tres inversiones: una captura **es** una intervención sobre el framework; **`Conocimiento/` entra en el snapshot**, por el criterio de `SDD-Development-Guide.md` §VI.5 y el precedente de `Templates/` —`Examples/` era mala analogía y este plan se apoyaba en ella—; y **la compuerta de ofuscación corre y es bloqueante**, porque el repositorio es público. §5.1, §5.4, §5.5 y §5.6 se reescriben en consecuencia, §6 y §7 se actualizan, y §8 registra las tres decisiones cerradas al revés de como el plan las traía más dos nuevas: el techo de tamaño con evidencia de un caso y **el costo operativo de que cada alta sea una intervención**, que tensiona con el «simplemente copiarlos» del planteo original. §9 suma el **estado de ejecución**: los pasos 1, 2 y 3 están aplicados, y el piloto **ejerció la compuerta** entre bloques encontrando cuatro defectos en el archivo de reglas. |
| 2.1 | 2026-08-23 | **Segundo ciclo de la mesa evaluadora, sobre la 2.0. Siete hallazgos, todos aplicados y verificados.** Dos salen de leer `Maqueta-Rules.md` en detalle en vez de citarla. **El primero refuerza el argumento de §2.5**: la válvula de escape ya existe —§7.2 admite apartarse del no-build **registrando un ADR en 05 del proyecto de código**—, de modo que lo que §4.9 predecía como riesgo es hoy **observable**: para una casa que construye así siempre, esa vía produce el mismo ADR en cada proyecto. El apartamiento **por proyecto** está resuelto; el **por organización** no tiene dónde declararse, y eso es lo que la base aporta. **El segundo abarata §II.4 y corrige una afirmación floja**: `Maqueta-Rules.md` §4 **ya está subdividido** en §4.1 Tecnología más cinco subsecciones de método, así que la separación es casi rotular lo que existe; el trabajo real es **sacar de §4.1 los dos ítems que no son tecnología** —iconografía vectorial y autonomía sin backend—, y por lo tanto era falso que «ninguna regla cambia de contenido: cambian de etiqueta». **Hueco S1 cerrado**: los insumos de AG-00031 son una lista cerrada en `Maqueta-Rules.md` §1 que no incluye la base, de modo que el conocimiento sobre cómo construir una página web **no llegaba al agente que construye la página**; el campo del índice pasa de «categoría consumidora» a **consumidor**, que admite subagentes de fase. **Contradicción cerrada entre §4.2 y §4.9**: la subordinación gobierna el **conflicto** —gana la regla— y la sustitución es un **reemplazo previsto y etiquetado** —gana el conocimiento en el ítem declarado—, con tabla comparativa; la sustitución **la habilita el framework por adelantado**, no el que escribe el conocimiento. Campo **`sustituye`** nuevo en el contrato del índice, sin el cual la sustitución quedaba declarada pero inejecutable, más el riesgo de **sustitución tácita** en §7. §9 declara el matiz sobre «el Bloque I vale por sí solo» cuando el piloto es de sustitución: se puede escribir, no se puede ejercer hasta el paso 6. §8.1 suma las decisiones cerradas 10 y 11. |
| 2.0 | 2026-08-23 | **El caso que motiva la capacidad entra al documento como evidencia, y obliga a corregir la regla de composición de la 1.9.** Nueva **§2.5**: el framework construye toda maqueta y todo código web a partir de **un único template**, `Templates/Modelo-Generico/`, y el acoplamiento real no está en el template sino en `Maqueta-Rules.md` §4, que fija como norma JavaScript vanilla, Bootstrap por CDN y ausencia de proceso de build, con §7 justificando la decisión. El punto de extensión que existe —capturar un modelo en la Fase B2— **sólo permite variar el modelo visual**, porque todo modelo nuevo sigue obligado por §4; de modo que aportar otra forma de construir páginas web hoy exige **editar el framework**, que es exactamente lo que esta capacidad existe para evitar. **§4.9 se amplía en consecuencia**: el piso mínimo tiene **dos capas**, método —criterios de aceptación, no desplazables— y **decisión de stack** —elecciones legítimas, sustituibles—, hoy mezcladas en el mismo párrafo. La regla de composición de la 1.9 era correcta pero insuficiente: tratar como desviación declarable algo que se declara en cada corrida convierte la base en una fábrica de apartamientos, que es el anti-patrón que `Root-Rules.md` §11 nombra. Se declaran los **tres modos de aportar** —sumar, especializar y **sustituir**— y el límite duro de la sustitución. **La separación de capas entra en el alcance**: nueva **§II.4** sobre `Maqueta-Rules.md` §4, sin cambiar ninguna regla de contenido, con verificación de equivalencia ítem por ítem; el cierre normativo pasa a II.5 y el orden suma un paso. §8.1 suma la decisión cerrada 9; §8.2 reformula el primer tema del piloto, que el caso de §2.5 sugiere solo; §8.3 suma la deuda de separar las mismas capas en las reglas de 02, 05, 08 y 09. Riesgo nuevo en §7: la sustitución desbordándose hacia el método. |
| 1.9 | 2026-08-23 | **Evaluación por mesa multiagente (`05-Mejora-Continuar-Mesa-Evaluadora.md`) y aplicación de los parches aprobados.** Nueva **§4.9 «Método y oficio»**, a pedido del PO: el SDD está fundado en gestión y su identidad es el proceso; el oficio no puede vivir adentro sin acoplar el framework a una casa, pero **el piso mínimo que ya tiene se conserva tal cual** —`References/Design/` como insumo normativo de la 03, `Modelos-UX-UI/`, y los criterios de las reglas de 02, 05, 08 y 09— con una **regla de composición** explícita: la base se apila sobre el piso, no lo reemplaza. Se corrigen **cuatro contradicciones internas S1** que la 1.8 arrastraba de versiones anteriores a §4.8: los documentos entrando en `_legacy/`, la compuerta de ofuscación declarada bloqueante en toda captura, el `Index-Knowledge.md` ubicado dentro del framework, y §5.6 escribiendo en `IA.SDD`. Se separa lo que la 1.8 fundía: **el catálogo de diseño del framework y la base de la organización son dos resoluciones distintas** y el master-prompt suma una nota en vez de reemplazar las suyas —el refactor de §2.4 sale del alcance y pasa a deuda declarada, con el conteo de «seis notas» corregido: son once notas, cinco mencionan el catálogo y cuatro tienen esa forma—. Se corrige el ámbito de unicidad del alias, que la 1.8 ataba al conjunto normativo del framework cuando la base vive afuera, y se suma la regla de colisión. Se registra que **`Root-Rules.md` sí se toca** para dar de alta `AG-00980`, verificado libre. Se cierran por evidencia **dos decisiones que estaban abiertas**: la plantilla de intake se amplía sin renumerar —§19 ya aparece después de §20 y §21— y por lo tanto **la intervención es minor, no major**. §8 se reestructura en cerradas, abiertas y **deuda declarada**. |
| 1.8 | 2026-08-23 | **Plan final.** §9 se reescribe entera y abandona las siete etapas lineales por **dos bloques con dueños, tiempos y riesgos distintos**: el **ingreso** —`Rules-Base-Conocimiento.md` como norma que el prompt de relevamiento cita, el prompt mismo y un piloto— y el **consumo** —andamiaje de intake, mecánica del orquestador y AG-00980—. Se declara la propiedad que de-riesgea la intervención: **el Bloque I vale por sí solo**, porque permite empezar a acumular conocimiento con formato consistente antes de que el framework sepa consumirlo. Se detallan las nueve secciones de `Rules-Base-Conocimiento.md`, incluido el §7 **contrato del índice** que faltaba nombrar, los cinco pasos del relevamiento con la **determinación de naturaleza** como paso propio, las dos declaraciones distintas del intake —base con identidad de versión a nivel producto, citas por proyecto de código— y el orden con el piloto como **compuerta entre bloques**. §8 registra las cinco decisiones cerradas durante el debate y deja seis abiertas, con una nueva: un archivo de reglas o dos, según lleve AG-00980 el suyo. |
| 1.7 | 2026-08-23 | **§4.7 se revisa entera y cambia de veredicto**, a partir de la metáfora del PO: un bibliotecario **entrega el libro, no lo lee por vos**. El rechazo anterior era correcto sobre una figura y equivocado sobre la otra, y se separan: el **bibliotecario que resume** sigue rechazado porque es la segunda fuente que `Master-Prompt.md` §6 punto 1 prohíbe por nombre; el **bibliotecario que entrega identificadores** se **adopta**, y con él caen o se acotan las cuatro objeciones. Se especifica el rol **AG-00980** en el bloque `009xx` que `Root-Rules.md` §9.2 reserva a roles que no son de categoría, con su contrato: entrada la necesidad en prosa más el índice filtrado, salida **alias con fundamento**, prohibido devolver texto y prohibido proponer fuera del índice —selección sobre conjunto cerrado, misma disciplina que D8—, y el orquestador como único que entrega, verbatim. Se abandona la idea de que **el índice viaje en todo despacho**: el despacho lleva una sola línea avisando que la biblioteca existe, y el costo pasa a crecer con la frecuencia de faltantes en vez de con el tamaño del catálogo. Secuencia de cinco pasos, tratamiento del resultado vacío como información, y la simetría final ampliada: **se busca al escribir, se selecciona al pedir, se cita al leer**. |
| 1.6 | 2026-08-23 | Nueva §4.7.1, cerrando la objeción de que el subagente tampoco puede cargar todas las formas posibles ni tiene por qué conocer el alias. Se precisa que **el pedido se expresa como necesidad y no como alias** —el campo «Qué se necesita» de `Master-Prompt.md` §9 ya existe para eso— y que **el «alguien» que atiende ya existe y es el orquestador**, cuyo trabajo declarado en §6 es justamente resolver índices y armar despachos; a diferencia de un bibliotecario, entrega el documento **entero y verbatim**, que es lo que evita la segunda fuente. Se agrega el criterio de escala: si el catálogo crece a centenares, el índice **se filtra por categoría consumidora antes de viajar**, con lo que el costo crece con la parte que le toca a cada subagente y no con el catálogo entero. |
| 1.5 | 2026-08-23 | **Corrección de raíz a partir del planteo del PO sobre el acoplamiento.** Nueva §4.8: la base de conocimiento **no es un subárbol de `IA.SDD`**, como este documento venía proponiendo, sino un **cuarto rol de repositorio, propiedad de la organización**. El motivo es que el conocimiento útil está acoplado a una casa por definición y el framework no puede estarlo: meterlo adentro lo acopla a una organización, choca con D7 y vuelve la compuerta de ofuscación un impuesto sobre lo que hace valioso al documento. El framework aporta el continente —`Rules-Base-Conocimiento.md`, el contrato del índice y la mecánica de inyección— y **ni un solo documento**. El enganche va por dos campos de intake de nivel producto, raíz e identidad de versión, con lo que la autosuficiencia de `README.md` queda intacta: el framework referencia un campo del intake, no un repositorio. Cinco consecuencias escritas: la capacidad es opcional y apagada por defecto; **D7 no alcanza a la base**; la ofuscación se mueve de toda captura a **solo la promoción** al catálogo público; `References/Design/` y `Modelos-UX-UI/` se quedan donde están y **se retira la Etapa 7** de reencuadre; y los dos niveles conviven en una resolución con `hereda-de`. §5.1 se reescribe en dos lados y §4.6 abandona la propuesta de meter los documentos en `_legacy/`: se cita la versión, no se copia el archivo. |
| 1.4 | 2026-08-23 | Nueva §4.7, a partir de la propuesta del PO de intercalar un agente bibliotecario que sí pueda buscar y servir. Se responde por qué **en el momento de consumo no conviene** —reubica la prohibición de `Master-Prompt.md` §8 en vez de resolverla y rompe la auditoría de §10 y D9; crea la segunda fuente que §6 punto 1 prohíbe por nombre; cuesta un despacho por consulta donde una tabla da el mismo resultado gratis; y reintroduce la deriva que el método existe para prevenir—. Se reconoce el problema real que la propuesta señala —**un subagente no puede pedir lo que no sabe que existe**— y se resuelve con mecanismos existentes: **viaja el índice, se inyectan los documentos**, y lo que falte se pide por detención con propuesta de §9, cuya reanudación agrega la cita al intake por §13. Se registra que cada detención de ese tipo es evidencia de una condición mal calibrada. Y se ubica dónde el bibliotecario **sí** corresponde: en la captura de §5.6, que corre fuera de una corrida, pasa por aceptación humana y produce un artefacto durable. Simetría a escribir en el archivo de reglas: **se busca al escribir, se cita al leer**. Riesgo nuevo en §7. |
| 1.3 | 2026-08-23 | Nueva §5.2.1 sobre cómo se nombra el conocimiento, a partir del planteo del PO de usar nombres establecidos —patrón DAO, arquitectura Clean— como alias. Fija que el alias es el nombre canónico cuando existe, y de ahí deriva la distinción que más impacta el costo del catálogo: **conocimiento canónico contra conocimiento propio**. El canónico escribe **el delta** —variante adoptada, convenciones locales, decisiones ya tomadas— y no reexplica el canon, con el mismo criterio que `README.md` ya aplica a los estándares de industria, que «se nombran, no se enlazan». Se agrega el campo **naturaleza** al índice para que el techo de tamaño de `Rules-Base-Conocimiento.md` §6 pueda diferenciarlos. Tres reglas de nomenclatura para su §3: forma Título-Con-Guiones por D3, unicidad en el ámbito del conjunto normativo vigente por `Root-Rules.md` §9.1, y honestidad del nombre cuando el contenido se aparta del canon que el alias designa. |
| 1.2 | 2026-08-23 | §5.5 pasa de nota corta a **cadena de resolución del alias**, en tabla de cinco pasos, a partir de la precisión del PO sobre cómo se cita el conocimiento desde el intake. Se escribe la corrección que el planteo dejaba implícita: **el subagente no consulta, recibe** — la resolución alias→documento ocurre entera en el orquestador antes del despacho, que es lo que mantiene intacta la prohibición de `Master-Prompt.md` §8. Tres consecuencias declaradas: la categoría consumidora del índice es lo que evita inyectar el documento en los doce despachos y admite lista; la validación del alias es **bloqueante** y corre en la fase de validación de intake por `Intake-Rules.md` §7 y §8, no en runtime; y citar un documento cuya condición no dispara **no es conflicto y no lleva ADR de apartamiento**, porque `Root-Rules.md` §11 no alcanza a lo que una condición declarada ya resuelve. |
| 1.1 | 2026-08-23 | Corrección de encuadre a partir de la precisión del PO. §4.1 deja de debatir recuperación por similitud contra cita explícita —la cita explícita era la premisa, no la conclusión— y pasa a codificar **qué aporta la práctica de RAG al formato del documento**: siete propiedades exigibles, incluido un techo de tamaño declarado que vuelve verificable el uso optimizado de recursos. §4.2 suma la frontera que faltaba y es la que más ordena el diseño: **el conocimiento describe un artefacto externo, no el método del framework**, con el borde contra los glosarios de `Vocabulario-Rules.md` §9 escrito. §5.3 reemplaza la plantilla suelta por **`Rules-Base-Conocimiento.md`, un archivo de reglas bajo el patrón de los dieciocho existentes**, porque su §5 son las tareas de relevamiento y su §8 es el bloque que el prompt de captura cita literalmente; se detalla su §4 como plantilla del documento y se registra el artefacto de referencia con el precedente de `Modelos-UX-UI`. §8 suma dos decisiones abiertas: artefacto de referencia y techo de tamaño. |
| 1.0 | 2026-08-23 | Documento inicial. Analiza el estado actual del framework respecto de la capa de conocimiento y encuentra que ya existe construida dos veces —`References/Design/` y `Modelos-UX-UI/`— con un precedente de captura ejecutado. Debate seis decisiones de fondo: cita explícita contra recuperación por similitud, frontera conocimiento/regla y su choque con `Root-Rules.md` §13, catálogo nuevo contra generalización, captura fuera de banda para no abrir una segunda excepción al modelo de tres repositorios, el hueco de cita en el intake, e identificadores/versionado/archivo. Propone un subárbol `References/Knowledge/` con índice, plantilla y regla de subordinación, y un plan de siete etapas encabezado por la confirmación de cinco decisiones del PO. |
