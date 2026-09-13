# Plan de aplicación — intervención 09, reporte 31 (borrador para la mesa)

**Base:** `IA.SDD` `main` `a501857` (13.17). **Conjunto resultante:** 13.18. **Snapshot** `_legacy/13.17/`
ya tomado desde `main` sin editar (133 archivos = `git ls-tree`, sin `Expedientes/`).

**Decisión de fondo (§5.1 del reporte): SÍ.** El método adopta el caso como figura normada, con la forma
mínima del dictamen: dieciocho campos, ningún dato derivado a mano, estados derivados. La regla nueva es
`SDD/Devs/Rules/Expediente-Rules.md` 1.0 (borrador en `plan/Expediente-Rules.md`).

**Severidad:** minor, salvo que la mesa conteste E-3 con la opción A (D9 suma una oración) — en ese caso
major con bloque de impacto que declare que ningún destino tiene que migrar nada.

## Cambios por artefacto

| # | Artefacto | Versión | Qué cambia | Preserva | Destinos alcanzados |
|---|---|---|---|---|---|
| 1 | `SDD/Devs/Rules/Expediente-Rules.md` | **nuevo, 1.0** | La figura entera (Q1–Q10, Q12), S1–S3, A1–A10, anti-patrones | — | Todos, sólo hacia adelante |
| 2 | `Master-Prompt.md` | 8.19 → 8.20 | **§3.5**: `SDD/Expedientes/` hermana de `SDD/Docs/` (párrafo junto al de `SDD/Maquetas/`). **§8.1**: subsección nueva «La mesa antes de la detención, para las dos familias que preguntan» con el orden de cinco pasos (Q11), acotado a ambigüedad §9 y arbitraje §7.0; confirmación de plan y T4 excluidas por nombre. **§12.1 T1**: una oración sobre S3. **§15**: término «expediente» | §8.2 intacto | Todos (comportamiento del orquestador; nada emitido deja de cumplir) |
| 3 | `Master-Prompt-Migracion.md` | 2.10 → 2.11 | **l.46** (tabla §1): «No la redefine ni la reconvoca dos veces» pasa a: la convoca en M1, verifica su registro si llega, **y la reconvoca sólo cuando un tropiezo de M2 a M6 cumple `Mesa-Rules.md` §0.0, una vez por lote de fase** (modificación declarada). **§8 M4 «Correcciones manuales»**: antes de devolver la ambigüedad corre el orden de `Master-Prompt.md` §8.1 | Las fases, sus detenciones de confirmación | Los que migran |
| 4 | `Master-Prompt-Reanudacion.md` | 1.13 → 1.14 | **R0 paso 4**: suma «los expedientes de `SDD/Expedientes/` cuyo último folio no es `archivo`, con el pase del último folio y el `Suspende hasta:` contrastado». **§5**: el punto de continuación de un expediente abierto es el pase de su último folio | Las seis dimensiones | Los que reanudan |
| 5 | `Mesa-Rules.md` | 1.3 → 1.4 | **§0.0**: una oración: cuando el caso cumple `Expediente-Rules.md` §1, el registro de mesa sigue en `Audit/` y el expediente lo folia por enlace; en el framework, el expediente es el registro. **§2.1**: nota en la fila del registro. **§8 criterio 1**: «en el repositorio del framework, que no tiene `SDD/Docs/`, el registro es el expediente (`Expediente-Rules.md` §5)». **§7.1**: la respuesta del Product Owner a una escalada se asienta con la forma de testimonio de `Expediente-Rules.md` §3.3 (literal, canal, fecha-hora, huella) | Todo lo demás | Todos |
| 6 | `Migracion-Rules.md` | 3.20 → 3.21 | **§2.2**: fila `SDD/Expedientes/` fuera de alcance: registros, no se migran ni renumeran. **l.669**: sin tocar; la ocurrencia «el expediente de la intervención» se declara sentido histórico en la nota de coherencia | — | Los que migran |
| 7 | `Root-Rules.md` | 8.7 → 8.8 | **§9.2, tabla de excluidas**: dos filas: el número de expediente (`NNNNN-<Titulo>`, local al repositorio, se cita por ruta, sin prefijo) y el folio (`NNN`, posición). Sin tocar §9.1 ni D3 | §9.1, §10, §12 | Todos |
| 8 | `SDD-Development-Guide.md` | 1.x → +minor | **§VI.5**: la línea de exclusiones del snapshot suma `Expedientes/` con su motivo. **§VI.3 comprobación 2**: la autosuficiencia se mide sobre el conjunto normativo; `Expedientes/` nombra repositorios como texto. **§III.8**: cita `Expediente-Rules.md` como tercer ejemplo. **l.145** (retención): «salvo los expedientes, que son de conservación permanente» sujeto a D-7 | — | Framework |
| 9 | `README.md` | in situ | **Anatomía**: fila `Expedientes/`. **Autosuficiencia (l.152)**: reformulada y declarada: rige sobre el conjunto normativo; `Expedientes/` nombra otros repositorios como texto y queda fuera del snapshot. **Reglas de intervención**: fila «abrir un expediente del framework». **Modelo de tres repositorios**: una oración | Invariantes D1–D9 | Framework |
| 10 | `_legacy/README.md` | in situ | Tabla «Qué no se copia»: fila `Expedientes/` | Intocabilidad de las subcarpetas | Framework |
| 11 | `SDD-User-Guide.md` | 1.21 → 1.22 | **F-17**: «¿Dónde queda escrito un caso que atraviesa corridas, y qué hago con lo que el Product Owner dijo por chat?» | — | Usuario |
| 12 | `Catalogo-De-Criterios.md` | 1.18 → 1.19 | **§3**: tres situaciones (abrir o no un expediente; asentar una aprobación dada por conversación; tropezar a mitad de fase: mesa o detención). **§4**: fila `Expediente-Rules.md` con sus anti-patrones contados; total recalculado | — | — |
| 13 | `Conocimiento/Knowledge-Mesa-De-Expertos-A-Pedido.md` | 1.0 → 1.1 | **§2.3** reescrita contra la regla: la carpeta de una mesa a pedido es un expediente de `Expediente-Rules.md` (contrato de entrada = folio `providencia`; pedido literal = folio `presentacion` con testimonio; informes = folios `informe` verbatim; plan y cierre = folio `resolucion`; `evidencia/`). **§3.2**: «El testimonio de quien pidió es evidencia E4» pasa a «se asienta con la forma de testimonio; es fuente de intención, y pasa a E4 cuando queda como restricción del contrato». **§5.2**: el despacho no fija nombre ni número de archivo: «devolvés tu informe verbatim; el presidente lo asienta como folio `informe`». **§5.3**: árbol reemplazado por el de la regla. **§6**: el primer criterio remite a A1–A10. **§8**: la deuda declarada se cierra. Fila 1.1 (D-3) | §2.1, §2.2, §3.1, §3.3, §4 | Ninguno normativo (catálogo) |
| 14 | `Conocimiento/Index-Knowledge.md` | 1.3 → 1.4 | Fila de la 13.17 con la versión 1.1 si la fila lleva versión | — | — |
| 15 | `Deriva-Rules.md` | **sólo si E-3 = A**: 5.4 → 6.0 | §1, «Qué no es evidencia»: una oración que diga que un asiento literal con original o huella, canal y fecha-hora de una aprobación es `humano` y no una captura; lo excluido es la captura sin procedencia | Las cuatro condiciones, los cinco tipos | Todos → major con bloque de impacto |
| 16 | `SDD/Devs/Guides/Coherencia-Expediente-De-Caso.md` | nuevo, 1.0 | Nota de coherencia: alcance, inventario, barrido por concepto (`expediente`, `EXP-`, `E4`, `00-Contrato-De-Entrada`), comprobaciones §VI.3, devolución al origen (criterios 1–5 del reporte y A1–A10 sobre los dos ejemplares), colisiones con comando | — | — |
| 17 | `CHANGELOG.md` | `[13.18]` | Entrada con la decisión de fondo, cada Q, la severidad y «Impacto sobre destinos existentes» (los dos expedientes ya abiertos, forma histórica; nada se reescribe) | — | — |
| 18 | `Expedientes/0001-…/actuaciones/019-…` | folio nuevo | Resolución: cita la 13.18, declara el 0001 forma histórica (Q10), asienta el resultado de A1–A10 sobre él, el residuo de S2 (cuatro piezas con la ruta del scratchpad) y el aplastamiento de la fusión (S3 no observable). README del expediente: fila 019 en el índice (forma histórica: su README sí lleva índice) | Los 18 folios | — |

## Lo que no se toca, y por qué

- `Master-Prompt.md` §8.2 y `Root-Rules.md` §12: ciclo de origen (R-10).
- `Root-Rules.md` §9.1 y D3: no hay tercer ámbito (J-06 opción A).
- `Rules-Base-Conocimiento.md`: su compuerta alcanza `Conocimiento/`; `Expediente-Rules.md` §4 S2 la extiende desde la regla nueva citándola, sin editarla. **La mesa (Seguridad) decide si alcanza o hay que editar la fuente.**
- `Rules-Devops.md` l.452: es un ejemplo de documento de destino, no una regla; no se toca.
- Ningún repositorio de destino.

## Las dos decisiones abiertas para la mesa

1. **E-3**: ¿D9 suma la oración (A, major) o no (B, minor)? Restricción dura: `ev-07`: «las pruebas que aporse yo o las que obtuviesen los agentes quedarian como prte de las especificaciones». Propuesta del presidente, marcada como propia: **A**, porque la letra de `humano` ya admite la aprobación registrada con fecha, el caso real (fase `k`) la usó, y dejar una contradicción E1 dentro de la invariante es peor que un major cuyo impacto medido es cero.
2. **D-7, disposición**: conservación permanente con excepción declarada a la guía l.145. Propuesta: sí, una oración en §VI.4/l.145 o en la regla §5.1.
