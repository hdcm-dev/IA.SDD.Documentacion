# OUTPUTs de la intervención 09 — reporte 31

**Estado: aplicada. SDD 13.18, minor**, en la rama `intervencion/09-reporte-31` del worktree `IA.SDD-i09`,
sin push, sin pedido de fusión y sin fusión. El reporte `31` quedó **RESUELTO en SDD 13.18**.

## Qué hay, en orden de lectura

| Pieza | Qué es |
|---|---|
| `10-Decision-De-Fondo-Y-Las-Doce-Preguntas.md` | Verificación previa, el lote tomado como resuelto, **la decisión de fondo (sí)** y Q1 a Q12 |
| `Mesa-2026-09-13-Intervencion-09/00-contrato-de-entrada.md` | Contrato de la mesa |
| `Mesa-2026-09-13-Intervencion-09/cartas/` | Las nueve cartas, asentadas antes de despachar |
| `Mesa-2026-09-13-Intervencion-09/informes/` | Los siete informes verbatim: Seguridad, Formal, Trazabilidad, Requisitos, Verificación, Lector sin contexto y Refutador |
| `Mesa-2026-09-13-Intervencion-09/07-constancia-redespacho-del-refutador.md` | El primer despacho del refutador murió por el límite de sesión; se comprobó que no quedaba vivo antes de repetir |
| `Mesa-2026-09-13-Intervencion-09/jurado/` | Los cinco votos, cada uno de un agente distinto: `Ev`, `Im`, `CB`, `CH`, `Ri` |
| `Mesa-2026-09-13-Intervencion-09/09-Dictamen-Del-Ciclo.md` | Veredicto (17/17, 5-0), homogeneidad, variantes, **testimonio del Product Owner** sobre `Lab-Geometria`, deuda D9-1 a D9-3 |
| `30-Verificacion-Del-Plan-Aplicado.md` | Commits, versiones, criterios probados fallando, **A1 a A12 re-medidos sobre los dos expedientes reales**, lo no verificado |
| `borrador/` | El plan que la mesa atacó, como quedó antes de la mesa |
| `evidencia/` | `ev-00` a `ev-07`, cada una con su comando y su salida |
| `HUELLAS-ANTES-S2.txt` | Huellas de las piezas de esta carpeta antes de su redacción S2 |

**Sobre las redacciones S2 de esta carpeta.** El informe de Seguridad ofuscó la organización de un repositorio
privado y detalles de infraestructura: huella `c9f7179e11b01691765a64efd79333fe757278d04593be47a929c17b7976c6a2` →
`dcbfb9f6dda9b4ba31cdeec76e999da8794f2684172fac5e6a09c51130170e9d`. Las rutas con el usuario del host pasaron a
`<u>`, `<workspace>` y `<scratchpad>`. Los originales quedaron en la custodia de sesión, que no es durable (D9-1).

**El PR #66 del framework**, que conserva originales anteriores a la redacción del folio 018: **evaluado, sin
acción**. La misma información es pública en su fuente, `Lab-Geometria`, desde el 2026-09-02.

## Punto de continuación

**Dónde está:** aplicada y verificada; commits en las dos ramas, sin push.

**Sigue:** la revisión y la fusión, que son del Product Owner o del coordinador de la sesión. Si se fusiona el
framework, **no aplastar la historia** de la rama: lleva folios de expediente (`Expediente-Rules.md` §4, S3).

**Queda abierto:** D9-1 (custodia durable), D9-2 (dirección y credencial en `_legacy/`; **la credencial tiene
que rotarse**), D9-3 (guía de usuario y remisiones de `Mesa-Rules.md`); D-1, de la corrida de migración de
`Lab-Geometria`.
