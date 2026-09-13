# 00 — Verificación de citas y medición del alcance (solicitudes 1 y 2)

Comandos y salidas completos en `evidencia/ev-01-citas.{sh,out}` y `evidencia/ev-02-destinos.{sh,out}`.
Todo se leyó **por objetos commiteados** (`git show main:<ruta>`), nunca del árbol de trabajo.

**Bases** (§8.1, origen del hecho contra la base de cada repositorio):

| Repositorio | Rama | SHA |
|---|---|---|
| `IA.SDD` | `main` | `47be07d2cec0445cc1ba9a264c09d2fbdb25c433` — framework **13.15** |
| `IA.SDD.Documentacion` | `main` | `779623cf2f2bd718ecfae1acd21f2c2ff27b45e0` |
| `Lab-Geometria` | `main` | `1ce1b2cb639516bb4306117c84e0e76518b193a4` |

La especificación de la Feature 20 **no está versionada**: se leyó desde el checkout principal,
`PROMPTs/Features/20-Agregar-BundleJS-Estructura-Solucion/OUPUTs/Especificacion-Estructura-Solucion.md`,
versión **3.2**, entera.

## 1. Las citas del reporte, una por una

**Nada de lo que el reporte cita se resolvió entre su emisión y esta intervención**: la base es la misma
13.15 que el reporte evalúa (`git log -1 main` en `IA.SDD` = `47be07d`, la fusión de la intervención `07`).

| Cita | ¿Sigue literal en 13.15? | Salida (`ev-01-citas.out`) |
|---|---|---|
| (a) `PRODUCT-INTAKE-template.md` §16.1: «tipo D8 de cada proyecto de código» | **Sí**, l.465 | `465:Instrucción: Describir cómo se materializan los samples según el tipo D8 de cada proyecto de código que los produce.` |
| (a) Fila 3.0 del control de cambios de la plantilla (D8 pasa a la unidad de entrega) | **Sí**, l.773 | `773:\| 3.0 \| 2026-08-15 \| **La composición se declara en dos ejes** (framework 8.0)…` |
| (b) `grep -rn -i "activo de construcci" SDD` | **Sí**, vacío | sin líneas |
| (c) `PRODUCT-MANIFEST-template.md` l.155, regla agnóstica; columna `Stack` | **Sí**, l.155 y l.120 | `155:La regla se expresa de forma agnóstica de stack a propósito…` |
| (c) Ningún ejemplo de identidad con forma npm | **Sí** | las únicas cadenas `minúscula-con-guion` en backticks son los ocho valores D8 |
| (d) `Vocabulario-Rules.md` §2, solución de código | **Sí**, l.33 | `\| **Solución de código** \| El artefacto del ecosistema que agrupa la construcción…` |
| (d) `grep … "otro stack\|stack distinto\|dos stacks\|más de un ecosistema\|ecosistemas distintos"` | **Sí**, vacío | sin líneas |
| (e) `Rules-Examples.md` §1.2, fila `rest-api` | **Sí**, l.81 | `\| rest-api \| Sample Engineer + API Demo \| Cliente HTTP de referencia (curl + lenguaje del integrador típico)…` |
| (e) Ninguna regla dice si un sample entra al agrupador | **Sí** | `grep -n -i "agrupador\|solución de código" Rules-Examples.md` vacío |
| §2.3: `Rules-Base-Conocimiento.md` §0.1 y §4.5 | **Sí**, l.47 y l.289 | «Describe el artefacto, no el método» · «Conocimiento disfrazado de regla» |
| `Rules-Devops.md`: `paquete-npm` como canal genérico de `library` | **Sí**, l.248 | `\| library \| paquete del gestor del runtime: paquete-npm, …` |
| Criterio 5, antes | **Vacío** | `git grep -n -i "NoTargets\|csproj\|webpack" main -- SDD/Devs/Rules` → `exit=1` |

**Pasajes del destino** (`Lab-Geometria` `main`):

| Cita | ¿Literal? | Salida |
|---|---|---|
| `PRODUCT-MANIFEST` fila `GeometriaFactory-Visor`: «Node.js con TypeScript y webpack; nodo `Microsoft.Build.NoTargets` en el agrupador» | **Sí**, l.161 | ver `ev-01` |
| `Vista-Producto.md`: «Aristas de compilación: **8**, de dos clases: **7** referencias de proyecto y **1** activo de construcción» | **Contenido literal, forma no**: es una celda de tabla (l.65, §1.1) y no la frase corrida que el reporte transcribe; la clase aparece además en l.113 (§3). **El prompt la ubica en §3.1, y no está ahí**: §3.1 narra el cierre de la discrepancia sin usar el nombre | `65:\| Aristas de compilación \| **8**, de dos clases: **7** referencias de proyecto y **1** activo de construcción (\`Visor → Web\`) \|` |
| `ADR-10008`, estado Aprobado, 2026-09-12 | **Sí** | cabecera en `ev-01` |
| `GeometriaFactory.Web.csproj`, targets `BuildVisor`, `DeclareVisorAsset`, `SealVisorAsset` | **Sí**, l.77, l.83, l.102 | |
| `-p:SkipVisorBuild=true` en `deploy/Dockerfile.web` | **Sí**, l.94 | |
| Once samples sin `.csproj` | **Sí, 11** | lista en `ev-01` |
| `grep -c 'samples\\\(visor\|api\|contracts\|web\)' GeometriaFactory.sln` | **Sí, 0** | |
| Diez de los once existían antes de la reestructuración (2026-08-11); `samples/api/04-cliente-http-basico` es del 2026-09-13 | **Sí** | fechas de alta en `ev-01` |

**Tres afirmaciones de la especificación de la Feature 20 que no son literales en la base**, y se
declaran antes de usarla como fuente:

1. **§2.3 y P-8 (a) dicen que el intake «§16.1 y §18 todavía dicen "tipo D8 de cada proyecto de código"».**
   §16.1 sí; **§18 no**: `awk '/^## §18/,/^# Parte D/' … | grep -c "D8"` → `0`. §18 pide «qué proyecto de
   código del producto ilustra cada uno», que no atribuye D8.
2. **P-8 dice que «el único canal» para un candidato a regla es un ADR de apartamiento con dos saltos.**
   Ni `Migracion-Rules.md` §4.7 ni `Root-Rules.md` §11 dicen «único»: la única ocurrencia de «únic» en §4.7
   es «Lo único que cambia es qué se contradice», ajena. §4.7 describe cómo **una migración** reporta sola
   un candidato («deja de depender de que alguien se acuerde de reportarlo: el número lo reporta»), no que
   sea la única vía. Y `SDD-Development-Guide.md` §VI.3, comprobación 13 (l.743), ya nombra **«un reporte,
   un incidente, un pedido»** como origen legítimo de una intervención.
3. **§3.1 decía que el visor no pertenece a `GeometriaFactory.sln`.** Es la foto del 2026-09-06
   (`89f3ab3`); en `main` hoy pertenece como nodo sin construcción (manifiesto l.161, intake §13.2). No es
   un error de la especificación: su §7.1 registra la ejecución. Se usa la foto de `main`.

## 2. El alcance real

`find <workspace> -type d -path "*/SDD/Docs" -not -path "*/_legacy/*"` devuelve
**cinco rutas, que son cuatro repositorios**: `Lab-Geometria-dc5` es un worktree del mismo repositorio que
`Lab-Geometria` (`git-common-dir` = `Lab-Geometria/.git`, rama `estructura/dc5-samples-en-la-solucion`, en
`1ce1b2c`), el del agente que está entrando los once samples al agrupador. Se cuenta una vez.

| Destino (HEAD) | Ecosistemas en la construcción | Proyecto de código de otro ecosistema | Samples que no se compilan |
|---|---|---|---|
| `Lab-Geometria` (`1ce1b2c`) | .NET y Node (`visor/package.json`) | **1**: `GeometriaFactory-Visor`, con una arista `Visor → Web` | **11 de 20** |
| `RPI.VideoControl` (`9aabe5c`) | .NET y Node **dentro de un proyecto .NET**: `src/VideoControl.PinMap/` tiene `package.json` y su `.csproj` corre `VerificarNode`, `RestaurarDependenciasDeJavascript` y `ConstruirBundle` | **0**: la segunda cadena corre dentro de un proyecto de la solución, no en un proyecto aparte | sin `samples/` |
| `SAI.Service.Core` (`6fd23d5`) | .NET | 0 | sin `samples/` |
| `SelfHosted.Service.Core` (`82fb235`) | sin código commiteado | 0 | sin `samples/` |

**Lo que el número decide.** El proyecto de otro ecosistema dentro de una solución y los samples que no se
compilan alcanzan a **un destino**, `Lab-Geometria`. La construcción que necesita **la cadena de
herramientas de más de un ecosistema** alcanza a **dos**: `Lab-Geometria` por una arista y
`RPI.VideoControl` por un proyecto. Ningún destino **que siga el texto vigente** deja de cumplir por
agregar las piezas —el único que tiene el caso lo resolvió fuera del texto—, y eso orienta a **minor**; la
decisión con su fundamento está en `OUTPUTs/10` y `OUTPUTs/20`.
