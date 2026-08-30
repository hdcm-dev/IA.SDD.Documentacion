# Reporte 21 — La decisión barre hacia arriba, y la categoría que la ejercita queda atrás

| Campo | Valor |
|---|---|
| Reporte | 21 |
| Fecha | 2026-08-30 |
| Origen | La **implementación de los dieciséis samples** de las categorías `10-Examples` del destino `Lab-Geometria`, entre el 2026-08-27 y el 2026-08-30. Cinco cierran exactos contra su §6 y once con divergencias; **la mitad de las divergencias tiene una sola causa**, y la causa es un barrido de alcance incompleto |
| Versión del framework evaluada | SDD **13.8** (`Rules-Examples.md`, `Master-Prompt.md` §6 y §7, `Maqueta-Rules.md` §3.6) |
| Artefactos del framework alcanzados | `SDD/Devs/Rules/Rules-Examples.md` §4.5 (anti-patrones) · `SDD/Devs/Orchestrator/Master-Prompt.md` §6 y §7 · `SDD/Devs/Rules/Maqueta-Rules.md` §3.6, por contraste |
| Naturaleza | Un hueco **de cobertura, no de figura**. El framework nombra el riesgo, prescribe una mitigación y la marca `[interpretativo]`; lo que no tiene es **quién declara el alcance del barrido cuando una decisión cambia un contrato ya escrito** |
| Estado | **Abierto** |
| Reportes relacionados | **`19`**, con el que comparte la forma y del que se distingue por la figura: aquél es sobre el **apartamiento**, que declara una regla hacia adelante y no barre el corpus que deja atrás; **éste es sobre una decisión del producto que sí barrió, y cuyo barrido no tiene cobertura declarada**. Los dos son la misma pregunta —quién enumera lo que una decisión invalida— desde dos figuras distintas |

---

## 1. Resumen

**Un destino emitió un ADR que cambia un contrato declarado, enumeró por escrito qué quedaba desalineado, aplicó las tres correcciones… y la categoría que ejercita ese contrato quedó afuera de la enumeración.**

El framework tiene una **matriz de propagación** —`Maqueta-Rules.md` §3.6— y es de la Fase B2: dice a qué categorías alcanza la retroalimentación de una maqueta validada. **No hay ninguna equivalente para un ADR.** Cuando una decisión cambia un contrato, qué categorías revisar depende de que quien hace el barrido se acuerde de ellas.

Y la categoría 10 es la que peor sobrevive a eso, por una razón estructural: **sus ejemplos se escriben antes que el código, a propósito** (`Rules-Examples.md`, pasada de diseño). Entre que se escribe el §6 y que existe el sample que lo corre puede pasar una etapa entera. **En esa ventana el ejemplo no tiene quien lo relea.**

## 2. La evidencia, en un caso reproducible

### 2.1 Lo que la decisión cambió

`ADR-08006` del destino `Lab-Geometria`, del 2026-08-16: **el visor recibe las piezas reconstruidas y no el texto del alumno**. La función `cargarJson` pasa a llamarse `loadPieces` y cambia de firma.

### 2.2 Lo que el destino hizo bien, y hay que decirlo

El destino emitió `Observacion-Alcance-Aguas-Arriba-De-ADR-08006.md`, que hoy está en **4.0 y cerrada**, con **tres afirmaciones alcanzadas enumeradas una por una, con su texto exacto**, y las tres escrituras aplicadas:

| Alcanzado | Dónde |
| --- | --- |
| «todo esto ocurre sin backend» | `PRODUCT-INTAKE` §20.E-7 |
| la condición `DIMENSION_NO_LEGIBLE` del escenario | `PRODUCT-INTAKE` §20.E-8 |
| la propiedad que se pide no perder | `Requerimientos-Tecnicos.md` §8.3 |

**Es un barrido hecho con criterio**, con una corrección de su propia versión 1.0 declarada adentro. No es un caso de negligencia.

### 2.3 Lo que quedó afuera

**Cero menciones a `10-Examples`, `ejemplo-0` y `samples/` en toda la observación.** Medido con `grep` sobre el documento completo.

Los tres §6 de los ejemplos del visor siguen describiendo la fachada anterior:

| Ejemplo | Lo que su §6 afirma hoy | Lo que el producto hace |
| --- | --- | --- |
| `ejemplo-01-basico` | «Texto de `E-1` cargado» y «Estructura del texto devuelta para el árbol» | la fachada no recibe texto y no devuelve estructura de texto |
| `ejemplo-02-intermedio` | `E-5` llega al visor con una pieza no dibujable | el laboratorio la rechaza antes; al visor no le llega |
| `ejemplo-03-avanzado` | los siete códigos del contrato | seis: `UNREADABLE_TEXT` era el del texto |

**Y el detalle que lo vuelve concluyente:** la propia observación, en su §2.2, escribe que esa pieza **«no llega al visor»**. El documento que enumera el alcance de la decisión **dice exactamente lo que el ejemplo contradice**, y el ejemplo no fue tocado.

### 2.4 Un efecto colateral que nadie podía ver sin correrlo

`NON_DRAWABLE_TYPE` quedó **sin camino**. El laboratorio sólo reconstruye los seis tipos que el visor dibuja; el séptimo del dominio existe únicamente como componente, y puesto como figura raíz **el laboratorio lo rechaza** —se probó—. La guarda del visor sigue en el código y hoy no cubre ningún caso alcanzable.

**Esto no lo detecta ninguna revisión documental**, porque los dos documentos son coherentes cada uno consigo mismo. Aparece al correr el sample contra el producto.

## 3. Qué dice hoy el framework, y por qué no alcanza

### 3.1 El riesgo está nombrado, y su mitigación llega tarde

`Rules-Examples.md` §4.5 —anti-patrones a evitar— tiene la fila:

> | Samples no ejecutables o **desactualizados** | El dev clona y no le compila; la documentación pierde credibilidad | **CI que compila y ejecuta cada sample en cada push** | `[interpretativo]` |

**El riesgo está bien visto y la mitigación es la correcta.** Tiene dos límites:

**Primero, es `[interpretativo]`.** No hay criterio enumerable que lo exija, así que un destino conforme puede no tener esa CI y seguir siendo conforme.

**Segundo, y más de fondo: la mitigación sólo funciona cuando el sample existe.** La misma regla manda escribir el ejemplo **antes** que el código —§5 y §6 se escriben en la pasada de diseño, y la carpeta nace con su README y sin código—. Entre esa pasada y la de ejecución no hay nada que correr, **y es justo la ventana en la que las decisiones de arquitectura ocurren**.

**En este destino la ventana se puede fechar.** El ejemplo del visor se emitió el **2026-08-11**; `ADR-08006` es del **2026-08-16**, cinco días después; y el primero que volvió a leer ese §6 fue quien lo implementó, el **2026-08-29**. **Dieciocho días entre que se escribió y que alguien lo corrió**, con la decisión que lo invalidaba adentro.

### 3.2 La asimetría con la Fase B2

`Maqueta-Rules.md` §3.6 declara una **matriz de propagación**: dice a qué categorías alcanza la retroalimentación de una maqueta validada, y `Master-Prompt.md` §7 la cablea al paso 6 de la fase. Es exactamente el instrumento que hace falta, **y existe para un solo disparador**.

| Disparador | ¿Tiene matriz de propagación? |
| --- | --- |
| Retroalimentación de maqueta validada (Fase B2) | **Sí**, `Maqueta-Rules.md` §3.6 |
| ADR que cambia un contrato ya declarado | **No** |
| Apartamiento declarado (`Root-Rules.md` §11) | **No** — es el reporte `19` |

## 4. El hueco, en una frase

**El framework sabe declarar el alcance de una propagación cuando el disparador es una fase suya, y no sabe declararlo cuando el disparador es una decisión del destino.**

En los dos casos que le faltan —el ADR y el apartamiento— **la enumeración de lo alcanzado queda a criterio de quien la hace**, sin lista de categorías contra la cual verificar que no faltó ninguna. Un barrido incompleto y un barrido completo **se ven igual**: los dos son un documento con sus ítems enumerados y sus escrituras aplicadas.

Es la misma forma que el reporte `19` describe para el apartamiento. Ahí el corpus que queda atrás **no se barre**; acá **se barre y no hay con qué medir la cobertura del barrido**. Los dos huecos se cierran con la misma pieza.

## 5. Qué se propone evaluar

**No se propone una redacción**, que es del framework. Se enumeran las tres cosas que el caso muestra que faltan:

**5.1 Una matriz de propagación para el ADR, con la categoría 10 adentro.** Del mismo tipo que `Maqueta-Rules.md` §3.6: qué categorías revisar cuando una decisión cambia un contrato declarado. Sin ella, la cobertura depende de la memoria de quien barre.

**5.2 Un campo de cobertura en el documento que enumera el alcance.** Que declare **contra qué lista se verificó**, no sólo qué se encontró. Es el mismo criterio que `Root-Rules.md` §11 aplica al apartamiento —seis campos sobre la decisión— llevado al barrido: hoy un barrido incompleto no tiene cómo declararse incompleto.

**5.3 Subir de `[interpretativo]` a enumerable la corrida de los samples**, o —si eso es demasiado para la ventana en que no existen— **declarar qué se hace con un §6 escrito y sin código durante esa ventana**. Hoy no hay ni una cosa ni la otra: el §6 se escribe, nadie lo relee, y el primero que lo lee de verdad es quien lo implementa, una etapa después.

## 6. Lo que este reporte no afirma

**No afirma que `ADR-08006` esté mal.** Está tomada, es correcta, y su observación de alcance es un buen trabajo.

**No afirma que el destino haya incumplido una regla.** No hay regla que exija la categoría 10 en ese barrido: eso es precisamente el hueco.

**No afirma que la CI de samples sea mala mitigación.** Es la correcta, y llega tarde para esta ventana.

## 7. Cómo reproducirlo

1. Tomar un destino con categorías `10-Examples` escritas en la pasada de diseño y sin código.
2. Emitir un ADR que cambie un contrato que esos ejemplos ejercitan.
3. Hacer el barrido de alcance con el método vigente y enumerar lo alcanzado.
4. **Medir con `grep` si el barrido menciona la categoría 10.**
5. Implementar los samples y comparar contra su §6.

En `Lab-Geometria` el paso 4 da **cero** y el paso 5 devuelve las divergencias de §2.3, todas con la misma causa.

---

## Control de cambios

| Versión | Fecha | Descripción |
|---|---|---|
| 1.0 | 2026-08-30 | Emisión. Un barrido de alcance de ADR hecho con criterio que no alcanzó la categoría que ejercita el contrato cambiado, con el caso medido en `Lab-Geometria`. Se distingue del reporte `19` por la figura —allá el apartamiento no barre; acá el barrido no tiene cobertura declarada— y se propone cerrar los dos con la misma pieza. |
