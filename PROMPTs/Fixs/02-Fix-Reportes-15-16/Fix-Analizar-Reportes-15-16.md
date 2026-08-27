# Tool-Prompt — Análisis y Fix de los reportes 15 a 16

> **Invocación**: Leer y ejecutar `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Fixs/02-Fix-Reportes-15-16/Fix-Analizar-Reportes-15-16.md`
>
> **Overview**: Evaluar el `Framework SDD` contra los reportes **15 y 16** —el rango que sigue al de la intervención `01`—, decidir un plan de corrección y aplicarlo sobre el framework.

---

## Contexto

Leer `/IA/SDD/IA.SDD/README.md`: es un `Framework SDD` (Spec-Driven Development) para especificar y programar con asistencia de IA.

**El rango de esta intervención es `15` a `16`**, que es donde terminó la `01`. Los dos reportes entran al alcance; **su estado no es el mismo y eso decide el trabajo**:

| Reporte | Estado declarado | Qué hay que hacer |
|---|---|---|
| [`15-Las-Exclusiones-Estructurales-Del-Barrido.md`](../../../Reportes/15-Las-Exclusiones-Estructurales-Del-Barrido.md) | **RESUELTO en SDD 10.1** | **Verificarlo, no reaplicarlo.** Comprobación hecha al escribir este prompt: `SDD-Development-Guide.md` §VI.3.2 tiene su séptima clase de exclusión —«La declaración de la propia intervención»— y el control de cambios de la guía lo registra en la fila **1.20 del 2026-08-20**, que es lo que su «Cómo se resolvió» declara. **Rehacé esa verificación**: si el estado cambió, decilo |
| [`16-La-Exclusion-De-Alcance-Se-Concede-Contra-Una-Declaracion.md`](../../../Reportes/16-La-Exclusion-De-Alcance-Se-Concede-Contra-Una-Declaracion.md) | **«Para evaluación. Ninguna modificación aplicada sobre el framework»** | **Es el trabajo de esta intervención** |

**El README de la serie declara que un reporte resuelto no se reanaliza**, de modo que el `15` entra al rango para que su estado quede verificado y declarado, no para volver a intervenirlo.

Los tres hallazgos medidos en la migración de `Lab-Geometria` **todavía no son reporte** y tomarán el `17`; quedan fuera del rango. Si al leer el índice encontrás que algún estado cambió, **decilo y detenete** antes de ampliar el alcance por tu cuenta.

Leer además:

- `/IA/SDD/IA.SDD.Documentacion/Reportes/README.md` — declara **cómo se usa cada sección de un reporte** dentro de un prompt de intervención, y las dos obligaciones que documenta como incumplidas seis veces: quien agrega un reporte agrega su fila, y **quien resuelve un reporte cierra su fila**.
- `/IA/SDD/IA.SDD/CHANGELOG.md` — el framework va por **13.4**. El reporte evaluó **13.3**.
- `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Fixs/01-Fix-Reportes-12-14/` — la intervención anterior, como referencia de forma. **Sus `OUTPUTs` no se tocan.**

---

## Permisos y límites, que son distintos de los habituales

- **Acá SÍ se escribe sobre `/IA/SDD/IA.SDD/`.** Es una intervención sobre el framework y es su propósito. En todo el resto del trabajo ese repositorio es de sólo lectura; esta es la excepción y vale sólo para los artefactos que el plan declare.
- **`PROMPTs/` es del usuario: sólo lectura**, incluida esta carpeta salvo sus `OUTPUTs`.
- **No se toca ningún repositorio de destino** (`Repos-RPIs/`, `PROG2/`, etc.). Si la corrección impacta destinos, se **declara** en el plan; no se aplica acá.
- Trabajar sobre árbol limpio. Si `git status` no está limpio en `IA.SDD`, detenerse y decirlo.

---

## Objetivo

Determinar si el hueco que el reporte 16 describe sigue vivo en **SDD 13.4**, y si lo está, corregirlo en el framework con una intervención verificada contra los criterios que el propio reporte declara.

---

## Solicitudes

**1 · Verificar primero qué ya está resuelto.** El reporte evaluó **13.3** y el framework publicó **13.4**. Por **cada** propuesta de su §6 —`6.1`, `6.2`, `6.3`— comprobar contra los archivos vivos si ya entró, y **declarar el resultado aunque sea que no entró**. Una intervención que reescribe lo que ya está hecho es peor que no haberla corrido.

**2 · Leer el reporte por sus secciones, con la función que el README les asigna:**

| Sección | Para qué la usás |
|---|---|
| §3 La evidencia | Comprobar que el hueco produce defectos reales. **Los incidentes son de un destino real y son verificables**: están en su historial de commits |
| §2 Lo que el framework ya resuelve bien | Delimita **qué no hay que reescribir**. §10.0, §10.1 y la decisión del reporte `12` se conservan |
| §4 La causa raíz | Impide que la corrección ataque el síntoma. El síntoma son las comprobaciones mal escritas; la causa es **que la exclusión se concede contra una declaración** |
| §5 El patrón, enunciado | **Es lo que hay que corregir.** Está en forma general a propósito: la corrección no se limita a compuertas |
| §6 Propuestas | Punto de partida, **no decisión tomada** |
| §7 Cómo verificar | Criterio de aceptación de esta intervención |

**3 · Respetar lo que el reporte declara que NO sabe y lo que declara fuera de alcance.**

- **No reabrir la decisión del reporte `12`** —que el framework no distribuye un verificador ejecutable, `SDD-Development-Guide.md` §II.7—. El reporte 16 es explícito: propone una **condición sobre el verificador que cada destino escribe**, no un verificador central. Una propuesta que termine distribuyendo un banco desde el framework cae en §II.7 y hay que descartarla con ese fundamento.
- **La medición es de un destino.** Ocho rondas, sí, pero un solo producto. Si la corrección necesita generalidad que ese destino no prueba, **construila mirando las 20 reglas vivas**, no la heredes del reporte.

**4 · Diagnosticar y producir evidencia en `OUTPUTs`.** Escribir los resultados intermedios en `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Fixs/02-Fix-Reportes-15-16/OUTPUTs`. Cada afirmación con su ancla: archivo, sección y, cuando sea medible, el comando y su salida.

**5 · Los dos hallazgos menores de §8 se deciden explícitamente, uno por uno.**

- **§8.1** — §10.0 dice «97 de 202» y `Catalogo-De-Criterios.md` §4 declara «100 / 108 / 208». **Verificá el conteo por tu cuenta** sobre los 20 archivos de regla antes de corregir nada: si el reporte contó mal, el hallazgo es del reporte.
- **§8.2** — §5.1 no declara qué hacer cuando un archivado salió mal. **Converge con el `HM-03` medido en `Lab-Geometria`, todavía sin escribir como reporte.** Decidí una de dos y declaralo: se resuelve ahora con la evidencia de un solo destino, o **se difiere hasta que ese reporte exista** y se resuelven juntos. Las dos son legítimas; lo que no lo es es resolverlo sin decir cuál elegiste.

**6 · Generar un plan de aplicación unificado**, coherente con lo que la 12.1 a la 13.4 ya incorporaron. El plan declara, por cada cambio: artefacto, sección, qué dice hoy, qué diría, **y si sube major o minor**, con el criterio que el framework usa para decidirlo.

**7 · Aplicar el plan, y corroborar que lo aplicado se corresponde con lo propuesto.** Un cambio aplicado que el plan no declaraba es un hallazgo de esta intervención.

**8 · Verificar contra los cuatro criterios de §7 del reporte, uno por uno, con veredicto explícito.** Son enumerables:

1. Toda comprobación tiene al menos un caso que la ejerce; casos ≥ comprobaciones.
2. Todo recorte declarado tiene su caso de la clase inversa.
3. Un hallazgo sobre el instrumento no pasa a «cerrado» sin su caso.
4. La proporción de hallazgos detectables por guion se declara en cada informe de ronda.

**El decisivo es el 3**, porque es el que rompe el ciclo que el reporte describe: sin él, la próxima corrección del instrumento vuelve a declararse cerrada sin evidencia.

**9 · Cerrar el circuito documental**, que es lo que el README declara incumplido **seis veces** —tres al emitir un reporte y tres al resolverlo—:

- El reporte 16 pasa a **RESUELTO en SDD `<versión>`** y suma su sección **«Cómo se resolvió»**, con el desenlace de cada propuesta y **el veredicto de cada criterio de aceptación, uno por uno**.
- `Reportes/README.md` cierra su fila y actualiza el estado de la serie.
- `CHANGELOG.md` del framework suma su entrada.

**Los tres van en el mismo commit que el cambio.** Una intervención que aplica y no cierra reproduce exactamente el defecto que el README documenta.

**10 · Declarar el impacto sobre destinos existentes.** Si la corrección obliga a los destinos a traer un banco de inyección, los destinos con compuerta ya escrita quedan incumpliendo el día que se publique. **Eso es una migración y no sólo una regla nueva**, y el plan dice cuál de las dos cosas está proponiendo, con qué versión y con qué plazo.

**11 · Si encontrás un conflicto entre dos reglas que la corrección no pueda resolver**, aplicá `Root-Rules.md` §13 (precedencia) y, si no decide, **detenete y llevá la pregunta**, con las dos opciones y una recomendación fundada. No la resuelvas por tu cuenta.

---

## Reglas

- **No inventar información.**
- **Toda afirmación debe estar respaldada por evidencia verificable**: archivo y sección, o comando y su salida.
- **Medir antes de corregir.** Si el reporte afirma un número, verificalo antes de usarlo como base. Un reporte es evidencia, no autoridad.
- **Declarar lo que no se pudo verificar**, y por qué.
- Entregar: el resultado de la solicitud 1, el plan, los cambios aplicados con su verificación criterio por criterio, y el cierre documental de la solicitud 9.
