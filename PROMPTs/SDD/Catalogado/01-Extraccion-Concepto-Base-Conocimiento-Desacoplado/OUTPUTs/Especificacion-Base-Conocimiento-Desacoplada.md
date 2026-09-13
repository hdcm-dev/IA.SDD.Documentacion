# Especificación del patrón — Base de conocimiento desacoplada

**Documento:** Especificacion-Base-Conocimiento-Desacoplada.md
**Versión:** 1.0
**Estado:** Vigente
**Fecha:** 2026-08-29
**Fuente:** `IA.SDD` — conjunto normativo 13.9
**Alcance:** Extracción del patrón implementado en `IA.SDD` para su incorporación a otros frameworks de diseño por especificación

---

## 0. Propósito y alcance

Este documento **extrae el patrón** con el que el `Framework SDD` incorpora conocimiento de oficio sin
tocar su conjunto normativo, y lo expresa de forma que otro framework de concepto similar pueda:

1. **Incorporarlo** a sus propios prompts orquestadores, y
2. **Consumir sin traducción** los documentos que hoy viven en `IA.SDD/Conocimiento/`.

**Qué queda explícitamente afuera:**

| Fuera de alcance | Dónde vive en la fuente |
| --- | --- |
| El método SDD —doce categorías, fases, auditoría, intake— | `IA.SDD/README.md` y `SDD/Devs/Rules/` |
| El contenido de los documentos de conocimiento existentes | `IA.SDD/Conocimiento/Knowledge-*.md` |
| El procedimiento de relevamiento con el que se captura un documento nuevo | `Rules-Base-Conocimiento.md` §5 y §8 |
| Las obligaciones de intervención sobre `IA.SDD` (CHANGELOG, `_legacy/`, nota de coherencia) | `IA.SDD/README.md`, tabla de reglas de intervención |

**Regla de redacción de este documento:** toda afirmación sobre el patrón cita el archivo y la sección
de `IA.SDD` que la respalda. La tabla de evidencia de §12 consolida las citas.

---

## 1. El problema que el patrón resuelve

Un framework de diseño por especificación aporta **método**: cómo se especifica, cómo se descompone,
cómo se audita, cómo se planifica. Deliberadamente **casi no aporta oficio**, porque «el momento en que
opine sobre cómo estructurar la capa de datos de una casa, deja de servirle a la de al lado»
(`Rules-Base-Conocimiento.md` §0.0).

Pero los productos reales necesitan oficio: la arquitectura de la casa, el template corporativo, la
convención de nomenclatura del esquema, el ciclo de entrega interno. El patrón resuelve **cómo entra ese
oficio sin desfigurar el método**.

La solución tiene una sola idea central, y todo lo demás se deriva de ella:

> **El conocimiento vive en un catálogo anexo que ninguna regla nombra. El framework sólo fija el
> contrato del índice. Con el catálogo vacío el framework corre exactamente igual.**
> (`Rules-Base-Conocimiento.md` §0.0 y §0.2)

---

## 2. Las cinco piezas del patrón

| Pieza | Qué es | Obligatoria | Referencia en la fuente |
| --- | --- | --- | --- |
| **P-A · Catálogo anexo** | Una carpeta del repositorio del framework, fuera del conjunto normativo, que contiene los documentos de conocimiento | Sí | `Conocimiento/`, `README.md` anatomía |
| **P-B · Índice-contrato** | El único lugar donde se declara qué existe y cuándo se carga. Es lo que el orquestador abre para resolver una cita | Sí | `Index-Knowledge.md`; contrato en `Rules-Base-Conocimiento.md` §7 |
| **P-C · Documento de conocimiento** | Un archivo por artefacto o convención caracterizada, con cabecera y secciones fijas | Sí | `Knowledge-<Tema>.md`; formato en `Rules-Base-Conocimiento.md` §4 |
| **P-D · Enganche en el orquestador** | Las notas operativas que arman la lista de documentos por despacho y fijan su precedencia | Sí | `Master-Prompt.md` §6 (dos notas) y §8 (una línea del esqueleto) |
| **P-E · Bibliotecario** | Un rol que, ante un subagente que se queda corto, devuelve **identificadores** y nunca texto | Opcional | `AG-00980`, contrato en `Rules-Base-Conocimiento.md` §9; mecánica en `Master-Prompt.md` §9.1 |

P-E es opcional en el sentido de que P-A a P-D constituyen un patrón completo y funcional sin él: en la
fuente, el bibliotecario tuvo identificador y contrato desde el conjunto 13.2 y **no se convocaba nunca**
hasta el 13.5, cuando se agregó la vía por la que un subagente pide (`Master-Prompt.md` control de
cambios 8.13).

---

## 3. Las siete invariantes del patrón

Son las propiedades que un framework anfitrión tiene que preservar para que su implementación sea la
misma cosa y no un mecanismo parecido. Cada una lleva **cómo se comprueba**, porque están escritas para
que un agente evaluador pueda auditarlas.

| Id | Invariante | Cómo se comprueba | Evidencia en la fuente |
| --- | --- | --- | --- |
| **K1** | **Vaciable.** Con el catálogo vacío el framework se comporta exactamente como si la capacidad no existiera. No hay flag que apagar | Vaciar el catálogo y verificar que ningún despacho, ninguna validación y ningún prompt cambian de forma | `Rules-Base-Conocimiento.md` §0.2; `Master-Prompt.md` §6: «Con la carpeta vacía o sin índice, la lista y el aviso viajan vacíos y el despacho se arma exactamente como sin esta nota» |
| **K2** | **Ninguna regla nombra un documento.** El conjunto normativo conoce el **contrato del índice**, no su contenido | Enumerar el nombre de cada documento del catálogo en el conjunto normativo: cero apariciones fuera del catálogo mismo | `Rules-Base-Conocimiento.md` §0.0; verificable por barrido, ver §12 |
| **K3** | **Se extiende sin tocar una regla.** El mecanismo de extensión es el fork: se agregan documentos, no se interviene el método | Agregar un documento y verificar que el diff no alcanza a ningún archivo de reglas ni orquestador | `Rules-Base-Conocimiento.md` §0.0; `README.md` fila `Conocimiento/` |
| **K4** | **Cita por alias, no por ruta.** El documento se cita con un nombre corto y estable, desacoplado del nombre de archivo | Renombrar un archivo del catálogo y verificar que ninguna cita de un producto ya generado se rompe | `Rules-Base-Conocimiento.md` §3.2 |
| **K5** | **Consumidor obligatorio.** Cada documento declara a qué destinatario se inyecta, y sólo llega a ése | Verificar que ninguna fila del índice tiene consumidor vacío y que ningún despacho recibe un documento cuyo consumidor no declara | `Rules-Base-Conocimiento.md` §7.1 y §7.3 |
| **K6** | **Consultivo, no normativo.** Ante conflicto entre un documento y la regla del destinatario, **manda la regla**, salvo sustitución declarada sobre un ítem que el framework haya rotulado como sustituible | Buscar un documento que contradiga una regla y verificar que declara `sustituye` o documenta la desviación | `Rules-Base-Conocimiento.md` §0.4; `Master-Prompt.md` §6, «Precedencia del conocimiento» |
| **K7** | **Sin identidad de versión propia.** La versión del catálogo es la del framework, porque el catálogo entra en el snapshot de versión | Verificar que el snapshot de una versión publicada incluye el catálogo, y que el intake no declara ninguna raíz ni versión de base | `Rules-Base-Conocimiento.md` §7.4; `Conocimiento/README.md` §5 |

**K1 es la invariante madre.** Las demás la sostienen. La fuente lo declara como criterio de detección de
degradación: «Si algún día el framework deja de funcionar con la carpeta vacía, la capacidad dejó de ser
una extensión y pasó a ser parte del método, que es exactamente lo que este archivo existe para evitar»
(`Rules-Base-Conocimiento.md` §0.2).

**K6 tiene un motivo mecánico además del conceptual.** Un documento de conocimiento y un archivo de
reglas **no viajan juntos** en los insumos obligatorios de todo despacho, de modo que el criterio general
de precedencia entre reglas no decide entre ellos y **el conflicto se detendría**. Declarar la
subordinación en el archivo de reglas del patrón le da resolución en el árbol
(`Rules-Base-Conocimiento.md` §0.4, párrafo final).

---

## 4. Contrato del documento de conocimiento (P-C)

Es lo que hay que reproducir literalmente para que **los documentos sean intercambiables** entre
frameworks. Un framework anfitrión que respete §4 y §5 puede consumir sin traducción los documentos de
`IA.SDD/Conocimiento/`.

### 4.1 Qué es y qué no es un documento de conocimiento

Caracteriza **un artefacto o una convención que el framework no gobierna**: cómo está construido un
template y cómo declara sus variables, qué nomenclatura sigue un esquema de base de datos, qué forma
tiene una arquitectura concreta, cómo se arma un ciclo de entrega interno. **Describe el artefacto, no el
método** (`Rules-Base-Conocimiento.md` §0.1).

| Va en una regla del framework | Va en un documento de conocimiento |
| --- | --- |
| Qué artefactos produce una categoría y con qué secciones | Cómo está construido un artefacto externo que el proyecto va a usar o reproducir |
| Criterios de aceptación de un entregable | Convenciones, puntos de extensión y contrato de uso de ese artefacto |
| Nomenclatura y trazabilidad de lo que el framework genera | Nomenclatura interna del artefacto caracterizado |
| Gating por tipo de proyecto y por flags | Condición de aplicabilidad del conocimiento, declarada en el índice |

### 4.2 Nombre de archivo

`Knowledge-<Tema>.md`, en Título-Con-Guiones ASCII, sin acentos ni eñes, **sin prefijos numéricos**: un
prefijo numérico envejece mal el día que hay que insertar un documento intermedio, y el orden de lectura
lo resuelve el índice (`Rules-Base-Conocimiento.md` §3.1).

### 4.3 Cabecera obligatoria — once campos, ninguno vacío

```text
# <Título del documento>

**Alias:** <Alias-Citable>
**Naturaleza:** canonico | propio
**Tema:** <una línea, la misma que va al índice>
**Consumidor:** <destinatario declarado del framework anfitrión>
**Condicion-de-carga:** <expresada contra campos del documento de entrada, flags o tipo de proyecto>
**Hereda-de:** <alias o documento del piso que especializa, o —>
**Sustituye:** <referencia literal al ítem del piso que reemplaza, o —>
**Compatible-con:** <archivo de reglas del patrón> <versión>
**Versión:** <X.Y>
**Estado:** Vigente | Superado
**Fecha:** YYYY-MM-DD
```

Los que no aplican llevan `—`. Los nombres de los **siete primeros más `Compatible-con`** son
literalmente los de las columnas del índice, «para que la comprobación de coincidencia se pueda hacer
campo por campo y no por interpretación». `Versión` y `Fecha` no viajan al índice; `Estado` sí
(`Rules-Base-Conocimiento.md` §4.1 y §7.1).

**La cabecera es lo que hace barata la divulgación progresiva:** se decide si el documento aplica leyendo
el índice, y se confirma leyendo la cabecera, sin cargar el cuerpo (§4.1).

### 4.4 Secciones obligatorias

| Sección | Contenido |
| --- | --- |
| **§0 Propósito y alcance** | Qué artefacto caracteriza, **qué queda explícitamente afuera**, y dónde vive lo que queda afuera |
| **§1 Identidad del artefacto** | Qué es, de qué tipo, sobre qué stack, con qué supuestos |
| **§2 Estructura** | Cómo está compuesto: layout de archivos, piezas y el rol de cada una |
| **§3 Contrato de uso** | Variables, puntos de extensión, convenciones que hay que respetar para no romperlo |
| **§4 Decisiones ya tomadas** | Las bifurcaciones que el artefacto resolvió, con el criterio de cada una |
| **§5 Esqueletos de referencia** | Lo mínimo reproducible. Omitible si lo caracterizado es una convención sin esqueleto, declarando el motivo en §0 |
| **§6 Criterios de aceptación** | Cómo se verifica que el conocimiento se aplicó bien |
| **§7 Anti-patrones** | Con su motivo |
| **§8 Frontera con las reglas** | Qué de este tema es normativo y vive en el archivo de reglas de su destinatario |
| **§9 Trazabilidad** | Índice, hermanos, consumidor, artefacto de referencia |
| **§10 Control de cambios** | |

**§0 y §8 no se negocian.** Sin el «qué queda afuera» de §0, el agente que lo lee completa el hueco por
su cuenta. Sin §8, el documento empieza a leerse como norma y desplaza en la práctica al archivo de
reglas de su categoría sin haber pasado por su gobierno (`Rules-Base-Conocimiento.md` §4.2).

### 4.5 Las siete propiedades de forma

| Propiedad | Qué exige | Por qué |
| --- | --- | --- |
| **Un documento, un artefacto** | Cubre un artefacto o convención y nada más. Dos temas son dos documentos | La unidad de carga y la unidad de sentido coinciden |
| **Cabecera autodescriptiva** | Qué es, a qué consumidor alimenta, cuándo aplica y qué queda afuera | La selección se resuelve sin abrir el cuerpo |
| **Secciones autocontenidas** | Cada sección se entiende leída sola | Permite citar una sección sin arrastrar el documento |
| **Forma extractiva antes que narrativa** | Tablas, enunciados declarativos, identificadores y rutas literales. La prosa se reserva para el principio y el motivo | Un dato en tabla se consume sin interpretación; en prosa se reconstruye |
| **Un hecho, un lugar** | Nada se repite entre documentos. Si dos lo necesitan, uno lo declara y el otro lo cita | Duplicar garantiza deriva |
| **Forma de contrato** | Lo que hay que saber para **usar** el artefacto, no la historia de cómo llegó a ser así | El consumidor va a reproducirlo, no a auditarlo |
| **Techo de tamaño declarado** | El de §4.6. Superarlo obliga a partir en dos | Sin techo, la base se degrada a documentos que nadie carga porque salen caros |

Fuente: `Rules-Base-Conocimiento.md` §4.4.

### 4.6 Techo de tamaño por naturaleza

| Naturaleza | Techo | Motivo |
| --- | --- | --- |
| `canonico` | **250 líneas** | El agente ya conoce el patrón. Lo que falta es el delta. Un documento canónico largo es casi siempre uno que se puso a explicar el canon |
| `propio` | **600 líneas** | El agente no sabe nada del artefacto: hay que darle identidad, estructura, contrato y esqueletos |

Superarlo **no se justifica: se parte el documento en dos**, y los dos se declaran hermanos en su §9. La
única excepción es un §5 de esqueletos que no se puede partir sin volverlo inútil, declarada en §0
(`Rules-Base-Conocimiento.md` §6.2). La fuente declara los dos números **calibrables**: «se fijan acá
para que el criterio exista desde el primer día y se revisan con los primeros documentos reales en la
mano».

### 4.7 Las tres reglas del alias

1. **Es el nombre establecido de la cosa, cuando la cosa tiene nombre establecido.**
   `Clean-Architecture`, `Patron-DAO`, `CQRS`, `Atomic-Design`. No `Arquitectura-V2` ni `Template-1`.
2. **Unicidad en el índice de la base que lo declara.** Dos variantes del mismo canon conviven con alias
   distintos, nunca con el mismo. Si un alias colisiona con un documento del piso del framework, el
   documento declara `hereda-de` y se resuelve como especialización; si no lo declara, la validación lo
   rechaza.
3. **Honestidad del nombre.** Si lo caracterizado se aparta materialmente de lo que el nombre canónico
   designa, el alias lo dice —`Clean-Architecture-Simplificada`— o el §0 declara la desviación.

Y **nombre agnóstico del dominio de origen**, que es **obligación y no recomendación** cuando el
repositorio es público: `Panel-Operativo-Denso` sí, `Panel-Cliente-Acme` no
(`Rules-Base-Conocimiento.md` §3.2).

---

## 5. Contrato del índice (P-B)

`Index-Knowledge.md` es **el único lugar donde se declara qué existe y cuándo se carga**, y es lo que el
orquestador abre para resolver un alias. **Una base cuyo índice no cumpla este contrato no valida**
(`Rules-Base-Conocimiento.md` §7).

| Columna | Qué lleva | Obligatoria |
| --- | --- | --- |
| `Documento` | Nombre de archivo | Sí |
| `Alias` | El alias citable de §4.7 | Sí |
| `Naturaleza` | `canonico` o `propio` | Sí |
| `Tema` | Una línea | Sí |
| `Consumidor` | Destinatario declarado del framework anfitrión. **Admite lista** | Sí |
| `Condicion-de-carga` | Expresada contra campos del documento de entrada, flags o tipo de proyecto. `—` si sólo se carga por cita explícita | Sí |
| `Hereda-de` | Alias o documento del piso que especializa | Si aplica |
| `Sustituye` | Referencia literal al ítem del piso que reemplaza | Si aplica |
| `Compatible-con` | Versión del archivo de reglas del patrón contra la que se escribió el documento | Sí |
| `Estado` | `Vigente` o `Superado` | Sí |

**Ocho de las diez columnas existen también como campo de la cabecera y con el mismo nombre**: alias,
naturaleza, tema, consumidor, condición de carga, hereda-de, sustituye y compatible-con. `Documento` sale
del nombre de archivo y `Estado` se replica. Es lo que vuelve verificable campo por campo la comprobación
de conformidad (§7.1).

**Por qué el consumidor es obligatorio:** sin él, un alias citado terminaría inyectado en todos los
despachos. Es la pieza que evita la inflación de contexto (§7.3).

**Por qué el consumidor admite destinatarios que no son categorías:** hay conocimiento cuyo consumidor
natural es un subagente concreto. El caso de la fuente: quien construye la maqueta es `AG-00031`, y un
documento sobre cómo construir páginas web tiene que llegarle a él; con el consumidor limitado a las doce
categorías, ese conocimiento no alcanzaría nunca al agente que lo necesita (§7.2).

---

## 6. Los tres modos de aportar, y la precedencia

| Modo | Qué hace | Qué exige del índice |
| --- | --- | --- |
| **Sumar** | Aporta conocimiento sobre algo que el framework no cubre | Nada adicional |
| **Especializar** | Concreta un documento del piso para una casa. **Sólo se escribe el delta** | Campo `hereda-de` |
| **Sustituir** | Reemplaza una **decisión de stack** rotulada del piso, y sólo esas | Campo `sustituye` |

**La sustitución la habilita el framework por adelantado, no el que escribe el conocimiento.** Un ítem
del piso sólo es sustituible si el archivo de reglas que lo contiene lo **rotuló** como decisión de
stack. Sin ese rótulo el caso vuelve a ser conflicto y manda la regla de categoría, salvo que el
documento documente la desviación con su justificación (`Rules-Base-Conocimiento.md` §0.4).

Esto obliga al framework anfitrión a distinguir **dos capas en su propio piso de oficio**:

| Capa | Qué es | ¿La base puede desplazarla? |
| --- | --- | --- |
| **Método** | Criterio de aceptación del artefacto. Es lo que hace que el entregable sirva, independientemente de con qué se lo construya | **No.** Desplazarlo baja la calidad, no la adapta |
| **Decisión de stack** | Una elección razonada entre alternativas legítimas. Es del framework porque alguien tenía que elegir, no porque sea la única correcta | **Sí**, declarándolo. Es sustitución, no desviación |

Fuente: `Rules-Base-Conocimiento.md` §0.3. El precedente concreto de rotulado en la fuente es
`Maqueta-Rules.md`, cuyo §4.1 está rotulado como decisión de stack y cuyo §4.2 a §4.7 es método
(control de cambios 2.1 de `Rules-Base-Conocimiento.md`).

**Consecuencia para el anfitrión:** mientras no rotule ningún ítem, el modo *sustituir* existe pero no
tiene contra qué validarse, y toda contradicción se resuelve como desviación declarada. La fuente pasó
por exactamente ese estado entre sus conjuntos 12.2 y 13.4.

---

## 7. Los cinco puntos de enganche en el framework anfitrión (P-D y P-E)

Esto es lo que hay que **agregar a los prompts orquestadores**. En la fuente son cinco intervenciones,
todas aditivas: «Con `Conocimiento/` vacía o sin índice, los cuatro archivos se comportan exactamente
como antes» (`CHANGELOG.md`, conjunto 13.2).

### 7.1 E1 — Cita por alias en el documento de entrada

Una subsección **opcional** del documento de entrada donde el usuario cita alias. En la fuente,
`§17.P.13 Conocimiento a aplicar`, con una fila por alias: alias, motivo de la cita y alcance
(`PRODUCT-INTAKE-template.md` §17.P.13).

Sus cuatro reglas, que el anfitrión reproduce:

- Un alias que no resuelve contra el índice es **error bloqueante de validación**.
- Citar un conocimiento cuya condición de carga no dispara **no es un apartamiento y no lleva ADR**: la
  condición del índice es un disparador por defecto, no una obligación.
- No hace falta citar lo que la condición ya dispara sola. Citarlo igual no es error, sólo redundante.
- **Qué destinatario recibe cada documento lo declara el índice, no esta tabla.**

Y su frontera: esta subsección **cita** documentos existentes, no los crea. Un conocimiento todavía no
capturado se releva aparte.

### 7.2 E2 — Validación temprana de la cita

Todo alias citado resuelve contra la columna `Alias` del índice y su fila declara `Estado` = `Vigente`.
Un alias que no resuelve, o que resuelve a una fila `Superado`, es **bloqueante**.

**Corre en la validación previa a la primera fase y no en runtime, y el motivo es de costo:** detectado
en la validación cuesta una corrección del documento de entrada; detectado en plena generación, cuesta
la fase entera. Si el catálogo está vacío o no tiene índice, la única cita válida es `Ninguno`
(`Intake-Rules.md` §5 y §7).

### 7.3 E3 — Armado de la lista por despacho

Antes de cada despacho, si el índice existe y tiene filas, el orquestador arma la lista de documentos
con **la unión de dos conjuntos**:

1. Las filas cuya **condición de carga** evalúa verdadera contra el documento de entrada, los flags y el
   tipo del proyecto en curso.
2. Las filas cuyo **alias** el documento de entrada cita, hayan disparado o no por condición.

Cada documento se suma **únicamente** al despacho del **consumidor** que su fila declara. El conjunto
cargado, con el motivo de cada documento —condición o cita—, se registra en el log del orquestador.
**Con la carpeta vacía o sin índice, la lista viaja vacía y el despacho se arma exactamente como sin esta
nota** (`Master-Prompt.md` §6).

El esqueleto de despacho lleva **una línea**, que puede venir vacía (`Master-Prompt.md` §8):

```text
- Documentos de conocimiento aplicables: {{LISTA_DOCUMENTOS_DE_CONOCIMIENTO}} (puede venir vacía; son insumo **consultivo**)
```

### 7.4 E4 — Nota de precedencia

Una nota operativa que declara el conocimiento como insumo **consultivo**: ante conflicto con el archivo
de reglas del destinatario **manda la regla**, salvo sustitución declarada sobre un ítem rotulado como
decisión de stack. **Un documento de conocimiento nunca redefine criterios de aceptación, nomenclatura de
artefactos generados ni gating** (`Master-Prompt.md` §6).

### 7.5 E5 — Pedido de conocimiento y bibliotecario (opcional)

Cierra el caso que la inyección determinista no cubre: el subagente que necesita algo específico y no lo
tiene entre sus insumos.

**Es una detención de otra clase: no va al humano, la resuelve el orquestador**
(`Master-Prompt.md` §9.1).

El aviso que viaja en el despacho es **una sola línea**, porque el subagente **no lleva el índice encima:
lleva la necesidad**:

```text
Existe una base de conocimiento declarada. Si para resolver tu entregable necesitás un procedimiento o
una convención específica que tus insumos no cubren, no la inventes ni la busques: pedila con el bloque
de pedido de conocimiento, describiendo la necesidad en tus términos.
```

El bloque del pedido describe **la necesidad, no el alias**:

```text
PEDIDO DE CONOCIMIENTO
- Subagente: {{NOMBRE_SUBAGENTE}}
- Producto / unidad de entrega: {{NOMBRE_PRODUCTO}} / {{NOMBRE_UNIDAD_ENTREGA}}
- Documento en curso: {{PATH_DOCUMENTO}}
- Qué se necesita: {{la necesidad en prosa, en los términos del subagente}}
- Por qué los insumos actuales no alcanzan: {{JUSTIFICACION}}
- Qué haría sin esto: {{la salida por defecto, para que el costo de no tenerlo sea visible}}
```

Y la secuencia del orquestador:

| Paso | Qué |
| --- | --- |
| 1 | Despacha al bibliotecario con la necesidad en prosa y el índice **filtrado por el consumidor** de ese subagente. No le manda el catálogo entero |
| 2 | El bibliotecario devuelve una lista de **alias**, cada uno con una línea de fundamento, **o vacía** |
| 3 | Si no está vacía: resuelve alias a ruta, registra pedido y respuesta en el log, y **reanuda** el despacho con los documentos sumados **enteros y verbatim** |
| 4 | Si está vacía: escala al humano como cualquier otra ambigüedad, declarando que la base no tiene lo pedido |

**Contrato del bibliotecario** (`Rules-Base-Conocimiento.md` §9.2):

| | |
| --- | --- |
| **Entrada** | La necesidad en prosa; el índice filtrado por consumidor; el tipo y los flags del proyecto |
| **Salida** | Una lista de **alias**, cada uno con una línea de fundamento. O vacía, que es respuesta legítima |
| **Prohibido** | Devolver texto de los documentos. Proponer un alias que no esté en el índice. Escribir en ningún lado |
| **Quién entrega** | El **orquestador**, que resuelve alias a ruta e inyecta el documento entero y verbatim |
| **Registro** | Pedido y respuesta completos al log del orquestador |

Las tres salvaguardas, y por qué existen:

- **El orquestador entrega y el bibliotecario nunca.** «Un bibliotecario entrega el libro; no lo lee por
  vos, no te lo resume». Si devolviera extractos crearía una **segunda fuente**, y la corrida dejaría de
  ser reproducible porque una síntesis no se repite igual (§9.1, §9.2).
- **No proponer fuera del índice** vuelve al rol una selección sobre un conjunto cerrado: «un agente que
  elige dentro de un conjunto declarado no deriva, elige» (§9.2).
- **Un pedido por despacho.** Un subagente que ya recibió sus documentos y vuelve a pedir está en un
  bucle: el segundo pedido se registra y no se atiende (§9.3).

Dos propiedades que la fuente señala como aprovechables (§9.4):

- **Cada llamada al bibliotecario es evidencia de una condición mal calibrada.** El catálogo se afina con
  su propio uso en lugar de con opinión.
- **El pedido en prosa es más barato que el índice viajando.** El costo deja de crecer con el tamaño del
  catálogo y pasa a crecer con la frecuencia con que un subagente se queda corto.

---

## 8. Compatibilidad: qué tiene que declarar el anfitrión para consumir documentos de `IA.SDD`

El formato del documento (§4) y el del índice (§5) son portables tal cual. **Tres campos son los únicos
acoplados al framework que los emitió**, y son los tres que el anfitrión tiene que mapear. Sin ese mapeo
declarado, un documento tomado de `IA.SDD/Conocimiento/` se puede leer pero no se puede **inyectar**.

| Campo | A qué está acoplado en la fuente | Qué debe declarar el anfitrión |
| --- | --- | --- |
| `Consumidor` | Las doce categorías `00` a `11`, `transversal`, o un subagente de fase (`AG-00031`) | Su propio **conjunto cerrado y enumerado** de destinatarios, más una tabla de equivalencia contra el de la fuente. `transversal` es el valor que siempre mapea |
| `Condicion-de-carga` | Campos del intake, flags y los ocho tipos de proyecto de la invariante D8 | Qué campos de su propio documento de entrada y qué conjunto de tipos evalúa. Una condición cuyo vocabulario el anfitrión no reconoce **no dispara**, y el documento queda accesible sólo por cita explícita |
| `Compatible-con` | La versión de `Rules-Base-Conocimiento.md` | Contra qué versión de **esta especificación** o de su propia regla equivalente está escrito el documento, y desde qué versión lo acepta |

**Los dos valores especiales que abaratan el intercambio:** un documento con `Consumidor: transversal` y
`Condicion-de-carga: —` es **portable sin mapa**: no depende del conjunto de destinatarios del anfitrión
ni de su vocabulario de condiciones, y se carga por cita explícita. El documento
`Conformacion-Pull-Request-Manual` del catálogo de la fuente es exactamente ese caso
(`Index-Knowledge.md` §3).

**Un cuarto acoplamiento, este de gobierno y no de formato:** `Sustituye` referencia **un ítem literal
del piso del framework emisor** —el ejemplo del contrato es `Maqueta-Rules.md §4.1 · tecnología de
construcción`—. Un documento con `sustituye` poblado **no se puede importar tal cual**: o el anfitrión
declara el ítem equivalente de su propio piso, o el documento se importa con el campo en `—` y su
contenido pasa a valer como desviación declarada, que es lo que manda §6 ante ítem no rotulado.

**Lo que el anfitrión NO tiene que replicar:** la fuente no declara ninguna raíz ni versión de base en el
documento de entrada. El intake **cita alias, y nada más**, porque la identidad de versión del catálogo
es la del framework (§7.4). Un anfitrión que importe documentos de un catálogo ajeno **sí** necesita
resolver esa trazabilidad, y tiene dos opciones coherentes con K7: copiar los documentos a su propio
catálogo anexo —el mecanismo del fork, que es el que la fuente prescribe— o declarar la procedencia en el
campo `Compatible-con` de la fila. **La primera preserva K7 sin agregar nada; la segunda no está
respaldada por la fuente y este documento no la especifica.**

---

## 9. Anti-patrones

Los seis de la fuente (`Rules-Base-Conocimiento.md` §4.5), aplicables tal cual a cualquier anfitrión. El
rótulo `[enumerable]` marca los que se detectan por barrido; `[interpretativo]`, los que exigen lectura.

| Anti-patrón | Detección | Por qué |
| --- | --- | --- |
| **Reexplicar el canon** `[interpretativo]` | Un documento `canonico` que dedica más de una sección a describir el patrón en general | Los estándares de industria se nombran, no se reexplican. Lo que aporta el documento es **lo que el nombre no dice** |
| **Conocimiento disfrazado de regla** `[enumerable]` | El documento define criterios de aceptación de un entregable del framework, nomenclatura de artefactos generados o gating por tipo de proyecto | Es una regla escrita en el lugar equivocado, sin el gobierno de una regla. §8 del documento existe para hacerlo visible |
| **Sustitución tácita** `[enumerable]` | El documento contradice un ítem del piso y el índice no declara `sustituye` | El subagente aplicaría la variante creyendo que aplica el piso |
| **Resumen de proyecto** `[interpretativo]` | El documento narra qué hace el sistema de origen en vez de cómo se construye lo caracterizado | Es lo que sale cuando la captura arranca sin el paso de orientación |
| **Documento de dos temas** `[interpretativo]` | §0 necesita dos oraciones con «y además» para declarar el alcance | Rompe la unidad de carga: se paga contexto por la mitad que no se usa |
| **Prefijo numérico en el nombre** `[enumerable]` | El nombre de archivo empieza con dígitos | Envejece mal al insertar un documento intermedio; el orden lo da el índice |

**Y dos anti-patrones del anfitrión**, derivados de las invariantes y no enunciados como tales en la
fuente:

| Anti-patrón del anfitrión | Detección | Invariante que rompe |
| --- | --- | --- |
| **Catálogo obligatorio** | Alguna validación, algún despacho o algún prompt cambia de forma cuando el catálogo está vacío | K1 |
| **Regla que nombra un documento** | Un archivo del conjunto normativo cita un `Knowledge-*.md` concreto en lugar de citar el contrato del índice | K2 |

---

## 10. Lista de conformidad, para evaluación por agentes

Un framework anfitrión implementa este patrón si y sólo si todos los ítems se verifican. Están ordenados
por costo de verificación creciente.

**Estructura**

- [ ] `[enumerable]` Existe un catálogo anexo, declarado **fuera del conjunto normativo**.
- [ ] `[enumerable]` El catálogo tiene un índice único, con las **diez columnas** de §5.
- [ ] `[enumerable]` Ninguna fila del índice tiene `Consumidor` vacío.
- [ ] `[enumerable]` Cada documento cumple `Knowledge-<Tema>.md`, ASCII, sin prefijo numérico.
- [ ] `[enumerable]` Cada cabecera lleva los **once campos** de §4.3, ninguno vacío; los que no aplican, `—`.
- [ ] `[enumerable]` Los **ocho campos comunes** de cada cabecera coinciden con su fila del índice.
- [ ] `[enumerable]` Cada documento tiene las secciones §0 a §10 de §4.4, salvo omisiones declaradas en §0.
- [ ] `[enumerable]` Cada documento entra bajo el techo de §4.6.
- [ ] `[enumerable]` La numeración interna de cada documento es contigua y sin huecos.
- [ ] `[enumerable]` Cada alias es único en el índice.

**Enganche**

- [ ] `[enumerable]` El documento de entrada tiene una subsección **opcional** de cita por alias, que admite `Ninguno` (E1).
- [ ] `[enumerable]` La validación previa declara **bloqueante** el alias que no resuelve o que resuelve a `Superado` (E2).
- [ ] `[enumerable]` El orquestador arma la lista por **unión de condición y cita**, y asigna cada documento **sólo** al despacho de su consumidor (E3).
- [ ] `[enumerable]` El esqueleto de despacho lleva la línea de documentos aplicables, que puede venir vacía (E3).
- [ ] `[enumerable]` El orquestador registra en su log el conjunto cargado **con el motivo** de cada documento (E3).
- [ ] `[enumerable]` Existe una nota de precedencia que declara el conocimiento **consultivo** (E4).
- [ ] `[enumerable]` Si se implementa E5: el rol devuelve **sólo alias**, el orquestador entrega el documento **entero y verbatim**, y rige **un pedido por despacho**.

**Invariantes**

- [ ] `[interpretativo]` **K1**: con el catálogo vacío, ningún despacho, validación ni prompt cambia de forma.
- [ ] `[enumerable]` **K2**: cero apariciones del nombre de un documento del catálogo en el conjunto normativo.
- [ ] `[interpretativo]` **K3**: agregar un documento no toca ninguna regla ni ningún orquestador.
- [ ] `[interpretativo]` **K4**: la cita es por alias y sobrevive a un renombre de archivo.
- [ ] `[interpretativo]` **K6**: ante conflicto manda la regla, salvo `sustituye` sobre ítem rotulado.
- [ ] `[interpretativo]` **K7**: el catálogo entra en el snapshot de versión del framework y el documento de entrada no declara raíz ni versión de base.

**Contenido**

- [ ] `[interpretativo]` §0 de cada documento declara qué queda afuera, y no en términos genéricos.
- [ ] `[interpretativo]` Un documento `canonico` escribe el delta y no reexplica el canon.
- [ ] `[interpretativo]` Ningún documento define criterios de aceptación, nomenclatura ni gating de lo que el framework genera.
- [ ] `[interpretativo]` Las siete propiedades de §4.5 se sostienen a lo largo de cada documento.
- [ ] `[interpretativo]` Un agente sin contexto previo podría usar el artefacto leyendo sólo el documento.

**Publicación, si el repositorio del anfitrión es público**

- [ ] `[enumerable]` La verificación de ofuscación está declarada por documento: términos del dominio, del cliente y del stack de origen buscados, con los falsos positivos léxicos enumerados uno por uno.
- [ ] `[enumerable]` Ningún alias nombra un cliente ni un dominio de origen.

Fuente de los ítems de estructura, contenido y publicación: `Rules-Base-Conocimiento.md` §6.1. Los de
enganche e invariantes se derivan de §7 de este documento y de §3.

---

## 11. Bloques citables para prompts orquestadores

Están escritos para **citarse literalmente** en el prompt orquestador del anfitrión, reemplazando lo que
va entre `<>`. Es el mismo mecanismo con el que la fuente distribuye su prompt-snippet de relevamiento:
«el prompt de relevamiento cita este bloque literalmente en lugar de reescribirlo»
(`Rules-Base-Conocimiento.md` §8).

### 11.1 Nota de armado de la lista (E3)

```text
Base de conocimiento. Si <RUTA_INDICE> existe y tiene filas, abrilo antes de cada despacho y armá
{{LISTA_DOCUMENTOS_DE_CONOCIMIENTO}} con la unión de dos conjuntos: las filas cuya condición de carga
evalúa verdadera contra <DOCUMENTO_DE_ENTRADA>, los flags y el tipo del proyecto en curso, y las filas
cuyo alias <DOCUMENTO_DE_ENTRADA> cita, hayan disparado o no por condición. Cada documento se suma
ÚNICAMENTE al despacho del consumidor que su fila declara, y el campo admite lista. Registrá en tu log
el conjunto cargado con el motivo de cada documento: condición o cita. Con la carpeta vacía o sin
índice, la lista viaja vacía y el despacho se arma exactamente como sin esta nota. El formato del índice
y del documento lo fija <ARCHIVO_DE_REGLAS_DEL_PATRON>; leelo, no lo dupliques.
```

### 11.2 Nota de precedencia (E4)

```text
Precedencia del conocimiento. Un documento de conocimiento es insumo CONSULTIVO: ante conflicto con el
archivo de reglas del destinatario que lo consume MANDA LA REGLA, salvo que el documento declare una
sustitución en el campo `sustituye` de su fila sobre un ítem que el framework haya rotulado como
decisión de stack. Un documento de conocimiento nunca redefine criterios de aceptación, nomenclatura de
artefactos generados ni gating.
```

### 11.3 Línea del esqueleto de despacho (E3)

```text
- Documentos de conocimiento aplicables: {{LISTA_DOCUMENTOS_DE_CONOCIMIENTO}} (puede venir vacía; son insumo consultivo, ver la nota de precedencia)

{{AVISO_BIBLIOTECA}}
```

### 11.4 Regla de validación de la cita (E2)

```text
Cita de conocimiento: todo alias citado resuelve contra la columna `Alias` de <RUTA_INDICE> y su fila
declara Estado = Vigente. Un alias que no resuelve, o que resuelve a una fila Superado, es BLOQUEANTE.
Se verifica una sola vez en la validación previa a la primera fase, y no en runtime: detectado acá
cuesta una corrección del documento de entrada; detectado en plena generación, cuesta la fase entera. Si
el catálogo está vacío o no tiene índice, la única cita válida es `Ninguno`.
```

---

## 12. Tabla de evidencia

Todo enunciado de este documento se respalda en los archivos siguientes, del repositorio `IA.SDD`,
conjunto normativo **13.9**, leídos el **2026-08-29**.

| Archivo | Versión leída | Qué respalda |
| --- | --- | --- |
| `Conocimiento/README.md` | 1.0 | Qué es el catálogo, propiedad a preservar, extensión por fork, condición bloqueante de ofuscación, entrada en el snapshot |
| `Conocimiento/Index-Knowledge.md` | 1.1 (fecha 2026-08-29) | El índice real y sus dos filas; identidad de versión; los dos valores especiales de §8 |
| `SDD/Devs/Rules/Rules-Base-Conocimiento.md` | 2.2 | El patrón completo: §0.0 a §0.4, §1 a §9 |
| `SDD/Devs/Orchestrator/Master-Prompt.md` | 8.14 | §6 notas de armado y precedencia; §8 línea del esqueleto y `{{AVISO_BIBLIOTECA}}`; §9.1 pedido de conocimiento |
| `SDD/Devs/Rules/Intake-Rules.md` | 4.2 | §5 y §7: validación de la cita y su carácter bloqueante |
| `SDD/Devs/Intake/PRODUCT-INTAKE-template.md` | 3.5 | §17.P.13: forma de la cita y sus cuatro reglas |
| `SDD/Devs/Rules/Root-Rules.md` | 8.6 | §9.2: alta de `AG-00980` en el bloque reservado a roles que no son de categoría |
| `SDD/Devs/Guides/Coherencia-Cita-De-Conocimiento.md` | 1.2 | Inventario de la intervención que conectó las dos puntas: qué archivos se tocaron y por qué juntos |
| `README.md` (raíz) | — | Anatomía del repositorio, fila `Conocimiento/`; autosuficiencia |
| `CHANGELOG.md` | conjunto 13.9 | Historia del patrón: 13.2 alta, 13.3 cita, 13.4 rotulado, 13.5 bibliotecario activo, 13.9 segundo documento |
| `Conocimiento/Knowledge-Clean-Architecture-DataManager.md` | 1.0 | Ejemplo real de cabecera y de §0 de un documento `canonico` |
| `Conocimiento/Knowledge-Conformacion-Pull-Request-Manual.md` | 1.0 | Ejemplo real de documento `transversal` sin condición de carga |

**Verificaciones ejecutadas para este documento:**

| Verificación | Método | Resultado |
| --- | --- | --- |
| K2 — ninguna regla nombra un documento del catálogo | Barrido de `Conocimiento` y `Knowledge` sobre todos los `.md` del repositorio, excluyendo `Conocimiento/` y `_legacy/` | Confirmado: las apariciones en `SDD/Devs/Rules/` citan la carpeta, el índice o el archivo de reglas; ninguna nombra un `Knowledge-*.md` |
| Contenido real del catálogo | Listado de `Conocimiento/` | Dos documentos, un índice y un README |
| Correspondencia cabecera-índice | Comparación campo por campo de `Knowledge-Clean-Architecture-DataManager.md` contra su fila | Coincide en los ocho campos comunes |

**Discrepancia observada y no resuelta acá.** `Index-Knowledge.md` declara en su cabecera
`Compatible con: Rules-Base-Conocimiento.md 2.0`, mientras el archivo de reglas está en **2.2** y la fila
de `Conformacion-Pull-Request-Manual` declara `Compatible-con` **2.2**. No afecta al patrón extraído —el
contrato de §7.1 no cambió entre 2.0 y 2.2— y se deja registrada porque una lista de conformidad como la
de §10 la marcaría.

---

## 13. Cómo usar este documento

| Si venís a… | Leé |
| --- | --- |
| Decidir si el patrón le sirve a tu framework | §1, §2 y §3 |
| Incorporarlo a tus prompts orquestadores | §7 y los bloques citables de §11 |
| Escribir tu propio archivo de reglas del patrón | §4, §5 y §6, que son el contrato completo |
| Consumir documentos de `IA.SDD/Conocimiento/` sin traducirlos | §8, y después §4 y §5 |
| Auditar una implementación con agentes | §10, con §9 para los anti-patrones |
| Verificar una afirmación de este documento | §12 |

---

## 14. Control de cambios

| Versión | Fecha | Cambios |
| --- | --- | --- |
| 1.0 | 2026-08-29 | Emisión inicial. Extrae el patrón de base de conocimiento desacoplada de `IA.SDD` conjunto 13.9: sus cinco piezas (§2), sus siete invariantes con método de comprobación (§3), el contrato del documento (§4) y del índice (§5) que hacen intercambiables los documentos, los tres modos de aportar y la precedencia (§6), los cinco puntos de enganche en el orquestador anfitrión (§7), los tres campos acoplados que hay que mapear para importar documentos y el cuarto de gobierno (§8), los seis anti-patrones de la fuente más dos del anfitrión (§9), la lista de conformidad para evaluación por agentes (§10) y los cuatro bloques citables para prompts orquestadores (§11). |
