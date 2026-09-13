# Especificación — Estructura de solución con proyectos fuera del árbol .NET y sus samples

**Documento:** `OUPUTs/Especificacion-Estructura-Solucion.md`
**Versión:** 3.2
**Estado:** Corregido por mesa evaluadora (ciclos 1 y 2, 2026-09-11/12) — no modifica el `Framework SDD`. Sin escaladas pendientes
**Fecha:** 2026-09-11
**Origen:** tool-prompt `Agregar-BundleJS-Estructura-Solucion.md` (Feature 20), replanteo `02-Replanteo.md`, mesa `03-Incoporar-Analisis.md`
**Propósito:** condensar la evaluación, las propuestas y los debates para que **otro agente pueda reproducir** lo que se establezca, sin volver a relevar.

> **Cómo leer este documento.** §1 fija qué se leyó y en qué revisión. §2 dice qué establece hoy el
> `Framework SDD` (con cita). §3 describe los dos casos reales tal como están. §4 es el replanteo del
> Product Owner contrastado con la norma. §5 son las propuestas. §6 la estructura resultante y el
> ejemplo de `Lab-Geometria`. §7 el plan por repositorio. §8 escaladas y decisiones. §9 el registro de
> debates y el cierre de la mesa. Toda afirmación cita su fuente; lo no verificado se marca como tal.

---

## Tabla de contenido

- [§1 Evidencia relevada](#1-evidencia-relevada)
- [§2 Lo que el Framework SDD fija hoy](#2-lo-que-el-framework-sdd-fija-hoy)
- [§3 Los dos casos reales](#3-los-dos-casos-reales)
- [§4 El replanteo, contrastado con la norma](#4-el-replanteo-contrastado-con-la-norma)
- [§5 Propuestas](#5-propuestas)
- [§6 Estructura resultante](#6-estructura-resultante)
  - [§6.1 Ejemplo: `Lab-Geometria` con la propuesta aplicada](#61-ejemplo-lab-geometria-con-la-propuesta-aplicada)
- [§7 Plan por repositorio](#7-plan-por-repositorio)
- [§8 Escaladas y decisiones pendientes del Product Owner](#8-escaladas-y-decisiones-pendientes-del-product-owner)
- [§9 Registro de debates y cierre de la mesa](#9-registro-de-debates-y-cierre-de-la-mesa)
- [§10 Control de cambios](#10-control-de-cambios)

---

## §1 Evidencia relevada

| Fuente | Revisión / fecha | Qué aporta |
| --- | --- | --- |
| `/IA/SDD/IA.SDD/README.md` | `476f927`, leído 2026-09-11 | Modelo de tres repositorios; D8; `Conocimiento/`; «Reglas de intervención sobre el framework» |
| `/IA/SDD/IA.SDD/SDD/Devs/Intake/PRODUCT-INTAKE-template.md` §13, §14, §16, §16.1 | íd. | Árbol del repositorio; D8 es de la unidad de entrega (l. 358); columna «Integra con (runtime)» de §13.1 |
| `/IA/SDD/IA.SDD/SDD/Devs/Rules/Rules-Examples.md` §0, §0.1, §0.2, §1.2, §2.2, §2.3, §3.1, §3.4, §4.2, §4.5, §4.6 | íd. (6.5) | Las dos aristas; obligatoriedad por `redistribuible`; matriz y slugs; contrato de verificación |
| `/IA/SDD/IA.SDD/SDD/Devs/Rules/Root-Rules.md` §11 | íd. | Apartamiento declarado; candidato a regla por saltos |
| `/IA/SDD/IA.SDD/SDD/Devs/Rules/Migracion-Rules.md` §0, §4.7 | íd. | Alcance de la migración; quién declara un candidato a regla |
| `/IA/SDD/IA.SDD/SDD/Devs/Rules/Rules-Base-Conocimiento.md` §0.1, §0.4, §3.2, §4.4, §4.5, §6.1 | íd. (2.2) | Qué va en `Conocimiento/`; naturaleza; un tema por documento |
| `/IA/SDD/IA.SDD/SDD/Devs/Rules/Vocabulario-Rules.md` §2, §3, §9.2 | íd. | Proyecto de código sin D8; univocidad por sección |
| `/IA/SDD/IA.SDD/SDD/Devs/Orchestrator/Master-Prompt.md` §0, §3.5, §13 | íd. | Salidas fuera de `SDD/`; casos de escritura del intake |
| `/PROG2/Geometria/Lab-Geometria` | `89f3ab3`, 2026-09-06 | Repositorio real generado con SDD; proyecto Node `visor/`; samples implementados |
| `/PROG2/Geometria/Lab-Geometria.Documentacion/ia-db/` | v3.0, 2026-09-11 | Índices 02 y 05 |
| `<repo-privado-de-mapas>` | `e223662`, 2026-09-11 | Referencia del patrón `main.js` + bundle + RCL + sandbox + `examples/WebBlazor_JS` |
| `<repo-privado-de-mapas>.Documentacion/ia-db/` | v1.0, 2026-09-11 | Índices 00, 01, 03, 05 |
| `INPUTs/Idea-Central.md` | 2026-09-11 | **La convención normativa deseada** (§1–§14: `src/dotnet`, `src/javascript`, `poc/`, `main.js`, opciones de integración, `.gitignore`) |
| `INPUTs/Contexto-Biblioteca-Mapas.md` | 2026-09-11 | Descripción corta (13 líneas) de cómo está armado `<biblioteca-de-mapas>` y de qué es cada carpeta |
| `02-Replanteo.md` | 2026-09-11 | El replanteo del Product Owner: no hay PoC, hay samples con doble rol |
| Mesa evaluadora (ciclo 1) | 2026-09-11 | Siete especialistas + abogado del diablo; 49 hallazgos; veredictos en §9.2 |

**Correcciones de ruta.** El prompt cita `/PORG2/...`; es `/PROG2/...`. La carpeta de salida existe
como `OUPUTs/`. **Las versiones 1.0–2.1 de este documento atribuían a `Contexto-Biblioteca-Mapas.md` lo que
está en `Idea-Central.md`**; esta versión cita el archivo correcto.

---

## §2 Lo que el Framework SDD fija hoy

### §2.1 El árbol lo propone el intake; el framework fija `SDD/`, `/samples/` y `AGENTS.md`

`PRODUCT-INTAKE-template.md` §16: «Proponer el árbol `tree` con `/src`, `/tests`, `/samples` y la
carpeta `SDD/` [...] cada proyecto de código es `src/<NombreProyectoCodigo>/`». `Master-Prompt.md`
§3.5 (l. 363–364): `AGENTS.md` es «la única salida del orquestador que no vive bajo `SDD/`»; §0 (l. 8)
suma `/samples/` a la salida. Toda otra carpeta (`deploy/`, `scripts/`, `visor/`) es propuesta del
intake del producto, y **un apartamiento declarado en ese intake es un estado legal del producto,
no una deuda** (`Root-Rules.md` §11).

### §2.2 El sample ya tiene dos roles, y son obligatorios los dos

`Rules-Examples.md` §0.1, «Las dos aristas del sample»:

| Arista | Qué hace | A quién sirve |
| --- | --- | --- |
| **A — Referencia de integración** | «Demuestra cómo incorporar la unidad de entrega en una aplicación propia» | «Al integrador, que copia el patrón y lo adapta» |
| **B — Arnés de autovalidación** | «Verifica que cada incremento construido sigue satisfaciendo los casos de uso especificados» | «Al equipo que construye, y a los agentes de IA que codifican contra la especificación» |

«Ambas aristas viven en el mismo artefacto. Está prohibido partir el sample en una versión
ilustrativa y otra verificable». §0.1 también: cada sample «lleva un `Contrato de verificación`
(§4.6) [...] y ese contrato se ejecuta durante la codificación». §0.2: pasada **de diseño**
(esqueleto con README y comando previsto) y **de ejecución** («Durante la codificación, ante cada
incremento»). §4.6: `verifica`, `discrimina`, `comando`, `precondiciones`, `criterio_aceptacion`,
`evidencia`.

### §2.3 Titular, obligatoriedad y forma

- **El titular de la categoría 10 y del tipo D8 es la unidad de entrega, no el proyecto de
  código.** Intake l. 358: «**Los proyectos de código no llevan valor D8.** El tipo describe una forma
  de entrega». `Vocabulario-Rules.md` §2: el proyecto de código «No lleva valor D8 y no tiene árbol
  documental propio». `Rules-Examples.md` l. 4: nivel de aplicación «Unidad de entrega». (Residuo en
  contra dentro del propio framework: intake §16.1 y §18 todavía dicen «tipo D8 de cada proyecto de
  código»; se anota como observación al framework, no se usa como base.)
- **Obligatoriedad** (§0): «se condiciona por **quién va a consumir el artefacto**, y no por el tipo
  D8». `redistribuible == true` → obligatoria con progresión completa; `false` con
  `tiene_portal_developers == true` → obligatoria con piso reducido; `false` sin portal →
  recomendada, piso de **un** sample (§2.2). Y para `library` no redistribuible, §0 l. 26–28: «no
  tiene integrador que lo consuma por gestor de paquetes».
- **Forma**: §1.2 y §2.3 la fijan por D8 de la unidad —`rest-api` → «Cliente HTTP de referencia (curl
  + lenguaje del integrador típico)»; `library` → «Apps consumidoras progresivas»—; §2.2 admite
  «samples adicionales para cubrir capacidades extra»; §2.3: la tabla «se ajusta sólo agregando
  carpetas extra, nunca renombrando las base»; §3.1 lista los slugs admitidos (`basico`, `intermedio`,
  `avanzado`, `app-basica`, `integracion-real`, …). §3.4: el código de `/samples/` «debe garantizar
  que siempre compila contra la versión actual del producto».

### §2.4 Un bundle JS es un proyecto de código; el framework no tiene carpeta para él

D8 no tiene «bundle». En `Lab-Geometria` el visor es proyecto de código de la unidad
`GeometriaFactory-Web` (manifiesto §13.1; `Vista-Producto.md` l. 89 lo lista con tipo `library`,
`redistribuible: false`), en `visor/` fuera de `src/` **por apartamiento declarado** (l. 97), y sus
samples viven bajo `SDD/Docs/Unidades-Entrega/GeometriaFactory-Web/10-Examples/` (README l. 34: «se
consolidaron el 2026-08-16, absorbiendo los de `GeometriaFactory-Visor`»).

### §2.5 Qué instrumento corresponde a cada cambio

| Cambio | Instrumento normativo |
| --- | --- |
| Regla local que el método no contempla | ADR de apartamiento con seis campos (`Root-Rules.md` §11). Ausente sin ADR: hallazgo P0. Usarlo para evadir una condición que ya existe es anti-patrón |
| Candidato a regla del framework | Un apartamiento con **dos o más saltos de versión sobrevividos**, declarado en el informe de migración (`Migracion-Rules.md` §4.7). No existe el criterio «dos productos» |
| Cambiar el intake de un producto | `Master-Prompt.md` §13: dos casos, respuesta del humano o migración; «Si la respuesta agrega o cambia un proyecto de código, su tipo o una dependencia, la modificación se hace en `PRODUCT-INTAKE` §13; el orquestador re-deriva el `PRODUCT-MANIFEST`» |
| Reexpresar documentación generada por salto del framework | `Migracion-Rules.md` (sólo eso: §0 «Cuando el framework avanza») |
| Aportar oficio sin tocar la norma | `Conocimiento/` (`Rules-Base-Conocimiento.md` §0.1 «Describe el artefacto, no el método»; §0.4 modo **Sumar**). Un documento, un tema (§4.4); naturaleza `propio` salvo canon con nombre establecido (§3.2); condición de carga contra campos del intake (§7.1). Lo que define «qué sample produce la categoría 10» es regla, no conocimiento (§4.5 «Conocimiento disfrazado de regla») |
| Intervenir el framework | `README.md` «Reglas de intervención sobre el framework» + `CHANGELOG.md` + `_legacy/` |

---

## §3 Los dos casos reales

### §3.1 `Lab-Geometria` — el visor 3D

| Aspecto | Estado verificado | Fuente |
| --- | --- | --- |
| Proyecto JS | `visor/` en la raíz. Apartamiento declarado de ruta y de nombre. **Es decisión cerrada del producto**: `Norma-De-Nomenclatura.md` §6.11 (l. 759) «la raíz `visor/` del proyecto de código, que no se renombra»; intake §13 (l. 491) «Su carpeta es `visor/` en la raíz [...], no `src/geometriafactory-visor/`»; `PRODUCT-MANIFEST` l. 161 y l. 167 «**El visor no pertenece a `GeometriaFactory.sln`**» | archivos citados |
| Bundle | webpack, `library.type: window`, global `GeometriaFactoryViewer`, three.js adentro, sin `externals`, sin `devtool` (no hay `.map`) | `visor/webpack.config.js` |
| Contrato hacia el anfitrión | Seis funciones planas + `liveInstanceCount()`. `initialize(element, options)` recibe un `HTMLElement` y `options.onPieceSelected` (`contract.ts` l. 75): **cruzan DTO, un nodo DOM y un callback**. No hay JS interop de Blazor: `grep IJSRuntime\|JSInvokable\|DotNetObjectReference src/` vacío. El anfitrión es JS del front: `wwwroot/interaction/surface-interaction.js` l. 461–652 invoca las seis (`initialize` 461, `loadPieces` 470, `resize` 503/508, `destroy` 513, `selectPiece` 609, `setMotion` 652); el lado Razor sólo emite `data-gf-viewer-pieces` (`WorkView.razor` l. 314) | ia-db 05 §7.1; archivos citados |
| Bundle → `wwwroot` | `scripts/build-visor.sh` (`npm ci` → `npm run build` → `cp`). El `.csproj` **no** lo invoca: «Un clon limpio construye un front SIN VISOR y sin que nada falle» | `deploy/Dockerfile.web` l. 25–28 |
| Quién genera el bundle hoy | `build-visor.sh`, llamado por `scripts/build.sh` l. 21, `e2e.yml` l. 89–90, `scripts/pruebas-e2e.sh` l. 60–64 y la etapa 1 de `Dockerfile.web` (l. 37–48). `deploy-front-ftp.yml` l. 59–62 y `Dockerfile.web` l. 30–32 declaran el criterio «un solo lugar desde donde se genera el mismo artefacto» | archivos citados |
| Sello de caché | `<script src="js/geometriafactory-visor.js" defer>` sin `?v=` (`WorkSubmission.razor` l. 92, `WorkView.razor` l. 70) | archivos citados |
| `.sln` | 9 proyectos (6 `src/` + 3 `tests/`). Fuera: el visor, los 9 `.csproj` de `samples/` y `tests/GeometriaFactory.E2ETests/` (que `e2e.yml` l. 93 construye aparte) | `GeometriaFactory.sln`; `ls tests/` |
| Samples del visor | `samples/visor/01..03`, los tres con `index.html` (carga `../../../visor/dist/geometriafactory-visor.js` por `<script>` clásico; l. 31 en `01`, l. 35 en `02`/`03`), `anfitrion.js`, `datos/`, `esperado/`, `tests/*.mjs` (Playwright sobre `file://`), `package.json` con `verify`. `01-basico` «Implementado»; su anfitrión invoca **tres de las seis** funciones y no ejerce `onPieceSelected` (`README.md` §4; `grep onPieceSelected samples/visor/` vacío) | archivos citados |
| Banco de medición | `visor/verification/{lifecycle,stage-g}.{html,mjs}`: «BANCO DE MEDICIÓN de `PT-02`, y no una superficie del producto»; lo usan `scripts/verify-viewer-lifecycle.sh` l. 32/37 y `verify-stage-g.sh` l. 61/73 | archivos citados |
| Divergencias documentales | `samples/README.md` dice «Esqueleto — sin código» (2026-08-11) y enlaza 19 veces a `SDD/Docs/Proyectos/…`, ruta que no existe; `samples/visor/01-basico/README.md` dice «Implementado» y enlaza a `Unidades-Entrega/GeometriaFactory-Web/10-Examples/` | archivos citados |
| Ambiente | `.devcontainer/devcontainer.json` (SDK 10 + Node 22) es «el único ambiente»; el host no tiene `dotnet` en el PATH | `Plan-Etapa-A.md` §2.2; `which dotnet` |

### §3.2 `<biblioteca-de-mapas>` — el bundle de Google Maps

| Aspecto | Estado verificado | Fuente |
| --- | --- | --- |
| Proyecto JS | `JS.Bundle/Maps/GoogleMaps/` (`package.json` `googlemaps-wrapper`, `files: ["dist"]`) | `ls`, `package.json` |
| Qué se distribuye | **Dos archivos**: el bundle UMD `googlemaps.min.js` (`webpack.lib.js` l. 26) y el adaptador `js/main.js` copiado legible sin transpilar (`webpack.lib.js` l. 40–41), más `imgs/` | `webpack.lib.js` |
| Adaptador | `src/interop/main.js`: clase `MapBlazor` (`constructor(dotnetHelper, options)`, l. 8–12) + 8 exports: tres `async ...(dotnetHelper, options)` (l. 141, 174, 200), cuatro `async ...(idMaps, …)` (l. 226, 244, 266, 283) y `DisposeMapAsync(idMaps, forceClean)` síncrona (l. 300). Devuelve `false` y hace `console.log` ante error (l. 141–172); l. 119–122 tiene la condición de liberación invertida (`if(!this.mapService) { await this.mapService.DisposeAsync() }`) | `main.js` |
| El bundle no conoce .NET | `grep -rni "dotnet\|blazor" src --include=*.ts` → sin código (sólo comentarios de tipos en `interop.d.ts`) | verificado |
| Sandbox | `sandbox/pages/*.html` (8; `index.html` es un menú de `<a target="content-frame">`), **plantillas de `HtmlWebpackPlugin`** emitidas a `.sandbox/` por `webpack.sandbox.js` (l. 27 `PAGES_DIR`, l. 53 devuelve `[]` si la carpeta no existe), con `shared/env.js` **generado en cada build** con la clave de API (`config.js` l. 3–7) y páginas con `<script type="module">`. `sandbox/README.md` l. 5: «Las páginas de acá **no son ejemplos de uso**: `examples/WebBlazor_JS` cumple ese papel. Son un banco de pruebas» | archivos citados |
| Pruebas del paquete | `tests/e2e/{contrato,dibujo,frontera}.spec.js` con `webServer: npm run dev` (`playwright.config.js` l. 31–36, puerto 8082). `frontera.spec.js` recorre cuatro páginas con un solo invariante («nada que salga hacia .NET escapa a JSON»). 5 de 8 páginas tienen spec | archivos citados |
| `fake-blazor.js` | `METODOS_JSINVOKABLE = ['OnMarkerCoordenadaChanged', 'OnMarkerClick']` (l. 21). **Desactualizado**: `GoogleMaps.razor` l. 455 expone además `OnPolygonClick`, que el `main.js` **copiado** invoca y el `main.js` fuente no (commit `d903b56` tocó las copias, no el fuente); `contrato.spec.js` l. 60–61 afirma la lista vieja | archivos citados |
| DTO | `src/interfaces.ts` define `MarkerInfo`/`PolygonInfo` pero no se distribuye (`files: ["dist"]`); `Infos/PolygonInfo.cs` agrega `tipo`; el sandbox usa formas distintas (`{"Id","Latitud",…}` vs `label`) | archivos citados |
| Consumidores .NET | RCL `src/<Mapas>.Core.Blazor.Components/` (`GoogleMaps.razor` importa `./js/components/GoogleMaps/main.js` en 9 lugares, relativo al host, con mayúscula) + `examples/WebBlazor_JS/` (`ProjectReference` a la RCL; `App.razor` l. 20 carga el global por `<script>`; íconos `imgs/icon-rojo.png` relativos al host) | archivos citados; ia-db 01 §8 |
| Bundle → consumidor | Copia manual; tres copias de `main.js` (las dos de `wwwroot/` idénticas entre sí y distintas del origen) versionadas en git | ia-db 03 §1; `git ls-files` |
| `.sln` | `<Mapas>.Core.Blazor.Components.sln`: 3 `.csproj` + 2 «Web Site» .NET Fx 4.8 (`{E24C65DC-…}`) + Solution Folders con `SolutionItems`. **Los Web Site rompen `dotnet build` en Linux**: `MSB4249: Unable to build website project "GoogleMaps"`; al quitarlos hay que limpiar `NestedProjects` (`MSB5023`) | reproducido por la mesa sobre copia, SDK 10.0.400 |
| Restore | `NU1101: Unable to find package NgForms.Component` (csproj l. 23) sin `nuget.config` → «clon limpio + `dotnet build`» exige un feed privado | reproducido por la mesa |
| Publicación | `.github/workflows/static.yml` corre `npm run pages` desde `JS.Bundle/Maps/GoogleMaps` y publica `.sandbox/` en GitHub Pages (l. 44–67) | `static.yml` |
| `.gitignore` | El de `JS.Bundle/Maps/` ignora `dist`, `.sandbox`, `GoogleMaps/sandbox/lab/*`; el raíz sólo `node_modules/` | `git check-ignore -v` |

### §3.3 Lo que importa de la comparación

`samples/visor/01-basico` de Geometría y `sandbox/` de <biblioteca-de-mapas> **comparten la idea** (HTML que carga el
bundle, un anfitrión que hace las llamadas, datos, una prueba) pero **no son el mismo artefacto**:
el primero corre desde `file://`, con `<script>` clásico, sin red ni credencial, y lleva contrato de
verificación; el segundo se construye con webpack, exige un dev-server y una clave de Google Maps,
usa módulos ES, y su README dice que no es un ejemplo de uso. El replanteo del Product Owner pide
**un** sample HTML del bundle (`02-Replanteo.md`: «un proyecto simple html que integre»); no pide
convertir el banco de pruebas en ocho samples.

---

## §4 El replanteo, contrastado con la norma

| # | Idea del replanteo | Ya está en la norma | Falta |
| --- | --- | --- | --- |
| R-1 | «Esos poc serían en realidad samples» | Sí. «PoC» no existe en el conjunto normativo; arista A de §0.1 | Nada. Se retira `poc/` |
| R-2 | El sample prueba contratos durante «las fases de codeo y revisión» | Sí: arista B; contrato «se ejecuta durante la codificación»; §0.2 pasada de ejecución «ante cada incremento» | Que los repositorios lo cumplan (<biblioteca-de-mapas> no tiene contratos) |
| R-3 | La forma del sample la fija el consumidor | **Sí, en lo esencial**: §0 condiciona por «quién va a consumir»; §1.2 pide el cliente «en el lenguaje del integrador típico» y «apps consumidoras»; §2.2 admite capacidades extra. Lo que P-5 de la versión 2.x llamaba «regla nueva» son ejemplos de aplicación de esas tres | Ejemplos concretos (P-5), sin regla nueva |
| R-4 | «Esos samples son proyectos dentro de la solución» | No dice nada. Geometría no los tiene en el `.sln`; <biblioteca-de-mapas> sí (`WebBlazor_JS`) | Criterio de inclusión (P-7). Para el visor de Geometría, el manifiesto ya decidió que **no** pertenece al `.sln` → escalada ESC-001 |
| R-5 | Sample HTML con la estructura de <biblioteca-de-mapas> como guía del componente Blazor | Parcialmente: Geometría ya lo hizo (HTML + anfitrión + tests con contrato) | La forma canónica con sus **dos sub-formas** y lo que una guía debe contener para serlo (P-6) |

---

## §5 Propuestas

### P-1 · El proyecto JS es proyecto de código `library` de su unidad de entrega; su ruta la fija el intake del producto

**Cambio respecto de 2.x (veredicto G-02, 5-0): no se mueve `visor/`.** Un apartamiento declarado de
ruta es válido (`Root-Rules.md` §11) y en Geometría es decisión cerrada del producto (§3.1, tres
documentos). La mesa buscó un beneficio funcional de mover y no encontró ninguno: lo único que cambia
es una cadena de ruta en el target, en los guiones y en los filtros; y el costo es tocar 11
documentos vivos, dos `Dockerfile` (`COPY src/` arrastraría `node_modules`, 94 MB, sin
`.dockerignore`) y tres workflows. Si el Product Owner quisiera retirar el apartamiento, es decisión
suya por `Master-Prompt.md` §13, fuera de este documento.

Para un **producto nuevo**, la recomendación sí es `src/<identidad-npm>/` (cumple §16 sin
apartamiento; el nombre en minúscula es lo que §13 llama «declararlo» cuando el ecosistema fija la
forma). `src/dotnet/` + `src/javascript/` (Idea-Central §4) se descarta por contradecir §16 (DC-4).

### P-2 · La adaptación a Blazor: dos formas válidas, una obligación bien delimitada

**Definiciones** (faltaban en 2.x y hacían falsa la obligación):

- **Bundle**: la salida del `entry` del empaquetador (`googlemaps.min.js`; `geometriafactory-visor.js`).
- **Adaptador**: el código que conoce `DotNetObjectReference` o el DOM del anfitrión (`main.js`;
  `surface-interaction.js`). Puede distribuirse junto al bundle (<biblioteca-de-mapas> copia `main.js` a `dist/`)
  **sin ser parte de él**.

**Obligación**: el bundle no conoce Blazor ni .NET (verificado en los dos repos: §3.1, §3.2). Lo que
cruza la frontera bundle ↔ adaptador son **DTO serializables más un canal de retorno declarado**: el
`dotnetHelper` en la forma 1, un callback en las opciones en la forma 2. «Sólo DTO planos», tal como lo
decía 2.x, es falso en ambos repos y se retira.

| Forma | Dónde vive el adaptador | Qué le exige al anfitrión | Canal JS → .NET | Quién la usa |
| --- | --- | --- | --- | --- |
| **1 — Adaptador en el paquete** (`src/interop/main.js`: clase `<Nombre>Blazor` + `export async function ...Async(dotnetHelper, options)`) | En el paquete JS, distribuido junto al bundle | Cargar el global por `<script>` clásico **y** el adaptador por `import` de módulo ES (`interop.d.ts` l. 11–14; `GoogleMaps.razor` l. 212); escribir los `[JSInvokable]` que el adaptador invoca | Sí: `dotnetHelper.invokeMethodAsync` | <biblioteca-de-mapas> |
| **2 — Fachada plana + adaptador en el anfitrión** | En el front, como JS propio que lee el DOM | Cargar el global por `<script>` clásico; emitir los datos en el marcado (`data-*`) | No hay JS interop; el retorno es un callback JS (`onPieceSelected`) que el adaptador del front resuelve | Geometría (`ADR-10006`, `ADR-12002`) |

**No son intercambiables para un integrador** (hallazgo H-INT-04): quien elija la 2 no obtiene un
componente Blazor con callbacks hacia .NET; quien elija la 1 hereda dos mecanismos de carga. La 1 es
la que conviene cuando el bundle va a una RCL reutilizable, porque el integrador recibe el adaptador
hecho. Se elige por producto en un ADR de 05.

### P-3 · La relación bundle → `wwwroot` la declara el `.csproj` consumidor, y es el único generador

Sin cambio de rumbo respecto de 2.x, con cuatro correcciones que la mesa reprodujo o evidenció:

1. **El artefacto generado se declara como `Content` dentro del propio Target**, con ruta relativa al
   proyecto. Sin eso, un archivo escrito en `wwwroot/` durante el build **no entra al manifiesto de
   Static Web Assets en el primer build** (`ResolveProjectStaticWebAssets` toma `@(Content)` evaluado
   antes de correr targets): reproducido con SDK 10.0.400 —endpoint ausente en el build 1, presente
   en el 2; `publish` desde limpio con `Endpoints: []`—. Vale para el front (Geometría) y para la RCL
   por `_content/` (<biblioteca-de-mapas>).
2. **El Target corre en todo `build`, `publish` y `test`** (`Integration.Tests` referencia
   `Web.csproj`). Donde no hay Node se pasa `-p:SkipVisorBuild=true`: la etapa `sdk:10.0` de
   `Dockerfile.web` (l. 78) y cualquier `dotnet test` sin red. La etapa `node:22` del `Dockerfile.web`
   **se conserva** y deja de ser opcional.
3. **Un único generador.** El Target reemplaza a las invocaciones directas de `build-visor.sh`:
   `scripts/build.sh` l. 21, `e2e.yml` l. 89–90, `scripts/pruebas-e2e.sh` l. 60–64 y el aviso de
   `tests/GeometriaFactory.E2ETests/Infraestructura/BancoLocal.cs` l. 283–297 se retiran o se
   reescriben para invocar `dotnet build`. El guion queda como lo que el Target ejecuta.
4. **Sello de caché derivado del build.** Idea-Central §9.1 pide que la versión «DEBERÍA generarse
   desde el proceso de build [...] no escribirse a mano», y hoy Geometría no tiene sello (§3.1) y
   <biblioteca-de-mapas> lo escribe a mano (`ComponentVersion.cs` l. 5). Con P-3 el bundle cambia en cada build con
   el mismo nombre: sin sello, el navegador sirve el anterior. Opción a verificar primero en el
   devcontainer: `MapStaticAssets` + `@Assets["js/…"]` de .NET 9+ (huella por contenido), que
   convive con la declaración `Content` del punto 1; si no aplica al modo de render del producto,
   sello por hash del archivo generado en el Target. **Marcado como a verificar, no como texto
   cerrado** (veredicto 4-1).

**Alternativa evaluada y no adoptada por defecto** (veredicto G-04d, 4-1): un nodo de proyecto
`Microsoft.Build.NoTargets` en `src/<paquete>/` como dueño del build, con el consumidor por
`ProjectReference ReferenceOutputAssembly="false"`. La mesa lo reprodujo (build limpio, 0 warnings,
endpoint presente, segundo build salteado, `dotnet sln add` funciona) y **es la salida correcta
cuando dos consumidores del mismo repositorio construyen el mismo bundle**, caso que hoy no existe en
ninguno de los dos productos. En Geometría además convertiría el visor en arista del grafo de la
solución, contra el manifiesto l. 167–169. Queda registrada con su condición.

Esbozo corregido (Geometría; rutas con `visor/` en la raíz):

```xml
<!-- GeometriaFactory.Web.csproj -->
<PropertyGroup>
  <VisorDir>$(MSBuildThisFileDirectory)../../visor/</VisorDir>
  <VisorBundle>wwwroot/js/geometriafactory-visor.js</VisorBundle>
</PropertyGroup>

<ItemGroup>
  <VisorSource Include="$(VisorDir)src/**/*.ts;$(VisorDir)package-lock.json;$(VisorDir)webpack.config.js" />
</ItemGroup>

<Target Name="BuildVisor" BeforeTargets="BeforeBuild"
        Inputs="@(VisorSource)" Outputs="$(VisorBundle)"
        Condition="'$(SkipVisorBuild)' != 'true'">
  <Exec Command="bash $(MSBuildThisFileDirectory)../../scripts/build-visor.sh" />
</Target>

<!-- Declarar el generado como contenido estático AUNQUE el Target se haya salteado -->
<Target Name="DeclareVisorAsset" BeforeTargets="ResolveProjectStaticWebAssets" AfterTargets="BuildVisor"
        Condition="Exists('$(VisorBundle)')">
  <ItemGroup>
    <Content Include="$(VisorBundle)" />
  </ItemGroup>
</Target>
```

Cerrado en el ciclo 2 (reproducido): `TreatWarningsAsErrors` de `Directory.Build.props` **no**
convierte en error las advertencias que emite un `Exec` (sólo `-warnaserror` lo hace); el build real
de webpack del visor sale sin advertencias; el SDK NoTargets no altera `Deterministic` ni la puerta;
no hace falta `global.json` (versión en línea). Si el producto quiere que `QG-01` alcance al Target,
`build.sh`/CI pasan `-warnaserror`. Queda abierto (nivel C) el costo de `npm ci` por disparo.

Con la opción D adoptada en P-7 este esbozo queda tal cual; con la alternativa C el consumidor se
reduce a una `Content` con `Link` a `visor/dist/` dentro de un Target y **hay que retirar antes la
copia física de `wwwroot/js/`** (si coexisten, `MSB4018` por clave duplicada en la compresión).

### P-4 · No hay `poc/`: hay samples con las dos aristas, y hay instrumentos que no son samples

| Artefacto | Qué es | Dónde va | Contrato |
| --- | --- | --- | --- |
| Página HTML que carga el bundle con anfitrión, datos y prueba | **Sample** de la unidad de entrega que contiene al bundle | `samples/<segmento>/XX-<slug>/` | `VER-XXXXX` (§4.6) |
| Aplicación .NET que consume la RCL / el NuGet / la REST | **Sample** de la unidad consumida | `samples/<segmento>/XX-<slug>/` | `VER-XXXXX` |
| Banco de medición de una puerta de calidad (`visor/verification/`) | Instrumento de la categoría 08 | Con el paquete | Es la puerta (`PT-02`); no lleva `VER` |
| **Banco de trabajo del paquete con pruebas propias** (`sandbox/` + `tests/e2e/` de <biblioteca-de-mapas>) | Instrumento de desarrollo del paquete; su README lo declara «no son ejemplos de uso» | Con el paquete (`sandbox/`, `tests/`); se publica a Pages como hoy | Sus specs; no `VER` |
| Páginas de exploración sin aserción (`sandbox/lab/`) | Trabajo en curso | Con el paquete, ignoradas por git como hoy | Ninguno |

**Fila nueva respecto de 2.x** (veredicto G-05, hallazgo H-ADD-01): el sandbox de <biblioteca-de-mapas> **no se
convierte en ocho samples**. Su spec `frontera.spec.js` verifica un invariante transversal sobre
cuatro páginas; partirlo sería el anti-patrón «contrato duplicado como test separado» (§4.5) y tres
páginas sin spec (`index`, `ver-todo`, `ver-markers-json-many-windows`) quedarían degradadas por una
regla que el Product Owner no pidió. DC-1 se sostiene en lo que dice: no hay carpeta `poc/`.

Regla derivada de §0.1: **un sample sin contrato no es sample** (es lo que §4.2 ítem 9 llama «demo»).
`<segmento>` es la convención de carpeta que Geometría declaró como «carpeta extra» de §2.3
(`samples/README.md` §2) y se deriva del proyecto de código que el sample ejercita, en minúscula
(`domain`, `visor`, `web`); para <biblioteca-de-mapas>: `googlemaps` (bundle) y `blazor` (RCL).

### P-5 · La forma del sample según el consumidor previsto: ejemplos de aplicación de la norma, no regla nueva

**Degradada respecto de 2.x** (veredicto G-06, 5-0): todo lo que sigue se deduce de §0 («quién va a
consumir»), §1.2 («lenguaje del integrador típico», «apps consumidoras») y §2.2 («capacidades
extra»). El titular es la **unidad de entrega**, y el consumidor previsto se lee de la columna
«Integra con (runtime)» de §13.1 del intake (no de §14, que pregunta por el usuario final).

| Unidad que emite la 10 | Consumidor previsto (§13.1 «Integra con») | Sample | Slug (§3.1, sin desvío) |
| --- | --- | --- | --- |
| `rest-api` | Aplicación web | App web mínima que hace las invocaciones reales | `01-cliente-http-basico` en el lenguaje del integrador |
| `rest-api` | NuGet de integración del mismo producto | El sample del NuGet consume la API a través del NuGet; el cliente HTTP básico de la API **sigue existiendo** porque verifica el contrato antes de que el NuGet exista (R-2) | `01-cliente-http-basico`, `02-postman-collection` |
| `library` NuGet para MAUI | Aplicación MAUI | Proyecto MAUI que usa la librería | `01-app-basica` |
| Unidad que contiene un bundle JS | RCL del mismo producto | Sample HTML del bundle (P-6) **y** app Blazor que consume la RCL | `01-basico` / `01-app-basica` |
| Unidad que contiene un bundle JS | **Front propio del producto, sin RCL** (caso Geometría) | Sample HTML del bundle (P-6). No hay sample «Blazor» aparte: el front es el producto, y `web-monolith` tiene `datos-seed`/`tema-custom` (§2.3) | `01-basico`, `02-intermedio`, `03-avanzado` |

Un sample que ejercita dos productores (`WebBlazor_JS` consume la RCL por `ProjectReference` y el
bundle por copia) se ubica bajo el segmento de la unidad que **el integrador consume** (la RCL), y su
contrato declara a los dos.

### P-6 · Forma canónica del sample de un bundle JS: dos sub-formas, y lo que una guía debe contener

**Reescrita** (veredicto G-05). Hay dos sub-formas porque el mecanismo de carga y de servicio
difiere, y ningún sample real cumple las dos a la vez:

| | Sub-forma **A — archivo local** | Sub-forma **B — servida** |
| --- | --- | --- |
| Adaptación (P-2) | Forma 2: bundle global por `<script>` clásico; anfitrión JS propio | Forma 1: bundle global + adaptador por `import` de módulo ES |
| Cómo se abre | `file://` (los módulos ES no cargan así; por eso A exige `<script>` clásico) | Servidor estático o `webServer` de Playwright sobre HTTP |
| Dependencias externas | Ninguna: sin red, sin credencial (`samples/visor/01-basico/README.md` l. 29) | Las del proveedor (clave de API por `shared/config.js`, nunca literal; CDN) |
| Doble de .NET | No hace falta | `shared/fake-blazor.js` con `METODOS_JSINVOKABLE` |
| Modelo real | `samples/visor/01-basico` (Geometría) | `sandbox/` de <biblioteca-de-mapas>, **reducido a una página con contrato** |

Estructura (los elementos marcados `B` sólo en la sub-forma B):

```text
samples/<segmento>/01-basico/
├── README.md                 # copia corta del ejemplo-01-basico.md: objetivo, comando, contrato
├── package.json              # scripts: verify (= comando del contrato); B: además serve
├── index.html                # carga el bundle CONSTRUIDO desde ../../../src|<raiz-js>/dist/, no una copia
├── shared/
│   ├── config.js             # opciones comunes; ninguna clave literal (<biblioteca-de-mapas> config.js l. 3–7)
│   └── fake-blazor.js        # B: doble de DotNetObjectReference con METODOS_JSINVOKABLE
├── anfitrion.js              # el anfitrión mínimo: invoca la fachada y nada más (Geometría)
├── datos/                    # escenarios, un archivo por escenario, nombrados por id del intake
├── esperado/                 # salida esperada del contrato (Geometría la tiene; se conserva)
└── tests/                    # la prueba que ejecuta el contrato (conductor de navegador)
```

La ruta desde `samples/<segmento>/01-basico/` hasta la raíz del repositorio tiene **tres niveles**
(`../../../`), como en Geometría; 2.x decía dos.

**Qué tiene que contener para ser la guía del componente Blazor** (hallazgos H-INT-01/02; hoy no lo
es en <biblioteca-de-mapas>):

1. **La lista de `[JSInvokable]` derivada de una sola fuente y verificada**: una prueba que falle si
   `METODOS_JSINVOKABLE`, el `main.js` fuente y el `.razor` divergen (hoy divergen: §3.2).
2. **Los DTO tipados en un artefacto distribuido** (`interop.d.ts` o `interfaces.ts` dentro de
   `dist/`), no reconstruidos a mano en `Infos/*.cs`.
3. **El caso de error de cada función con su valor de retorno** afirmado por la prueba.
4. **El recorrido de liberación con aserción** (`liveInstanceCount` en Geometría; `DisposeMapAsync`
   nunca se invoca en <biblioteca-de-mapas>).
5. **La fachada completa cubierta por el conjunto de samples**, no por cada uno: `anfitrion.js` de
   `01-basico` invoca tres de seis funciones y no ejerce el callback; la afirmación «es la lista de
   llamadas que el front hace» vale sobre `01+02+03` sólo si `02` y `03` cubren el resto y
   `onPieceSelected`.

### P-7 · Los samples y el paquete JS son proyectos de la solución (DC-5)

**Decisión cerrada del Product Owner (2026-09-11, respuesta a ESC-001): «todos los proyectos quedan
bajo el árbol de solución de Visual Studio, aunque sea bajo carpetas virtuales» (DC-5).** El ciclo 2
de la mesa comparó tres formas de cumplirla y adoptó **D** (5-0):

| Opción | Qué es | Cumple DC-5 | Costo verificado | Veredicto |
| --- | --- | --- | --- | --- |
| **B** | Solution Folder con `SolutionItems` | Sí, el día que se escribe la lista | Archivo por archivo, sin globs, sin CLI; un `.ts` nuevo no aparece (`grep` = 0); `dotnet sln list` no lo muestra | Descartada: envejece en silencio |
| **C** | `visor/visor.csproj` NoTargets **dueño del build** + `ProjectReference` desde `Web` + `Content` con `Link` | Sí | Reproducida y funciona (publish limpio en una invocación, huella de contenido, incremental), pero: convierte el `.sln` en dueño de `npm` —el «estorbo» que intake l.424 y l.491 declaran evitar—; **`MSB4018` en todo clon ya construido** mientras exista la copia física en `wwwroot/js/` (clave duplicada en la compresión de Static Web Assets); tres entradas major en el intake (§13.2, §13.3, §16), manifiesto §2/§3/§4 y `Vista-Producto` §3.1 (major), `Pipeline-Producto`, `Plan-Etapa-A`; `COPY visor/visor.csproj` obligatorio en `Dockerfile.web` (si falta, `publish --no-restore` termina en 0 con `warning MSB9008`) | **Alternativa condicionada** a dos consumidores del mismo bundle en el mismo repositorio, con cinco condiciones (excludes; `Content`+`Link`; tres cambios en `Dockerfile.web`; `verify` fuera de `Build`; retiro previo de la copia física con su lista de dependientes) |
| **D** | `visor/geometriafactory-visor.csproj` NoTargets **inerte**: `EnableDefaultItems=false`, un `None Include="src/**/*.ts;package.json;package-lock.json;webpack.config.js;tsconfig.json"`, sin `Exec`, sin `ProjectReference`, sin Target; `dotnet sln add --solution-folder visor` | Sí: visible por glob | Reproducido: `dotnet build GeometriaFactory.sln` 0/0 con `npm` ausente del PATH; `dotnet sln list` lo muestra; un `.ts` nuevo aparece sin editar nada. Costos: el paquete `Microsoft.Build.NoTargets` en el restore (Api, Infrastructure y los tests ya exigen NuGet); el nombre del archivo de proyecto = `Identidad-Codigo` (`geometriafactory-visor`), anotado en intake §13.3; `dotnet sln add` en SDK 10 inyecta plataformas `x64`/`x86` (84 líneas) que se limpian a mano | **Adoptada.** P-3 queda intacto (el Target del consumidor sigue siendo el generador); la arista `Visor → Web` sigue siendo «activo de construcción» |

| Sample | Cómo entra al agrupador | Cómo referencia al producto |
| --- | --- | --- |
| `.csproj` (cliente web, app MAUI, consumidor de RCL/NuGet, consola) | Como proyecto, bajo Solution Folder `samples`, **y se construye con la solución**: es la forma de cumplir `Rules-Examples.md` §3.4 («su CI debe garantizar que siempre compila contra la versión actual del producto»). Los nueve de Geometría construyen en Release con `TreatWarningsAsErrors` en 0/0 (verificado dos veces). **Diez textos del repositorio dicen «NO ENTRA EN `GeometriaFactory.sln` A PROPÓSITO»** por temor a `QG-03` (siete `.csproj`, tres README de `samples/domain/`): se reescriben, y `scripts/coverage.sh` verifica que `QG-03` no cambia; si cambiara, esos proyectos quedan en el `.sln` sin `.Build.0` (visibles, no construidos) y se registra | `ProjectReference`. Para `redistribuible == false` **no hay desvío que declarar**: §0 excluye el gestor de paquetes para `library` no redistribuible. Para `redistribuible == true`, el sample `avanzado`/`integracion-real` pasa a `PackageReference` al publicar; **cláusula no ejercida hoy** |
| HTML del bundle (P-6) | `SolutionItems` bajo `samples/<segmento>/0N`, o nodo NoTargets inerte como el visor. **Su `verify` nunca se engancha a `Build`**: con Playwright sin navegador instalado rompe `dotnet build` de toda la solución (`MSB3073`, reproducido) | Carga `dist/` del paquete; el contrato se corre con `npm run verify` |

Hechos que acotan «proyecto de la solución»:

- Los «Web Site» .NET Fx 4.8 de `<Mapas>.Core.Blazor.Components.sln` **no son inocuos**: rompen
  `dotnet build` en Linux (`MSB4249`) antes de compilar nada. Retirarlos (con su `NestedProjects`) es
  **precondición** de todo el plan §7.2.
- SDK 10 emite `.slnx` por omisión en `dotnet new sln`; `dotnet sln migrate` conserva `SolutionItems`
  como `<File Path=…>`. No se propone migrar.
- `tests/GeometriaFactory.E2ETests/` existe, `e2e.yml` lo construye y no está en el `.sln`: bajo DC-5
  entra (D-4).

### P-8 · Cómo se lleva al framework sin modificarlo

**Degradada** (veredicto G-08, 5-0). Lo que 2.x llamaba «documento de `Conocimiento/`» mezclaba
método (P-5, P-7: qué sample produce la categoría 10 y cómo entra al agrupador) con artefacto (P-2,
P-6). Lo primero está excluido de `Conocimiento/` por `Rules-Base-Conocimiento.md` §0.1 y §4.5; lo
segundo ya vive donde se consulta (`sandbox/README.md` §«Las dos mitades del contrato»,
`fake-blazor.js` l. 1–13, `ejemplo-0N-*.md`, `ADR-10006`, `ADR-12002`, y este documento).

Lo que queda:

- **D-5**: no emitir el documento de `Conocimiento/` por ahora. Si se emite más adelante, son **dos**
  documentos de naturaleza `propio` (forma del sample HTML de un bundle; adaptación bundle ↔ Blazor),
  con condición de carga contra §13.1/§13.2 del intake y ofuscación con lista de términos buscados.
- **Candidatos a regla**: el único canal es un ADR de apartamiento que sobreviva **dos o más saltos**
  del framework y sea declarado en un informe de migración (`Migracion-Rules.md` §4.7). Hoy ningún
  candidato tiene ADR: el apartamiento de Geometría está declarado en manifiesto e intake, no como ADR
  con estado y contador. Se registran como **observaciones al framework**, sin vehículo todavía:
  (a) intake §16.1 y §18 dicen «tipo D8 de cada proyecto de código» contra §13.2; (b) `Vista-Producto`
  necesitó inventar la clase «activo de construcción» para una arista que ningún `.csproj` expresa;
  (c) §13 no tiene ejemplo de identidad de código con la forma del ecosistema npm.

---

## §6 Estructura resultante

Nombres neutros; **para un producto nuevo**. Manda el intake §16; se toma de Idea-Central lo que no lo
contradice.

```text
<Repositorio>/
├── <Raiz-Codigo>.sln                      # .NET de src/ y tests/ + samples .csproj + Solution Folders (P-7)
├── Directory.Build.props · .gitignore     # bin/ obj/ node_modules/ **/dist/ <front>/wwwroot/js/*.js
├── README.md · changelog.md · AGENTS.md
├── src/
│   ├── <Raiz>.Api/                        # rest-api
│   ├── <Raiz>.Integracion/                # library NuGet que consume la API
│   ├── <Raiz>.Web/                        # front; su .csproj construye, copia y DECLARA el bundle (P-3)
│   │   └── wwwroot/js/                    # generado; README.md + .gitkeep
│   ├── <Raiz>.Mapas.Blazor/               # RCL que integra el bundle por _content/ (P-3)
│   └── <paquete-js>/                      # library, identidad npm; en un producto ya emitido, donde su intake lo fije (P-1)
│       ├── package.json · webpack.config.js · tsconfig.json
│       ├── src/ (interop/main.js · interop/interop.d.ts · *.ts)   (P-2 forma 1)
│       ├── sandbox/ · tests/              # banco de trabajo y pruebas del paquete (P-4); no son samples
│       ├── verification/                  # bancos de medición de puertas 08 (P-4)
│       └── dist/                          # generado
├── tests/
│   └── <Raiz>.*.Tests/
├── samples/                               # Rules-Examples.md; cada carpeta con VER-XXXXX (P-4)
│   ├── api/01-cliente-http-basico/        # verifica el contrato ANTES de que exista el NuGet
│   ├── api/02-postman-collection/
│   ├── integracion/01-basico/             # app que consume el NuGet por ProjectReference (P-7)
│   ├── <segmento-js>/01-basico/           # HTML con la forma de P-6 (sub-forma A o B)
│   └── blazor/01-app-basica/              # app Blazor que consume la RCL
├── deploy/ · scripts/
└── SDD/                                   # Intake/ Docs/ Maquetas/
```

**Descartado de Idea-Central:** `src/dotnet`/`src/javascript` (§4; contradice intake §16); `poc/` y
`examples/` como carpetas separadas (§4, §5; R-1); `tests/javascript/` (las pruebas viven con el
paquete y con el sample); `artifacts/` centralizado (§6.4 recomienda postergarlo).

**Tomado de Idea-Central:** §6 (artifact = generado, no se versiona), §7.1 (forma del paquete), §8.1
(integración declarada en el build) y §8.2 opción A (Target) con sus «consideraciones honestas», §9
(`main.js` como contrato; l. 390–392 «La PoC consume el mismo archivo que consumirá Blazor; si
estuviera duplicado, la PoC dejaría de probar el contrato real»), §9.1 (sin versión en el nombre
físico **y** sello generado desde el build), §10 (`fake-blazor.js`; no promover código de PoC), §12
(`.gitignore`).

### §6.1 Ejemplo: `Lab-Geometria` con la propuesta aplicada

Estado de partida: `89f3ab3`, inventario de §3.1. **Con P-1 corregida, el visor no se mueve.** Lo
marcado `←` cambia; lo demás queda como está.

```text
Lab-Geometria/
├── GeometriaFactory.sln                        ← + `visor/geometriafactory-visor.csproj` (nodo inerte, D) bajo folder `visor`; Solution Folder `samples` con los 9 Sample.*.csproj; E2ETests (D-4); limpiar plataformas x64/x86 que inyecta `dotnet sln add`
├── Directory.Build.props · .editorconfig
├── .gitignore                                  (sin cambio: `visor/dist/` l. 439 y `wwwroot/js` l. 442–444 siguen válidos)
├── README.md · AGENTS.md · changelog.md
├── src/
│   ├── GeometriaFactory.{Domain,Contracts,Application,Infrastructure,Api}/   (sin cambio)
│   └── GeometriaFactory.Web/
│       ├── GeometriaFactory.Web.csproj         ← targets BuildVisor + DeclareVisorAsset (P-3)
│       ├── Components/Pages/WorkSubmission.razor · WorkView.razor   ← sello de caché (P-3.4, a verificar)
│       └── wwwroot/js/                         destino generado; README.md + .gitkeep (sin cambio)
├── visor/                                      (sin cambio de ruta: apartamiento vigente, P-1)
│   ├── geometriafactory-visor.csproj           ← nodo NoTargets inerte (P-7, opción D): EnableDefaultItems=false + None Include de src/**/*.ts y config; sin Exec ni ProjectReference
│   ├── package.json · package-lock.json · tsconfig.json · webpack.config.js
│   ├── src/{main.ts,contract.ts,viewer/}
│   ├── verification/                           instrumento de PT-02 y etapa g (P-4); sin cambio
│   └── dist/                                   generado; ignorado
├── tests/
│   ├── GeometriaFactory.{Domain,Application,Integration}.Tests/
│   └── GeometriaFactory.E2ETests/              (fuera del .sln hoy; decisión D-4)
├── samples/
│   ├── README.md                               ← estado real por carpeta y enlaces a Unidades-Entrega/ (hoy 19 enlaces rotos a Proyectos/)
│   ├── domain/·application/·infrastructure/    ← 9 Sample.*.csproj entran al .sln y se construyen; reescribir los 10 textos «NO ENTRA … A PROPÓSITO» (7 csproj + 3 README); coverage.sh verifica QG-03
│   ├── contracts/{01,02,03}/                   esqueleto (README.md); entran al .sln cuando se implementen
│   ├── api/{01,02,03}/ · web/01-datos-seed/    run.sh; Solution Folder con SolutionItems (opcional)
│   └── visor/{01-basico,02-intermedio,03-avanzado}/   ← sólo lo que P-6 exige y falta: cobertura de las seis funciones + onPieceSelected en el conjunto (punto 5); el resto (index.html, anfitrion.js, datos/, esperado/, tests/) ya cumple la sub-forma A
├── deploy/
│   ├── Dockerfile · compose.yaml               (sin cambio)
│   └── Dockerfile.web                          ← l. 78: `-p:SkipVisorBuild=true`; la etapa node:22 se conserva
├── scripts/
│   ├── build-visor.sh                          (sin cambio: lo ejecuta el Target)
│   ├── build.sh                                ← l. 21: se retira la llamada directa (P-3.3)
│   ├── pruebas-e2e.sh                          ← l. 60–64: ídem
│   └── verify-viewer-lifecycle.sh · verify-stage-g.sh   (sin cambio: `visor/` no se mueve)
├── .github/workflows/
│   ├── ci.yml                                  ← si corre `dotnet test` sin Node, `-p:SkipVisorBuild=true`; el comentario l. 6 no es un filtro
│   ├── e2e.yml                                 ← l. 89–90: se retira la llamada directa (P-3.3)
│   └── deploy-front-ftp.yml                    (sin cambio: `paths: visor/**` l. 31 sigue válido)
├── tests/GeometriaFactory.E2ETests/Infraestructura/BancoLocal.cs   ← l. 283–297: el aviso «lo genera build-visor.sh» pasa a «lo genera dotnet build»
└── SDD/                                        ← intake §13.2 l.420/424 («Solución de código: Ninguna» → GeometriaFactory.sln, nodo sin construcción) por Master-Prompt §13 caso (a), major, una entrada, _legacy/; §13.3 anota el nombre del archivo de proyecto; PRODUCT-MANIFEST re-derivado (l.146, 157, 167–169; l.218, 229–232, 250 caen por P-3); Vista-Producto l.113 (minor); Plan-Etapa-A l.279 (minor); ADR nuevo en Web/05; Web/09 y ADR-12006 §7 por P-3. La Norma no cambia (P-1)
```

**No hay `shared/fake-blazor.js` en los samples del visor, y es correcto**: sub-forma A (P-6).

**Lo que entra a `GeometriaFactory.sln`** (P-7, DC-5): `visor/geometriafactory-visor.csproj` (nodo
inerte) bajo folder `visor`; los 9 `Sample.*.csproj` bajo folder `samples`, construidos;
`contracts/*` cuando existan sus `.csproj`; `api/`, `web/` y `visor/0N` como `SolutionItems` o
nodos inertes (con `verify` fuera de `Build`); `tests/GeometriaFactory.E2ETests` (D-4).

**Documentación de Geometría que cambia, y por qué instrumento**: el **intake** §13.2 (l.420
«Solución de código: **Ninguna**», l.424 «El visor no pertenece a ninguna solución de código») por
`Master-Prompt.md` §13 caso (a) —respuesta del humano, **major** porque reescribe una sección
aprobada, atómica, `_legacy/`— y el **manifiesto se re-deriva**, no se edita (l.1608). Los
**generados** (`Vista-Producto.md` l.113; `Plan-Etapa-A.md` l.279 «6 + 3»; ADR nuevo en `Web/05`;
`Web/09`) por `Master-Prompt.md` §5, con `_legacy/`. **Nada por `Migracion-Rules.md`** (rige sólo
cuando el framework avanza). El apartamiento de ruta y nombre **no cambia de estado**: sus dos
objetos siguen iguales. `samples/README.md` se corrige contra el estado real **con la evidencia
de cada contrato** (campo `evidencia` de los `ejemplo-0N-*.md`), no por transcripción.

**Qué NO cambia.** Los siete proyectos de código, sus tipos, el grafo de ocho aristas y la clase
«activo de construcción» de `Visor → Web`, los diecinueve contratos `VER`, `visor/` y su
apartamiento, `verification/`, los guiones `verify-stage-*.sh`, las puertas `QG`/`PT`, el devcontainer
como único ambiente, `.gitignore`, `deploy-front-ftp.yml`, `build-visor.sh`.

---

## §7 Plan por repositorio

Ningún paso se ejecutó. Ambiente de ejecución y de verificación de **todos** los pasos: el
devcontainer del repositorio (no hay `dotnet` en el host). Cada paso lleva su criterio evaluable.

### §7.1 `Lab-Geometria`

> **Ejecutado el 2026-09-12** en la rama `estructura-solucion-visor-y-samples`, pull request
> [#187](https://github.com/hdcm-dev/Lab-Geometria/pull/187), con la evidencia en
> `evidencia/2026-09-12-estructura-solucion/`. Los nueve pasos se cumplieron; el paso 4 se resolvió
> con hash de contenido en el target (`SealVisorAsset`), porque `MapStaticAssets` resuelve después de
> `UseRouting` y el guardián de aprovisionamiento desviaría el pedido. **No se fusionó**: fusionar publica
> el front en producción y el paso 0 reescribe el intake, las dos cosas del Product Owner.

| # | Paso | Criterio de aceptación (comando en el devcontainer) |
| --- | --- | --- |
| 1 | Targets `BuildVisor` + `DeclareVisorAsset` en `GeometriaFactory.Web.csproj` (P-3.1/3.2) + ADR en `Web/05` | Clon limpio: `dotnet publish src/GeometriaFactory.Web -c Release -o /tmp/p` **en una sola invocación** deja `/tmp/p/wwwroot/js/geometriafactory-visor.js` y `Web.staticwebassets.endpoints.json` lo lista; segunda corrida de `dotnet build` no ejecuta `Exec` (`-v:n` sin «npm ci»); `dotnet build -p:SkipVisorBuild=true` termina en 0 sin Node en el PATH |
| 2 | `Dockerfile.web` l. 78: `-p:SkipVisorBuild=true`; etapa node:22 se conserva | `docker build -f deploy/Dockerfile.web .` construye y la imagen contiene `wwwroot/js/geometriafactory-visor.js` |
| 3 | Un único generador (P-3.3): retirar la llamada directa en `build.sh` l. 21, `e2e.yml` l. 89–90, `pruebas-e2e.sh` l. 60–64; reescribir el aviso de `BancoLocal.cs` l. 283–297; `ci.yml`: bandera en `dotnet test` si corre sin Node | `grep -rn "build-visor.sh" scripts .github tests` devuelve sólo el `.csproj` y el propio guion; `bash scripts/build.sh` y `bash scripts/test.sh` en 0 |
| 4 | Sello de caché (P-3.4): verificar `@Assets[...]` en `WorkSubmission.razor`/`WorkView.razor`; si no aplica, hash en el Target | La respuesta HTML del front referencia el bundle con huella distinta tras cambiar un `.ts` y reconstruir |
| 0 | **Escritura del intake** (precondición de 5): §13.2 l.420/424 → «`GeometriaFactory.sln`, nodo sin construcción»; §13.3 consecuencia 3 de la excepción (archivo de proyecto `geometriafactory-visor.csproj`); una entrada de control de cambios, major, `_legacy/`; re-derivar el manifiesto (l.146, 157, 167–169; l.218/229–232/250 según P-3) | El manifiesto re-derivado no contiene «no pertenece a `GeometriaFactory.sln`»; el intake tiene la entrada con fecha |
| 5 | `GeometriaFactory.sln`: `dotnet sln add visor/geometriafactory-visor.csproj --solution-folder visor` (nodo inerte, P-7 D); los 9 `Sample.*.csproj` bajo folder `samples`; `tests/GeometriaFactory.E2ETests` (D-4); limpiar las plataformas `x64`/`x86` inyectadas; reescribir los 10 textos «NO ENTRA … A PROPÓSITO» | `dotnet sln GeometriaFactory.sln list` muestra 9 + 1 + 9 + 1; `dotnet build GeometriaFactory.sln` en 0 y sin advertencias **con `npm` fuera del PATH y `-p:SkipVisorBuild=true`** (el nodo no construye nada); `bash scripts/coverage.sh` da el mismo `QG-03` que antes — si no, quitar `.Build.0` de los samples y registrarlo; `grep -rn "NO ENTRA" samples/` = 0 |
| 6 | Samples del visor: cubrir en `02`/`03` lo que falta de P-6 punto 5 (seis funciones + `onPieceSelected` en el conjunto), sin cambiar `01` ni los contratos existentes salvo ampliarlos | `npm --prefix samples/visor/0N run verify` en 0 para los tres; `grep -l "onPieceSelected\|resize\|selectPiece\|setMotion" samples/visor/*/anfitrion.js` cubre las seis entre los tres |
| 7 | `samples/README.md`: estado por carpeta desde el campo `evidencia` de cada `ejemplo-0N-*.md`; enlaces a `Unidades-Entrega/` | `grep -c "SDD/Docs/Proyectos" samples/README.md` = 0; cada enlace resuelve (`find`); estados coinciden con `evidencia` |
| 8 | Generados: `Vista-Producto.md` l.113 (minor: la justificación «ningún `.csproj` puede expresar» cae; la clase queda), `Plan-Etapa-A.md` l.279 (minor: el agrupador ya no es «6 + 3»), `Web/09` `Pipeline-CI-CD.md` l.104/113 y `ADR-12006` §7 (por P-3) | Control de cambios con fecha y `_legacy/`; ninguna referencia a `Migracion-Rules` |
| 9 | Evidencia | Capturas con fecha en `evidencia/` de los criterios 1, 2, 5 y 6 |

Precondiciones: paso 0 ejecutado y confirmado por el Product Owner antes del paso 5; el trabajo va por rama y pull request.

### §7.2 `<biblioteca-de-mapas>`

Precondiciones: autorización del Product Owner (la ia-db lo declara de solo lectura para agentes que la
usen); **feed NuGet configurado** para `NgForms.Component` (sin él `dotnet restore` falla `NU1101`:
agregar `nuget.config` o declarar el feed en el README).

| # | Paso | Criterio de aceptación |
| --- | --- | --- |
| 1 | **Bloqueante**: retirar los dos «Web Site» y sus entradas en `NestedProjects` de `<Mapas>.Core.Blazor.Components.sln`; Solution Folder `src/googlemaps` con `SolutionItems` (opcional) | `dotnet build <Mapas>.Core.Blazor.Components.sln` pasa el parseo de la solución (sin `MSB4249`/`MSB5023`) y el restore con el feed |
| 2 | Borrar `JS.Bundle/Maps/OpenStreet/` (obsoleto declarado). El paquete `GoogleMaps/` **no se mueve** en este ciclo (mismo criterio que P-1: primero que compile y sirva; mover es cosmético). `.gitignore` anidado se conserva | `git ls-files JS.Bundle/Maps/OpenStreet` vacío |
| 3 | RCL con Static Web Assets (P-3): Target en `<Mapas>.Core.Blazor.Components.csproj` que construye el paquete (`npm ci && npm run build`, con `SkipMapsBuild`), copia `dist/` a `wwwroot/js/components/googlemaps/` (minúscula) **y lo declara como `Content`**; `GoogleMaps.razor`: los 9 `import` pasan a `./_content/<Mapas>.Core.Blazor.Components/js/components/googlemaps/main.js`; los íconos por defecto (`imgs/icon-rojo.png`, l. 264/292/339) pasan a `_content/…/imgs/`; `git rm --cached` de las copias versionadas en `src/…/wwwroot/js/components/GoogleMaps/` y `.gitignore` de la ruta generada | **Primer** `dotnet build` desde clon limpio: `staticwebassets.build.endpoints.json` del host lista `_content/<Mapas>.Core.Blazor.Components/js/components/googlemaps/main.js`; `diff JS.Bundle/Maps/GoogleMaps/src/interop/main.js <servido>` vacío |
| 4 | El global sigue cargándose desde `App.razor` del host (l. 20) —una RCL no puede inyectar `<script>`—: documentar en `guides/Blazor-Componente-User-Guide.md` el contrato de instalación (el `<script>` de `_content/…/googlemaps.min.js`, sin copias, sin `imgs/` propios) | La guía lista los tres puntos; `examples/WebBlazor_JS/wwwroot/js/components/` y `wwwroot/imgs/` se borran y el example sigue funcionando |
| 5 | Sello de caché: `ComponentVersion.Version` deja de escribirse a mano (P-3.4; misma verificación que Geometría) | Huella distinta tras cambiar un `.ts` |
| 6 | `examples/WebBlazor_JS/` → `samples/blazor/01-app-basica/` **con contrato `VER-00001`** (Playwright sobre una página que crea un mapa, agrega un marcador y recibe `OnMarkerClick`); mantiene `ProjectReference` (P-7). `examples/GenJson/` → herramienta del paquete (D-3) | `dotnet run --project samples/blazor/01-app-basica` + `npm --prefix samples/blazor/01-app-basica run verify` en 0 |
| 7 | **Un** sample HTML del bundle, `samples/googlemaps/01-basico/`, sub-forma B (P-6): una página con `shared/{config.js,fake-blazor.js}`, `anfitrion.js`, `datos/`, `tests/`, `package.json` con `serve` + `verify`; carga `../../../JS.Bundle/Maps/GoogleMaps/dist/{googlemaps.min.js,js/main.js}`; requiere la clave por `.env` (precondición declarada). El sandbox y `tests/e2e` **quedan** con el paquete (P-4) y `static.yml` no cambia | `npm --prefix samples/googlemaps/01-basico run verify` en 0; `npm run pages` y `npm test` del paquete siguen en 0; Pages sigue publicando las ocho páginas |
| 8 | Guía del componente (P-6 puntos 1–4): prueba que falle si `METODOS_JSINVOKABLE` ≠ `[JSInvokable]` del `.razor` ≠ invocaciones de `main.js`; corregir `OnPolygonClick` en el `main.js` fuente; distribuir `interop.d.ts`/`interfaces.ts` en `dist/`; corregir `main.js` l. 119–122; afirmar `DisposeMapAsync` en el sample | La prueba nueva pasa; `diff` de las tres fuentes de la lista vacío |
| 9 | Actualizar ia-db 03 §1 (dejan de existir las tres copias) y 05 §4/§5 | Índices con fecha nueva |

---

## §8 Escaladas y decisiones pendientes del Product Owner

### ESC-001 — cerrada por el Product Owner (2026-09-11)

- **Pregunta**: ¿el visor entra al agrupador `GeometriaFactory.sln` de alguna forma?
- **Respuesta**: «todos los proyectos quedan bajo el árbol de solución de Visual Studio, aunque sea
  bajo carpetas virtuales» → **DC-5**.
- **Cómo se aplica**: ciclo 2 de la mesa; opción **D** adoptada 5-0 (P-7), con C registrada como
  alternativa condicionada y B descartada. La afirmación que DC-5 supera vive en el intake §13.2
  (no sólo en el manifiesto) y se reescribe por `Master-Prompt.md` §13 caso (a) (§7.1 paso 0).

### Decisiones

| Id | Decisión | Opciones | Recomendación |
| --- | --- | --- | --- |
| D-1 | Slugs para «cliente web» y «app MAUI» | Los existentes de §3.1 · slug nuevo **con ADR de apartamiento** (no hay «desvío en README») | Los existentes (`cliente-http-basico`, `app-basica`) |
| D-2 | ¿Probar `.esproj` en el devcontainer? | Sí · No | No: D y C ya están reproducidos con NoTargets |
| D-3 | `examples/GenJson` de <biblioteca-de-mapas> | herramienta del paquete · sample de datos | Herramienta |
| D-4 | `tests/GeometriaFactory.E2ETests` ¿entra al `.sln`? | Sí · No | Sí (DC-5); queda escrito en `Plan-Etapa-A` l.279 al reversionar |
| D-5 | ¿Emitir documento(s) de `Conocimiento/`? | Sí (dos, `propio`) · No por ahora | No por ahora (P-8) |
| D-6 | ¿Elevar observaciones al framework? | Por el canal de intervención del framework · cuando exista un ADR con ≥2 saltos · nunca | Registrarlas como observaciones; sin ADR no hay candidato |
| D-7 | Si `coverage.sh` muestra que los samples alteran `QG-03` | quitar `.Build.0` de los 9 en el `.sln` · aceptar el nuevo número | Quitar `.Build.0` (visibles, no construidos) y registrar |

---

## §9 Registro de debates y cierre de la mesa

### §9.1 Debates

| Fecha | Tema | Posiciones | Resolución |
| --- | --- | --- | --- |
| 2026-09-11 | ¿`src/dotnet` + `src/javascript` o `src/<proyecto>`? | Idea-Central §4 la primera; intake §16 la segunda | Se sigue §16 (DC-4) |
| 2026-09-11 | ¿Carpeta `poc/`/`demo/`? | 1.0: `poc/`; replanteo: ninguna | Ninguna (DC-1). La mesa acotó la consecuencia: el sandbox de <biblioteca-de-mapas> no se convierte en samples (P-4) |
| 2026-09-11 | ¿Mover `visor/` a `src/`? | 2.x: sí; mesa: S1 (decisión cerrada del producto, beneficio nulo) | **No se mueve** (P-1) |
| 2026-09-11 | ¿El sample prueba o muestra? | Replanteo: las dos | Ya lo exige §0.1; se cumple en Geometría, falta en <biblioteca-de-mapas> |
| 2026-09-11 | ¿Forma del sample por productor o por consumidor? | 2.x: regla nueva; mesa: ya está en §0/§1.2/§2.2 y el titular es la unidad de entrega | Ejemplos, no regla (P-5) |
| 2026-09-11 | ¿Samples y visor en el `.sln`? | Norma: no dice; intake/manifiesto de Geometría: el visor no; PO: todos, «aunque sea bajo carpetas virtuales» | DC-5. Ciclo 2: B (lista a mano) descartada, C (dueño del build) condicionada, **D (nodo inerte) adoptada 5-0**; samples `.csproj` construidos, 10 textos a reescribir, `QG-03` medido (P-7) |
| 2026-09-11 | ¿`ProjectReference` es desvío? | 2.x: «tensión declarada»; mesa: no hay obligación para `redistribuible:false` | Sin desvío; cláusula `PackageReference` no ejercida (P-7) |
| 2026-09-11 | ¿Target en el consumidor o proyecto NoTargets? | Arquitectura: NoTargets reproducido; abogado del diablo: duplicación hipotética | Target por defecto; NoTargets condicionado a dos consumidores (P-3) |
| 2026-09-11 | ¿`main.js` obligatorio? ¿«sólo DTO planos»? | 2.x: sí/sí; mesa: dos formas no intercambiables; cruza un canal de retorno | Definir bundle vs adaptador; obligación acotada al bundle (P-2) |
| 2026-09-11 | ¿Documento de `Conocimiento/`? | 2.x: uno `canonico`; mesa: mezcla método y artefacto, duplica fuentes vivas | No por ahora (P-8, D-5) |

### §9.2 Cierre de la mesa (ciclo 1)

```yaml
cierre:
  version_final: 3.0
  ciclos_ejecutados: 1 (de 2)
  panel:
    convocados:
      - requisitos: 5 procedentes de 7
      - verificacion-qa: 6 de 7
      - implementador-ingenuo: 7 de 7
      - arquitectura: 6 de 7 (NoTargets registrado como alternativa condicionada)
      - operacion-entrega: 6 de 7 (.dockerignore cae con P-1)
      - interfaz-consumidor: 7 de 7
      - abogado-del-diablo: 7 de 7
    descartados: [formal-matematico: recuentos sin umbrales, cubiertos por QA; seguridad: sin exposición nueva; datos, concurrencia, rendimiento, cumplimiento, accesibilidad: sin señal]
    ad_hoc: [AH-001 Normativa SDD: «¿cada afirmación sobre el framework es literal y cada propuesta declara bien su desvío?» — 7 hallazgos, 7 procedentes; disuelto al cierre]
    postergados_por_cupo: []
    aporte_nulo: []
  hallazgos: { detectados: 49 (+1 mecánico), consolidados: 10 grupos + 7 del abogado, procedentes: 16 ítems, no_procede: 1 (NoTargets por defecto), no_aplicar: 1 (.dockerignore), aplicados: 16 (fusionados en la reescritura 3.0), revertidos: 0 }
  coherencia: { contradicciones_internas: 0, referencias_colgadas_P-x_D-x: 0, citas_a_INPUTs_verificadas: todas contra encabezados de Idea-Central.md, terminos: «sample» y «PoC» con un solo sentido (PoC sólo como término de <biblioteca-de-mapas>/Idea-Central) }
  deuda_declarada:
    - NoTargets no adoptado: alternativa condicionada a dos consumidores del mismo bundle (G-04d)
    - .dockerignore no agregado: innecesario mientras el visor no esté bajo src/ (G-04e)
    - Preguntas de nivel C sin resolver: warnings de webpack/npm bajo Exec con TreatWarningsAsErrors; costo de npm ci por disparo; PackageReference + feed en clon limpio
    - Sello de caché: mecanismo (@Assets) a verificar en el devcontainer antes de fijar texto (4-1)
  escaladas_pendientes: [ESC-001]
  capas_a_revalidar: [§7.1 y §7.2 al responderse ESC-001 y D-4; ia-db de ambos repos tras ejecutar los planes]
  parada: por umbral (ningún S1/S2 abierto tras aplicar) — el ciclo 2 queda disponible para verificar la aplicación de los planes, no para reabrir el documento
```

### §9.3 Cierre del ciclo 2 (2026-09-11/12)

```yaml
cierre_ciclo_2:
  pregunta_unica: forma de entrada del visor y los samples al .sln bajo DC-5
  panel: [arquitectura (5 hallazgos, 5 procedentes; recomendó C), AH-001 normativa (5, 5 procedentes), abogado-del-diablo (5, 5 procedentes; propuso y reprodujo D)]
  reproducciones: varB, varC, varD, dockerC (SDK 10.0.400; scratchpad/c2)
  veredictos: D adoptada 5-0; C alternativa condicionada (5 condiciones); B descartada; samples csproj construidos 4-1 con condición QG-03; verify nunca en Build 5-0; escritura del intake por Master-Prompt §13 caso (a) 5-0
  hallazgos_nuevos_S2: 3 (MSB4018 con copia física bajo C; MSB9008 silencioso en Dockerfile bajo C; 10 textos «NO ENTRA» en samples)
  deuda_declarada:
    - C no adoptada: condicionada a dos consumidores del mismo bundle (con retiro previo de la copia física)
    - costo de npm ci por disparo del Target (nivel C, sin medir)
    - huella de caché: el manifiesto SWA expone js/<archivo>.<hash>.js (Discovered) — falta verificar cómo se referencia desde .razor (P-3.4)
    - QG-03 con los samples construidos: medido en el paso 5, no antes (D-7)
  escaladas_pendientes: []
  parada: rendimientos decrecientes (3 S2 nuevos sobre una sola pregunta) + umbral (sin S1/S2 abiertos)
```

**Verificación post-aplicación ejecutada**: (1) referencias `P-x`/`D-x` sin colgadas; (2) cada
«Idea-Central §N» resuelve a un encabezado del archivo; (3) las líneas citadas de los repositorios
son las que el panel verificó (E1); (4) chequeo de contradicciones entre §5, §6.1 y §7; (5) la lista
«queda como está» del abogado del diablo (P-2 obligación, P-3 con `SkipVisorBuild`, P-4 filas 3–4,
retiro de los Web Site, `ProjectReference`, DC-4, inventarios de §3) está intacta.

---

## §10 Control de cambios

| Versión | Fecha | Cambios |
| --- | --- | --- |
| 3.2 | 2026-09-12 | §7.1 ejecutado: rama, PR #187 y evidencia; paso 4 resuelto con hash de contenido (el mecanismo `@Assets` no aplica por el guardián 1). Sube patch. |
| 3.1 | 2026-09-12 | **Ciclo 2 de la mesa, sobre la respuesta del Product Owner a ESC-001 (DC-5: todo bajo el árbol de solución, aunque sea en carpetas virtuales).** P-7 reescrita: opción D (nodo NoTargets inerte en `visor/`) adoptada 5-0; C condicionada con cinco condiciones (incluye `MSB4018` con copia física y `MSB9008` silencioso en `Dockerfile.web`); B descartada; samples `.csproj` construidos con la solución, diez textos «NO ENTRA» a reescribir y `QG-03` medido; `verify` de samples HTML nunca en `Build`. P-3: preguntas de nivel C cerradas con reproducción. §6.1 y §7.1: la escritura va en el intake §13.2 (caso (a), major) y el manifiesto se re-deriva; paso 0 nuevo; `Plan-Etapa-A` l.279. §8: ESC-001 cerrada; D-7. §9.3 cierre del ciclo 2. Sube minor. |
| 3.0 | 2026-09-11 | **Corrección por mesa evaluadora (ciclo 1; siete especialistas + abogado del diablo; 49 hallazgos, 16 ítems procedentes fusionados).** Citas a `INPUTs/` reatribuidas a `Idea-Central.md`. P-1: no se mueve `visor/` (decisión cerrada del producto; beneficio nulo). P-2: definición de bundle vs adaptador; obligación acotada; las dos formas no intercambiables. P-3: `Content` dentro del Target (reproducido), `SkipVisorBuild` en `publish`/`test`, un único generador, sello de caché; NoTargets como alternativa condicionada. P-4: el sandbox de <biblioteca-de-mapas> es banco de trabajo, no ocho samples. P-5: degradada a ejemplos; titular = unidad de entrega; slugs existentes. P-6: dos sub-formas y los cinco contenidos de una guía. P-7: sin «tensión»; Web Site bloqueantes (`MSB4249`); `SolutionItems` por archivo; E2ETests. P-8: sin documento de `Conocimiento/` por ahora; «candidato a regla» con el criterio real (saltos). §6.1 y §7 rehechos con criterio evaluable por paso y ambiente. ESC-001. Sube major: cambia el criterio de P-1, P-5, P-6 y P-8. |
| 2.1 | 2026-09-11 | Suma §6.1: `Lab-Geometria` con la propuesta aplicada. |
| 2.0 | 2026-09-11 | Replanteo del Product Owner: se retira `poc/`; todo es `samples/` con las dos aristas. |
| 1.0 | 2026-09-11 | Emisión inicial con carpeta `poc/`. Superada. |
