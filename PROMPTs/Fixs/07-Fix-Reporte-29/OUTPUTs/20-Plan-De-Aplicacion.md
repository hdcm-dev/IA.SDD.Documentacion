# 20 — Plan de aplicación (solicitud 8)

Un solo artefacto alcanzado: `SDD/Devs/Rules/Rules-Backlog-Tecnico.md` (5.2 → 5.3, minor). Snapshot
previo en `_legacy/13.14/SDD/Devs/Rules/Rules-Backlog-Tecnico.md` (framework en 13.14 antes de esta
intervención).

| # | Cambio | Sección | Qué se preserva | Destinos alcanzados |
|---|---|---|---|---|
| 1 | Nota de alcance que distingue nivel de aplicación (dónde vive el documento) de unidad de conteo del umbral (de qué proyecto es cada US/BT) | Cabecera | Los cinco campos de cabecera existentes, sin tocar ninguno | Ninguno: aclaración, no cambia comportamiento |
| 2 | Sin cambios | §2.1 tabla maestra | Íntegra: ya decía «proyecto de código» con tres bandas | — |
| 3 | Reescritura de la convención: «unidad de entrega» → «proyecto de código», dos bandas → tres; suma el porqué, el caso del documento consolidado y la atribución por bloque/rango declarado del producto | §3.3 | La justificación original de cada carpeta (trazar dependencias, versionar por separado) y la obligación de criterios/trazabilidad/DoR en los dos modos | `Lab-Geometria` (confirma su lectura), `RPI.VideoControl` (confirma su lectura para US; deja abierta su propia `DEC-00003` de atribución de BT, que esta regla no resuelve ni le corresponde) |
| 4 | Las preguntas nombran la unidad de conteo | §5.2, §5.5 | La pregunta en sí, sin agregar ni quitar ítems | Ninguno: guía para el subagente, no gating |
| 5 | Reclasifica `[interpretativo]` → `[enumerable]`, agrega el comando de conteo por proyecto | §6 | El resto de los quince criterios de aceptación, sin tocar ninguno | Ninguno rompe: el criterio pasa a poder correrse mecánicamente, no cambia lo que exige |
| 6 | «unidad de entrega» → «cada proyecto de código que supere» en las dos líneas de generación condicional | §8 snippet | El resto del snippet | Ninguno: guía de despacho, no un artefacto generado |
| 7 | Fila 5.3 de control de cambios, con el fundamento y el impacto medido | §9 | Las quince filas anteriores | — |

**Severidad del conjunto: minor.** Ningún destino medido deja de cumplir; uno que bajo la lectura
vieja de §6 parecía incumplir pasa a cumplir. No exige `v2.0` de ningún artefacto generado ni
reescritura retroactiva en ningún destino.

**Qué no se toca, y por qué.** `Master-Prompt.md` §10.0 (compuerta mecánica): solo consume los
anti-patrones `[enumerable]` de la tabla §4.8 de cada regla de categoría, no el listado de §6
(verificado: §10.0 nombra «tabla §4.8 —o equivalente—» y el criterio de §6 alcanzado por este fix
no está en esa tabla). `Catalogo-De-Criterios.md` §4: indexa el recuento de anti-patrones de §4.8
por archivo (`Rules-Backlog-Tecnico.md | 11 | 5 | 6`), no los criterios de §6; ese recuento no
cambia porque ningún anti-patrón de §4.8 se tocó. Ningún otro archivo del framework nombra «30 BT»
ni «20 US» (`evidencia/ev-01-citas.out`).
