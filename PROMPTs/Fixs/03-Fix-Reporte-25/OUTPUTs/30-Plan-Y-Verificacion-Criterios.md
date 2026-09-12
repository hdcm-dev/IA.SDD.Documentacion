# OUTPUT 30 — Plan aplicado y verificación contra §7 del reporte 25

## Plan de aplicación (solicitud 9), y su correspondencia con lo aplicado (solicitud 10)

| # | Artefacto | Sección | Versión anterior → nueva | Severidad | Qué se preserva | Destinos alcanzados |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | `Master-Prompt.md` | §13.1 nueva; §15 (dos términos + corrección «Fase») | 8.17 → 8.18 | minor | Los dos casos de §13 regla 2, sin cambios | Todos los destinos con handoff cerrado |
| 2 | `Rules-Backlog-Tecnico.md` | §3.6 (evento + criterio + exigencia de BT/ítem diferido) | 5.1 → 5.2 | minor | La mecánica de versionado v1.0→v2.0 ya existente | Todos los destinos con backlog generado |
| 3 | `Rules-Contexto.md` | §3.5 nueva | 4.5 → 4.6 | minor | El resto de la categoría 00, sin tocar | Todos los destinos con `Roadmap-Producto.md` |
| 4 | `Master-Prompt-Reanudacion.md` | §4 (nota en la fila D) | 1.12 → 1.13 | minor | Las cinco salidas, sin agregar ni quitar ninguna | Todo destino que se reanude con salida D |
| 5 | `CHANGELOG.md` | Entrada 13.14 | 13.13 → 13.14 (conjunto, minor) | minor | — | — |

**Verificado que lo aplicado se corresponde con lo propuesto:** los cuatro archivos de la tabla son los
únicos archivos normativos tocados por esta intervención (`git show --name-only` en la sección de
hashes). No se tocó `Root-Rules.md`, `Migracion-Rules.md`, `Vocabulario-Rules.md` ni ninguna plantilla
de intake. No se generó ninguna fase nueva del orquestador ni ningún archivo de reglas nuevo.

## Verificación contra §7 del reporte, paso por paso

`Master-Prompt.md` §13.1 se agregó exactamente para que el paso 2 diera un resultado distinto sin
reescribir la regla 2; los pasos 1, 5 y 6 cambian de resultado y el 3 y el 4 se declaran explícitamente
por qué no.

| Paso de §7 | Qué pedía | Resultado antes | Resultado después de esta intervención |
| --- | --- | --- | --- |
| 1 | Registrar una decisión de alcance posterior al handoff | — (paso de reproducción, no de verificación) | Sin cambio: sigue siendo el paso que arma el caso, no el que se verifica |
| 2 | Buscar el caso de escritura del intake que la reciba | `Master-Prompt.md` §13 declara dos y ninguno aplica | **Sigue declarando dos, y esta intervención decide con fundamento que no hace falta un tercero** (§13.1): la edición del Product Owner fuera de una corrida no necesitaba caso de escritura porque §13 nunca gobernó ese momento. El resultado cambia de «hueco sin decidir» a «decidido y declarado» |
| 3 | Buscar la fase que la tome | Las dos fases posteriores al handoff (I, J) son de documentación y de contratos de verificación | **Sin cambio, y se declara por qué**: no se agregó ninguna fase, porque `SDD-Development-Guide.md` §III.4 no alcanzaba (OUTPUT 20) — el hueco no era de una fase. No es un paso pendiente: es un paso cuya respuesta correcta es «sigue sin haber fase, y no hace falta una» |
| 4 | Buscar la cardinalidad que la nombre | `Master-Prompt-Reanudacion.md` §0 declara tres | **Sin cambio, y se declara por qué**: no se agregó una cuarta cardinalidad. El evento de §5.2 no es una corrida del método con fases propias; es un asiento en el control de cambios del intake, que ya tiene su propia mecánica de escritura (§13 regla 3) |
| 5 (**el decisivo**) | Buscar el evento que reabra el backlog | `Rules-Backlog-Tecnico.md` §3.4 sabe qué hacer y ninguna regla dice cuándo | **Cambia.** `Rules-Backlog-Tecnico.md` §3.6 ahora declara el evento (la entrada de control de cambios del intake) y el criterio de clasificación. `Rules-Contexto.md` §3.5 declara el mismo evento para el roadmap |
| 6 | Verificar el efecto sobre los artefactos de planificación, comparando fechas | 18 días de distancia entre la última modificación de planificación y la decisión más reciente, con 0 altas en el medio | **No se volvió a correr sobre `Lab-Geometria`**, que es de solo lectura para esta intervención (declarado como «lo que queda sin medir»). El mecanismo que haría que la próxima corrida no repita el mismo resultado queda escrito y verificado por lectura contra los dos casos medidos (OUTPUT 20, §5.3), no ejecutado sobre un tercer caso real |

**Veredicto global del paso 5**, que el prompt de intervención señala como el decisivo: **el hueco se
cierra**. Antes, `Rules-Backlog-Tecnico.md` §3.4 sabía qué hacer y ninguna regla decía cuándo; después,
§3.6 lo dice, con un evento verificable (una entrada de control de cambios, que se abre y se mira, no un
momento) y un criterio enumerable de clasificación.

## Lo que no se pudo verificar, y por qué (solicitud 9 del prompt general)

- **El paso 6 de §7 no se re-ejecutó sobre `Lab-Geometria`.** Es un destino de solo lectura para esta
  intervención por mandato explícito del prompt. La verificación queda para su próxima reanudación.
- **El criterio de `Rules-Backlog-Tecnico.md` §3.6 no corrió sobre un tercer caso real**, distinto de
  los dos que el reporte ya midió. Se verificó por lectura contra esos dos, no por ejecución sobre un
  caso nuevo.
- **No se pudo determinar, sin acceso de escritura a `Lab-Geometria`, si el Product Owner va a asentar
  las dos decisiones pendientes (topología de despliegue y reestructuración de proyectos) como una sola
  entrada de control de cambios o como dos.** El criterio de §5.3 se aplica igual en ambos casos, pero
  el número de `BT-XXXXX` o ítems diferidos que resulten no se puede anticipar desde acá.

## Detenciones pendientes (formato §8.1)

**Ninguna.** La solicitud 5 —la pregunta de fondo, la única que el prompt de intervención advertía que
podía exigir intención de producto— se resolvió con cita literal contra el árbol vigente (`Master-Prompt.md`
§13 regla 1, `Migracion-Rules.md` §4.4) y no por criterio de producto: es autocorrección conforme a la
pregunta previa de `Master-Prompt.md` §8.1 («¿esto tiene respuesta en el árbol? Si la tiene... no es una
detención: es trabajo propio»). Las cuatro preguntas restantes de §5 se resolvieron ensamblando
instrumentos que el método ya tenía (`Rules-Backlog-Tecnico.md` §3.4, `Root-Rules.md` §12.2), sin
requerir una decisión de producto que esta intervención no pudiera tomar por sí sola.
