# Reporte 23 — La mesa evita el consenso prematuro y no tiene con qué reconciliar criterios

| Campo | Valor |
|---|---|
| Reporte | 23 |
| Fecha | 2026-08-31 |
| Origen | **Una observación del Product Owner de `Lab-Geometria`**, hecha al arrancar la unidad 2 del plan de la mesa del 2026-08-31: *«es importante la agresividad de los investigadores y los jueces, pero también deben ser adultos a la hora de establecer relaciones»*. Se verificó contra la regla y **procede**; después se aplicó, y el resultado cambió el hallazgo que la unidad venía a cerrar |
| Versión del framework evaluada | SDD **13.8** (`Mesa-Rules.md` 1.0 §3 `P1`, §5.1, §5.3, §6.4, §7.0) |
| Artefactos del framework alcanzados | `SDD/Devs/Rules/Mesa-Rules.md` §5.1 —el núcleo permanente— y §6.4 —el jurado— |
| Naturaleza | Un hueco **de rol, no de principio**. El principio contra el consenso prematuro es correcto y no se discute. Lo que falta es qué pasa cuando **dos roles producen criterios incompatibles para la misma decisión**, que no es lo mismo que coincidir temprano |
| Estado | **Abierto** |
| Reportes relacionados | **`18`**, el primero contra la mesa. Éste es el segundo, y sale de la **segunda** corrida del mecanismo en el mismo destino |

---

## 1. Resumen

**`Mesa-Rules.md` está construida para impedir el acuerdo fácil, y lo logra. No tiene ninguna pieza para el desacuerdo legítimo entre dos criterios que no se pueden aplicar a la vez.**

Lo que la regla tiene, verificado:

| Pieza | Qué hace | Dónde |
| --- | --- | --- |
| «**La refutación es el producto, no el consenso**» | Impide que el panel coincida temprano | §3, principio `P1` |
| El panel **a ciegas y en paralelo** | Impide la confirmación correlacionada | §5.3 |
| El **refutador** revisando los `NO_PROCEDE` | «Salvaguarda contra el consenso vacío» | §6.4 |
| **Arbitraje** | Sólo cuando **dos restricciones duras** del contrato de entrada chocan, y **escala al humano** | §7.0, disparadores 2 y 3 |

**Las cuatro apuntan en la misma dirección: que nadie ceda.** Ninguna contesta qué pasa cuando dos roles, los dos con ancla y los dos dentro de su mandato, **proponen criterios que no se pueden sostener juntos** — y el desacuerdo no es entre dos restricciones del contrato, así que §7.0 no lo alcanza.

**Lo que ocurre entonces está medido:** el investigador produce una lista y el juez la descarta entera.

## 2. El caso, medido

### 2.1 Los dos criterios

La unidad 2 del plan de la mesa del 2026-08-31 barría una clase de defecto —ramas defensivas de las que ninguna operación puede tirar—.

| Rol | Su criterio | Su resultado |
| --- | --- | --- |
| **Investigador** | Barrer la clase completa: encontrar cada condición que el dominio emite y la capa de superficie no traduce | **Quince** |
| **Juez** | Sólo procede lo que responde **mal** si se alcanza; lo demás es trabajo sin valor y riesgo de romper | Las **dos** que el hallazgo ya conocía |

**Los dos criterios son correctos y ninguno es completo.** El del investigador no dice qué hacer con lo que encuentra. El del juez descarta trece sin mirarlas, y su pregunta implícita —«¿es alcanzable?»— **tiene una propiedad que lo descalifica**: se contesta hoy leyendo los invocadores y **deja de valer mañana**, cuando alguien agregue uno.

### 2.2 Lo que produjo la conciliación

**El criterio que resolvió el desacuerdo no era el de ninguno de los dos.** La pregunta que lo desbloqueó fue *«¿alcanzable es la pregunta correcta?»*, y la respuesta es que no: **un criterio cuya respuesta caduca no puede fundar una decisión permanente.**

El criterio negociado: **si se alcanzara, ¿de quién sería el defecto?**

| De quién | Qué corresponde | Cuántas |
| --- | --- | --- |
| **Del producto** — el llamador pasó algo que no correspondía | El código genérico con `500` **es correcto**. No se toca | **12** |
| **Del pedido** — la persona pidió algo que su papel o el estado no admite | `500` le diría que el producto falló. **Procede** | **3** |

**Y contradijo al juez en un caso**, que es el dato que más dice: el hallazgo original pedía la misma corrección para dos códigos, y con el criterio negociado **sólo uno la merece**. El otro habla de lo que el llamador pasó, no de quién pide, y su `500` es correcto.

**Ninguno de los dos roles habría llegado ahí.** El investigador no clasifica; el juez habría cerrado con dos.

### 2.3 Lo que cuesta no tenerlo

Sin conciliación, el desenlace probable era uno de estos dos, y los dos son malos:

- **Gana el juez**: se parchean dos, quedan trece sin mirar, y la clase sigue sin medición — que es el hallazgo que la unidad venía a cerrar.
- **Gana el investigador**: se parchean quince, doce de ellas cambiando un `500` correcto por una respuesta que miente sobre de quién fue el defecto.

## 3. Por qué el principio `P1` no cubre esto, y no debería cambiarse

**«La refutación es el producto, no el consenso» es correcto y este reporte no lo discute.** Lo que impide es que el panel **coincida temprano** sobre un hallazgo, que es cómo nace la confirmación correlacionada.

**Conciliar dos criterios incompatibles es otra cosa.** No es coincidir sobre un hallazgo: es decidir **con qué regla se van a evaluar todos**. Y esa decisión, si no se toma antes, se toma implícitamente al final — cuando el juez descarta la lista del investigador, y nadie escribe por qué.

**La distinción tiene una consecuencia práctica:** la conciliación va **antes** del trabajo, no después. Un negociador que entra al final reparte culpas; uno que entra al principio fija el criterio con el que los dos van a producir.

## 4. Qué se propone evaluar

**No se propone una redacción.** Se enumeran tres cosas:

**4.1 Un rol de conciliación en el núcleo de §5.1.** Su mandato no es acercar posiciones: es **detectar que dos criterios no se pueden aplicar juntos y producir el que los reemplaza**. En el caso medido, su aporte fue una pregunta sobre la pregunta del juez, no una posición intermedia.

**4.2 Que entre antes y no después.** El refutador entra **último** por su mandato; el conciliador tiene el mandato inverso y debería entrar **cuando dos criterios se declaran**, antes de que se produzca sobre ellos.

**4.3 Que su producto quede escrito.** El criterio negociado —y **por qué se descartó el de cada rol**— es lo que hace revisable la decisión. En el caso medido, «alcanzable no sirve porque caduca» es la línea que explica todo el resto, y sin ella el resultado parece arbitrario.

## 5. Lo que este reporte no afirma

**No afirma que la mesa deba buscar consenso.** Propone lo contrario de lo que `P1` prohíbe: que el desacuerdo se **resuelva con una regla escrita** en lugar de resolverse solo, en silencio, a favor de quien decide último.

**No afirma que §7.0 esté mal.** El arbitraje escala al humano cuando dos **restricciones duras** chocan. El caso medido no es eso: los dos criterios son de rol, no del contrato de entrada, y **tienen respuesta en el árbol** — por eso no correspondía escalar.

**No sale de una revisión de escritorio.** La observación es del Product Owner del destino, y la evidencia es una corrida real en la que el criterio conciliado **cambió el resultado y contradijo a un rol**.

---

## Control de cambios

| Versión | Fecha | Descripción |
|---|---|---|
| 1.0 | 2026-08-31 | Emisión, a partir de una observación del Product Owner de `Lab-Geometria` verificada contra la regla. La mesa tiene cuatro piezas contra el consenso prematuro y **ninguna para el desacuerdo entre criterios**; §7.0 arbitra sólo restricciones duras y escala al humano. La corrida que lo midió: investigador **quince**, juez **dos**, y un criterio conciliado que **ninguno propuso** —«si se alcanzara, ¿de quién sería el defecto?»— que dejó **tres** procedentes y **doce** correctas, y **contradijo al juez en un caso**. Propone un rol de conciliación que entre **antes** y cuyo producto quede escrito. |
