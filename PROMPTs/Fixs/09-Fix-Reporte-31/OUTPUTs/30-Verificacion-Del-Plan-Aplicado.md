# 30 — Verificación del plan aplicado (solicitudes 9 a 14)

Comandos y salidas completos en `evidencia/ev-04` a `ev-07`, corridos sobre el worktree `IA.SDD-i09`, rama
`intervencion/09-reporte-31`, contra la base `main` `a501857`. **Sin push, sin pedido de fusión, sin fusión.**

## 1. Commits del framework

| Commit | Lote |
|---|---|
| `35212d7` | `_legacy/13.17/`, snapshot tomado de `main` antes de editar: 133 archivos, idéntico a `git archive main`, sin `Expedientes/` |
| `f41bc49` | Lote 1: `Expediente-Rules.md` 1.0 y su cableado |
| `0486712` | Lote 2: ofuscación de `Examples/` |
| `12e9580` | Expediente `0001`: folios 019 (redacción S2) y 020 (resolución) |
| `9337b20` | Lote 3: autocorrección de A7, A9 y A12 (`core.quotepath=off`) |
| `e9f029d` | Lote 4: autocorrección de §5.1 (no nombra otro repositorio) |
| `64df4f7` | Lote 5: nota de coherencia y `CHANGELOG.md` `[13.18]` |

## 2. Lo aplicado es lo que votó el jurado

| Archivo | Base → nueva | En `_legacy/13.17/` |
|---|---|---|
| `Expediente-Rules.md` | — → **1.0** | no existe |
| `Master-Prompt.md` | 8.19 → **8.20** | 8.19 |
| `Master-Prompt-Migracion.md` | 2.10 → **2.11** | 2.10 |
| `Master-Prompt-Reanudacion.md` | 1.13 → **1.14** | 1.13 |
| `Mesa-Rules.md` | 1.3 → **1.4** | 1.3 |
| `Migracion-Rules.md` | 3.20 → **3.21** | 3.20 |
| `Root-Rules.md` | 8.7 → **8.8** | 8.7 |
| `Catalogo-De-Criterios.md` | 1.18 → **1.19** | 1.18 |
| `SDD-Development-Guide.md` | 1.30 → **1.31** | 1.30 |
| `SDD-User-Guide.md` | 1.21 → **1.22** | 1.21 |
| `Knowledge-Mesa-De-Expertos-A-Pedido.md` | 1.0 → **1.1** | 1.0 |

Cabecera igual a la mayor fila, filas ordenadas y ninguna repetida en los once (`ev-07`). **`Deriva-Rules.md` no
se tocó** (J9-02). **`Index-Knowledge.md` no se tocó**: su fila no lleva la versión del documento.

## 3. Los criterios de la figura, probados fallando (criterio 1 y 4 del reporte)

Sobre un caso de dos folios con remoto (`ev-04`), con los comandos **extraídos de la regla con `awk`**, sin
copiarlos a mano (`ev-04b`):

- **Conforme**: salida vacía; `README 6 · 001 7+1 · 002 4+1 · archivos 3` → **diecinueve campos**.
- **Cada criterio falla en su caso**: A2 número distinto; A3 salto; A4 tipo por subcadena; A5 `Corrige` de cuatro
  dígitos y a sí mismo; A6 sin pase; **A7 README editado después del push, borrado en `evidencia/` después del push
  (criterio 4 del reporte), y vacío con una redacción S2 nombrada en su constancia**; A8 testimonio alterado y
  cerco con espacio; A9 `.txt` sin sus tres líneas y pieza ejecutable; A10 cita rota (la calificada no se marca);
  A11 ruta del host y nombre privado; A12 registro de `Audit/` sin foliar.

## 4. A1 a A12 re-medidos sobre los dos expedientes reales (`ev-06a`, `ev-06b`)

| Criterio | `0001` del framework | Expediente del destino |
|---|---|---|
| A1 | **0** | **0** |
| A2 | 2 | 2 |
| A3 | 5 | 7 |
| A4 | 47 | 65 |
| A5 | 19 | 13 |
| A6 | 0 | 1 |
| A7 | **0**, y 0 contra la rama de la intervención con las ocho redacciones nombradas en el folio 019 | 8 |
| A8 | 0 | 0 |
| A9 | 49 | 32 |
| A10 | **0** | **0** |
| A11 | **0** | **0** |
| A12 | 0 | 3 |

**Los dos son forma histórica** y la regla no les exige A2 a A12. **La primera medición de A7 sobre el `0001`
encontró dos rutas sin reconocer**: git escapaba las tildes. Se corrigió en la regla (lote 3) y la repetición dio
cero. Es la razón de medir sobre los reales y no sólo sobre el caso construido.

## 5. Verificación del conjunto

- **D1–D9**: nota de coherencia §5. D9 intacta; D7: cero nombres de plataforma o de stack en lo agregado a `SDD/`.
- **Barrido por concepto**: nota §4, nueve patrones con residuo cero fuera de las clases excluidas.
- **Snapshot**: `_legacy/13.17/` no contiene la versión nueva de ningún archivo tocado ni `Expedientes/` (`ev-07`).
- **Barridos del coordinador**, sin `_legacy`, sobre el framework:
  el de nombres de organizaciones y repositorios privados, direcciones de red privada y rutas del host → **0**;
  el de marcas y protocolos de la infraestructura de un destino privado → **0**;
  y en `Examples/`, el de direcciones, rutas de infraestructura y versiones del servicio anterior → **0**.
  Los patrones literales están en los pedidos del coordinador y no se transcriben acá, porque este archivo
  quedaría encontrándose a sí mismo en el barrido que declara.
  Sobre la carpeta `OUTPUTs/` de esta intervención, los dos barridos → **0**. Las carpetas de resultados de las
  intervenciones 04 a 08 y `PROMPTs/Features/` quedan fuera de alcance, por decisión del coordinador.

## 6. Qué no se verificó

- **El criterio 3 del reporte** (el orquestador que tropieza en M4) se verifica en el texto y no en una migración real.
- **La custodia durable de los originales** redactados: es de sesión (deuda D9-1).
- **La credencial de `Examples/`** sigue en 44 archivos de 22 snapshots de `_legacy/` (deuda D9-2); **no se verificó
  si fue rotada**.
- **A11 sobre un push real**: se midió sobre `origin/main..HEAD` sin empujar.
