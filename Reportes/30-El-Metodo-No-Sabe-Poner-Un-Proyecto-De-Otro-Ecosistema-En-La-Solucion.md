# Reporte 30 — El método no sabe poner un proyecto de otro ecosistema en la solución

| Campo | Valor |
|---|---|
| Reporte | 30 |
| Fecha | 2026-09-13 |
| Origen | El Product Owner de `Lab-Geometria`, al cerrar la fase `k`: *«pensé que el `Framework SDD` iba a reestructurar la solución incluyendo el visor, que es en realidad un bundle javascript»*. La reestructuración existe en el destino —la hizo a mano la Feature 20 del framework, con una mesa de dos ciclos— y **el framework no aprendió nada de ella**: la propia especificación degradó su única vía hacia el método (P-8, veredicto G-08, 5-0) |
| Versión del framework evaluada | SDD **13.15** (`PRODUCT-INTAKE-template.md` §13 y §16.1 · `PRODUCT-MANIFEST-template.md` §1.2, §2 y §13 · `Vocabulario-Rules.md` §2 · `Rules-Examples.md` §1.2 y §3 · `Rules-Contexto.md` · `Rules-Devops.md` · `Rules-Base-Conocimiento.md` §0.1 y §4.5) |
| Artefactos del framework alcanzados | `SDD/Devs/Intake/PRODUCT-INTAKE-template.md` §16.1 —donde nace la contradicción— y §13 · `SDD/Devs/Intake/PRODUCT-MANIFEST-template.md` §13 · `SDD/Devs/Rules/Rules-Examples.md` · la regla que gobierne la vista de producto y su grafo de compilación |
| Naturaleza | **Un caso que el método no modela, resuelto a mano en un destino, y un canal de aprendizaje que se cerró por diseño.** El framework declara la «solución de código» como agrupador del ecosistema y el stack por proyecto, pero **no tiene cómo expresar que un proyecto de un ecosistema es insumo de construcción de un proyecto de otro dentro de la misma solución**, ni cómo entra al agrupador un sample que no se compila. Un destino que lo necesite lo inventa, y lo que inventa no vuelve |
| Estado | **RESUELTO en SDD 13.16** |
| Reportes relacionados | **`12`**, que decidió que el banco de pruebas es del destino y no del framework: este reporte **no reabre esa decisión**, pide lo que el método necesita para describir la estructura. **`25`**, que dio al método el evento para recibir un cambio de producto posterior al handoff: acá el cambio sí se recibió en el destino, y lo que falta es del framework |

---

## 1. Resumen

**`Lab-Geometria` tiene un proyecto que no es .NET dentro de una solución .NET.** El visor 3D es un
paquete Node.js con TypeScript y webpack cuyo producto —un bundle JavaScript— consume el front Blazor.
El 2026-09-11 el Product Owner decidió que *«todos los proyectos quedan bajo el árbol de solución de
Visual Studio, aunque sea bajo carpetas virtuales»* (DC-5), y el 2026-09-12 la estructura se aplicó:
el visor entró a la solución como nodo sin construcción, el proyecto del front pasó a ser el único
generador del bundle, y el intake, el manifiesto, la vista de producto y dos ADR se reescribieron.

**Todo eso se hizo con una especificación escrita a propósito fuera del framework**, cuya consigna era
no modificarlo. Su propuesta P-8, «Cómo se lleva al framework sin modificarlo», quedó **degradada** por
la mesa: nada va al método hasta que exista una ADR de apartamiento que sobreviva dos saltos, y las
diferencias que encontró quedaron como **observaciones sin vehículo**.

**El resultado es que el próximo destino con un bundle JavaScript parte de cero.** Y el que ya lo hizo
quedó con piezas que el framework no reconoce: una clase de arista inventada, un conmutador de
construcción que ninguna regla nombra, y once samples fuera del árbol de la solución porque ninguna
regla dice cómo entra un sample que no se compila.

---

## 2. La evidencia

### 2.1 Lo que el destino tuvo que resolver solo

Medido sobre `Lab-Geometria` en `main` (2026-09-13):

| Pieza | Dónde | Qué resolvió |
|---|---|---|
| El visor como proyecto de código | `PRODUCT-MANIFEST` fila `GeometriaFactory-Visor`: *«Node.js con TypeScript y webpack; nodo `Microsoft.Build.NoTargets` en el agrupador»* | Un proyecto de otro ecosistema **dentro** de la solución .NET, sin construirse con ella |
| El bundle lo genera el front | `ADR-10008-El-Bundle-Del-Visor-Lo-Genera-El-Proyecto-Del-Front.md`; `GeometriaFactory.Web.csproj`, targets `BuildVisor`, `DeclareVisorAsset`, `SealVisorAsset` | La arista de construcción entre dos ecosistemas y quién es su único generador |
| Una clase de arista nueva | `Vista-Producto.md`: *«Aristas de compilación: **8**, de dos clases: **7** referencias de proyecto y **1** activo de construcción (`Visor → Web`)»* | El grafo de compilación del método sólo conoce referencias de proyecto |
| Un conmutador para construir sin el otro ecosistema | `-p:SkipVisorBuild=true` en `deploy/Dockerfile.web` y en toda construcción dentro de `mcr.microsoft.com/dotnet/sdk:10.0`, que no tiene Node | La solución no se puede construir donde falta la cadena del otro ecosistema |
| Samples que no se compilan | `samples/visor/0N` (HTML anfitrión), `samples/api/0N` (`curl`), `samples/contracts/0N`, `samples/web/01` | **Once**, y **ninguno está en la solución** |

```bash
find samples -mindepth 2 -maxdepth 2 -type d | while read d; do ls $d/*.csproj >/dev/null 2>&1 || echo "$d"; done | wc -l   → 11
grep -c 'samples\\\(visor\|api\|contracts\|web\)' GeometriaFactory.sln                                          → 0
```

**Diez de esos once existían antes de la reestructuración** (creados el 2026-08-11; la
reestructuración es del 2026-09-12) y la especificación los incluía —*«`api/`, `web/` y `visor/0N`
como `SolutionItems` o nodos inertes»*—. Quedaron fuera en la ejecución. El undécimo,
`samples/api/04-cliente-http-basico`, se creó el 2026-09-13 y entró fuera porque **nada lo vigila**.

### 2.2 Lo que el framework dice, y dónde se contradice

**a) El D8 de un proyecto de código.** `PRODUCT-INTAKE-template.md` §16.1, instrucción literal:

> *«Describir cómo se materializan los samples según el **tipo D8 de cada proyecto de código** que los produce.»*

Desde la 8.0 el D8 es atributo de la **unidad de entrega**, no del proyecto de código —la fila 3.0 del
control de cambios de la misma plantilla lo registra: *«La composición se declara en dos ejes
(framework 8.0). §13 pasa de una tabla de proyectos de código a tres subsecciones: §13.1 unidades de
entrega con su `tipo_unidad_entrega`…»*—. **§16.1 quedó escrita con el modelo anterior.** Un proyecto
de otro ecosistema es exactamente el caso donde la diferencia importa: el visor es `library` en el
destino por inferencia, no por regla.

```bash
grep -n "tipo D8 de cada proyecto de código" SDD/Devs/Intake/PRODUCT-INTAKE-template.md   → l.465
```

**b) La arista de construcción entre ecosistemas.** El framework no tiene la clase:

```bash
grep -rn -i "activo de construcci" SDD --include=*.md | grep -v _legacy   → (vacío)
```

**c) La identidad de código en otro ecosistema.** `PRODUCT-MANIFEST-template.md` declara la regla
agnóstica —*«La regla se expresa de forma agnóstica de stack a propósito. El perfil de convención de
§1.2 es donde un producto concreto materializa la convención de su ecosistema»* (l.155)— y su tabla de
proyectos de código lleva una columna `Stack` por fila. **No hay ningún ejemplo de identidad con la
forma de npm** (minúsculas, guion, sin segmentos con punto), que es la que el visor tiene
(`geometriafactory-visor`).

**d) Dos ecosistemas en una misma solución de código.** `Vocabulario-Rules.md` §2 define la solución
de código como *«el artefacto del ecosistema que agrupa la construcción: el archivo de solución en .NET,
el POM agregador…»* — **un** ecosistema por agrupador. Ninguna regla dice qué pasa cuando un proyecto de
otro ecosistema tiene que estar en ese agrupador:

```bash
grep -rn -i -E "otro stack|stack distinto|dos stacks|más de un ecosistema|ecosistemas distintos" SDD --include=*.md | grep -v _legacy   → (vacío)
```

**e) Cómo entra al agrupador un sample que no se compila.** `Rules-Examples.md` §1.2 ya prevé samples
que no son proyectos compilables —para `rest-api`: *«Cliente HTTP de referencia (curl + lenguaje del
integrador típico), colección Postman o Bruno…»*— pero **no dice si entran a la solución ni cómo**, y
tampoco describe la forma de un sample de un bundle JavaScript: una página anfitriona que guía la
integración con el consumidor. La especificación de la Feature 20 le dedicó dos propuestas (P-6 y P-7)
con tres alternativas medidas.

### 2.3 Por qué el canal de aprendizaje estaba cerrado

La especificación explica su propia degradación de P-8:

> *«Lo que 2.x llamaba "documento de `Conocimiento/`" mezclaba método (P-5, P-7: qué sample produce la
> categoría 10 y cómo entra al agrupador) con artefacto (P-2, P-6). Lo primero está excluido de
> `Conocimiento/` por `Rules-Base-Conocimiento.md` §0.1 y §4.5 […] **Candidatos a regla**: el único
> canal es un ADR de apartamiento que sobreviva dos o más saltos del framework […] Hoy ningún candidato
> tiene ADR.»*

**El razonamiento es correcto dentro de su consigna, y es exactamente el problema.** El método tiene
dos canales para que un destino le enseñe algo —`Conocimiento/`, que excluye lo que es método, y el ADR
de apartamiento, que exige tiempo— y **ninguno de los dos es un reporte**. La serie de reportes es el
canal que funciona, y esta especificación se escribió con la prohibición de usarlo.

---

## 3. Qué dice hoy el framework, y por qué no alcanza

### 3.1 Lo que resuelve bien, y no hay que tocar

- **La separación entre unidad de entrega, proyecto de código y solución de código** (8.0) es la que
  hace posible describir el caso: el visor es un proyecto de código de la unidad `GeometriaFactory-Web`,
  en la solución de código del producto. **El modelo alcanza; le faltan dos piezas.**
- **La neutralidad de stack del texto normativo** es una decisión fundada y **no se negocia**: el
  manifiesto lo declara, y D7 lo exige. `Microsoft.Build.NoTargets`, `.csproj` y `wwwroot` son cómo lo
  resolvió .NET; **ninguno puede entrar a una regla**.
- **El banco de pruebas es del destino** (reporte `12`). La comprobación que impide que un sample quede
  fuera del árbol se escribe en el destino.

### 3.2 Lo que no está

**a) §16.1 de la plantilla del intake habla del D8 de un proyecto de código**, contra el modelo vigente.

**b) No hay clase de arista para un insumo de construcción** que no es referencia de proyecto.

**c) No hay regla para un proyecto de otro ecosistema dentro de una solución de código**: si está, qué
significa, quién lo construye, qué pasa donde falta su cadena de herramientas.

**d) No hay forma declarada de sample que no se compila** respecto del agrupador, ni forma de sample de
un artefacto que otro proyecto consume en el navegador.

**e) El manifiesto no ilustra una identidad de código fuera de la forma de dos segmentos con punto.**

---

## 4. El hueco, en una frase

**El framework modela unidades, proyectos y soluciones de código sin atar el modelo a un stack, pero no
tiene cómo decir que un proyecto de un ecosistema es insumo de construcción de uno de otro dentro de la
misma solución, ni cómo entra al agrupador un sample que no se compila; un destino que lo necesita lo
inventa, y lo que inventa no vuelve al método porque sus dos canales de aprendizaje excluyen este caso.**

---

## 5. Qué se propone evaluar

**Ninguna es una propuesta de redacción.** La especificación de la Feature 20 —v3.2, en
`IA.SDD.Documentacion/PROMPTs/Features/20-Agregar-BundleJS-Estructura-Solucion/OUPUTs/Especificacion-Estructura-Solucion.md`—
es evidencia primaria: sus propuestas P-1 a P-7 son **puntos de partida medidos**, no decisiones.

### 5.1 El caso de fondo — se decide primero

¿Corresponde que el método reconozca **un proyecto de código cuyo ecosistema difiere del de la solución
de código que lo agrupa**? Si sí: qué significa estar en el agrupador sin construirse con él, y qué
declara el manifiesto. Si no: por qué, y dónde vive entonces un caso como el visor.

### 5.2 La arista de construcción entre ecosistemas

¿Corresponde una segunda clase de arista en el grafo de compilación —la que el destino llamó «activo de
construcción»—, con quién es su único generador? P-3 de la especificación la mide.

### 5.3 La cadena de herramientas ausente

¿Corresponde declarar qué pasa cuando la solución se construye donde falta la cadena de un ecosistema
—el conmutador que el destino necesitó—, **sin nombrar ninguna herramienta**?

### 5.4 El sample que no se compila

¿Corresponde que `Rules-Examples.md` declare cómo entra al agrupador un sample que no se compila, y la
forma del sample de un artefacto que otro proyecto consume (P-6, P-7)? **Y que su verificación nunca
quede enganchada a la construcción de la solución**, que es el defecto que la especificación midió.

### 5.5 La contradicción de §16.1

¿Corresponde corregir la instrucción de §16.1 al D8 de la **unidad de entrega**?

### 5.6 El canal

¿Corresponde que el método admita que una especificación de destino con mesa y evidencia —como la
Feature 20— alimente un reporte, en lugar de exigir un ADR de apartamiento con dos saltos? **La
posición de este reporte es que ya lo admite**: este reporte es ese canal. La pregunta es si P-8 de la
especificación tiene que declararse superada.

---

## 6. Lo que este reporte no afirma

- **No afirma que el framework deba nombrar .NET, npm ni ninguna herramienta.** Pide piezas agnósticas.
- **No reabre el reporte `12`**: la comprobación del árbol es del destino.
- **No afirma que la especificación de la Feature 20 esté mal**: cumplió su consigna.
- **No afirma que el destino haya elegido mal**: la opción D (nodo inerte) está medida contra dos
  alternativas. Afirma que el framework no le dio el vocabulario para declararla.

---

## 7. Cómo verificar que la corrección funcionó

1. **§16.1 dice D8 de la unidad**, medido con el mismo `grep`.
2. **El grafo de compilación admite la arista de construcción** y `Vista-Producto` de un destino puede
   declarar la del visor sin inventar la clase.
3. **Reproducir el caso sobre la plantilla**: completar un manifiesto con un proyecto npm dentro de una
   solución .NET usando sólo lo que el framework dice. Si hace falta inventar algo, no alcanzó.
4. **Un sample que no se compila tiene forma declarada** respecto del agrupador, y la regla dice que su
   verificación no se engancha a la construcción.
5. **Ningún texto normativo nombra una herramienta** de un ecosistema: `grep -rn -i "NoTargets\|csproj\|webpack" SDD/Devs/Rules` no gana ocurrencias.

---

## Control de cambios

| Versión | Fecha | Cambios | Autor |
|---|---|---|---|
| 1.0 | 2026-09-13 | Emisión inicial. Documenta que el framework no modela un proyecto de otro ecosistema dentro de una solución de código ni cómo entra al agrupador un sample que no se compila, con el caso de `Lab-Geometria` resuelto a mano por la Feature 20 y **once samples fuera del árbol** como evidencia. Verifica contra 13.15 las tres observaciones que la especificación dejó sin vehículo (P-8) y suma dos. **La especificación de la Feature 20 no está versionada al emitirse este reporte**; se cita por su ruta. | Orquestador, sobre el planteo del Product Owner al cerrar la fase `k` |
| 1.1 | 2026-09-13 | **RESUELTO en SDD 13.16**, con §8 «Cómo se resolvió». Lo que la verificación encontró inexacto en este reporte se declara en §8 sin reescribir el cuerpo: la cita de `Vista-Producto.md` es una celda de tabla y no la frase que se transcribe. | Intervención `08` |

---

## 8. Cómo se resolvió

**Verificación previa (solicitud 1).** Todas las citas al framework siguen literales en la base
(`IA.SDD` `main` `47be07d`, 13.15), y los pasajes del destino también (`Lab-Geometria` `main` `1ce1b2c`),
con dos precisiones: la clase «activo de construcción» de `Vista-Producto.md` está en una **celda de tabla**
(l.65) y en §3 (l.113), no en §3.1 ni con la forma corrida que §2.1 transcribe; y los once samples, las diez
fechas del 2026-08-11 y la del 2026-09-13 se reprodujeron por objetos commiteados. **Tres afirmaciones de la
especificación de la Feature 20 no son literales en la norma**: §18 del intake **no** atribuye D8 al
proyecto (`grep -c D8` = 0); ni `Migracion-Rules.md` §4.7 ni `Root-Rules.md` §11 dicen que el ADR con dos
saltos sea **el único** canal; y su §3.1 es la foto del 2026-09-06, anterior a la reestructuración. Detalle en
`PROMPTs/Fixs/08-Fix-Reporte-30/OUTPUTs/00-Verificacion-De-Citas-Y-Alcance.md`.

**Alcance (solicitud 2).** Cinco rutas con `SDD/Docs/`, **cuatro repositorios** (`Lab-Geometria-dc5` es un
worktree de `Lab-Geometria`). El proyecto de otro ecosistema y los samples que no se compilan alcanzan a **uno**,
`Lab-Geometria`; la construcción con la cadena de herramientas de más de un ecosistema, a **dos**: también
`RPI.VideoControl`, cuyo proyecto `VideoControl.PinMap` corre la cadena de JavaScript dentro de su propia
construcción, un caso que este reporte no había medido.

**§5.1, la decisión de fondo: sí.** El método reconoce el proyecto de otro ecosistema dentro de la solución de
código **cuando un proyecto de esa solución toma su artefacto como insumo de construcción**; si ninguno lo toma,
es su propia solución. El fundamento no es de preferencia: `Vocabulario-Rules.md` §2 delimita la solución por
**el comando de construcción**, y en el caso medido ese comando genera el bundle del visor a través del front.
El «no» habría obligado a declarar como consumo de artefacto publicado un artefacto que no se publica.
**`Vocabulario-Rules.md` no se modifica**: su definición por frontera sigue siendo exacta. La regla vive en
`Intake-Rules.md` §4.

**§5.2: una segunda clase de arista, `insumo de construcción`**, junto a `referencia de proyecto`, con **único
generador** y marca en la columna de dependencias; colisión medida en cero en los ocho lectores y en el árbol
vivo. **No se adoptó «activo de construcción»**, el nombre del destino: su forma desnuda ya es adjetivo y verbo
en `Master-Prompt.md` y `Rules-Examples.md`, y «insumo» ya tiene ahí el sentido que el término necesita.
**§5.3: sí**, en `Rules-Devops.md` §4.9 punto 4: un modo de construcción explícito donde falta la cadena, y sin él
la construcción **falla y la nombra** —la propiedad que `ADR-10008` y `VideoControl.PinMap` ya cumplían por su
cuenta—. **§5.4: sí**, `Rules-Examples.md` §3.6: dos formas de entrada al agrupador, la verificación **nunca**
enganchada a la construcción, la cobertura comprobada por enumeración **con un instrumento del destino** —el
reporte `12` no se reabre— y la forma del anfitrión mínimo de un artefacto que otro proyecto carga, tomada de P-6
y P-7 sin sus herramientas. **§5.5: sí**, §16.1 dice D8 de la unidad de entrega, y el barrido corrigió dos residuos
más en los archivos tocados y declaró cinco con su motivo. **§5.6: P-8 queda superada en su premisa** —la vía al
framework no estaba cerrada por la norma, y la comprobación 13 de la guía ya nombra un reporte como origen—, **y
la guía no se toca**: escribir ahí sobre especificaciones de destino rompería la autosuficiencia. La mitad de P-8
que niega un documento de `Conocimiento/` se sostiene. Fundamento completo en `OUTPUTs/10-Decision-De-Fondo-Y-Las-Cinco-Preguntas.md`.

**Aplicado: SDD 13.16, minor**, en ocho archivos: `Intake-Rules.md` 4.3, `Rules-Devops.md` 6.2,
`Rules-Examples.md` 6.6, `Rules-Arquitectura-Tecnica.md` 4.6, `Master-Prompt.md` 8.19,
`Catalogo-De-Criterios.md` 1.18, `PRODUCT-MANIFEST-template.md` 6.1 y `PRODUCT-INTAKE-template.md` 3.6, más la
nota `Coherencia-Proyecto-De-Otro-Ecosistema.md` y el snapshot `_legacy/13.15/` **entero** (130 archivos,
verificados blob por blob contra `main`, cero no conformes).

**Veredicto de los cinco criterios de §7:**

1. **§16.1 dice D8 de la unidad.** **Cumplido.** El `grep` de §2.2 a) ya no encuentra la instrucción: su única
   ocurrencia es la fila 3.6 del control de cambios que declara la corrección.
2. **El grafo admite la arista y `Vista-Producto` puede declararla sin inventar la clase.** **Cumplido**, con otro
   nombre que el del destino: `insumo de construcción` (`Rules-Arquitectura-Tecnica.md` §4.8 punto 3).
3. **Un manifiesto con un proyecto npm dentro de una solución .NET, sólo con el framework.** **Cumplido**,
   reproducido en `OUTPUTs/30` §3: perfil por ecosistema, fila del paquete, marca de la arista y único generador
   salen del texto. Lo único que el framework deja al destino es la forma concreta con que su ecosistema muestra
   un proyecto sin construirlo, y la regla lo declara así.
4. **Un sample que no se compila tiene forma declarada, y su verificación no se engancha a la construcción.**
   **Cumplido**, `Rules-Examples.md` §3.6, con un criterio `[enumerable]` y otro `[interpretativo]` en §6.
5. **Ningún texto normativo nombra una herramienta.** **Cumplido**: `grep -rn -i "NoTargets\|csproj\|webpack"
   SDD/Devs/Rules` vacío (`exit=1`) antes y después, y cero nombres de herramienta o ecosistema en las líneas
   agregadas a `SDD/Devs/Rules` y `SDD/Devs/Orchestrator`. El único lugar donde un ecosistema se nombra es el
   ejemplo del perfil de convención de `PRODUCT-MANIFEST-template.md` §1.2, que es el lugar declarado para eso.

**Qué le exige a `Lab-Geometria`**, que no se tocó: en su próxima migración, re-expresar «activo de construcción»
como `insumo de construcción` y marcar la arista `GeometriaFactory-Visor (insumo de construcción)` en §13.2 del
intake, con el manifiesto re-derivado; declarar el perfil del ecosistema npm en §1.2 en lugar de la «excepción
declarada» de identidad (apartamiento absorbido); re-expresar §16.1 del intake y el mapa de §2 de su
`Vista-Producto.md` sin D8 por proyecto. **Sobre los samples no le exige nada**: los once ya cumplen
`Rules-Examples.md` §3.6 en `main` `b58dec3`, fusionado durante esta intervención —entraron a
`GeometriaFactory.sln` como nodos sin construcción, ninguno con un target, y `scripts/verify-solution-tree.sh`
falla en CI si una carpeta queda afuera—. **Lo que ya cumple, además**: el único generador (`ADR-10008`) y la construcción que falla sin
la cadena salvo bandera explícita.

**Lo no verificado**: ninguna corrida del orquestador ejerció las validaciones nuevas de `Intake-Rules.md` §4 sobre
un intake real; no se construyó nada en ningún destino; y no se midió si `Pipeline-Producto.md` de
`RPI.VideoControl` declara los ambientes sin cadena (su `grep` por la cadena de JavaScript no devuelve nada, que
no prueba que falte).
