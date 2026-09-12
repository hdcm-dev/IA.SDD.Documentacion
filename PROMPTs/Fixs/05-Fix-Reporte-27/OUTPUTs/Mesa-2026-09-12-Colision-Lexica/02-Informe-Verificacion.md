# Expediente 02 — Verificación y compuerta

> **Transcripción verbatim.** Entregado el 2026-09-12. No editado.
> Mandato: decidir si la verificación de colisión es mecanizable, dónde iría la compuerta, a qué costo, y
> proponer un criterio de aceptación con su marca.

---

## Informe del agente de Verificación

### 1. Estado medido: §10 de `Vocabulario-Rules.md`

```bash
sed -n '/^## §10 Criterios de aceptación/,/^## §11/p' Rules/Vocabulario-Rules.md | grep '^- \[ \]'
# → 13 líneas, las 13 marcadas [interpretativo]. Cero [enumerable].
```

Comparado contra el resto del framework (mismo patrón `- [ ] [marca]`, robusto a `` `[marca]` `` con backticks):

```bash
for f in Rules/*.md; do
  e=$(grep -Ec '^\s*- \[ \] `?\[enumerable\]`?' "$f")
  i=$(grep -Ec '^\s*- \[ \] `?\[interpretativo\]`?' "$f")
  echo "$f: enumerable=$e interpretativo=$i"
done
```

Resultado: de los 19 archivos de `Rules/*.md` que usan el esquema `[enumerable]`/`[interpretativo]`, **18 aportan al menos un enumerable** (rango 1 a 21 — `Migracion-Rules.md` con 21, `Root-Rules.md` con 7, `Rules-Documentacion.md` con 4, `Mesa-Rules.md` con 9). **`Vocabulario-Rules.md` es el único con 0 enumerables sobre 13 criterios.** `Catalogo-De-Criterios.md` e `Intake-Rules.md` dan 0/0 porque no usan el esquema: el primero se declara explícitamente «un índice, no una regla» (§1); el segundo tiene una sección distinta (`§5 Validaciones de completitud semántica`) sin estas marcas.

**Conclusión del punto 1: no es lo normal, es un caso atípico.** Ancla **E1** (recuento reproducible con el comando de arriba). Severidad **P2**: no bloquea nada por sí solo, pero es una asimetría real de cobertura frente a las otras 18 reglas, y como muestro en el punto 2, no es una limitación inherente del dominio — hay al menos un enumerable disponible que no se tomó.

### 2. La frontera enumerable/interpretativo en la verificación de colisión

La comprobación de §9.1+§9.2 se descompone en dos actos distintos:

- **Localizar ocurrencias de un término T por sección** — es enumerable. Es exactamente lo que hace un `grep` acotado: existe/no existe la cadena, en qué archivo y qué sección. Comprobé esto con el propio término del caso:

```bash
grep -rn "procedencia" SDD/Devs --include=*.md | wc -l   # → 82
grep -rln "procedencia" SDD/Devs --include=*.md          # → 12 archivos
```

  `procedencia` ya es un término vivo y bien establecido en el framework — designa la versión de origen de un destino en una migración (`Migracion-Rules.md` §2.3, §4.5; `Master-Prompt-Reanudacion.md`; y el propio `Mesa-Rules.md` §4, campo `diff_normativo`: «Qué cambió en el framework entre la procedencia y la vigente»). La localización de esas 82 ocurrencias es trivial y mecánica.

- **Decidir si esas ocurrencias tienen «otro referente»** — no es enumerable. Requiere leer qué designa cada ocurrencia y compararlo semánticamente contra el sentido del término candidato, exactamente el ejemplo que `Vocabulario-Rules.md` §9.1 usa para el caso contrario («imagen de registro» / «registro del contenedor»): contextos disjuntos que conviven sin colisión aunque la cadena coincida. Esto es lectura, no comparación de cadenas.

**La frontera exacta**: el `grep` por sección puede entrar a la compuerta mecánica de §10.0 **como localizador de candidatos**, nunca como veredicto de colisión. Poner en la compuerta «T aparece en la sección S ⇒ colisiona» sería precisamente la falsa confianza que la propia §10 (intro) y `Vocabulario-Rules.md` §9.1/§9.4 nombran como el error peor que no verificar — el 80 % de las 82 ocurrencias de «procedencia» conviven sin problema con cualquier sentido nuevo que no hable de versiones de origen, y reportar las 82 como aviso sería el mismo patrón que el caso de `_legacy/` que §10.0 ya excluyó por el mismo motivo.

Ancla **E2** (cita literal de §9.1/§9.2/§9.4) + **E1** (el grep reproducido arriba). Severidad: no aplica a un hallazgo, es el análisis que fundamenta el criterio del punto 5.

### 3. Dónde va la compuerta

El acto del caso —una afirmación de colisión sin verificar, hecha **mientras se escribía un informe de evaluación**— no cae bajo ninguna compuerta existente, por un hueco de cobertura, no por ausencia de regla:

- **`Master-Prompt.md` §10.0** corre «antes del audit de cada fase» de una **generación de destino**. Su lista de comprobaciones mínimas (enlaces, recuentos anclados, idempotencia, identificadores, anclaje de referencias, ítems diferidos) no incluye nada sobre verificación léxica de términos candidatos. No aplica al acto del caso ni aunque aplicara: el acto ocurrió en un informe de evaluación, no en una fase de generación.
- **`Mesa-Rules.md` §6.2 P0** reusa esa misma compuerta «aplicada al corpus en lugar de a una fase» — así que si el acto hubiera ocurrido dentro de un ciclo de mesa formal sobre un destino, heredaría el mismo hueco: nada en §10.0 cubre esto hoy.
- **`SDD-Development-Guide.md` §VI.3.1**, punto 1, ya exige literalmente lo que faltó: «Enumerar el concepto, no los archivos. Buscar el término y sus formas en todo el árbol». Pero esa exigencia rige para **intervenciones cerradas** sobre el framework (con nota de coherencia y las 13 comprobaciones de §VI.3), no para una afirmación suelta dentro de un informe de evaluación que todavía no es una intervención.
- La afirmación del caso es, además, textualmente una **afirmación sobre el estado del sistema** («colisionaría»/«no colisionaría»), y `Vocabulario-Rules.md` §9.4 lo dice explícito: «La verificación es por ocurrencia y es afirmación sobre el estado del sistema: cae bajo D9». D9 hoy se verifica en el **audit** (`Master-Prompt.md` §10, interpretativo: «toda afirmación… cita evidencia… sin evidencia es P1»), nunca en la compuerta mecánica de §10.0.

**Conclusión: el hueco es real y está entre tres mecanismos que casi lo cubren y ninguno lo cubre.** La compuerta debería correr en el punto donde hoy no hay ninguna: **al declarar cualquier invariante de desambiguación o sustitución léxica (§9.4/§9.5/§9.6)**, sea dentro de una intervención al framework (§VI.3) o dentro de un informe de panel/mesa que propone un término nuevo. La corre **quien redacta la afirmación**, como un paso obligatorio previo a escribirla (igual que `Root-Rules.md` §10 R2 obliga a anclar un recuento antes de escribirlo en prosa), y la revisa mecánicamente **quien despache el cierre** (AG-00970 en mesa, o el autor de la nota de coherencia en una intervención). Ancla **E4** (regla declarada: §9.4 + §VI.3.1 punto 1) + **E2** (los tres puntos de casi-cobertura citados). Severidad **P1**: es un hueco real de proceso, no bloqueante hoy porque nadie lo explota activamente, pero deja sin defensa mecánica exactamente el defecto que originó la mesa.

### 4. Costo de la comprobación

```bash
# candidato puntual — barato, específico, reproducible en segundos
grep -rn "procedencia" SDD/Devs --include=*.md | wc -l    # 82, en 12 archivos

# barrido no acotado — el modo de falla que §10.0 ya nombra con _legacy/
grep -rn "\bestado\b" SDD/Devs --include=*.md | wc -l     # 418
grep -rn "\bregistro\b" SDD/Devs --include=*.md | wc -l   # 195
```

La diferencia es de alcance, no de tecnología. Un barrido **acotado a un término explícitamente propuesto como candidato de vocabulario** (los casos de §9.4/§9.5/§9.6: acuñar, renombrar, declarar invariante) es un `grep` de un término contra ~91 archivos / ~27.000 líneas — instantáneo y con volumen de salida manejable (12 archivos, no miles). Un barrido **no acotado** —intentar detectar automáticamente «toda palabra potencialmente ambigua» en cualquier prosa nueva— produce cientos de coincidencias por palabra común («estado», «registro»), exactamente el volumen que desactiva el instrumento, el mismo argumento con el que §10.0 excluyó los snapshots de `_legacy/` como origen.

**Es viable si y solo si se acota a eventos de acuñado/renombre declarados explícitamente** (§9.4/§9.5), que son discretos y poco frecuentes por intervención o informe (típicamente 0 a 3), nunca como escáner continuo de prosa libre. Ancla **E1** (los dos comandos arriba, con sus recuentos contrastados). Severidad: informativa para el criterio del punto 5, no un hallazgo en sí.

### 5. Criterio de aceptación propuesto

```
- [ ] [enumerable] Toda afirmación de colisión o no-colisión de un término candidato contra el
      vocabulario vigente (Vocabulario-Rules.md §9.4) cita, en el mismo punto donde se afirma, el
      comando o el listado de secciones inspeccionadas y su resultado. La ausencia de esa cita es
      hallazgo, independientemente de si la conclusión sobre la colisión resulta después correcta.
```

**Fundamento y por qué se marca así, no distinto.** Se marca `[enumerable]` porque lo que verifica es presencia de evidencia adjunta (un patrón sintáctico: comando + salida, o lista de secciones citadas) — comparable en naturaleza a `Root-Rules.md` §10 R2 (recuento anclado) y a `Deriva-Rules.md` §1 (formato de evidencia D9). **No** se marca enumerable el juicio de si la colisión es real: eso sigue siendo del auditor o del jurado de mesa, interpretativo por naturaleza según el punto 2. Marcarlo de otro modo —enumerable la conclusión, no solo la presencia de evidencia— sería exactamente la falsa confianza que la propia `Vocabulario-Rules.md` §10 (intro) declara peor que no verificar, y que este mandato pidió evitar explícitamente.

Este criterio, de aprobarse, sería el primer `[enumerable]` de `Vocabulario-Rules.md` §10, y cerraría parte de la asimetría medida en el punto 1 sin fingir que el resto de los doce criterios interpretativos de esa sección son mecanizables — no lo son, por el mismo argumento del punto 2 aplicado en general a «¿el término se lee mal solo en algunas secciones?», que exige lectura semántica en todos los casos.
