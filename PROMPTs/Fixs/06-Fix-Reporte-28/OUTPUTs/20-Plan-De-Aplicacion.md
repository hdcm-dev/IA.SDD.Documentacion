# 20 — Plan de aplicación

**Fecha:** 2026-09-12 · **Base:** `9dc8ded` (SDD 13.11) · **Resultado previsto:** SDD **13.12**, minor

| # | Artefacto | Versión | Severidad | Qué cambia | Qué se preserva | Destinos alcanzados |
|---|---|---|---|---|---|---|
| 0 | `_legacy/13.11/` | — | — | Snapshot **antes** de editar, desde `9dc8ded`, con las exclusiones de §VI.5 (`CHANGELOG.md`, `_legacy/`, `.gitignore`, `vs.bat`, las mismas de `_legacy/13.10`) | Todo | Ninguno: habilita el diff normativo 13.11 → 13.12 |
| 1 | `Vocabulario-Rules.md` | 3.2 → **3.3** | minor | §8 alcance; §9.2 contexto por lector; §9.4 toda afirmación con comando; §9.6 cita de §9.2; §10 primer `[enumerable]` | Los seis términos, §9.1, §9.3, §9.5, la resolución de §9.6, los doce criterios interpretativos | Todos, **hacia adelante**: afirmaciones nuevas con comando; costeo de familias calificadas por lector |
| 2 | `Master-Prompt.md` | 8.15 → **8.16** | minor | §10.0 comprobación 7; §10 criterio de polisemia; §15 «Contexto de lectura», «Glosario operativo», «Compuerta mecánica» | Las seis comprobaciones, las tres obligaciones del banco, el flujo, los insumos, D8 | Su compuerta suma la 7 **cuando se la toque**, con el alcance temporal de §10.0 |
| 3 | `Mesa-Rules.md` | 1.2 → **1.3** | minor | §6.1 ancla E1 de una afirmación de colisión; §8 criterio enumerable | Condición de convocatoria, roles, escala de ancla, lista cerrada | Próxima mesa |
| 4 | `SDD-Development-Guide.md` | 1.29 → **1.30** | — (guía) | §VI.3 comprobación 14 y fundamento; §II.7 trece → catorce; **reordenar** filas 1.25–1.29 | Texto de toda fila existente | Ninguno (rige sobre el framework) |
| 5 | `SDD-User-Guide.md` | 1.20 → **1.21** | — (guía) | Glosario «Contexto de lectura»; **reordenar** filas 1.17–1.19 | Texto de toda fila existente | Ninguno |
| 6 | `Catalogo-De-Criterios.md` | 1.16 → **1.17** | — (índice) | §3 situación nueva y dos reapuntadas | §4, total 222 | Ninguno |
| 7 | `CHANGELOG.md` | entrada **13.12** | minor | Decisión, cambios, lo no tocado, lo no medido, por qué minor, impacto medido, snapshot | Entradas publicadas | — |
| 8 | `Coherencia-Colision-Lexica.md` | **1.0** | — | Nota con las catorce comprobaciones y la devolución al origen | — | — |

**Por qué minor, derivado con §VI.1 y §VI.5.** La pregunta es si un documento generado con la 13.11 sigue cumpliendo
con la 13.12. **Sí**: el criterio enumerable nuevo rige desde la 3.3; el criterio de polisemia ya decía «todo término»
en `Vocabulario-Rules.md` §10 y en `Master-Prompt.md` §10, de modo que ensanchar §8 no agrega lo que ya se auditaba;
la comprobación 7 no emite hallazgo. Ninguna regla sube major, ninguna plantilla de intake cambia y no se modifica
ninguna invariante D1–D9. **Minor.**

**Impacto medido sobre destinos** ([`evidencia/ev-destinos.out`](evidencia/ev-destinos.out)): en `SDD/Docs/` fuera
de carpetas archivadas, **73** (`RPI.VideoControl`), **59** (`SelfHosted.Service.Core`), **1** (`SAI.Service.Core`) y
**89** (`Lab-Geometria`) líneas que mencionan una colisión junto a un término, un sentido o una polisemia, **ninguna
con un comando en la línea**. Es proxy, y **es el volumen de hallazgos que la regla produciría si fuera retroactiva**.
Por eso no lo es. **Ningún destino se toca.**

**Lo que el plan NO hace**: registro de términos; mecanizar los otros doce criterios; que la compuerta decida;
`Root-Rules.md` §13; `Migracion-Rules.md` y `Master-Prompt-Migracion.md`; reescribir las afirmaciones ya publicadas
sin comando; decidir los nombres de los campos de los reportes `26` y `27`.
