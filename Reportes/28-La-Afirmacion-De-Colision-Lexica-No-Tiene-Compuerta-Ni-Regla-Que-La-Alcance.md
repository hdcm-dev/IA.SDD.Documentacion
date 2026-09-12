# Reporte 28 — La afirmación de colisión léxica no tiene compuerta, ni regla que la alcance

| Campo | Valor |
|---|---|
| Reporte | 28 |
| Fecha | 2026-09-12 |
| Origen | Una mesa de evaluación convocada por el Product Owner de `Lab-Geometria` el 2026-09-12, sobre un hecho ocurrido **mientras se escribían los reportes `26` y `27`**: el orquestador afirmó que un término nuevo *«no puede llamarse `procedencia` porque colisionaría»* y renombró, sin haber verificado la colisión. Expedientes completos, verbatim, en `PROMPTs/Fixs/05-Fix-Reporte-27/OUTPUTs/Mesa-2026-09-12-Colision-Lexica/` |
| Versión del framework evaluada | SDD **13.10** (`Vocabulario-Rules.md` cabecera, §1, §8, §9 y §10 · `Master-Prompt.md` §10.0 y §15 · `Migracion-Rules.md` cabecera · `Master-Prompt-Migracion.md` insumos · `Root-Rules.md` §13 · `SDD-Development-Guide.md` §VI.3.1) |
| Artefactos del framework alcanzados | `SDD/Devs/Rules/Vocabulario-Rules.md` **§8 y §10** —donde nace— y §9.4 · `SDD/Devs/Rules/Mesa-Rules.md` · `SDD/Devs/Orchestrator/Master-Prompt.md` §10.0 |
| Naturaleza | **Tres huecos encadenados, y el tercero es de la regla contra sí misma.** (a) `Vocabulario-Rules.md` es **la única de las diecinueve reglas del framework que no aporta ni una comprobación mecánica**. (b) La exigencia de verificar antes de afirmar una colisión **existe escrita dos veces** —§9.4 y la guía de desarrollo §VI.3.1— y **ninguna de las dos alcanza** al acto en que el defecto ocurrió. (c) La regla **se contradice sobre su propio alcance**: su cabecera la declara universal, su §8 la acota a seis términos, y su §9.6 la aplica a un término que no es ninguno de los seis |
| Estado | **RESUELTO en SDD 13.12** — ver §8, «Cómo se resolvió» |
| Reportes relacionados | **`26`** y **`27`**, con los que comparte la corrida de origen y **no el artefacto**: por el criterio de la serie con el AND, va separado. **`24`**, precedente **de forma**: el primero en incluir entre su evidencia un error del orquestador cometido mientras escribía otros reportes. No comparte ni corrida ni artefacto. **`11`**, resuelto, que fijó el reparto del vocabulario en §8: este reporte **encuentra que ese reparto quedó desactualizado por la práctica posterior del propio archivo**, y lo documenta sin reabrir la decisión de fondo |

---

## 1. Resumen

**El framework ya sabe cómo decidir si un término colisiona**, y lo sabe bien. `Vocabulario-Rules.md` §9
tiene un criterio fundado —se desambigua sólo si los sentidos comparten contexto de lectura—, una unidad
de contexto declarada —la sección, para un subagente—, una escalera de remedios por costo creciente, y un
precedente resuelto con cuidado en §9.6. Y §9.4 nombra con precisión el modo de falla: *«el patrón queda
primado […] se aplica al siguiente término sin volver a verificar la premisa»*.

**Lo que no tiene es nada que haga cumplir eso en el momento en que se incumple.** Un agente afirmó una
colisión sin medirla, renombró dos campos en dos reportes, y **nada del método lo detectó**: lo detectó el
propio agente al releerse, después de que el Product Owner preguntara qué problema exacto había.

**La mesa que se convocó para investigarlo lo reprodujo.** Su despacho llevaba cuatro datos y tres
estaban mal; las comisiones los corrigieron. El refutador encontró dos citas de sección equivocadas más,
adentro de los reportes `26` y `27`. Y al verificar la refutación, el número del propio refutador
también estaba mal. **Seis afirmaciones sin verificar en un mismo trabajo**, cinco del orquestador y una
de un subagente, **todas detectadas por relectura ajena y ninguna por un mecanismo del método**.

---

## 2. La evidencia

### 2.1 La única regla sin comprobaciones mecánicas

`Master-Prompt.md` §10.0 separa las propiedades en **enumerables** —las decide un guion— e
**interpretativas** —las decide un lector—, y alimenta su compuerta mecánica con los anti-patrones
marcados `[enumerable]` de cada regla. Medido sobre las diecinueve reglas que usan el esquema:

```bash
for f in SDD/Devs/Rules/*.md; do
  e=$(grep -Ec '^\s*- \[ \] `?\[enumerable\]`?' "$f")
  i=$(grep -Ec '^\s*- \[ \] `?\[interpretativo\]`?' "$f")
  [ $((e+i)) -gt 0 ] && printf "%-34s enum=%-3s interp=%s\n" "$(basename $f)" "$e" "$i"
done
```

| Resultado | |
|---|---|
| Reglas con el esquema | **19** |
| Reglas con al menos un `[enumerable]` | **18**, entre 1 y 21 |
| `Vocabulario-Rules.md` | **0 enumerables sobre 13 criterios** |

**No es que lo léxico sea inmecanizable.** La comisión de verificación encontró la frontera con precisión:
**localizar** las ocurrencias de un término por sección es mecánico e instantáneo; **decidir si tienen
otro referente** es lectura. La primera mitad entra en una compuerta y no se tomó.

Y las seis comprobaciones transversales de §10.0 —enlaces y anclas, recuentos anclados, idempotencia,
identificadores, anclaje de referencias, ítems diferidos— **no incluyen ninguna léxica**.

### 2.2 La exigencia existe dos veces, y ninguna alcanza al acto

| Dónde | Qué exige | Por qué no alcanzó |
|---|---|---|
| `Vocabulario-Rules.md` §9.4 | *«No se declara una invariante de desambiguación sin haber verificado que los contextos colisionan»* | Habla de **invariante declarada**, la forma más cara de §9.3. El acto del caso fue un **renombre dentro de un documento**, más barato y fuera de su letra |
| `SDD-Development-Guide.md` §VI.3.1, punto 1 | *«Enumerar el concepto, no los archivos. Buscar el término y sus formas en todo el árbol»* | Rige para **intervenciones sobre el framework**, con nota de coherencia. El acto ocurrió **escribiendo un reporte**, que todavía no es una intervención |

**Y el criterio de aceptación más cercano** —§10: *«toda invariante de desambiguación declarada cita la
verificación de colisión que la justifica»*— hereda el mismo recorte, y es `[interpretativo]`.

**Es la forma que esta serie ya encontró tres veces seguidas**: el `25` —el instrumento para cambiar el
alcance existe y no tiene disparador—, el `26` —el snapshot que resolvería la procedencia se toma y no se
lee para eso—, y éste: **la exigencia está escrita y le falta el momento**.

### 2.3 El caso: un barrido hecho en un reporte y heredado en el siguiente

La comisión de requisitos reconstruyó la secuencia desde los dos controles de cambios:

1. En la verificación previa a la intervención `04`, el orquestador encontró que `procedencia` ya estaba
   en uso con el sentido *versión del framework bajo la que el destino se estructuró*.
2. **Afirmó la colisión sin medirla** y renombró en los dos reportes.
3. Preguntado por el Product Owner, **midió en el reporte `26`**: las ocurrencias de `Master-Prompt.md`
   están en §0, §2.1, §3, §5 y §7, **ninguna en §8, §8.1 ni §9**, donde el campo viviría. No colisionaba.
   Corrigió.
4. **En el reporte `27` no repitió el barrido.** Mantuvo el renombre citando colisiones en
   `Intake-Rules.md` y `Migracion-Rules.md` —**secciones ajenas a donde su propio campo viviría**—.
   Medido después: `Root-Rules.md`, que es donde vive, tiene **cero** ocurrencias.

**El paso 4 es literal §9.4**: la premisa verificada para un término se aplicó al siguiente sin volver a
verificarla. **La regla describió el defecto con exactitud y no tuvo con qué detenerlo.**

### 2.4 Seis afirmaciones sin verificar en un mismo trabajo

**Este cuadro es la evidencia central**, y queda completo porque omitir cualquiera de sus filas lo haría más
prolijo y menos cierto.

| # | Afirmación | Dónde | Medido | Quién la detectó |
|---|---|---|---|---|
| 1 | `procedencia` «colisionaría», en el `26` | Reporte `26` v1.1 | No colisiona en §8/§8.1/§9 | El orquestador, al releerse, preguntado por el PO |
| 2 | «`Vocabulario-Rules.md` §10 tiene **once** criterios» | Despacho de la mesa | Son **13** | Lector sin contexto y Requisitos, por separado |
| 3 | «`Migracion-Rules.md` **§4.7**, **ocho** usos desnudos» | Despacho de la mesa | §4.7 tiene **cero**; la checklist es §6 | Requisitos y Terminología, por separado |
| 4 | `Migracion-Rules.md` **§4.7** | Reporte `26` §2.1 | §4.5, §4.6 y §6 | Refutador |
| 5 | `Intake-Rules.md` **§1.1** | Reporte `27` §2.1 | La sección no existe; es §2.1, línea 39 | Refutador |
| 6 | «16 + 19 ≈ **35** ocurrencias» | Informe del refutador | **23 + 22 = 45** | El orquestador, al verificar la refutación |

**Cinco del orquestador y una de un subagente. Ninguna detectada por la compuerta, el audit ni un
criterio de aceptación.** Todas por relectura de otro, y dos de ellas por dos lectores independientes que
no se vieron.

**Lo que el cuadro no dice, y conviene no hacerle decir**: no mide que los agentes sean descuidados. Mide
que **una afirmación sobre el estado del árbol que no adjunta su medición no es distinguible, al leerla, de
una que sí la hizo**. Las seis se leían igual de firmes que las que eran ciertas.

### 2.5 La regla se contradice sobre su propio alcance

Los tres textos, verificados contra el archivo:

| Dónde | Qué dice |
|---|---|
| **Cabecera**, `Archivo target` | *«todo artefacto del framework y toda documentación que el framework genera»* |
| **§8**, «Alcance de esta regla, declarado» | *«Esta regla gobierna los términos del framework que colisionan con el vocabulario del dominio de un cliente: los seis de §2, con su precedencia de §6 y su criterio de desambiguación de §9. **No gobierna el resto del vocabulario propio del framework** —`sonda`, `pasada de diseño`, `pasada de ejecución`, `arnés` y equivalentes—, que vive en el glosario operativo de `Master-Prompt.md` §15»* |
| **§9.6**, «Familia calificada declarada: migración normativa» | Aplica el criterio de §9 a **«migración»**, con tres referentes: R1 una intervención del propio framework, R2 migraciones de datos del producto, R3 una capacidad del propio framework |

**«Migración» no es ninguno de los seis de §2**, y la colisión que §9.6 resuelve —R1 contra R3— **es
framework contra framework**, no framework contra vocabulario de cliente. **Si §8 dijera la verdad, §9.6
no podría estar donde está.**

**Y la remisión de §8 no tiene destino útil.** Medido: `procedencia` **no figura** en el glosario
operativo de `Master-Prompt.md` §15 —cero ocurrencias en la sección—, y §15 **no tiene criterio de
colisión**: es una tabla de definiciones. **Un término propio del método que colisiona con otro término
propio del método no está gobernado hoy por ninguna de las dos piezas.**

**Por qué `Root-Rules.md` §13 no lo resuelve.** Su criterio es *«una regla que viaja en la lista de
insumos obligatorios de todo despacho desplaza a una que no viaja»*. Acá no hay dos reglas: la cabecera y
§8 son del mismo archivo y viajan siempre juntas. §13 declara que en ese caso *«el conflicto se detiene»*,
y la mesa estuvo a punto de escalarlo al Product Owner con la escalada ya redactada. **La disolvió el
refutador trayendo §9.6**, un texto que ninguna de las cuatro comisiones había mirado. La contradicción no
es una ambigüedad de intención: **es una sección desactualizada por la práctica posterior del mismo
archivo**.

### 2.6 La unidad de contexto no es la misma en todos los lectores

§9.2 declara: *«el contexto de lectura de un subagente es la sección, no el documento»*. Es correcto para
el subagente de generación, que recibe secciones nombradas en su despacho.

**Pero no todos los lectores del framework leen por sección, y el propio framework lo declara.**

| Lector | Qué recibe | Fuente |
|---|---|---|
| Subagente de generación | Secciones nombradas | `Master-Prompt.md` §8, lista de insumos |
| Orquestador de migración | *«`Migracion-Rules.md`, **íntegra**»* | `Master-Prompt-Migracion.md`, insumos |
| — y el archivo lo asume | *«Dentro de este archivo «migración» se usa en forma desnuda […]: **en este contexto de lectura** no hay otro referente»* | `Migracion-Rules.md`, cabecera |

**La consecuencia se midió en la mesa, como P0.** La comisión de terminología propuso resolver el caso con
una familia calificada copiada de §9.6 y declaró **costo retroactivo cero**, calificando sólo una sección
nueva de `Migracion-Rules.md`. El refutador mostró que ese archivo **se declara a sí mismo como un único
contexto de lectura**, así que un segundo referente en cualquier punto obliga a calificar el archivo
entero y el orquestador que lo lee íntegro:

```
grep -o procedencia SDD/Devs/Rules/Migracion-Rules.md | wc -l               → 23
grep -o procedencia SDD/Devs/Orchestrator/Master-Prompt-Migracion.md | wc -l → 22
```

**Cuarenta y cinco ocurrencias, no cero.** §9.2 declara la unidad para un lector y **no la declara para
los demás**, y un remedio correcto en dirección se costeó con la unidad equivocada.

---

## 3. Qué dice hoy el framework, y por qué no alcanza

### 3.1 Lo que resuelve bien, y no hay que tocar

- **El criterio de §9.1 es correcto.** Desambiguar sólo cuando los sentidos comparten contexto evita la
  sobrecalificación, que §9.1 mismo nombra como defecto.
- **La escalera de §9.3 es correcta**, y en el caso real eligió bien la dirección: familia calificada, no
  renombre ni invariante.
- **§9.4 nombra el modo de falla con exactitud.** El caso lo reprodujo paso por paso.
- **§9.6 es un buen precedente**, y es precisamente el texto que resolvió la contradicción de alcance.
- **La frontera enumerable/interpretativo de §10.0 es la correcta**, y la clasificación conservadora de
  `Vocabulario-Rules.md` §10 —ante la duda, interpretativo— tiene fundamento: una comprobación que produce
  falsa confianza es peor que ninguna.
- **No hace falta un registro de términos acuñados.** La mesa lo evaluó a pedido explícito del Product
  Owner y lo **rechazó con evidencia**: un registro es una fuente declarativa más, y cuando una sección se
  edita sin actualizar su fila afirma «no colisiona» cuando ya colisiona, y nadie reverifica porque parece
  autoritativo. `Mesa-Rules.md` §6.1 mide ese patrón con la propia mesa cometiéndolo dos veces.

### 3.2 Lo que no está

**a) No hay una comprobación mecánica léxica.** La mitad localizable del barrido no entró nunca a la
compuerta, y `Vocabulario-Rules.md` es la única regla sin enumerables.

**b) La exigencia de verificar tiene dos recortes que dejan afuera el acto real**: §9.4 a la invariante
declarada, §VI.3.1 a la intervención cerrada. **Un renombre dentro de un documento, o una afirmación de
colisión dentro de un informe, no está alcanzado por ninguna.**

**c) Una afirmación de colisión no está obligada a adjuntar su medición**, de modo que al leerla no se
distingue de una que la hizo. Las seis del cuadro de §2.4 se leían igual de firmes.

**d) §8 contradice a la cabecera y a §9.6**, y remite el vocabulario propio del método a un glosario que
no tiene criterio de colisión.

**e) §9.2 declara la unidad de contexto para un solo tipo de lector.**

**f) La producción de reportes contra el framework no está bajo ningún `Archivo target` que la
verifique.** `Vocabulario-Rules.md` nombra entre sus lectores a *«quien interviene el framework»*, pero
escribir un reporte **no es intervenir**: el propio README de la serie los declara *«insumo de prompts de
intervención […] ninguno modifica el framework»*. Y el registro que `Mesa-Rules.md` define como artefacto
de la mesa vive en el destino, no en esta serie.

---

## 4. El hueco, en una frase

**El framework sabe decidir si un término colisiona y nombra con exactitud el error de afirmarlo sin
medir, pero no obliga a que la afirmación adjunte su medición, no pone la parte mecánica de esa medición
en ninguna compuerta, recorta la exigencia a actos que no son donde el error ocurre, declara la unidad de
contexto para un solo lector, y se contradice sobre qué términos gobierna.**

---

## 5. Qué se propone evaluar

**Ninguna es una propuesta de redacción: son las preguntas que la intervención tiene que contestar.** La
mesa llegó a una posición en cada una y la deja escrita como punto de partida, no como decisión.

### 5.1 El alcance de la regla — **se decide primero**

¿Corresponde corregir §8 para que declare lo que la regla hace de hecho —gobernar la colisión de **todo**
término del framework, incluido el propio del método—, alineándolo con la cabecera y con §9.6?

**Posición de la mesa: sí.** Resuelta por el refutador con ancla E2, sin escalar. Se decide primero porque
**§5.2 a §5.5 no se pueden ubicar sin saber qué archivo gobierna**. Y hay que decir qué pasa con la
remisión a `Master-Prompt.md` §15: si §15 sigue siendo el lugar donde **se definen** los términos del
método, y §9 el lugar donde **se decide su colisión**, el reparto queda limpio y el reporte `11` no se
reabre.

### 5.2 El criterio de aceptación enumerable

¿Corresponde el **primer `[enumerable]`** de `Vocabulario-Rules.md` §10, con esta forma?

> Toda afirmación de colisión o no-colisión de un término contra el vocabulario vigente adjunta, en el
> mismo punto donde se afirma, **el comando reproducible** y su salida. La ausencia de esa evidencia es
> hallazgo, **independientemente de si la conclusión resulta después correcta**.

**Lo que el criterio verifica es la presencia de la medición, nunca el veredicto.** Por eso es enumerable
sin producir falsa confianza. La refutación lo atacó con el caso del comando falso —un `grep` sobre el
archivo equivocado cumple la letra— y **el criterio sobrevive en su naturaleza**: no promete impedir la
medición errónea, promete volverla **reproducible**, que es el estándar D9 que el framework ya usa para
toda evidencia. **La prueba está en §2.4**: las filas 4 y 5 las encontró alguien que **releyó** una cita
que se podía reejecutar.

**La cláusula «comando reproducible» no es opcional**: una prosa que diga «revisé tal sección» cumple una
versión más blanda y no se relee mecánicamente.

### 5.3 Dónde corre, para que alcance al acto real

¿El criterio de §5.2 vive **sólo** en `Vocabulario-Rules.md` §10, o también en `Mesa-Rules.md` y en la
guía de desarrollo §VI.3?

**Posición de la mesa, levantada por la refutación como P1**: si vive sólo en §10 **es cosmético para el
caso que lo originó**, porque lo verifica el auditor de fase y el acto ocurrió escribiendo un reporte, que
no tiene fase. Tiene que alcanzar los tres lugares donde se afirma una colisión: la generación, la mesa, y
la intervención —incluida su verificación previa, que es donde ocurrió este caso—.

### 5.4 La unidad de contexto por tipo de lector

¿Corresponde que §9.2 declare la unidad de contexto **para cada lector** que el framework tiene —sección
para el subagente de generación, archivo para el que recibe insumos íntegros— en lugar de para uno solo?

Es lo que habría evitado el `P0` de §2.6. **Y la tabla ya está escrita en los insumos de cada orquestador**:
no hay que inventarla, hay que leerla desde §9.2.

### 5.5 La mitad mecánica en la compuerta

¿Corresponde que la compuerta de §10.0 **localice** las ocurrencias de todo término que la fase declara
acuñar o renombrar, **por la unidad de contexto de §5.4**, y entregue la lista al auditor **como insumo y no
como veredicto**?

**El recorte es la condición de viabilidad, y la comisión de verificación lo midió**: un barrido de un
término candidato cuesta segundos y devuelve una docena de archivos; un barrido de toda palabra
potencialmente ambigua devuelve cientos de coincidencias por palabra común y desactiva el instrumento —el
mismo argumento con que §10.0 ya excluyó los snapshots de `_legacy/`—. **Sólo términos declarados como
acuñados o renombrados, nunca prosa libre.**

### 5.6 El remedio del caso concreto

**Lo decide la intervención `05`, no ésta**, con la evidencia de §2.6. La mesa deja escrito que:

- el campo del reporte `26` **no colisiona** en sus secciones destino y puede llamarse como la intervención
  prefiera;
- el del reporte `27` **no colisiona en `Root-Rules.md`**, donde vive, **pero sí en `Migracion-Rules.md`**
  si la clasificación que el `27` propone se escribe ahí, y con el costo de **45 ocurrencias** por la
  unidad de contexto de ese archivo;
- el renombre a `ciclo de origen` **se hizo sin verificar** y quedó reabierto.

---

## 6. Lo que este reporte no afirma

- **No afirma que el criterio de §9.1 esté mal.** Es correcto, y el caso lo confirmó cada vez que se aplicó
  midiendo.
- **No propone un registro de términos.** Lo evaluó y lo rechazó con evidencia, a pedido del Product Owner.
- **No reabre el reporte `11`.** El reparto definición-en-§15 / vocabulario-de-negocio-en-§2 sigue en pie;
  lo que se corrige es que §8 niega a §9 un alcance que §9.6 ya ejerce.
- **No propone mecanizar los trece criterios de §10.** La comisión de requisitos lo declaró fuera de alcance
  a propósito: es un proyecto propio y no puede volverse prerrequisito de éste. Se pide **uno**.
- **No afirma que la compuerta pueda decidir colisiones.** Afirma que puede localizarlas, y que decidir
  sigue siendo lectura.
- **No afirma que los agentes sean descuidados.** Afirma que una afirmación que no adjunta su medición es
  indistinguible de una que la tiene, y que eso vale igual para el orquestador, para un subagente y para
  un refutador — el cuadro de §2.4 tiene de los tres.

---

## 7. Cómo verificar que la corrección funcionó

1. **El recuento de §2.1 cambia.** `Vocabulario-Rules.md` pasa a tener al menos un `[enumerable]`, medido
   con el mismo comando.
2. **§8, la cabecera y §9.6 dejan de contradecirse.** Leídos juntos, los tres declaran el mismo alcance.
3. **Reproducir el caso.** En una verificación previa a una intervención, afirmar la colisión de un término
   sin adjuntar comando. **Tiene que ser hallazgo** por vía del método, no por relectura casual.
4. **Reproducir el `P0` de §2.6.** Proponer calificar una sección de un archivo que se lee íntegro. **La
   unidad de contexto de §9.2 tiene que dar el costo correcto** —el archivo, no la sección— sin que haga
   falta un refutador.
5. **La compuerta localiza sin decidir.** Declarar un término acuñado y comprobar que §10.0 devuelve sus
   ocurrencias por unidad de contexto, **y que no emite ningún veredicto de colisión**.
6. **Criterio negativo.** Un término cuyos sentidos están en contextos disjuntos **no** aparece como
   hallazgo: la compuerta lo localiza, el auditor lo descarta, y el descarte queda escrito.

---

## 8. Cómo se resolvió

**RESUELTO en SDD 13.12**, el 2026-09-12, por la intervención `06`, **segunda** del orden `04` → `06` → `05` → `03`.
Evidencia con cada comando y su salida en `PROMPTs/Fixs/06-Fix-Reporte-28/OUTPUTs/`, y en el framework la nota
`SDD/Devs/Guides/Coherencia-Colision-Lexica.md`.

**Lo que la verificación corrigió de este reporte antes de usarlo.** Los tres recuentos **se reprodujeron** con sus
comandos, en 13.10 y en 13.11. Pero:

- **§2.6 hereda una premisa de §9.2 que era cierta a medias**: el despacho del subagente nombra por sección el intake
  y las reglas transversales, **y por ruta** la regla de su categoría, los documentos upstream y los de conocimiento.
- **§2.5 y §5.1 fundan la resolución en una cronología falsa**: §9.6 es de la 2.1 de la regla (2026-07-29) y el
  párrafo de §8 de la 2.2 (2026-08-15). **La conclusión se sostiene por otras tres citas**; «desactualizado por la
  práctica posterior», no.
- **La fila 6 de §2.4 era un recuento de líneas**: `grep -c procedencia` da 16 y 19. Y el 22 es 24 sin distinguir
  mayúsculas.
- **El 45 de §2.6 suma dos archivos como un contexto**, y §9.6 ya había declarado que viajar juntos no los junta.
- **§2.5 dice que §15 no tiene criterio de colisión**: define «colisión de sentidos» y remite a §9.2. No decide casos.
- **La cita de `Root-Rules.md` §13 omite sin marcar** el paréntesis y su cláusula final; y **§8 no se titula**
  «Alcance de esta regla, declarado»: es el arranque de un párrafo de «Pendientes declarados y su cierre».

| Pregunta | Desenlace |
|---|---|
| **§5.1** El alcance | **§8 se corrige**: significado y precedencia sobre los seis términos; **criterio de colisión sobre todo término, incluido el vocabulario del método**. **§15 define y §9 decide la colisión**; el `11` **no se reabre**. Se resolvió con el árbol y sin detener: origen del hecho ajeno a la corrida, calculado, y respuesta con cita literal |
| **§5.2** El criterio enumerable | **Entra** como primer `[enumerable]` de §10, **con comando reproducible obligatorio**, que decide la presencia de la medición y no la colisión, desde la 3.3. **El argumento del comando falso se verificó**: los tres errores de medición de esta corrida fueron comandos reales que medían otra cosa, y los tres se ven con el comando al lado |
| **§5.3** Dónde corre | **En tres lugares**: `Vocabulario-Rules.md` §9.4 y §10; `Mesa-Rules.md` §6.1 —sin comando, una afirmación de colisión es `C`— y §8; y la **comprobación 14** de la guía §VI.3, que alcanza a la verificación previa y a lo que trae el origen. **Escribir un reporte sigue fuera de todo target**, por autosuficiencia: se lo alcanza cuando lo produce una mesa y cuando lo usa una intervención |
| **§5.4** El contexto por lector | **§9.2 lo declara leyendo los insumos de cada lector**: sección cuando la lista la nombra, archivo cuando no. Co-ocurrencia y costo en el contexto mayor, desambiguación en el menor, y **la suma de lo que un lector recibe no es un contexto** |
| **§5.5** La compuerta | **Comprobación 7 de `Master-Prompt.md` §10.0**: localiza por sección y por archivo los términos que la fase acuña o renombra, **calculados contra la base de la corrida**, como insumo y **nunca como veredicto**. Volumen medido: tres términos acuñados en 4 a 6 archivos y milisegundos; `estado`, 711 ocurrencias en 90 |
| **§5.6** El caso concreto | **No se decidió acá.** Para la `05`: calificar en `Migracion-Rules.md` cuesta **23**; **45 sólo si el sentido nuevo se escribe también en `Master-Prompt-Migracion.md`** |

| # | Criterio de §7 | Veredicto |
|---|---|---|
| 1 | El recuento de §2.1 cambia | **CUMPLIDO**: `Vocabulario-Rules.md enum=1 interp=13` |
| 2 | Cabecera, §8 y §9.6 dejan de contradecirse | **CUMPLIDO** |
| 3 | Afirmar una colisión sin comando en una verificación previa es hallazgo por vía del método | **CUMPLIDO A MEDIAS.** La comprobación 14 marca las dos afirmaciones sin comando con que la 13.11 descartó `procedencia` —que resultaron ciertas—, **pero no se ejerció sobre una verificación previa en vivo**, y la localización por cadena deja escapar sinónimos. Precedente: el `18` |
| 4 | El costo de calificar en un archivo que se lee íntegro sale sin refutador | **CUMPLIDO**: 23, por la fila del orquestador de migración de §9.2 |
| 5 | La compuerta localiza sin decidir | **CUMPLIDO sobre el comando publicado**, corrido sobre los términos que la 13.11 agregó a §15: cero palabras de veredicto. El banco es del destino |
| 6 | Un término con contextos disjuntos no aparece como hallazgo | **CUMPLIDO**: «migración» en `Rules-Devops.md` y `Migracion-Rules.md`, localizado en dos archivos, descarte escrito en §9.6, y §9.2 impide sumarlos |

**Cinco cumplidos y uno a medias.**

## Control de cambios

| Versión | Fecha | Cambios | Autor |
|---|---|---|---|
| 1.0 | 2026-09-12 | Emisión inicial. Documenta tres huecos encadenados en `Vocabulario-Rules.md` —la única de diecinueve reglas sin enumerables, una exigencia de verificar que existe dos veces y no alcanza al acto real, y una contradicción de alcance entre cabecera, §8 y §9.6— más la unidad de contexto declarada para un solo lector. **Su evidencia central es un cuadro de seis afirmaciones sin verificar producidas en el mismo trabajo**, cinco del orquestador y una del refutador, todas detectadas por relectura ajena. **Todas las citas de este reporte se midieron en el acto de escribirlo**, con los comandos a la vista en §2, porque las seis del cuadro se escribieron creyendo que ya estaban medidas. | Mesa del 2026-09-12 sobre colisión léxica (requisitos, verificación, terminología, lector sin contexto, refutador), sobre un planteo del Product Owner |
| 1.1 | 2026-09-12 | **RESUELTO en SDD 13.12.** Suma §8, «Cómo se resolvió», con el desenlace de las seis preguntas de §5 y el veredicto de los seis criterios de §7 —cinco cumplidos y el 3 a medias—. **El cuerpo no se reescribe**: lo que la verificación encontró inexacto —la cronología de §2.5 y §5.1, la premisa de §2.6, el alcance del 45, la afirmación sobre §15, la cita elidida de `Root-Rules.md` §13— se declara en §8 en lugar de corregirse en silencio, por la misma razón por la que el cuadro de §2.4 quedó completo. | Intervención `06` |
