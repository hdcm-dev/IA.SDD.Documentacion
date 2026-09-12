# Prompts de aplicación de fixes sobre el `Framework SDD`

Tratamiento de los reportes de `/IA/SDD/IA.SDD.Documentacion/Reportes` durante la fase de
orquestación: **acá viven los prompts que aplican un reporte sobre el framework**, uno por
intervención, con sus resultados intermedios en su propia carpeta `OUTPUTs/`.

**Un reporte documenta un hueco con evidencia; un prompt de acá lo convierte en una versión del
framework.** Son dos actos distintos y por eso viven en dos lugares distintos: el reporte no
modifica nada, y este prompt sí.

## Las intervenciones

| # | Prompt | Reportes que aplicó | Estado |
|---|---|---|---|
| `00` | [Fix-Analizar-Reportes-00-11.md](00-Fix-Reportes-00-11/Fix-Analizar-Reportes-00-11.md) | `00` a `11` — los doce primeros, como una sola intervención | **Aplicado.** Cerró en **SDD 7.0**, el 2026-08-15 |
| `01` | [Fix-Analizar-Reportes-12-14.md](01-Fix-Reportes-12-14/Fix-Analizar-Reportes-12-14.md) | `12`, `13` y `14` — los que quedaron fuera del cierre de 7.0 | **Aplicado**, de a uno y en versiones distintas: el `13` en **9.19**, el `14` en **10.0** y **11.0**, el `12` en **12.1** |
| `02` | [Fix-Analizar-Reporte-16.md](02-Fix-Reporte-16/Fix-Analizar-Reporte-16.md) | `16` — la exclusión de alcance concedida contra una declaración | **Sin objeto: el reporte se resolvió por otra vía.** El `16` está **RESUELTO en SDD 13.6**, con su sección «Cómo se resolvió», y este prompt nunca fue el vehículo. Verificado el 2026-09-12 contra [`Reportes/README.md`](../../Reportes/README.md) y contra el propio reporte, no contra el nombre de esta carpeta |
| `03` | [Fix-Analizar-Reporte-25.md](03-Fix-Reporte-25/Fix-Analizar-Reporte-25.md) | `25` — el producto evoluciona y el método no tiene dónde registrarlo | **Sin aplicar.** Cuarta y última del orden `04` → `06` → `05` → `03` |
| `04` | [Fix-Analizar-Reporte-26.md](04-Fix-Reporte-26/Fix-Analizar-Reporte-26.md) | `26` — la pregunta previa no distingue quién generó la situación | **Aplicado.** Cerró en **SDD 13.11**, el 2026-09-12, **primera del orden**. El origen del hecho se **calcula contra la base de la corrida** —el commit sobre el que corre T0—, **no contra el snapshot por despacho** que el reporte proponía, que ya contiene lo que dejaron las unidades anteriores; y las detenciones de una fase salen en lote. Un criterio de aceptación queda a medias y dos esperan una corrida real, declarados en su [`OUTPUTs/30`](04-Fix-Reporte-26/OUTPUTs/30-Verificacion-Del-Plan-Aplicado.md) |
| `05` | [Fix-Analizar-Reporte-27.md](05-Fix-Reporte-27/Fix-Analizar-Reporte-27.md) | `27` — la especificación no se puede correlacionar con el ciclo que la produjo | **Aplicado.** Cerró en **SDD 13.13**, el 2026-09-12, **tercera del orden**. El campo **`ciclo de origen`** reutiliza la base de la corrida de la `04` y se congela en vez de recalcularse, porque un hueco se lee en corridas futuras; se confirmó con cero colisiones, con la unidad de contexto que fija la `06`. `Migracion-Rules.md` deriva la clasificación **hueco del ciclo / hueco de norma posterior** del commit y no de un campo declarado aparte, y el tratamiento retroactivo deriva o marca `no derivable` sin exigir reescribir los 118 de `Lab-Geometria`. Un criterio cumplido, dos a medias y dos sin veredicto hasta una migración real, declarados en su [`OUTPUTs`](05-Fix-Reporte-27/OUTPUTs/) |
| `06` | [Fix-Analizar-Reporte-28.md](06-Fix-Reporte-28/Fix-Analizar-Reporte-28.md) | `28` — la afirmación de colisión léxica no tiene compuerta, ni regla que la alcance | **Aplicado.** Cerró en **SDD 13.12**, el 2026-09-12, **segunda del orden**. `Vocabulario-Rules.md` gobierna la colisión de **todo término** y §15 sólo define; el contexto de lectura se declara **por lector**; toda afirmación de colisión lleva su comando, en la regla, en la mesa y en la intervención; y la compuerta **localiza sin decidir**. **Para la `05`**: calificar en `Migracion-Rules.md` cuesta 23, y 45 sólo si el sentido nuevo se escribe también en `Master-Prompt-Migracion.md`. Un criterio a medias, declarado en su [`OUTPUTs/30`](06-Fix-Reporte-28/OUTPUTs/30-Verificacion-Del-Plan-Aplicado.md) |

**El `16` siguió el camino del `15`, y la fila de arriba lo dice en lugar de dejar «Sin aplicar».** Una fila que declara trabajo pendiente sobre un reporte resuelto hace que la próxima intervención lo re-trabaje, que es la mitad de circuito que este mismo README declara incumplida tres veces. Se detectó el 2026-09-12, dos versiones del framework después del cierre real.

**El `15` no tiene prompt acá y está resuelto**: entró en **SDD 10.1** por otra vía, y se verificó
—§VI.3.2 con su séptima clase de exclusión, y la fila 1.20 del control de cambios de la guía—. El
**`17`** **ya existe** —se emitió el 2026-08-31 con dos de los tres hallazgos de la migración de
`Lab-Geometria`, y el tercero se declaró del destino— y **sigue sin intervención asignada**, igual que
los `19` a `24`. Esta línea decía lo contrario hasta el 2026-09-12: se corrige acá porque una fila
desactualizada de este README ya produjo una vez que se re-trabajara un reporte resuelto.

**Las intervenciones `04`, `06`, `05` y `03` salieron de la misma corrida y se aplican en ese orden.** No es
alfabético y tiene fundamento: la `04` corrige **cuándo un agente detiene y pregunta**, y mientras ese
hueco siga vivo las otras tres van a producir consultas al humano durante su propia aplicación —que es
exactamente el problema que la `04` cierra—. La `06` va segunda porque la `05` tiene que **decidir el nombre de un campo** que colisiona o no según la
unidad de contexto de `Migracion-Rules.md`, y esa unidad es lo que la `06` declara. La `05` va tercera porque **reutiliza** la pieza que la
`04` decidió: el **origen del hecho**, que se **calcula contra la base de la corrida** en vez de
pedírselo al agente que lo generó. **Esta frase decía «un dato de procedencia que se deriva del estado
previo» hasta la aplicación de la `04`**, que midió que el snapshot no contiene el dato y descartó el
nombre `procedencia` por colisión. La `03` va última porque decide el **disparador del ciclo**, y conviene decidirlo con los
huecos ya correlacionables. **Si alguna se ejecuta fuera de orden, su prompt pide declararlo.**

**Van separadas y no fusionadas**, por el criterio del ciclo 3 aplicado **con el AND y no con el OR**:
comparten la corrida de origen y **no el artefacto** —la `03` toca el disparador, la `04` la compuerta de
escalada, la `05` el formato del hueco, la `06` la regla de vocabulario—. Fusionarlas produciría una intervención que nadie puede
auditar por partes.

**La intervención `03` abre un eje que la serie no tenía.** Las tres anteriores corrigen cómo el método
especifica, propaga o audita. La `03` decide **si el método recibe un cambio de alcance del producto
después del handoff**, y por eso su prompt empieza pidiendo que se decida eso antes que nada: si la
respuesta es que no, las otras cuatro preguntas del reporte cambian de forma. **Una decisión negativa
con fundamento escrito es un desenlace válido**, y el precedente es el reporte `12`.

## Cómo se numera

**Dos números distintos, y conviene no confundirlos.** El prefijo —`00`, `01`, `02`— es el de la
**intervención**, por orden. Lo que sigue son **los reportes que aplica**, en rango cuando son varios
—`00-11`, `12-14`— y sueltos cuando es uno.

**Un reporte que ya está resuelto no entra a una intervención.** El `15` sigue al rango de la `01` y
**no** está en la `02`: se verificó que su corrección está en el framework —§VI.3.2 con su séptima
clase de exclusión, y la fila 1.20 del control de cambios de la guía— y con eso queda afuera. El
README de la serie es explícito: un reporte resuelto no se reanaliza.

> **Por qué esto está escrito.** El borrador del `02` se llamaba `02-Fix-Reportes-15-17` y arrastraba
> del `01` —el reporte `14`, sus versiones, su carpeta de `OUTPUTs`, «las quince reglas» cuando ya son
> veinte— además de dar por aplicado un reporte que declara lo contrario y de incluir uno ya resuelto,
> que el README de la serie declara **no reanalizable**. El borrador queda como
> [`Fix-Analizar-Reportes-15-17-SUPERADO.md`](02-Fix-Reporte-16/Fix-Analizar-Reportes-15-17-SUPERADO.md).
>
> **Un prompt que se copia del anterior hereda su alcance**, y el alcance es lo primero que cambia
> entre una intervención y la siguiente. Conviene que lo primero que verifique quien escriba el
> siguiente sea **qué reportes están sin aplicar hoy**, leyendo el estado en
> [`Reportes/README.md`](../../Reportes/README.md) y no el nombre de la carpeta anterior.

## Qué tiene que cerrar toda intervención

`Reportes/README.md` documenta **seis fallas** de este circuito: tres al emitir un reporte sin su
fila, y tres al resolverlo sin cerrarla. Las dos mitades son la misma causa —el acto que cambia el
estado ocurre en el otro repositorio y nadie del lado de acá lo ve pasar—, así que toda intervención
cierra, **en el mismo commit que el cambio**:

1. El reporte pasa a `RESUELTO en SDD <versión>` y suma su sección **«Cómo se resolvió»**, con el
   desenlace de cada propuesta y **el veredicto de cada criterio de aceptación, uno por uno**.
2. `Reportes/README.md` cierra la fila y actualiza el estado de la serie.
3. El `CHANGELOG.md` del framework suma su entrada, con la decisión major/minor.
