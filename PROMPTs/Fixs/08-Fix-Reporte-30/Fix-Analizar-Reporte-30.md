# Tool-Prompt — Análisis y Fix del reporte 30

> **Invocación**: Leer y ejecutar `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Fixs/08-Fix-Reporte-30/Fix-Analizar-Reporte-30.md`
>
> **Overview**: Evaluar el `Framework SDD` contra el reporte **30** —el método no sabe poner un proyecto de otro ecosistema en la solución—, decidir un plan de corrección y aplicarlo sobre el framework.

---

## Contexto

Leer `/IA/SDD/IA.SDD/README.md`: es un `Framework SDD` (Spec-Driven Development) para especificar y programar con asistencia de IA.

**El reporte a aplicar es uno solo:**

- [`30-El-Metodo-No-Sabe-Poner-Un-Proyecto-De-Otro-Ecosistema-En-La-Solucion.md`](../../../Reportes/30-El-Metodo-No-Sabe-Poner-Un-Proyecto-De-Otro-Ecosistema-En-La-Solucion.md) — estado **Abierto**, evaluado contra SDD **13.15**.

**Y su evidencia primaria**, que no es resumen: la especificación de la Feature 20 —`/IA/SDD/IA.SDD.Documentacion/PROMPTs/Features/20-Agregar-BundleJS-Estructura-Solucion/OUPUTs/Especificacion-Estructura-Solucion.md` v3.2—, con sus propuestas P-1 a P-8, sus decisiones D-1 a D-7 y el cierre de su mesa. **Leela entera.** Y el caso aplicado: `/PROG2/Geometria/Lab-Geometria` (sólo lectura): `PRODUCT-MANIFEST` fila `GeometriaFactory-Visor`, `Vista-Producto.md` §3.1, `ADR-10008`, `GeometriaFactory.Web.csproj`, `visor/geometriafactory-visor.csproj`, `GeometriaFactory.sln`, `samples/`.

**Por qué no entran los otros.** Verificar el estado en [`Reportes/README.md`](../../../Reportes/README.md). Ninguno entra acá.

**Lo que este reporte tiene de distinto, y es su trampa principal.** El caso nació en .NET y se resolvió con piezas de .NET —`Microsoft.Build.NoTargets`, targets de MSBuild, `wwwroot`, Static Web Assets—. **Nada de eso puede entrar a una regla.** El texto normativo del framework es agnóstico de stack por decisión fundada (`PRODUCT-MANIFEST-template.md` l.~155 y D7), y la intervención que convierta la solución de Geometría en regla habrá hecho lo contrario de lo que el reporte pide. **La materialización por ecosistema tiene su lugar declarado —el perfil de convención del manifiesto §1.2—, y ahí sí puede ir un ejemplo.**

**Y una segunda trampa**: la especificación **degradó** su propia vía al framework (P-8, veredicto G-08 5-0). El reporte sostiene que esa degradación fue correcta dentro de su consigna —no modificar el framework— y que el canal es este reporte. **Decidí si eso es cierto antes de usar P-1 a P-7 como fuente.**

---

## Permisos y límites

- **Acá SÍ se escribe sobre `/IA/SDD/IA.SDD/`.** Es su propósito y no se extiende a nada más.
- **`PROMPTs/` es del usuario: sólo lectura**, salvo esta carpeta `OUTPUTs` y la fila `08` de `PROMPTs/Fixs/README.md`.
- **No se toca ningún repositorio de destino.** `Lab-Geometria` se lee.
- Trabajar sobre árbol limpio.

---

## Objetivo

Decidir si el método reconoce un proyecto de código cuyo ecosistema difiere del de la solución de código que lo agrupa, y si sí, darle las piezas que un destino hoy inventa —la arista de construcción entre ecosistemas, la construcción donde falta una cadena de herramientas, la forma y la entrada al agrupador de los samples que no se compilan— **sin nombrar ninguna herramienta** en el texto normativo; y corregir la contradicción de §16.1 de la plantilla del intake.

**Una decisión negativa fundada es un desenlace válido** (precedente, reporte `12`).

---

## Solicitudes

**1 · Verificar primero qué ya está resuelto.** Por cada cita del reporte —plantillas de intake y manifiesto, `Vocabulario-Rules.md` §2, `Rules-Examples.md` §1.2, `Rules-Base-Conocimiento.md` §0.1 y §4.5, y los pasajes del destino—, abrir el archivo vigente y decir si sigue literal. **Correr los comandos del reporte y pegar la salida.**

**2 · Medir el alcance real antes de decidir.** ¿Cuántos destinos del workspace con `SDD/Docs/` tienen proyectos de más de un ecosistema, o samples que no se compilan? (`find /home/fernando/workspaces/workspace-dev -type d -path "*/SDD/Docs" -not -path "*/_legacy/*"`.) El número decide si la corrección es minor o major y a quién alcanza.

**3 · Respetar las cuatro cosas que el reporte no afirma (§6).** En particular: **no nombrar herramientas en reglas** (el criterio 5 de §7 lo verifica con `grep`) y **no reabrir el reporte `12`**.

**4 · Decidir la pregunta de fondo (§5.1)**, y **decidirla primero**: si el método reconoce el proyecto de otro ecosistema dentro de una solución de código. Si la respuesta es no, §5.2 a §5.4 cambian de forma y hay que decir dónde vive entonces un caso como el visor.

**5 · Las otras cinco preguntas de §5, una por una**, con fundamento escrito aunque la decisión sea no hacer nada:

| # | Pregunta | Qué decidir |
|---|---|---|
| §5.2 | La arista de construcción entre ecosistemas | Si el grafo de compilación suma una clase y cómo se llama —**la colisión del nombre se afirma con su comando** (13.12)—, y qué regla la gobierna |
| §5.3 | La cadena de herramientas ausente | Si se declara el caso y con qué forma agnóstica |
| §5.4 | El sample que no se compila | Forma y entrada al agrupador en `Rules-Examples.md`; que su verificación no se enganche a la construcción. P-6 y P-7 de la especificación son punto de partida |
| §5.5 | §16.1 de la plantilla del intake | Corregir al D8 de la unidad de entrega |
| §5.6 | El canal | Si P-8 de la especificación se declara superada, y si hace falta escribir en la guía de desarrollo que una especificación de destino con mesa puede alimentar un reporte |

**6 · Reutilizar antes de inventar.** El modelo de dos ejes de la 8.0, el perfil de convención del manifiesto §1.2, la columna `Stack` de la tabla de proyectos, y `Rules-Devops.md` (que ya nombra `paquete-npm` como canal de `library` en forma genérica) son las piezas existentes. **Si se crea una figura nueva, decir por qué ninguna alcanzaba.**

**7 · Diagnosticar y producir evidencia en `OUTPUTs`**: solicitudes 1 y 2 con comandos, decisión de la solicitud 4, plan, verificación.

**8 · Plan de aplicación**: por cambio, artefacto, versión y severidad, qué se preserva, qué destinos alcanza.

**9 · Aplicar y corroborar.** Snapshot `_legacy/13.15/` **con el conjunto entero** antes de editar (guía §VI: *«no solo los archivos que cambiaron»*; una intervención anterior de esta serie archivó uno solo y hubo que completarlo).

**10 · Verificar contra los cinco criterios de §7 del reporte**, uno por uno. **El decisivo es el 3**: completar un manifiesto con un proyecto npm dentro de una solución .NET usando sólo lo que el framework dice. **Y el 5 es el que protege contra la trampa principal.**

**11 · Cerrar el circuito documental**: reporte `30` → `RESUELTO en SDD <versión>` con «Cómo se resolvió»; `Reportes/README.md`; `CHANGELOG.md` con impacto medido; fila `08` de `PROMPTs/Fixs/README.md`.

**12 · Declarar qué le exige a `Lab-Geometria`**: en particular, si su clase de arista inventada pasa a tener nombre del framework, y si su manifiesto necesita re-derivarse.

---

## Reglas

- **No inventar información.**
- **Toda afirmación de recuento, sección o colisión lleva su comando y su salida al lado** (13.12).
- **Ninguna herramienta de un ecosistema en el texto normativo.**
- **Declarar lo que no se pudo verificar.**
- **Una decisión negativa es un desenlace válido y se escribe.**
