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
| `02` | [Fix-Analizar-Reporte-16.md](02-Fix-Reporte-16/Fix-Analizar-Reporte-16.md) | `16` — la exclusión de alcance concedida contra una declaración | **Sin aplicar** |

**El `15` no tiene prompt acá y está resuelto**: entró en **SDD 10.1** por otra vía, y se verificó
—§VI.3.2 con su séptima clase de exclusión, y la fila 1.20 del control de cambios de la guía—. El
**`17`** todavía no existe: lo esperan tres hallazgos ya medidos en la migración de `Lab-Geometria`.

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
