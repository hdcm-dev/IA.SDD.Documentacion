# OUTPUT 30 — Plan de aplicación, cambios aplicados y verificación criterio por criterio

**Intervención:** `05-Fix-Reporte-27`
**Fecha:** 2026-09-12

---

## 1 · Plan de aplicación (solicitud 9)

| # | Cambio | Artefacto | Versión | Severidad | Qué se preserva | Destinos alcanzados |
|---|---|---|---|---|---|---|
| 1 | Campo `ciclo de origen` en los tres instrumentos | `Root-Rules.md` §11 (punto 7), §12 (párrafo compartido), §12.1 (punto 4), §12.2 (punto 5 y fila de escalamiento) | 8.6 → **8.7** | minor | Los seis/tres/cuatro campos existentes de cada instrumento, sin reescribir ninguno | Todo destino: hacia adelante, en su próxima escritura de un hueco |
| 2 | Mecanismo de cómputo y comprobación de presencia | `Master-Prompt.md` §8.2 (nueva), §10.0 (comprobación 8), §15 (glosario) | 8.16 → **8.17** | minor | El mecanismo del origen del hecho (§8.1), sin modificarlo | Todo destino: la compuerta de su próxima fase |
| 3 | Clasificación en migración y tratamiento retroactivo | `Migracion-Rules.md` §4.8 (nueva), §4.9 (nueva), §6 (dos criterios) | 3.19 → **3.20** | minor | El principio de estado objetivo (§3) y los §4.1-§4.7 existentes, sin reescribir ninguno | Todo destino con huecos declarados: su próxima migración normativa |
| 4 | Cierre documental del reporte | `Reportes/27-*.md` | 1.2 → **1.3** | — | El cuerpo original del reporte, sin reescribir | — |
| 5 | Cierre de la serie | `Reportes/README.md` | 1.27 → **1.28** | — | Las filas de los demás reportes | — |
| 6 | Cierre de la fila de la intervención | `PROMPTs/Fixs/README.md` | (sin campo de versión) | — | Las filas de las demás intervenciones | — |
| 7 | Entrada del conjunto | `CHANGELOG.md` de `IA.SDD` | 13.12 → **13.13** | minor | Todas las entradas anteriores | — |
| 8 | Snapshot previo a editar | `_legacy/13.12/` | ausente → **tomado** | — | El conjunto 13.12 completo, byte a byte | — |
| 9 | Nota de coherencia | `SDD/Devs/Guides/Coherencia-Ciclo-De-Origen.md` | — → 1.0 | — | — | — |

**Ningún cambio toca invariante D1-D9 ni plantilla de intake.** El conjunto sube **minor**: ninguna de
sus tres partes sube major, y la razón por parte está en cada entrada de control de cambios (arriba).

---

## 2 · Corroboración de que lo aplicado corresponde al plan (solicitud 10)

```bash
cd IA.SDD && git diff --stat
```

Archivos con cambios: `SDD/Devs/Rules/Root-Rules.md`, `SDD/Devs/Orchestrator/Master-Prompt.md`,
`SDD/Devs/Rules/Migracion-Rules.md`, `CHANGELOG.md`, `SDD/Devs/Guides/Coherencia-Ciclo-De-Origen.md`
(nuevo), `_legacy/13.12/**` (nuevo, snapshot). **Ningún archivo fuera de esta lista.** En particular:
`Vocabulario-Rules.md`, `Mesa-Rules.md`, `Master-Prompt-Migracion.md` y
`Master-Prompt-Reanudacion.md` **no se tocaron**, verificado con `git diff --stat` sin líneas para esos
archivos — consistente con lo declarado en «lo que este conjunto NO toca» del `CHANGELOG.md`.

En `IA.SDD.Documentacion`: `Reportes/27-*.md`, `Reportes/README.md`, `PROMPTs/Fixs/README.md`, y esta
carpeta `OUTPUTs/`. **No se tocó ningún otro reporte** (verificado: sólo el `27` cambia de estado) ni
ninguna carpeta `PROMPTs/` fuera de `05-Fix-Reporte-27/OUTPUTs/` y la fila `05` del README de la serie.

---

## 3 · Verificación contra los cinco criterios de §7 del reporte (solicitud 11)

| # | Criterio | Veredicto | Fundamento |
|---|---|---|---|
| 1 | Declarar un hueco nuevo en una corrida real y comprobar que su ciclo de origen queda escrito sin que ningún agente lo tipee | **SIN VEREDICTO** | Requiere una corrida real posterior a la 13.13 que genere documentación de producto. Esta intervención no genera documentación de producto: sólo interviene el framework |
| 2 | Cruzar dos recuentos de diferidos tomados en momentos distintos y comprobar que se pueden comparar sin abrir los ítems | **CUMPLIDO A MEDIAS**, precedente del reporte `18` | Verificado sobre `Lab-Geometria` que el total se cruza sin abrir los 118 (OUTPUT 10 §2.1), pero por reconstrucción manual anterior al mecanismo. No hay todavía un par de recuentos posteriores a la 13.13 que usen el campo |
| 3 | Correr una migración sobre un árbol con huecos de las dos clases y contar cuántos se elevan; **el número tiene que ser menor que el total** | **SIN VEREDICTO — es el criterio decisivo, y no se pudo ejecutar** | Exige correr `Migracion-Rules.md` §4.8 sobre un destino real, y los destinos son de solo lectura para esta intervención. El criterio enumerable que lo exige está escrito en §6 de esa regla, con la forma exacta del reporte (menor, no igual) |
| 4 | Probar el caso retroactivo: correr la migración sobre los 118 de `Lab-Geometria` y comprobar que la decisión de §5.4 los absorbe sin elevarlos uno por uno | **CUMPLIDO A MEDIAS** | El mecanismo de §4.9 se probó con éxito sobre **una** fila real (OUTPUT 20 §1.1) y no sobre las 118: correrlo entero es una migración sobre un destino, fuera de alcance de esta intervención por norma explícita del prompt |
| 5 | El criterio de §5.5, enumerable: ningún hueco posterior a la aplicación sin ciclo de origen | **CUMPLIDO** | Fila de escalamiento P1 en `Root-Rules.md` §12.2, dos criterios en `Migracion-Rules.md` §6, comprobación 8 en `Master-Prompt.md` §10.0 |

**Un criterio cumplido, dos a medias y dos sin veredicto.** Con el precedente del reporte `18` (declarar
cumplido a medias en lugar de darlo por resuelto cuando el criterio exige correr sobre un destino), que
el propio prompt de esta intervención cita como forma aceptada de cierre parcial.

---

## 4 · Conflicto de reglas — `Root-Rules.md` §13 (solicitud 14)

**No se encontró ningún conflicto entre dos reglas que esta corrección no pudiera resolver.** Las tres
piezas nuevas (`Root-Rules.md` §11/§12, `Master-Prompt.md` §8.2, `Migracion-Rules.md` §4.8/§4.9) son
aditivas sobre archivos que no se contradicen entre sí ni con ninguna regla existente: el campo nuevo no
compite con ningún campo declarado, y la clasificación deriva de datos que ya existían (control de
cambios de las reglas, bloque de procedencia del destino) sin reescribir su forma. **`Root-Rules.md`
§13 no se ejerció** porque no hubo conflicto que arbitrar, y se declara en lugar de omitirse.

---

## 5 · Qué cambió para la intervención `03` (solicitud, «qué devolver» punto 7)

**Nada que le agregue una precondición.** La `03` (reporte `25`, el disparador del ciclo) no depende de
ninguna pieza que esta intervención haya creado: el ciclo de origen es del **formato del hueco**, y el
`25` trata el evento que dispara un nuevo ciclo, no el contenido de lo que ese ciclo declara. Lo único
que la `03` hereda, igual que esta intervención lo heredó de la `04`, es la disponibilidad de la **base
de la corrida** como pieza reutilizable si el disparador que decida terminara necesitando anclar un
momento — y si lo necesita, el precedente ya está escrito dos veces (origen del hecho, ciclo de
origen) con el mismo cuidado de cuándo conviene recalcular y cuándo conviene congelar.

---

## 6 · Lo que no se pudo verificar, y por qué (solicitud, reglas)

- **Los criterios 1 y 3 del reporte** no se ejecutaron: exigen una corrida real de generación y una
  migración real sobre un destino, y esta intervención no produce ninguna de las dos por su propio
  alcance (framework, no destino).
- **La derivación de las 118 filas de `Lab-Geometria`** se probó sobre una sola fila de muestra y no
  sobre el conjunto completo, por la misma razón: ejecutarla entera es trabajo de migración sobre un
  destino, y el destino es de solo lectura para esta intervención.
- **El costo de calificación de `ciclo de origen`** se verificó con `grep` contra el árbol de `IA.SDD`
  únicamente: no se corrió contra `IA.SDD.Documentacion` ni contra ningún destino, porque el término es
  nuevo del framework y no tiene por qué colisionar con vocabulario de un destino — y si colisionara, no
  sería un defecto de esta intervención sino del destino que lo usa con otro sentido, caso no observado.
