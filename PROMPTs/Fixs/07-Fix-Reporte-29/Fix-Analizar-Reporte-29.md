# Tool-Prompt — Análisis y Fix del reporte 29

> **Invocación**: Leer y ejecutar `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Fixs/07-Fix-Reporte-29/Fix-Analizar-Reporte-29.md`
>
> **Overview**: Evaluar el `Framework SDD` contra el reporte **29** —el umbral de archivos individuales no dice de qué se cuenta—, decidir un plan de corrección y aplicarlo sobre el framework.

---

## Contexto

Leer `/IA/SDD/IA.SDD/README.md`: es un `Framework SDD` (Spec-Driven Development) para especificar y programar con asistencia de IA.

**El reporte a aplicar es uno solo:**

- [`29-El-Umbral-De-Archivos-Individuales-No-Dice-De-Que-Se-Cuenta.md`](../../../Reportes/29-El-Umbral-De-Archivos-Individuales-No-Dice-De-Que-Se-Cuenta.md) — estado **Abierto**, evaluado contra SDD **13.14**.

**Por qué no entran los otros.** Verificar el estado en [`Reportes/README.md`](../../../Reportes/README.md) **antes** de fijar el alcance. **Ninguno entra acá**: el `29` toca una sola regla y un solo mecanismo.

**Lo que este reporte tiene de distinto.** Es el primero de la serie que nace **de ejercer una corrección recién aplicada**: el evento de `Rules-Backlog-Tecnico.md` §3.6 que escribió la 13.14 abrió un backlog por primera vez, y al abrirlo se contó. No es una regla que falta: es **una regla que dice dos cosas**, y cualquier destino que la aplique ya eligió una sin saber que había otra. **El modo de falla típico de esta intervención es elegir la lectura más cómoda y declarar a la otra un error de redacción**, sin medir a quién rompe. §5.1 del reporte da el argumento de las dos; la intervención tiene que pesarlos, no heredar ninguno.

---

## Permisos y límites

- **Acá SÍ se escribe sobre `/IA/SDD/IA.SDD/`.** Es su propósito y no se extiende a nada más.
- **`PROMPTs/` es del usuario: sólo lectura**, salvo esta carpeta `OUTPUTs` y la fila `07` de `PROMPTs/Fixs/README.md`.
- **No se toca ningún repositorio de destino.** `Lab-Geometria` es el caso medido: **se lee, no se modifica**.
- Trabajar sobre árbol limpio. Si `git status` no está limpio en `IA.SDD`, detenerse y decirlo.

---

## Objetivo

Decidir **de qué se cuenta** el umbral de archivos individuales de `Rules-Backlog-Tecnico.md`, con cuántas bandas, qué forma tiene un documento consolidado con proyectos a los dos lados del umbral, y qué les pasa a los destinos existentes — y dejar las seis menciones de la regla diciendo lo mismo, con un criterio que se decida con un comando.

**Una decisión negativa fundada es un desenlace válido** (precedente, reporte `12`). Lo que no es legítimo es no decidir.

---

## Solicitudes

**1 · Verificar primero qué ya está resuelto.** Por cada cita del reporte —cabecera, §2.1, §3.3, §5.2, §5.5, §6 y §8 de `Rules-Backlog-Tecnico.md`; los pasajes de `Lab-Geometria`—, abrir el archivo vigente y decir si sigue literal. **Correr el comando de §2.1 del reporte y pegar la salida**: si la regla cambió de líneas, el comando de números fijos ya no sirve y hay que decirlo.

**2 · Reproducir los recuentos, no citarlos.** Los de §2.2 (por bloque y por unidad, en `Lab-Geometria`) y el de §2.4 (carpetas `tareas-tecnicas/` en el workspace). **Ampliar §2.4 a `historias-usuario/`** y a todos los destinos del workspace con `SDD/Docs/`, porque la misma contradicción existe para las US (20 y 10) y el reporte no la midió.

**3 · Respetar las cuatro cosas que el reporte no afirma (§6).** En particular: **no tratar a `Lab-Geometria` como el que se equivocó**. Aplicó una lectura con coherencia. Si la corrección elige la otra, es el framework el que cambia y el destino el que queda alcanzado, y eso va al bloque de impacto.

**4 · Decidir la pregunta de fondo: la unidad del recuento (§5.1).** Proyecto de código o unidad de entrega. **Decidirla primero**, porque §5.2 a §5.4 dependen de ella. Pesar los dos argumentos del reporte y **el tercero que esconden**: la carpeta `tareas-tecnicas/` es de la unidad, pero si se cuenta por proyecto, un documento de unidad queda mixto — `Lab-Geometria` va a quedar exactamente así. **Decir si el estado mixto es la forma correcta o un transitorio**, y con qué fundamento.

**`Root-Rules.md` §13 no alcanza**: el conflicto es interno a un archivo, como el del reporte `28`. Si la contradicción no se resuelve con el árbol, rige `Master-Prompt.md` §8.1 con `ORIGEN DEL HECHO` y `SI NO RESPONDÉS`. **No resolverla por conteo de menciones**: que cuatro digan una cosa y dos otra no es un criterio.

**5 · Las otras tres preguntas de §5, una por una**, con fundamento escrito aunque la decisión sea no hacer nada:

| # | Pregunta | Qué decidir |
|---|---|---|
| §5.2 | Las bandas | Dos o tres; si tres, qué obliga «recomendado» |
| §5.3 | Los destinos existentes | Medido en todos: cuántos incumplen con la decisión de §5.1, y si eso hace **major** el salto |
| §5.4 | El criterio enumerable | Si §6 pasa a `[enumerable]`, con qué comando |

**6 · Extender la decisión a las US.** §2.1 y §3.3 tienen la misma contradicción para `historias-usuario/` (20 y 10). **Una corrección que arregle las BT y deje las US con la contradicción** es un hallazgo de la propia intervención.

**7 · Diagnosticar y producir evidencia en `OUTPUTs`**: solicitudes 1 y 2 con comandos y salidas, la decisión de la solicitud 4 con su fundamento, el plan, la verificación criterio por criterio.

**8 · Generar un plan de aplicación.** Por cada cambio: artefacto, versión y severidad, qué se preserva, **qué destinos quedan alcanzados**.

**9 · Aplicar el plan y corroborar** que lo aplicado es lo propuesto. Snapshot en `_legacy/13.14/` antes de editar si el salto lo exige.

**10 · Verificar contra los cinco criterios de §7 del reporte**, uno por uno, con veredicto explícito. **El decisivo es el 3**: sobre `Lab-Geometria`, la regla tiene que dar un solo resultado sin leer dos secciones juntas.

**11 · Cerrar el circuito documental** en el mismo acto: reporte `29` → `RESUELTO en SDD <versión>` con «Cómo se resolvió»; `Reportes/README.md`; `CHANGELOG.md` con impacto medido; fila `07` de `PROMPTs/Fixs/README.md`.

**12 · Declarar qué le exige a `Lab-Geometria`**, que al emitirse este reporte resolvió su caso con la lectura por proyecto de código.

---

## Reglas

- **No inventar información.**
- **Toda afirmación de recuento, sección o colisión lleva su comando y su salida al lado** (13.12).
- **Medir antes de corregir.** Los recuentos del reporte se reproducen.
- **Declarar lo que no se pudo verificar.**
- **Una decisión negativa es un desenlace válido y se escribe.**
