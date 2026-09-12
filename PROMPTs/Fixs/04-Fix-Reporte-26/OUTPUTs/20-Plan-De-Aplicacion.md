# 20 — Plan de aplicación unificado

**Fecha:** 2026-09-12
**Decisiones que aplica:** [`10-Decision-Origen-Del-Hecho.md`](10-Decision-Origen-Del-Hecho.md)
**Base de esta intervención:** `IA.SDD` en `476f927`, árbol limpio — es, literalmente, la base de la corrida que este plan introduce

---

## 1. Cambios sobre el framework

| # | Artefacto | Sección | Versión | Severidad | Qué cambia | Qué se preserva |
|---|---|---|---|---|---|---|
| 0 | `_legacy/13.10/` | — | — | — | **Snapshot del conjunto 13.10**, tomado **antes** de editar, desde `476f927` con `git archive`, con las exclusiones de §VI.5 | — |
| 1a | `Master-Prompt.md` | §8.1, «La autocorrección» | 8.14 → **8.15** | minor | **El origen del hecho**, antes de la pregunta previa: definición, cálculo contra la base, «ante la duda, de la corrida», y la tabla de qué cambia según el valor. **Tercera fila** de la autocorrección. «Ante la duda, se detiene» queda acotado a lo ajeno. «Qué obliga en el cierre» suma el alcance ampliado y el criterio enumerable | La pregunta previa y su cita; F1 a F4; la contraparte |
| 1b | `Master-Prompt.md` | §8.1, bloque `DETENCIÓN` | ídem | ídem | Suma `ORIGEN DEL HECHO` y `SI NO RESPONDÉS` | Los cinco bloques existentes |
| 1c | `Master-Prompt.md` | §8.1, «Qué no cambia» | ídem | ídem | Deja de afirmar que la sección **no quita** detenciones. **Era falso desde la pregunta previa** y el cambio lo agravaba: comprobación 9 | Que no agrega detenciones y que no autoriza a decidir |
| 1d | `Master-Prompt.md` | §8, esqueleto y reglas de construcción | ídem | ídem | La cláusula del snapshot suma que el subagente **no declara** el origen; nueva regla: **el snapshot no es la base**, y el orquestador calcula el origen antes de elevar | Que el subagente se detiene sin editar |
| 1e | `Master-Prompt.md` | §7.0 | ídem | ídem | **El lote de la fase**: lo que espera, lo bloqueante, cuándo sale, el origen calculado sobre el lote, `SI NO RESPONDÉS`, y que el registro **no** suma columna | El registro, sus campos y su exhibición al cerrar la fase |
| 1f | `Master-Prompt.md` | §9 | ídem | ídem | El bloque suma el campo **que no completa el subagente**; el paso 3 presenta en el lote | Los pasos 1, 2, 4 a 6 y las heurísticas |
| 1g | `Master-Prompt.md` | §12.1 T0 y T5 | ídem | ídem | T0 publica **`Base`**, la base de la corrida, con su definición; T5 la republica sin cambiarla | Las cinco comprobaciones de T0 |
| 1h | `Master-Prompt.md` | §15 | ídem | ídem | Tres términos: **base de la corrida**, **origen del hecho**, **lote de la fase** | — |
| 1i | `Master-Prompt.md` | §16 | ídem | ídem | Fila 8.15. **Y el registro se reordena por versión**: veintiuna filas estaban después de «Fin del master-prompt» y la 8.12 a la 8.14 entre la 8.2 y la 8.3. Comprobación 10. **Ninguna fila cambia de texto** | El texto de todas las filas. **El hueco de la 7.5 no se rellena**: una fila la escribe quien hizo el cambio |
| 2 | `Mesa-Rules.md` | §7, §7.1, §8, §11 | 1.1 → **1.2** | minor | El origen del hecho **antes** de la lista cerrada; §7.1 suma el campo y declara que §7.0 la generaliza; §8 suma el criterio `[enumerable]` de §5.5 | Los siete disparadores, la inversión de la asimetría, §0.0 y §0.3 |
| 3 | `Master-Prompt-Reanudacion.md` | §3 R1, §6, §8 | 1.11 → **1.12** | minor | El bloque `REPOSITORIO`, que reproduce T0, suma la base; §6 suma el criterio `[enumerable]` | Las seis dimensiones, R1.5 y el criterio de la lista cerrada |
| 4 | `Master-Prompt-Migracion.md` | §8 M4, control de cambios | 2.9 → **2.10** | minor | La **segunda copia** de la cláusula del snapshot: el orquestador calcula el origen antes de tratar la diferencia como corrección manual | Que la corrección manual ajena se enumera y se confirma |
| 5 | `Catalogo-De-Criterios.md` | §3, §6 | 1.15 → **1.16** | minor | Dos situaciones nuevas y una reapuntada (comprobación 12). **La fila 1.13 del registro vuelve a su lugar** (comprobación 10) | El total de 222 anti-patrones de §4: no entra ninguno |
| 6 | `CHANGELOG.md` | `[13.11]` | — | **minor** | Entrada con la decisión, el porqué del minor y el impacto sobre destinos | Las entradas publicadas |
| 7 | `SDD/Devs/Guides/Coherencia-Origen-Del-Hecho.md` | — | **1.0** | — | Nota de coherencia, con barrido y devolución al origen | — |

**Versión resultante del conjunto: SDD 13.11, minor.** Ninguna parte sube major, no se toca ninguna invariante ni
ninguna plantilla de intake (`SDD-Development-Guide.md` §VI.5).

## 2. Lo que este plan NO toca, y por qué

| Artefacto | Por qué no |
|---|---|
| `Root-Rules.md` §13 | No hay conflicto entre reglas que resolver: la cláusula vive dentro de §8.1, que §13 declara que corre antes |
| `Vocabulario-Rules.md` | El nombre se decidió con la medición de §9.1 tal como está. La unidad de contexto es de la intervención `06` |
| `Migracion-Rules.md` | Es alcance de la `05`. Su §8 no contiene la cláusula del snapshot: la segunda copia está en el orquestador de migración, que sí se toca |
| `Mesa-Rules.md` §0.0 y §0.3 | Solicitud 6: no se agrega punto de invocación. La observación sobre §0.3 queda declarada en `10` §8 |
| `Conocimiento/Knowledge-Conformacion-Pull-Request-Manual.md` | Nombra T0 sólo por su título (líneas 145 y 158) y no reproduce sus campos. Lo verifica el barrido |
| El registro de decisiones pendientes | Sin columna nueva: `10` §7, acotación 1 |

## 3. Destinos alcanzados

**`Lab-Geometria`**, con lo que `10` §10 detalla: nada retroactivo; sus escaladas abiertas `E-02`, `E-04` y `E-05`
llevan el campo cuando se vuelvan a presentar, y la base de su corrida del 2026-09-12 ya está escrita (`5c95dab`).
**Todo destino**: sus próximas salidas de T0 publican la base, y sus próximas detenciones llevan el origen del hecho.
**Otros destinos no se inventariaron.**

## 4. Cierre documental, en `IA.SDD.Documentacion`

| Artefacto | Cambio |
|---|---|
| `Reportes/26-…md` | 1.2 → **1.3**, estado **RESUELTO en SDD 13.11**, sección «Cómo se resolvió» con las cinco preguntas y los cinco criterios |
| `Reportes/README.md` | 1.25 → **1.26**: cabecera, fila de desenlace del `26` y control de cambios |
| `PROMPTs/Fixs/README.md` | Fila de la intervención `04` |
| `PROMPTs/Fixs/04-Fix-Reporte-26/OUTPUTs/` | `00`, `10`, `20`, `30` y `evidencia/` |

**Un commit por repositorio**, cada mensaje nombrando al otro, en la rama `intervencion/04-reporte-26` de cada uno.

## Control de cambios

| Versión | Fecha | Cambios | Autor |
|---|---|---|---|
| 1.0 | 2026-09-12 | Emisión: ocho cambios sobre el framework con su severidad, lo que se preserva, lo que no se toca con motivo, los destinos alcanzados y el cierre documental. | Intervención `04` |
