# Mesa 2026-09-12 — Verificación de colisión léxica · Contrato de entrada

| Campo | Valor |
|---|---|
| Fecha | 2026-09-12 |
| Convocante | Product Owner de `Lab-Geometria`, sobre un hecho ocurrido durante la escritura de los reportes `26` y `27` |
| Versión del framework evaluada | SDD **13.10** |
| Estado | **Abierta** — cuatro informes entregados, refutación en curso |
| Ubicación de los expedientes | `PROMPTs/Fixs/05-Fix-Reporte-27/OUTPUTs/Mesa-2026-09-12-Colision-Lexica/` |

---

## 1. El hecho

Durante la verificación previa a la intervención `04`, el orquestador encontró que el término
`procedencia` ya estaba en uso en el framework con otro significado. **Afirmó que el campo nuevo que los
reportes `26` y `27` proponían «no puede llamarse así porque colisionaría», y renombró los dos** —a
`origen del hecho` y `ciclo de origen`— **sin haber verificado la colisión.**

`Vocabulario-Rules.md` §9.4 prohíbe exactamente eso, y con estas palabras: *«No se declara una invariante
de desambiguación sin haber verificado que los contextos colisionan […] El patrón queda primado: una vez
que un producto declara una invariante para un término, la forma del patrón se aplica al siguiente
término sin volver a verificar la premisa.»*

**Nadie lo detectó por vía del método.** Lo detectó el propio orquestador al releerse, y recién después
de que el Product Owner preguntara qué problema exacto había.

## 2. Por qué se convoca

El Product Owner lo planteó así:

> *«ese es el problema que deriva de la implementación — la mesa debió verlo y debió tratar una solución
> o propuesta que tal propuesta debió ser evaluada — levantaría un caso con eso y encontraría una
> solución que armonizara ese problema de ambigüedades ya sea asignando un contexto, o algo similar —
> buscando un plan integral.»*

El pedido no es corregir el renombre. Es que **el framework tenga un mecanismo repetible para esta clase
de acto**, en vez de un parche por episodio.

## 3. Composición del panel

| Rol | Mandato |
|---|---|
| **Requisitos** | Delimitar qué hay que resolver y si corresponde reporte nuevo o arista de uno abierto |
| **Verificación** | Si la comprobación de colisión es mecanizable, dónde va la compuerta, a qué costo |
| **Terminología y diseño léxico** | El remedio por §9.3, y la evaluación de la idea del Product Owner (registro de términos / contexto asignado) |
| **Lector sin contexto** | Leer §9 y §10 en frío y decir si un agente que acuña un término sabe qué hacer |
| **Refutador** | Atacar el plan compuesto por su aplicación, y resolver la contradicción de jurisdicción |

Las cuatro primeras trabajaron **a ciegas y en paralelo**: ninguna vio el informe de las otras.

## 4. Evidencia entregada en el despacho, y su suerte

**El contrato de entrada llevaba cuatro datos. Tres resultaron mal, y las comisiones los corrigieron.**
Se deja constancia porque el caso es sobre afirmar sin verificar, y el despacho de esta mesa lo hizo.

| Dato del despacho | Veredicto | Quién lo corrigió |
|---|---|---|
| «§10 de `Vocabulario-Rules.md` tiene once criterios» | **Falso.** Son **13** | Lector sin contexto y Requisitos, por separado |
| «`Migracion-Rules.md` **§4.7** colisiona, con **ocho** usos desnudos en la misma checklist» | **Falso en los dos términos.** §4.7 es «La revisión de apartamientos» y tiene **cero** ocurrencias. La checklist real es **§6**, con **4** | Requisitos y Terminología, por separado |
| «`Master-Prompt.md` tiene 14 ocurrencias» | **Impreciso**: 14 era recuento de líneas e incluía el control de cambios | Requisitos y Terminología |
| «Los 13 criterios son todos interpretativos; cero enumerables» | **Verdadero**, verificado por recuento reproducible | — |

**La conclusión que importa se sostuvo**: hay colisión en `Migracion-Rules.md`, y no la hay en las
secciones donde los campos nuevos vivirían. Pero **ninguno de los tres números citados era utilizable
como estaba**, y eso es en sí mismo evidencia del caso que la mesa trata.

## 5. Los expedientes

| # | Comisión | Archivo |
|---|---|---|
| 01 | Requisitos y alcance | [01-Informe-Requisitos.md](01-Informe-Requisitos.md) |
| 02 | Verificación y compuerta | [02-Informe-Verificacion.md](02-Informe-Verificacion.md) |
| 03 | Terminología y diseño léxico | [03-Informe-Terminologia.md](03-Informe-Terminologia.md) |
| 04 | Lector sin contexto | [04-Informe-Lector-Sin-Contexto.md](04-Informe-Lector-Sin-Contexto.md) |
| 05 | Refutación del plan compuesto | [05-Informe-Refutador.md](05-Informe-Refutador.md) |
| 06 | Plan compuesto y cierre | [06-Plan-Y-Cierre.md](06-Plan-Y-Cierre.md) |

## 6. Nota sobre la fidelidad de estos expedientes

Los informes `01` a `04` se transcriben **verbatim**, tal como los entregó cada comisión, sin edición ni
resumen. Lo que el orquestador agrega —correcciones verificadas por su cuenta, cruces entre informes y
decisiones— vive en `06-Plan-Y-Cierre.md` y está marcado como suyo. **Un expediente editado por quien lo
recibe deja de ser evidencia**, que es el defecto que `Mesa-Rules.md` §0.1 mide como «conocimiento
reenviado».
