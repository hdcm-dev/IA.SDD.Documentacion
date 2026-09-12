# Expediente 03 — Terminología y diseño léxico

> **Transcripción verbatim.** Entregado el 2026-09-12. No editado.
> Mandato: evaluar qué mecanismo de «asignar contexto» existe hoy, el remedio del caso por §9.3 con costos
> medidos, la idea del Product Owner de un registro de términos, y cómo se evita la sobrecorrección.

---

# Informe — Especialista de Terminología y Diseño Léxico

## 0. Método aplicado

Antes de opinar sobre el remedio corrí el mismo barrido que `Vocabulario-Rules.md` §9.4 exige y que el caso denuncia que no siempre se corre: grep de `procedencia` en cada archivo candidato, lectura de cada sección donde aparece, y verificación de si el campo nuevo que cada reporte propone vive en una sección donde el sentido viejo también aparece. Ancla de cada afirmación: **E1** (comando + salida) salvo que se indique otra.

---

## 1. ¿Existe hoy un mecanismo para «asignar un contexto» a un término?

**Sí, en tres piezas distintas, y ninguna es un registro consultable de términos acuñados:**

- **§9.3** (`Vocabulario-Rules.md`) da la escalera de costo creciente: entrada de glosario → forma calificada obligatoria → invariante de producto con prohibición de fusión (`Master-Prompt.md` §5). Es un **procedimiento de decisión**, no un artefacto que se consulte.
- **§9.6** es el precedente resuelto que el enunciado señala como el más parecido: «migración» tenía tres referentes (R1 la intervención 5.0, R2 migraciones de datos del producto, R3 la capacidad nueva). Se calificó **sólo** donde R3 y R1 conviven en la misma sección de lectura (`Vocabulario-Rules.md` §9.5); no se tocó nada frente a R2 por contextos disjuntos; se liberó R1 a «intervención» en sus dos ocurrencias de prosa; las filas de control de cambios no se tocaron. Es exactamente el patrón «asignar contexto por sección, no por documento» (§9.2).
- **§3**, los cuatro planos de identidad, **no aplica a este caso**: gobierna cómo se nombra un mismo producto en cuatro planos (negocio/documental/código-raíz/código-agrupador), no la desambiguación de un término polisémico cualquiera. Lo cito para descartarlo, no para usarlo.

**Lo que falta**, y es real: no hay un artefacto tipo tabla que diga «término X → ámbito verificado → colisiona/no colisiona». Lo que hay es **R5** (`§4`): «ningún artefacto introduce un sinónimo de los seis términos de §2 sin incorporarlo primero» —que es un registro obligatorio pero acotado a esos seis— y la práctica de dejar constancia en prosa dentro de §9 cuando un término se estudia (como hizo §9.6). Vuelvo sobre esto en el punto 3.

---

## 2. El remedio para el caso concreto, con costos medidos

### 2.1 Los números del enunciado están desactualizados — verificado, no supuesto

```
grep -o "procedencia" SDD/Devs/Orchestrator/Master-Prompt.md | wc -l            → 16  (enunciado decía 14)
grep -o "procedencia" SDD/Devs/Orchestrator/Master-Prompt-Reanudacion.md | wc -l → 18  (coincide)
grep -o "procedencia" SDD/Devs/Orchestrator/Master-Prompt-Migracion.md | wc -l   → 22  (enunciado decía 20)
grep -o "procedencia" SDD/Devs/Rules/Migracion-Rules.md | wc -l                  → 23  (enunciado decía 16)
```
**Ancla E1, severidad P2**: no cambia la conclusión pero sí el tamaño de cualquier estimación de costo que se apoye en esos números.

### 2.2 La colisión que se afirma en `Migracion-Rules.md` §4.7 no existe — verificado

```
sed -n '568,601p' SDD/Devs/Rules/Migracion-Rules.md | grep -c procedencia   → 0
```
§4.7 («La revisión de apartamientos», líneas 568-601) tiene **cero** ocurrencias de `procedencia`. La afirmación del enunciado —«ocho usos desnudos en la misma checklist»— **es la misma clase de error que se le imputa al agente que renombró sin verificar**: una colisión afirmada y no contrastada. **Ancla E1, severidad P1** (si se hubiese actuado sobre esta premisa se habría calificado una sección que no lo necesita, o peor, se habría usado como evidencia para justificar la forma más cara de §9.3).

La concentración real de `procedencia` desnuda en `Migracion-Rules.md`, por sección:

| Sección | Ocurrencias | Sentido |
|---|---|---|
| §0 | 1 | framework-versión |
| §2.3 Nomenclatura | 1 (+ token `sin-procedencia`) | framework-versión |
| §3 (línea 107) | 1 | framework-versión |
| §4.3.2 (línea 346) | 1 | **tercer sentido**: prosa genérica, «de qué carpeta de origen viene» — ver 2.4 |
| §4.5 | 2 | framework-versión |
| §4.6 | 3 | framework-versión |
| §5 Preguntas guía | 1 | framework-versión |
| **§6 Criterios de aceptación** (la checklist real) | **4** (líneas 694, 695×2, 703) | framework-versión |
| §7 Anti-patrones | 2 | framework-versión |
| §9 Control de cambios | 1 | framework-versión (histórico) |

El ítem de §6 línea 665 cita «(§4.7)» pero **no contiene la palabra** `procedencia`: es una referencia cruzada a otra sección, no una colisión.

### 2.3 Dónde vivirían los campos nuevos, y si colisionan ahí — no en abstracto

- **Reporte 26** (`origen del hecho`) vive en `Master-Prompt.md` §8/§8.1/§9. Confirmado sobre el árbol vivo (16 ocurrencias totales de `procedencia`, todas en §0/§2.1/§3/§5/§7): **cero en §8, §8.1 y §9**. El reporte 26 hizo el barrido correctamente, sección por sección, antes de afirmar «no colisiona» — es el uso correcto de §9.1/§9.2/§9.4, y dejó explícitamente la puerta abierta a llamar el campo `procedencia` si la intervención lo prefiere. **Nada que corregir acá.**

- **Reporte 27** (`ciclo de origen`) propone que el campo viva en `Root-Rules.md` §11 (Apartamiento declarado) y §12.1/§12.2 (Referencia pendiente / Ítem diferido). Verificado:
```
grep -n "procedencia" SDD/Devs/Rules/Root-Rules.md   → (sin salida, cero ocurrencias en todo el archivo)
```
**`Root-Rules.md` no tiene una sola ocurrencia de `procedencia`.** El reporte 27 afirmó la colisión citando `Intake-Rules.md` §1.1 y `Migracion-Rules.md` §4.5 —secciones **ajenas** a donde su propio campo viviría— sin verificar sus propias secciones destino. Por §9.2 el contexto de lectura relevante es la sección donde el término nuevo se usa, no «en algún lugar del árbol». **Esto es precisamente el defecto que el enunciado describe, y corresponde al reporte 27, no al 26.** Ancla E1, severidad P1 (la 1.1 del propio reporte 27 ya se corrigió una vez sin llegar a verificar la sección de destino; quedó a medio verificar).

  **Pero hay una colisión real y distinta, que el reporte 27 no vio**: su propio §5.3 propone que `Migracion-Rules.md` **derive** de ese campo una clasificación («hueco del ciclo» vs. «hueco de norma posterior»). Esa lógica de clasificación va a vivir, previsiblemente, junto a §4.3/§4.7 de `Migracion-Rules.md` — exactamente la sección más cargada de `procedencia` (sentido framework-versión) del corpus. **Ahí sí, cuando se escriba, va a convivir el sentido viejo con el nuevo en la misma sección de lectura.**

### 2.4 Hallazgo colateral: `procedencia` ya tiene un tercer sentido, no normativo

`Migracion-Rules.md` §4.3.2, línea 346: *«se preservan en `<categoria>/_fusion/<Proyecto-De-Origen>/`, **con su procedencia en la ruta**»* — uso de prosa corriente («de dónde viene»), no el término definido de §1.1 del `PRODUCT-MANIFEST`. Ancla **E2**. Aplico el **criterio negativo** de `Vocabulario-Rules.md` §10: los contextos son disjuntos (una es prosa incidental sobre una ruta de archivo, la otra es el bloque normativo de versión), así que **esto no es un hallazgo, es la constancia que evita que una auditoría posterior lo levante como uno** — el mismo tratamiento que §9.6 dio a R2 frente a R3. Severidad: **P3/no-acción**.

### 2.5 El remedio, por costo creciente de §9.3

1. **Reporte 26** (`origen del hecho`, vive en Master-Prompt.md §8/§8.1/§9): **nada que hacer**. Cero colisión verificada. Puede llamarse `procedencia` desnuda si se prefiere, o mantener `origen del hecho` como elección de estilo — las dos son válidas, ninguna la exige §9.4.

2. **Reporte 27** (vive en Root-Rules.md, con clasificación derivada en Migracion-Rules.md): **no hace falta una palabra distinta**. Alcanza con el patrón exacto de §9.6:
   - **Familia calificada**: `procedencia` (framework-versión, la de siempre) vs. **`procedencia del hueco`** o **`procedencia del ítem`** (el campo nuevo del reporte 27).
   - **Forma desnuda admitida**: en `Root-Rules.md` §11/§12.1/§12.2 (cero colisión ahí, confirmado) y en todo el resto de `Migracion-Rules.md` donde sólo aparece el sentido viejo — sin tocar ni una de las 23 ocurrencias existentes.
   - **Calificación obligatoria**: únicamente en la(s) sección(es) nuevas de `Migracion-Rules.md` que el reporte 27 todavía no escribió (la lógica de clasificación de su §5.3) y en el ítem de checklist que se le agregue a §6. **Costo: cero ocurrencias retroactivas a calificar** —la sección todavía no existe—, sólo la disciplina de escribirla ya calificada desde el primer borrador.

   Este remedio cuesta menos que renombrar a `ciclo de origen`: reutiliza la palabra natural que pidió el Product Owner, no inventa un tercer lexema, y no dispara §9.5 (no hay sustitución de nada ya escrito, porque no hay nada ya escrito que sustituir).

3. **Entrada de glosario sola** no alcanza para el punto de colisión real (la futura sección de clasificación en Migracion-Rules.md), por el mismo argumento que §9.6 ya usó para R3-vs-R1: `Vocabulario-Rules.md` está siempre en el alcance de despacho (`Root-Rules.md`, control de cambios 4.1, confirma que se inyecta «en todo despacho sin excepción de categoría»), pero si los dos sentidos aparecen **mezclados en la misma prosa**, el glosario no le dice al subagente cuál aplica a cada ocurrencia puntual — hace falta calificar la ocurrencia misma, no remitir a una tabla aparte.

4. **Invariante con prohibición de fusión** (`Master-Prompt.md` §5): claramente sobredimensionado. El término no atraviesa las doce categorías con un conflicto estructural; es un caso puntual entre dos secciones de dos archivos. Aplicarlo acá sería exactamente la sobrecorrección que el punto 4 pide evitar.

---

## 3. ¿Corresponde un registro de términos acuñados con su ámbito de validez?

**Evaluación honesta: no como artefacto nuevo. Sí como disciplina que ya está escrita y no siempre se ejecuta.**

**Qué resolvería**: evitaría que cada acuñación repita el barrido manual — alguien consulta una tabla en vez de correr grep + leer secciones.

**Qué costaría mantener, y su modo de falla — que el framework ya midió**: `Mesa-Rules.md` §6.1 nombra literalmente el patrón: *«el anti-patrón que el método nombra primero»* es `Master-Prompt-Reanudacion.md` §7, **«confiar en la fuente declarativa sin contrastarla»**, y la propia mesa lo cometió dos veces en su primera corrida real —elevó como P0 filas de plan ya resueltas, y dio por buena la declaración de un documento sobre una cifra que en realidad estaba completa en otro lado—. Un registro de términos acuñados **es exactamente una fuente declarativa más**: en cuanto una sección se edita sin actualizar la fila del registro, el registro dice «no colisiona» cuando ya colisiona, y **nadie vuelve a correr el grep porque el registro parece autoritativo**. Eso es peor que no tenerlo, porque además dispara justo lo que §9.4 llama primado: una vez que existe la tabla, se la consulta en vez de verificar, que es el reflejo que produjo el error del reporte 27.

Además, por §9.2, el contexto de lectura de un subagente es la sección — un registro que vive fuera del despacho (a diferencia de `Vocabulario-Rules.md`, que sí se inyecta siempre) no se consulta en el momento en que haría falta, salvo que se lo vuelva un insumo transversal más, lo cual es un costo permanente sobre **todo** despacho para un beneficio que ocurre sólo a quien acuña un término nuevo.

**Lo que sí corresponde, y ya existe sin crear nada**:
- **R5** (`§4`) ya obliga a incorporar todo sinónimo nuevo a §2 antes de usarlo — es un registro, acotado a los seis términos centrales, y el reporte 27 simplemente no lo siguió con la disciplina de §9.4 antes de proponer su renombre.
- El patrón de **§9.6**: cuando un término nuevo puede colisionar, se corre el barrido, se deja **constancia escrita** del resultado (colisiona/no colisiona, con la cita) dentro de §9, se resuelve por la escalera de §9.3, y esa constancia queda ahí «para que una ronda de auditoría posterior no lo levante como hallazgo» — literal de §9.6. Eso es «asignar un contexto» sin inventar un artefacto nuevo: el contexto queda escrito donde el término se decide, no en una tabla aparte que hay que sincronizar.

**Desenlace: no crear el registro.** Es válido por evidencia (§6.1 mide el modo de falla exacto) y no por reflejo conservador.

---

## 4. Cómo este plan no cae en la sobrecorrección que §9.4 advierte

- **No declaro ninguna invariante de desambiguación** (la forma más cara de §9.3): la colisión real es puntual —una sección todavía no escrita de `Migracion-Rules.md`— y no atraviesa las doce categorías.
- **No toco ni una de las 23 ocurrencias existentes de `procedencia`** en `Migracion-Rules.md`, ni las 16 de `Master-Prompt.md`: eso dispararía §9.5 (prohibición de sustitución) sin que haya colisión verificada que lo justifique en ninguna de ellas.
- **No propongo un registro transversal nuevo**, que sería exactamente el vehículo del primado que el punto 4 del mandato señala: un mecanismo general «por las dudas» que se aplicaría al término siguiente sin volver a verificar si hacía falta — el mismo reflejo que ya produjo el error del reporte 27.
- **Verifiqué cada colisión por sección antes de decidir la forma**, incluida la del propio enunciado (§4.7) y la de mi propia hipótesis inicial (Root-Rules.md): dos veces el resultado fue «no colisiona» donde se afirmaba que sí, y las corregí antes de proponer nada.
- **Dejo constancia escrita de los «no colisiona»** (Root-Rules.md completo, Master-Prompt.md §8/§8.1/§9, la prosa de §4.3.2) con el mismo objetivo que §9.6: que una auditoría futura no los reabra como hallazgo.

---

## Resumen ejecutivo

| Punto | Resultado |
|---|---|
| Mecanismo para «asignar contexto» | Existe como procedimiento (§9.3/§9.6), no como artefacto consultable. §3 no aplica a este caso |
| Reporte 26 (`origen del hecho`) | Correcto tal como está. Cero colisión verificada en Master-Prompt.md §8/§8.1/§9. Nada que cambiar |
| Reporte 27 (`ciclo de origen`) | Colisión no verificada en sus propias secciones destino (Root-Rules.md: cero ocurrencias de `procedencia`). Remedio: no renombrar — usar familia calificada `procedencia` / `procedencia del hueco`, calificando sólo la sección de clasificación que `Migracion-Rules.md` todavía no escribió |
| §4.7 con «ocho usos desnudos» | Falso, verificado: cero ocurrencias. La concentración real está en §6 (4) y §7 (2) |
| Registro de términos acuñados | No crear uno nuevo — es una fuente declarativa que se desactualiza (patrón ya medido en `Mesa-Rules.md` §6.1). Usar R5 + la constancia de §9.6 caso por caso |
| Sobrecorrección | Evitada: sin invariantes nuevas, sin sustituciones retroactivas, sin registro transversal nuevo, con barrido verificado antes de cada afirmación |
