# Reporte 22 — El apartamiento no declarado no se revisa nunca, y nada lo busca

| Campo | Valor |
|---|---|
| Reporte | 22 |
| Fecha | 2026-08-31 |
| Origen | El cierre del hallazgo `H-12` de `Lab-Geometria`, el 2026-08-31. Un apartamiento **real, con su fundamento escrito y su recuento correcto**, que vivió **diecinueve días** sin la forma de `Root-Rules.md` §11 mientras **siete migraciones normativas** pasaban al lado sin verlo |
| Versión del framework evaluada | SDD **13.8** (`Root-Rules.md` 8.6 §11, `Migracion-Rules.md` 3.19 §4.7) |
| Artefactos del framework alcanzados | `SDD/Devs/Rules/Root-Rules.md` §11 · `SDD/Devs/Rules/Migracion-Rules.md` §4.7 |
| Naturaleza | Un hueco **en el disparador, no en la figura**. §11 diseñó un contador para medir cuánto sobrevive un apartamiento, y **el contador sólo cuenta los que alguien declaró**. El que no se declara **no tiene contador, no tiene revisión y no tiene forma de aparecer** |
| Estado | **Abierto** |
| Reportes relacionados | **`19`**, del que es la otra mitad. Aquél dice que el apartamiento **declara hacia adelante y nadie barre lo que deja atrás**; éste dice que **el que no se declara no se barre nunca**. Los dos salieron del mismo destino y de la misma figura, con doce días de diferencia |

---

## 1. Resumen

**`Root-Rules.md` §11 tiene un mecanismo excelente para el apartamiento declarado, y ninguno para el que no lo está.**

El campo 6 —los **saltos de versión sobrevividos**— es la mejor pieza de esa sección: convierte «alguien tendría que acordarse» en un número, y su regla es precisa —«un apartamiento que sobrevive **dos o más saltos** sin ser contemplado ya demostró que **no es de un producto**»—.

**Quien incrementa ese número es `Migracion-Rules.md` §4.7, y §4.7 revisa apartamientos declarados.** Un apartamiento que existe en el producto y **no lleva la figura** no entra en ninguna revisión: no tiene estado que envejezca, no tiene contador que suba, y **no hay ningún barrido que lo encuentre**.

**El resultado no es que se revise tarde: es que no se revisa nunca.**

## 2. El caso, medido

### 2.1 El apartamiento existía, y estaba bien fundado

`Lab-Geometria` emite `UNCLASSIFIED_ERROR` con **cuatro** destinos donde su propia especificación de superficie le da **dos**. Los dos de más están **declarados desde el 2026-08-12** en `ADR-00004` §2 regla 2, con el recuento correcto y con su fundamento: un `500` diría que el producto falló cuando lo que pasa es que la operación no procede.

**No es un descuido ni una evasión.** Es exactamente el caso para el que §11 existe: una obligación que no contempla lo que al producto le pasa.

### 2.2 Lo que le faltaba, y lo que eso costó

Le faltaban los **seis campos**. En particular **el estado y el contador**, que son los dos que §11 agregó en su 6.1 con este fundamento: *«sin estado, un apartamiento absorbido, uno contradicho y uno todavía no contemplado se ven igual, y el tercero es indistinguible del olvido»*.

**Entre el 2026-08-12 y el 2026-08-31 cerraron siete migraciones normativas** en ese destino: 6.0→8.6, 8.6→8.11, 8.11→9.9, 9.9→9.10, 9.10→9.12, 9.12→10.0 y 10.0→13.3.

**Ninguna lo revisó.** No por omisión de quien migró: **§4.7 revisa la lista de apartamientos declarados**, y éste no estaba en ella.

### 2.3 El número que el campo 6 no puede escribir

Cuando el destino formalizó el apartamiento, el campo 6 quedó así:

> **0 revisados, y siete transcurridos.**

**Y esas dos cifras no son la misma cosa.** «Sobrevivió siete» dice que siete revisiones lo miraron y lo dejaron vigente — que es lo que §11 quiere medir y lo que funda su regla de los dos saltos. «Transcurrieron siete» dice que **nadie lo miró**, y no funda nada: no se puede concluir que la regla es del framework a partir de siete revisiones que no ocurrieron.

**El campo tiene un solo casillero para dos hechos distintos**, y el segundo es el que el método no ve.

## 3. Por qué no lo encuentra ninguna otra pieza

Se revisaron las tres que podrían:

| Pieza | Por qué no lo alcanza |
| --- | --- |
| `Migracion-Rules.md` §4.7 | Su entrada es **la lista de apartamientos declarados**. Un apartamiento sin ADR no está en la lista |
| El audit independiente | Audita **artefactos contra su regla**. Un ADR que declara una decisión correcta y bien fundada **pasa**: lo que le falta es una figura que nadie le exigió |
| La mesa de evaluación | `Mesa-Rules.md` §4 le **prohíbe relevar el estado**, y su compuerta mecánica mide enlaces, no formas de decisión |

**Y hay una asimetría que lo explica.** El framework sabe encontrar **el artefacto obligatorio que falta** —lo declara obligatorio y lo busca por nombre—. No sabe encontrar **la figura que le falta a un artefacto que sí existe**, porque el artefacto está ahí y su contenido es correcto.

## 4. El hueco, en una frase

**El contador de §11 mide la edad de los apartamientos que alguien recordó declarar, y es ciego a los que no.** Y el que no se declaró es, por construcción, el que nadie está mirando — que es exactamente la población que el contador existe para vigilar.

## 5. Qué se propone evaluar

**No se propone una redacción.** Se enumeran las tres cosas que el caso muestra que faltan:

**5.1 Un barrido que encuentre apartamientos no declarados.** La señal es observable y barata: un artefacto del destino que **contradice una obligación citada** y lo dice en su prosa. En el caso medido, la frase estaba escrita —«hay dos huecos declarados»— y ninguna pieza la leyó como lo que era.

**5.2 Separar los dos hechos del campo 6.** «Revisado y dejado vigente» y «transcurrido sin revisión» son distintos, y **sólo el primero funda la regla de los dos saltos**. Un apartamiento con siete transcurridos y cero revisados no demostró que sea del framework: demostró que el método no lo vio.

**5.3 Que la formalización tardía deje rastro.** Cuando un apartamiento existente recibe su figura años o semanas después, el campo 6 arranca en cero y **el documento no dice desde cuándo la decisión estaba tomada**. En el caso medido lo dice porque el destino lo escribió a mano; el framework no lo pide.

## 6. Lo que este reporte no afirma

**No afirma que el destino haya incumplido una regla.** §11 dice cuándo corresponde un apartamiento, y no dice que un ADR que declara un hueco en su prosa tenga que además formalizarlo — eso es lo que falta.

**No afirma que el contador esté mal diseñado.** Es la mejor pieza de §11. Lo que le falta es la población que no puede contar.

**No propone que toda contradicción se declare como apartamiento.** La propuesta 5.1 es un **barrido que las encuentre**, no una obligación de convertirlas.

## 7. Cómo reproducirlo

1. Tomar un destino con un ADR que declare, en su prosa, que se aparta de una obligación citada.
2. **No** formalizarlo con los seis campos de §11.
3. Correr las migraciones normativas que correspondan.
4. Medir cuántas revisaron el apartamiento.

En `Lab-Geometria` el paso 4 da **cero sobre siete**, en diecinueve días.

---

## Control de cambios

| Versión | Fecha | Descripción |
|---|---|---|
| 1.0 | 2026-08-31 | Emisión. Un apartamiento real y bien fundado que vivió diecinueve días sin la figura de §11, con **siete migraciones normativas transcurridas y cero revisiones**, porque `Migracion-Rules.md` §4.7 revisa **apartamientos declarados**. Se distingue del reporte `19` por la mitad que ataca: aquél, el corpus que el apartamiento deja atrás; éste, el apartamiento que nunca se declaró. Propone un barrido que los encuentre y separar los dos hechos que hoy comparten el campo 6. |
