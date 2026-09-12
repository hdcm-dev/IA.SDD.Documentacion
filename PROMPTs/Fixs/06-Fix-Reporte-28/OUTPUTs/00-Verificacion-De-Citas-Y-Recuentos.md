# 00 — Qué sigue literal y qué se reproduce: las citas y los recuentos del reporte `28`

**Fecha:** 2026-09-12
**Framework verificado:** `IA.SDD` en `9dc8ded` (SDD **13.11**), árbol limpio, y `476f927` (SDD **13.10**, la que el reporte evaluó)
**Evidencia cruda:** [`evidencia/ev-06.sh`](evidencia/ev-06.sh) y su salida [`evidencia/ev-06.out`](evidencia/ev-06.out). El guion corre contra los dos commits con `git archive`, **nunca contra el árbol de trabajo**, de modo que lo que muestra no depende de lo que esta intervención editó después. Cada fila nombra el bloque de esa salida.

---

## 0. Precondiciones

| Qué | Cómo se verificó | Resultado |
|---|---|---|
| La `04` está aplicada | `head -6 IA.SDD/CHANGELOG.md` → `## [13.11] - 2026-09-12`; `git log --oneline -3` → `9dc8ded Merge pull request #59 … intervencion/04-reporte-26`; `Reportes/README.md` y `PROMPTs/Fixs/README.md` declaran el `26` resuelto en 13.11 | **Sí.** Se avanza en el orden previsto |
| Árbol limpio en `IA.SDD` | `git status --short` → vacío | **Sí** |
| Alcance: sólo el `28` | `Reportes/README.md`, índice: `28` sin desenlace; `25` y `27` abiertos con intervención propia (`03` y `05`) | **Sólo el `28`** |
| Base de la corrida | El commit de `main` sobre el que se abrió la rama `intervencion/06-reporte-28` | **`9dc8ded`** |

---

## 1. Solicitud 1 — cita por cita, contra 13.11

| # | Cita del reporte | ¿Literal en 13.11? | ¿Se sostiene la lectura? | Bloque |
|---|---|---|---|---|
| 1 | `Vocabulario-Rules.md` cabecera: *«todo artefacto del framework y toda documentación que el framework genera»* | **Sí** — línea 3 | **Sí** | `S1.a` |
| 2 | `Vocabulario-Rules.md` §1 (la cita la trae el refutador): *«Fija qué designa cada término del framework»* | **Sí** — línea 11 | **Sí** | `S1.b` |
| 3 | `Vocabulario-Rules.md` **§8, «Alcance de esta regla, declarado»** | **El texto sí** — líneas 177 a 181. **El nombre de sección no**: §8 se titula «Pendientes declarados y su cierre» (línea 163), y «Alcance de esta regla, declarado» es el arranque en negrita de un párrafo adentro | **Sí, la contradicción existe.** Ver §1.1 | `S1.c` |
| 4 | §9.1 a §9.5: las cinco subsecciones, y la cita de §9.4 *«No se declara una invariante de desambiguación sin haber verificado…»* con *«El patrón queda primado»* | **Sí** — títulos en 211, 217, 229, 239 y 245; la cita en 241 | **Sí** | `S1.d` |
| 5 | §9.2: *«el contexto de lectura de un subagente es la sección, no el documento»* | **Sí** | **A medias, y el reporte no lo vio.** §9.2 funda esa frase en que el despacho de §8 *«nombra secciones, no archivos completos»*. El esqueleto del despacho nombra por sección el intake, `Vocabulario-Rules.md` y `Root-Rules.md`, **y por ruta** la regla de la categoría, los documentos upstream y los de conocimiento. La tabla de §2.6 del reporte hereda la premisa: *«Subagente de generación · Secciones nombradas»* | `S1.d`, `S4.a` |
| 6 | §9.6: R1, R2 y R3 de «migración» | **Sí** — líneas 262 a 264 | **Sí**: «migración» no es de los seis y la colisión R3/R1 es de framework contra framework | `S1.d` |
| 7 | §10: *«Toda invariante de desambiguación declarada cita la verificación de colisión que la justifica»*, y **13** criterios | **Sí** — línea 308; recuento acotado a §10 → **13** | **Sí** | `S1.e` |
| 8 | `Master-Prompt.md` §10.0: seis comprobaciones transversales, ninguna léxica | **Sí** — las seis numeradas | **Sí** | `S1.i` |
| 9 | `Master-Prompt.md` §15: cero ocurrencias de `procedencia`, y *«no tiene criterio de colisión: es una tabla de definiciones»* | **El recuento sí**: cero en 13.10 y en 13.11 (§2). **La sección se movió**: 1642–1709 en 13.10, **1740–1810** en 13.11, por los tres términos que sumó la `04` | **A medias.** §15 define «Colisión de sentidos» —*«Es la única condición que obliga a desambiguar»*— y «Contexto de lectura», y remite a §9.2. **No decide casos**, que es lo que el reporte necesita; pero no es cierto que no tenga nada del criterio | `S1.j`, `S2.c`, `S4.f` |
| 10 | `Migracion-Rules.md` cabecera: *«en este contexto de lectura no hay otro referente»* | **Sí** — línea **8** en 13.11 (el refutador la citó en la 7, contra 13.10) | **Sí** | `S1.k` |
| 11 | `Master-Prompt-Migracion.md` insumos: *«`Migracion-Rules.md`, íntegra»* | **Sí** — línea 68 | **Sí.** Y la línea 72 agrega algo que el reporte no usa y decide §5.4: *«El archivo de reglas de cada categoría cuyos documentos se migren»*, también por ruta | `S1.l` |
| 12 | `Root-Rules.md` §13: *«una regla que viaja en la lista de insumos obligatorios de todo despacho desplaza a una que no viaja»* y *«el conflicto se detiene»* | **No literal la primera**: omite sin marcar el paréntesis `(Master-Prompt.md §8)` y la cláusula final *«cuando las dos alcanzan al mismo ítem»* (líneas 750–751). **La segunda sí** — línea 757 | **Sí**: el criterio no decide un conflicto interno de un archivo | `S1.m` |
| 13 | `SDD-Development-Guide.md` §VI.3.1 punto 1: *«Enumerar el concepto, no los archivos. Buscar el término y sus formas en todo el árbol»* | **Sí** — línea 813 | **Sí** | `S1.n` |
| 14 | `Reportes/README.md` (§3.2 f del reporte): *«insumo de prompts de intervención […] ninguno modifica el framework»* | **Sí** — línea 9, con «Ninguno» en mayúscula | **Sí** | `grep -n 'insumo de prompts de intervención' Reportes/README.md` |

### 1.1 El argumento con que la mesa resolvió la contradicción, verificado

El reporte (§2.5 y §5.1) y el expediente `06` de la mesa dicen que §8 **quedó desactualizado por la práctica
posterior del propio archivo**. El control de cambios de `Vocabulario-Rules.md` (`S1.h`):

```
319:| 2.1 | 2026-07-29 | Adopción del término de la capaci…   ← §9.6 nueva
320:| 2.2 | 2026-08-15 | Nivel por artefacto y alcance decla…  ← el párrafo de alcance de §8
```

**§9.6 es anterior al párrafo que supuestamente la contradice por ser posterior.** La cronología del argumento es
falsa. **La conclusión no depende de ella**: la letra de §9 (`S1.f`, línea 209, *«en cualquier documentación que el
framework genere, si un término con más de un referente»*), R6 (`S1.g`, línea 109) y `Master-Prompt.md` §10
(«Polisemia gobernada», *«todo término»*) sostienen la lectura amplia sin necesidad de fechas.

---

## 2. Solicitud 2 — los tres recuentos, con los comandos del propio reporte

| Recuento del reporte | Comando | 13.10 | 13.11 | ¿Reproduce? | Bloque |
|---|---|---|---|---|---|
| §2.1: **19** reglas con el esquema, **18** con algún `[enumerable]`, `Vocabulario-Rules.md` con **0** sobre 13 | El bucle de §2.1, literal | 19 · 18 · `enum=0 interp=13` | 19 · 18 · `enum=0 interp=13` | **Sí.** Única diferencia entre versiones: `Mesa-Rules.md` pasa de 9 a 10 enumerables por la `04` | `S2.a` |
| §2.6: **23 + 22 = 45** ocurrencias de `procedencia` | `grep -o procedencia <archivo> \| wc -l` | 23 · 22 | 23 · 22 | **Sí, con el comando del reporte.** Al lado: `grep -c` da **16 · 19** y `grep -oi … \| wc -l` da **23 · 24** | `S2.b` |
| §2.5: cero ocurrencias de `procedencia` en §15 | la sección acotada por título, `grep -oi \| wc -l` | 0 | 0 | **Sí** | `S2.c` |

**El primer hallazgo de la intervención no es un recuento que no da: es qué midió el que no daba.** El «16 + 19 ≈
35» del refutador, que el cuadro de §2.4 registra como afirmación sin verificar (fila 6), **es exactamente
`grep -c`**: un recuento de **líneas**. No midió mal: midió otra cosa, y sin el comando al lado era indistinguible de
un error. Y el «22» depende de distinguir mayúsculas: sin distinguirlas son **24**. **Es la evidencia más directa de
que lo que vuelve releíble una afirmación es su comando**, y se usa en la decisión de §5.2.

---

## 3. Una medición heredada que no se hereda: el descarte de `procedencia` en la `04`

La 13.11 publicó, en su nota de coherencia (§2.4) y en su entrada del `CHANGELOG.md`, que `procedencia`
*«colisiona en secciones que esta intervención toca»* —`Master-Prompt.md` §7.0 y `Master-Prompt-Reanudacion.md` §3 y
§6—, **sin comando** (`S3.b`). Reproducida por sección contra la base de aquella intervención (`S3.a`, con
[`evidencia/localizar.sh`](evidencia/localizar.sh)):

| Archivo | Sección | Ocurrencias en 13.10 |
|---|---|---|
| `Master-Prompt.md` | §7.0 | **1** |
| `Master-Prompt-Reanudacion.md` | §3 R1 | **2** |
| `Master-Prompt-Reanudacion.md` | §6 | **1** |

**La afirmación es cierta**, y se leía exactamente igual que las seis del cuadro que no lo eran. Es el caso que
[`30`](30-Verificacion-Del-Plan-Aplicado.md) usa para el criterio 3.

---

## 4. Solicitud 3 — lo que el reporte declara que NO afirma, y cómo se respetó

| §6 del reporte | Cómo queda |
|---|---|
| El criterio de §9.1 no está mal | No se toca |
| **No crear un registro de términos acuñados** | No se crea. La comprobación 7 **calcula** sus términos contra la base de la corrida desde los glosarios y los registros de sustitución, que ya existen, y no guarda nada. Se evaluó si eso «se parece» a un registro: no persiste, no afirma colisión y no se consulta en lugar de medir |
| No reabre el `11` | No se reabre ([`10`](10-Decision-Del-Alcance-Y-De-Las-Cuatro-Preguntas.md) §1.3) |
| **No mecanizar los trece criterios** | Entra **uno** |
| **La compuerta no decide colisiones** | La comprobación 7 es la única de §10.0 que no emite hallazgo |
| Los agentes no son descuidados | La corrección es de método: medición adjunta, no más cuidado |
