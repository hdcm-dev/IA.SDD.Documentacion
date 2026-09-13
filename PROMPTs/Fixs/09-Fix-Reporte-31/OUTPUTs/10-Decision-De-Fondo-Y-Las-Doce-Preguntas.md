# 10 — Decisión de fondo y las doce preguntas (solicitudes 1, 2, 4, 6 y 7)

Evidencia en `evidencia/ev-01-comandos-del-reporte.out` y `evidencia/ev-02-colision.out`; la mesa, en
`Mesa-2026-09-13-Intervencion-09/`; el dictamen del ciclo, en su `09-Dictamen-Del-Ciclo.md`.

## 1. Qué estaba resuelto antes de empezar (solicitud 1)

- **Versión vigente: 13.17**, ya fusionada (`CHANGELOG.md` l.6; `git merge-base --is-ancestor cab03ed main` → sí). Esta intervención es la **13.18**.
- **El expediente `0001` está en `main`** (`650053e`, por squash), con 18 folios; `git ls-tree -r --name-only main Expedientes | wc -l` → `63`.
- **Las citas del reporte siguen literales en `main`**, con una diferencia: `Lab-Geometria/SDD/Docs/Audit/` tiene **116** archivos y no 113, porque la migración ya fusionada sumó tres. «Expediente» sigue apareciendo una sola vez en la norma como prosa (`Migracion-Rules.md` l.669) más las ocurrencias de la 13.17. «Punto de continuación» sigue sólo en la reanudación. `Master-Prompt-Migracion.md` l.46 y l.291 siguen como el reporte las cita. La lista de exclusiones del snapshot sigue siendo la de l.990.
- **Ningún otro reporte entra**: el `31` es el único abierto contra el framework (`Reportes/README.md`).

## 2. El lote, tomado como resuelto (solicitud 2)

E-1 → A (los expedientes del framework en `IA.SDD/Expedientes/`); E-2 → A (el dato personal, redactado);
E-3 → **insumo de la mesa**, con `ev-07` como restricción dura. **La mesa lo resolvió por la opción C**
(J9-02, 5-0): D9 intacta; el asiento literal con canal, fecha-hora y huella **es** la aprobación registrada
de D9. El coordinador de la sesión había decidido aplicarla sin elevar si el jurado la respaldaba. **El salto
es minor.**

## 3. Decisión de fondo (solicitud 4): **sí**

El método adopta el caso como figura normada. **Fundamento:** ningún contenedor del método tiene la unidad
«caso» (folio 006, V4-02), y reconstruir una fase de un destino exigió nueve archivos, tres directorios y una
rama (folio 008, N3-08). **La forma es la del jurado de esta intervención**, no la del dictamen del `0001`
al pie de la letra: la mesa encontró 64 hallazgos contra el plan y el refutador, 8 ataques de costo.

## 4. Las doce preguntas

| Q | Respuesta | Qué se verificó antes de aplicar | Fundamento |
|---|---|---|---|
| **Q1** Dónde vive | Destino `SDD/Expedientes/<NNNN>-<Titulo>/`; framework `Expedientes/`. Fuera del snapshot por **exclusión nombrada en §VI.5**; `README.md` l.152 **reformulada y declarada** | `ev-07`: `find _legacy/13.17 -path '*Expedientes*' \| wc -l` → `0`; la exclusión figura en §VI.5 | J9-15; folio 016 Q1 |
| **Q2** Cuándo se abre | Alguna de dos ramas y **ninguna** exclusión; radicación donde corre la corrida | Observable al abrir; excluye la mesa con registro en `Audit/` y la detención del lote por nombre | J9-05; FOR-03, REQ-02, REQ-05 |
| **Q3** Forma mínima | Carátula de **seis** campos: **diecinueve** en un caso de dos folios, no dieciocho | `ev-04`: `campos: README 6 · 001 7+1 · 002 4+1 · archivos 3`. **Pasa el techo de 18 del prompt en uno**, por `Objeto`, que pide la letra de `ev-07` («un README.md que describa el caso tratado»); se declara | J9-13; REQ-03 |
| **Q4** Identificador | Número local de **cuatro dígitos**, familia excluida en `Root-Rules.md` §9.2, **sin tocar D3** | `ev-02`: `EXP-` en 20 archivos de `Lab-Geometria` `main` (la rama `migracion/a-13.16` ya fusionada), `EV-` en 9 y 45; `ev-06a`/`ev-06b`: A1 → `0` en los dos repositorios | J9-03; REF-07, VER-03 |
| **Q5** Estados | Seis tipos; estado derivado de la **secuencia**; mapeo total por enumeración (FOR «lo que revisé» 1) | Formal convocada (D-5) | J9-06; FOR-01, FOR-02 |
| **Q6** Inmutabilidad | S1 desde el primer push contra la rama principal, **carpeta entera y renombres**; S3 sobre la fusión; sin folio por commit ni trailer; **excepción: redacción S2** con constancia | `ev-04`: A7 marca README editado y borrado en `evidencia/` después del push, y queda vacío con la constancia S2; renombre de carpeta detectado | J9-07; REQ-04, VER-04 |
| **Q7** Evidencia | Medición contra observación; huella sólo para lo no versionado; testimonio **por contenido**; oración de D9: **no** (C); S2 con Seguridad | Seguridad convocada (D-2); S2 con visibilidad verificada (`ev-05`: tres públicos, un privado) | J9-02, J9-08; SEG-01..08 |
| **Q8** Evidencia → especificación | Una sola vía declarada, la fila de control de cambios, **directa o a través de `Audit/`**; inversa en dos pasos con `git grep` | TRZ-03: 13 de 31 artefactos del caso real citan el plan y no el expediente | J9-10 |
| **Q9** Relación con `Audit/` y reportes | Folio por enlace (`ruta@commit`); en el framework el expediente es el registro (`Mesa-Rules.md` §8 criterio 1) | Aplicado en `Mesa-Rules.md` 1.4 | J9-04 |
| **Q10** Retroactivo | Forma histórica para los dos adelantos y el precedente; nada se reescribe | `ev-06a`, `ev-06b` | J9-12, J9-16 |
| **Q11** Mesa y no detención | Párrafo en `Master-Prompt.md` §8.1 **acotado** a ambigüedad y arbitraje; **confirmación de plan y T4 excluidas por nombre**; **modificación declarada** de `Master-Prompt-Migracion.md` l.46 | Cableado en migración (l.46, M4) y reanudación (§0) | J9-11; FOR-08, LEC-05..07, REQ-06 |
| **Q12** Punto de continuación | El pase del último folio; R0 paso 4 lo lee en expedientes de forma vigente | `Master-Prompt-Reanudacion.md` 1.14 | J9-12; REF-06, LEC-04 |

## 5. Reutilizar antes de inventar (solicitud 7)

| Pieza existente | Cómo se usó | Por qué no alcanzaba sola |
|---|---|---|
| `Audit/` | Sigue siendo la fuente de cada acto; el expediente la folia por enlace | Es por acto, no por caso |
| Origen del hecho y lote de §7.0 | La mesa antes de la detención los reutiliza en su orden | No tenían la mesa como salida |
| D9 y su tipo `humano` | El testimonio aprobatorio es `humano` sin cambiar D9 | D9 no decía qué distingue un registro de una captura |
| `Root-Rules.md` §9.5 | El número y el folio, familias excluidas | — |
| La frontera de §II.7 | Los comandos viven en §6 de la regla | — |
| El ítem diferido de §12.2 | La deuda D9-1 a D9-3 tiene su forma | — |

**Lo nuevo es una regla transversal**, porque ninguna de esas piezas tiene la unidad caso ni la custodia
de lo que entra desde afuera del árbol.
