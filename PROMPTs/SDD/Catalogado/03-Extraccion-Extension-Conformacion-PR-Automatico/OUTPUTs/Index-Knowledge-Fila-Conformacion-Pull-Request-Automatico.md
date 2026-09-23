# Fila de índice — Conformacion-Pull-Request-Automatico

**Documento:** Index-Knowledge-Fila-Conformacion-Pull-Request-Automatico.md
**Destino:** §3 Catálogo de `Conocimiento/Index-Knowledge.md` del fork que incorpore el documento
**Compatible con:** Rules-Base-Conocimiento.md 2.2
**Fecha:** 2026-09-19

---

## 1. Qué es este archivo

La segunda pieza que exige `Rules-Base-Conocimiento.md` §2.1 y §8: **la fila del índice** del documento
`Knowledge-Conformacion-Pull-Request-Automatico.md`. Se entrega por separado porque el pedido prohíbe
escribir en el repositorio del framework: quien lo incorpore a su fork pega la fila en su índice.

## 2. La fila

Va **a continuación de la fila de `Conformacion-Pull-Request-Manual`**, que es su padre.

| Documento | Alias | Naturaleza | Tema | Consumidor | Condicion-de-carga | Hereda-de | Sustituye | Compatible-con | Estado |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `Knowledge-Conformacion-Pull-Request-Automatico.md` | `Conformacion-Pull-Request-Automatico` | canonico | Ciclo de entrega de una unidad de trabajo cerrado por el propio agente orquestador: compuerta, rama, pull request abierto por API, informe con el enlace, guarda de merge sobre los controles, merge y borrado de la rama remota por el agente, preparación del repositorio local y continuación sin acuse humano, con retorno al ciclo manual ante una reserva | transversal | — | `Conformacion-Pull-Request-Manual` | — | 2.2 | Vigente |

## 3. Cómo se incorpora

| Paso | Qué |
| --- | --- |
| 1 | Copiar `Knowledge-Conformacion-Pull-Request-Automatico.md` a `Conocimiento/` del fork |
| 2 | Pegar la fila de §2 en §3 de `Index-Knowledge.md` |
| 3 | Sumar una fila al control de cambios del índice: «Alta de `Conformacion-Pull-Request-Automatico`, especialización del traspaso manual» |
| 4 | Cumplir lo que el framework exige a toda alta en su repositorio (`Index-Knowledge.md` §2): entrada en el `CHANGELOG.md`, copia del conjunto superado a `_legacy/` y, si toca varios archivos, nota de coherencia |
| 5 | Correr la lista de `Rules-Base-Conocimiento.md` §6.1, en especial la coincidencia campo por campo entre esta fila y la cabecera del documento |

**Lo que no se incorpora con el alta.** La delegación del merge (§3.1 del documento) **no la concede el
índice ni el documento**: la asienta el responsable de cada producto en su repositorio destino. Un fork
que tenga la fila y un producto sin delegación asentada sigue aplicando el traspaso manual.

## 4. Control de cambios

| Versión | Fecha | Cambios |
| --- | --- | --- |
| 1.0 | 2026-09-19 | Emisión inicial, junto con el documento. |
