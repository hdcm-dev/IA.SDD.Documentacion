# OUTPUT 10 — Verificación de citas (solicitud 1) y recuento de los 118 (solicitud 2)

**Intervención:** `05-Fix-Reporte-27`
**Fecha:** 2026-09-12
**Repos:** `IA.SDD` (main, limpio al empezar) y `Lab-Geometria` (solo lectura, ramas `main` y
`archivo/reanudacion-6-2026-09-12`)

---

## 1 · Verificación de citas del reporte `27` contra el árbol vigente

El reporte evaluó SDD **13.10**. Las intervenciones `04` (13.11) y `06` (13.12) no tocaron ninguna de
las secciones que el reporte cita — verificado leyendo el `CHANGELOG.md` de `IA.SDD` para las entradas
13.11 y 13.12, cuyas listas de "Cambiado" nombran `Master-Prompt.md`, `Vocabulario-Rules.md`,
`Mesa-Rules.md`, `SDD-Development-Guide.md`, `SDD-User-Guide.md` y `Catalogo-De-Criterios.md`, y en
ningún caso `Root-Rules.md`, `Migracion-Rules.md`, `Deriva-Rules.md` ni `Rules-Documentacion.md`.

| Cita del reporte | Sigue literal en 13.12 | Cómo se verificó |
|---|---|---|
| `Root-Rules.md` §9 (sistema de identificadores) | **Sí** | Lectura completa de §9.1 a §9.5 |
| `Root-Rules.md` §10 (datos derivados en la prosa) | **Sí** | Lectura completa, R1 a R5 |
| `Root-Rules.md` §11 (apartamiento declarado) | **Sí** | Lectura completa, seis campos, sin cambios |
| `Root-Rules.md` §12.1 (referencia pendiente) | **Sí** | Lectura completa, tres campos |
| `Root-Rules.md` §12.2 (ítem diferido) | **Sí** | Lectura completa, cuatro campos y tabla de escalamiento |
| `Migracion-Rules.md` §3 (principio de estado objetivo) | **Sí** | Lectura completa |
| `Migracion-Rules.md` §4 (reglas constructivas, incluidos §4.5, §4.6, §4.7) | **Sí** | Lectura completa |
| `Deriva-Rules.md`, tipo de evidencia `ejecucion` | **Sí** | `grep -n "ejecucion" SDD/Devs/Rules/Deriva-Rules.md` → línea 53, sin cambios |
| `Rules-Documentacion.md` §0.6 | **Sí, sin cambios — y sin uso.** | La cabecera del reporte la lista como alcance evaluado; el cuerpo del reporte **nunca la cita ni la usa como evidencia**. Se declara: es una cita de alcance, no una afirmación que verificar |

**Ninguna cita cayó.** El patrón central del reporte —los tres instrumentos apuntan hacia adelante y
ninguno hacia atrás— seguía vivo en 13.12, sin que hiciera falta reabrir ninguna sección.

---

## 2 · El caso medido: los 118 diferidos de `Lab-Geometria`

### 2.1 Las dos fuentes primarias, leídas con `git show`

```bash
cd Lab-Geometria
git show archivo/reanudacion-6-2026-09-12:SDD/Docs/Audit/Estado-Del-Destino-2026-09-12.md
git show archivo/reanudacion-6-2026-09-12:SDD/Docs/Audit/Estado-Del-Destino-2026-08-27.md
```

**Salida relevante, `2026-09-12` §4:**

```
| Estado    | Cantidad | Qué significa                                              |
| Cerrados  | 87       | Incluye «cerrado en parte», «por lectura», «con un NO»…    |
| Vigentes  | 25       | Su evento no ocurrió, o depende de E-01                    |
| NO APLICA | 6        | Con la figura de ADR-14004                                 |
| Total     | 118      |                                                             |
```

**Salida relevante, `2026-08-27` §4:**

```
| Estado    | Antes | Después de la salida A |
| Cerrados  | 85    | 86                      |
| Vencidos  | 13    | 9                       |
| Vigentes  | 7+2   | 12                      |
| Sin evento| 11    | 11                      |
| Total     | 116+2 | 118                     |
```

**La aritmética de la transición cierra exacta.** De las 20 filas que el 08-27 tenía como `vencido` (9)
o `sin evento` (11), el 09-12 redistribuye: 6 → `NO APLICA`, 13 → `Vigente`, 1 → `Cerrado`. 6+13+1=20.
86+1=87 ✓. 12+13=25 ✓. 0+6=6 ✓. **Los dos documentos declaran 118 y son consistentes entre sí.**

### 2.2 Recuento mecánico independiente, sobre las tablas del instrumento

Los ocho documentos que llevan el instrumento, según `Estado-Del-Destino-2026-08-27.md` §4: los dos
`Product-Backlog.md`, los dos `Pipeline-CI-CD.md`, las dos `Arquitectura-Unidad-Entrega.md` y las dos
`Supply-Chain-Seguridad.md` (Api y Web).

```bash
python3 - "${8 archivos}" << 'EOF'
# cuenta filas de toda tabla encabezada "| Id | Punto abierto | ..."
# ver script completo abajo
EOF
```

Script usado (contar sólo filas dentro de una tabla que empieza con el encabezado exacto del
instrumento, para no confundir con otras tablas del mismo documento que reusan prefijos de
identificador como `BT-`, `ADR-` o `PA-` fuera de este instrumento):

```python
import re
def count(path):
    n = 0; in_table = False
    for line in open(path, encoding="utf-8"):
        if line.startswith("| Id | Punto abierto |"):
            in_table = True; continue
        if in_table:
            if line.startswith("| --- "):
                continue
            if re.match(r"^\| [A-Za-z]{1,4}-\d+ \|", line) or re.match(r"^\| `[A-Za-z]{1,4}-\d+` \|", line):
                n += 1; continue
            in_table = False
    return n
```

**Resultado:**

| Documento | Filas |
|---|---|
| `GeometriaFactory-Api/06-Backlog-Tecnico/Product-Backlog.md` | 33 |
| `GeometriaFactory-Web/06-Backlog-Tecnico/Product-Backlog.md` | 16 |
| `GeometriaFactory-Api/09-Devops/Pipeline-CI-CD.md` | 16 |
| `GeometriaFactory-Web/09-Devops/Pipeline-CI-CD.md` | 8 |
| `GeometriaFactory-Api/05-Arquitectura-Tecnica/Arquitectura-Unidad-Entrega.md` | 12 |
| `GeometriaFactory-Web/05-Arquitectura-Tecnica/Arquitectura-Unidad-Entrega.md` | 31 |
| `GeometriaFactory-Api/09-Devops/Supply-Chain-Seguridad.md` | 1 |
| `GeometriaFactory-Web/09-Devops/Supply-Chain-Seguridad.md` | 1 |
| **Total** | **118** |

**Coincide exacto con las dos fuentes primarias.** La primera pasada del script (sin el patrón con
backticks) daba **116**: los dos `PD-10` de `Supply-Chain-Seguridad.md` se escriben `` `PD-10` `` y no
`PD-10`, y el patrón desnudo no los capturaba — es la misma omisión que
`Estado-Del-Destino-2026-08-23.md` había cometido, y que la reanudación del 08-27 corrigió a mano.

### 2.3 Respuesta a la solicitud 2: ¿es sobredimensionado el reporte?

**Sí, en un punto puntual, y se dice antes de usarlo como fundamento.** El reporte §2.4 describe los
118 como «tres recuentos… tomados en momentos distintos por instrumentos distintos» que «no se pueden
cruzar… sin abrir los 118 uno por uno». Verificado: los tres números (87/25/6) son tres **categorías**
de **una** tabla, en **un** documento, de **una** fecha — no tres recuentos independientes. Y ese mismo
documento cruza su propio recuento contra el de 16 días antes con aritmética exacta (§2.1), sin abrir
los 118 ítems.

**Lo que el reporte afirma y se sostiene**: ningún ítem de los 118 declara contra qué versión del
framework se difirió. El campo que §12.2 ya exige —evento de cierre— apunta hacia adelante. La
reconciliación de §2.1 fue posible porque un orquestador de reanudación la escribió a mano, leyendo
decisiones del Product Owner del 08-26 y del 08-30 y `ADR-14004`: es exactamente el costo de
reconstrucción manual que el reporte describe, no la prueba de que no exista ese costo.

**Conclusión operativa**: el hueco central del reporte sigue siendo válido y se usa como fundamento;
el detalle de «tomados en momentos distintos por instrumentos distintos, no cruzables» se corrige en la
sección «Cómo se resolvió» del reporte, sin reescribir su cuerpo original (`SDD-Development-Guide.md`
§VI.2: una afirmación ya publicada no se reescribe, se declara).
