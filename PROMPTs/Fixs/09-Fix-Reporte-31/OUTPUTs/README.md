# OUTPUTs de la intervención 09 — reporte 31

**Estado: en curso, cortado.** Este archivo es el punto de continuación. Lo que está acá se produjo el
2026-09-13 contra `IA.SDD` `main` `a501857` (13.17), `Lab-Geometria` `main` `d12fb1c` y
`RPI.VideoControl` `HEAD` `9aabe5c`.

## Qué hay

| Pieza | Qué es |
|---|---|
| `evidencia/ev-00-snapshot-13.17.out` | Snapshot `_legacy/13.17/` tomado de `main` sin editar: 133 archivos = `git ls-tree`, sin `Expedientes/`. Commiteado en `IA.SDD-i09` como `35212d7` |
| `evidencia/ev-01-comandos-del-reporte.out` | Los comandos del reporte 31 §2 corridos sobre `main`. Todo literal salvo `Audit/` de `Lab-Geometria`: 116 y no 113 (la migración sumó tres). La 13.17 está fusionada |
| `evidencia/ev-02-colision.out` | Colisión de términos y prefijos (`expediente`, `folio`, `EXP-`, `EV-`, `M9-`) |
| `evidencia/ev-03-a1a10-reales.out` y `ev-03b-…sh.txt` | A1–A10 del borrador sobre los dos expedientes reales. **Tomado con una versión anterior de A9** (M9-VER-07): se retoma con los comandos definitivos |
| `borrador/Expediente-Rules.md`, `borrador/20-Plan-De-Aplicacion.md` | El plan que la mesa atacó: decisión de fondo **sí**, regla transversal nueva, 18 cambios |
| `Mesa-2026-09-13-Intervencion-09/` | Contrato de entrada, cartas asentadas **antes** de despachar, y seis informes verbatim del panel a ciegas: Seguridad, Formal, Trazabilidad, Requisitos, Verificación, Lector sin contexto |
| `HUELLAS-ANTES-S2.txt` | SHA-256 de las piezas antes de la redacción S2 (usuario del host en rutas → `<u>`, `<workspace>`, `<scratchpad>`). Los originales quedaron en el scratchpad de la sesión, **que no es custodia durable** (M9-SEG-05) |

## Dónde se cortó

El **refutador** fue despachado con los seis informes a la vista y **no terminó** (límite de sesión de la
API). No hay informe del refutador, ni jurado, ni dictamen de este ciclo. **Antes de volver a despachar,
comprobar que no quedó un despacho vivo** (folio 003 del 0001).

## Qué dijo el panel, en una línea por raíz (para retomar sin releer; la fuente son los informes)

1. **E-3**: esta mesa no puede modificar D9 (README l.145); opción **C** —D9 intacta, el asiento con
   original, canal, fecha-hora y huella *es* la «aprobación explícita registrada» de `Deriva-Rules.md`
   l.53— minor, con A preparada para el Product Owner (M9-REQ-01).
2. **Criterios rotos**: A4 sin anclas, A9 vacuo para `.txt`, A1 imposible con carpetas de cuatro dígitos,
   A7 con `main` fijo, sin renombres y «vacío» cuando no evalúa, A8 frágil (forma de la celda, CRLF, dos
   bloques, salto final), A10 trunca títulos con punto y no reconoce la cita del dictamen
   (FOR-04..07, VER-01..06, TRZ-01/02, LEC-01/02).
3. **Estado derivado**: una `constancia` de errata muda el estado; «reabierto» con dos definiciones; qué
   sigue a `archivo` (FOR-01/02). Tipo en nombre y cabecera, Número/Título duplicados (TRZ-05).
4. **§1 apertura**: listas que se intersecan sin precedencia; «ante la duda, no se abre» y «sin casa» no
   estaban en el dictamen; el testimonio de un cambio de intake no tiene casa (FOR-03, REQ-05, LEC-03).
5. **Q11**: el paso 5 vacía el 3 para el arbitraje (l.640 vs. `Mesa-Rules.md` l.562); «cumple §0.0» a
   mitad de fase sin contrato; sin punto fijo; «lote» en M4 indefinido; falta la reanudación
   (FOR-08, LEC-05..07, REQ-06).
6. **S1**: el dictamen dice «primer push», el borrador «fusión» (REQ-04). **S2**: comando de §7 errado
   (7 falsos positivos, 0 verdaderos), respuesta por clase de dato (revocar / retiro / constancia),
   autónoma de `Rules-Base-Conocimiento.md` §2.2, redacción como única edición de un verbatim; los
   originales pre-S2 del 0001 **siguen públicos** en los commits del PR #66 (SEG-01..08).
7. **Vínculo**: la vía única pierde 13 de 31 artefactos de la migración real, que citan el plan y no el
   expediente (cadena de dos saltos); `ruta@commit` sin forma; calificador de repositorio sin fuente
   (TRZ-03/04/06/07).
8. **Requisitos**: el README tiene que describir el caso (campo `Objeto`), criterio de radicación «donde
   estás parada», foliatura de `Audit/` sin criterio, estándares sin rastro (REQ-02/03/07/08).
9. **Folio 019 sobre el 0001 fusionado** choca con S1 (VER, fuera de competencia).

## Qué sigue

1. Re-despachar el **refutador** (`cartas/07-Refutador.md`, más los seis informes), después de comprobar
   que no hay despacho vivo.
2. **Jurado de cinco agentes distintos**, uno por función (Ev, Im, CB, CH, Ri).
3. Dictamen del ciclo, corrección del borrador y del plan, y recién ahí aplicar en `IA.SDD-i09`
   (rama `intervencion/09-reporte-31`, sobre el snapshot ya commiteado), nota de coherencia,
   `CHANGELOG.md` `[13.18]`, verificación, cierre del reporte 31 y fila 09 de `PROMPTs/Fixs/README.md`.
4. **Lote al Product Owner (sin enviar todavía)**: E-3 opción A o C; si pide el retiro de los commits
   del PR #66 con el dato personal; si acepta que `Expedientes/` público nombre destinos.
