# IA.SDD.Documentacion

Repositorio complementario del **Framework SDD**. El framework se versiona en [`IA.SDD`](https://github.com/hdcm-dev/IA.SDD); acá se lleva **cómo se lo construyó**: los prompts con que se lo intervino, los hallazgos que motivaron cada versión, los análisis e informes que formaron criterio y el material de trabajo de las corridas. Nada de lo que está acá es norma del framework.

Este archivo es la superficie de entrada para un agente que llega sin contexto. Si venís a hacer algo concreto, andá directo a la [matriz de ruteo](#matriz-de-ruteo-por-intención).

---

## Los dos repositorios

El autor sigue un patrón fijo en todos sus proyectos: un **repositorio principal** que versiona el producto y un **repositorio complementario**, terminado en `.Documentacion`, que lleva el prompteo y la documentación fundacional de ese producto. Acá el producto es el propio framework.

| | `IA.SDD` (principal) | `IA.SDD.Documentacion` (este) |
| --- | --- | --- |
| **Qué es** | El Framework SDD: reglas constructivas, orquestadores, plantillas de intake, guías, catálogo de conocimiento y expedientes | El origen y la traza de cada cambio del framework |
| **Qué se versiona** | El conjunto normativo, con su `CHANGELOG.md` (13.23 al 2026-10-27) y, en `_legacy/`, una copia del conjunto superado por cada versión desde la 4.1 | Los tool-prompts, los reportes de hallazgos, los análisis, los informes y las notas, con su propio `CHANGELOG.md` (serie `1.N`) |
| **Quién escribe** | Los agentes, cuando un prompt de acá lo ordena y en la forma que fija su `SDD/Guides/SDD-Development-Guide.md` | El dueño, a mano; los agentes solo escriben en las `OUTPUTs/` de la unidad que ejecutan |
| **Qué cita a qué** | El framework **no depende de este repositorio para operar**: se clona y corre solo (`SDD-Development-Guide.md`, comprobación 2). Lo nombra **como texto, sin enlaces**: en su `CHANGELOG.md`, en las notas de coherencia de `SDD/Devs/Guides/`, en `Expedientes/`, en los controles de cambios de algunas reglas y guías, y como antecedente: `Informes/Memoria-De-Antecedentes-Casos-Resueltos.md` §2.2 lo citan `Master-Prompt-Migracion.md`, `Master-Prompt-Reanudacion.md` y `Mesa-Rules.md` | Cita libremente al framework: versiones, archivos, secciones y expedientes |

El framework describe este rol en su modelo de tres repositorios (`IA.SDD/README.md` y `SDD/Guides/SDD-Getting-Started-Guide.md` §2): el **repositorio de documentación** «lo mantiene el usuario a mano», persiste los tool-prompts reejecutables y el material de investigación, y el orquestador no lo toca nunca. Para un producto cualquiera ese repositorio es `<Slug-Producto>.Documentacion`; un ejemplo público del patrón aplicado a un producto destino es el par `Lab-Geometria` / `Lab-Geometria.Documentacion`.

### El circuito entre los dos

```text
IA.SDD.Documentacion                                   IA.SDD
────────────────────                                   ──────
Reportes/NN-…            hueco del framework,
                         con evidencia reproducible
      │
      ▼
PROMPTs/DEVs/Fixs/NN-…   tool-prompt de intervención  ──►  versión nueva (CHANGELOG.md)
      │                  OUTPUTs/: verificación,            nota de coherencia en SDD/Devs/Guides/
      │                  plan, evidencia, mesa              copia de lo superado en _legacy/
      ▼
el reporte pasa a «RESUELTO en SDD <versión>» y se cierra su fila en Reportes/README.md

PROMPTs/DEVs/Features/NN-…   prompt de capacidad nueva  ──►  versión nueva
PROMPTs/SDD/Catalogado/NN-…  extracción de conocimiento ──►  Knowledge-*.md, que el dueño
                                                             incorpora o deja para un fork
```

Un reporte **no modifica nada**: documenta. El prompt de fix **sí modifica**, y por eso viven en lugares distintos (`PROMPTs/DEVs/Fixs/README.md`). El cierre de una intervención —estado del reporte, su fila en el índice y la entrada en el `CHANGELOG.md` del framework— va en el mismo acto que el cambio.

---

## Anatomía del repositorio

| Ruta | Qué contiene |
| --- | --- |
| [`PROMPTs/DEVs/Features/`](PROMPTs/DEVs/Features/) | Veintiún unidades (`01` a `21`) que hicieron crecer el framework: del renombre a `SDD` (2.0) a la mesa evaluadora (13.7) y los expedientes (13.18). Cada unidad guarda el pedido y su traza; el cambio en sí vive en `IA.SDD` |
| [`PROMPTs/DEVs/Fixs/`](PROMPTs/DEVs/Fixs/) | Diez intervenciones (`00` a `09`) sobre reportes del framework: nueve aplicadas y la `02` sin objeto, porque su reporte se resolvió por otra vía. Su [`README.md`](PROMPTs/DEVs/Fixs/README.md) es el índice: qué reportes aplicó cada una y en qué versión cerró |
| [`PROMPTs/SDD/Catalogado/`](PROMPTs/SDD/Catalogado/) | Prompts que operan **sobre el framework** y no sobre un producto: extracciones de conocimiento para la base desacoplada (`01` especificación de la base, `02` `Knowledge-Bundle-JS`, `03` `Knowledge-Conformacion-Pull-Request-Automatico`) |
| [`PROMPTs/Analisis/`](PROMPTs/Analisis/) | Prompts de análisis o debate sobre el método. Hoy, una unidad |
| [`PROMPTs/Promptings/`](PROMPTs/Promptings/) | Un prompt sobre el framework de prompts, no sobre SDD |
| [`Reportes/`](Reportes/) | Treinta y dos reportes de hallazgos contra el framework (`00` a `31`), con su índice [`README.md`](Reportes/README.md): estado de cada uno, desenlaces y línea de corte |
| [`Informes/`](Informes/) | Estudios que dejan criterio formado, no hallazgos: criterios de decisión, memoria de antecedentes, paso o prosa. Índice en su [`README.md`](Informes/README.md) |
| [`Analisis/`](Analisis/) | Documentos de análisis y material de apoyo, sin invocación: optimización del orquestador, flujo git del agente, el plan de las correcciones 12 a 14 y sus mediciones. `IA-Documentacion/` (ADR, SAD, manual técnico de otro producto), `Caracteristicas-UI-IX/` y `Estudio-UX-UI-Historias/` son material de consulta sin relación demostrada con el framework |
| [`Notas/`](Notas/) | Notas de trabajo del dueño, nombradas por marca de tiempo `AAAAMMDDhhmm`. La suelta `2022607271949.md` es la nota de la carpeta `202607271949/`, con un dígito de más |
| `Apuntes/`, `Expedientes/` | Carpetas creadas en disco y no versionadas. Los expedientes del framework viven en `IA.SDD/Expedientes/`, no acá: lo resolvió el expediente `0001` |
| [`CHANGELOG.md`](CHANGELOG.md) | La bitácora de este repositorio, en formato Keep a Changelog, de `1.0` (2026-07-18) a `1.21` (2026-09-23) |

**Sin indexado.** A diferencia de otros repositorios `.Documentacion` del autor, este no lleva una base de indexado (`ia-db` ni equivalente). La unidad `15-RAG` no produjo un índice acá: su plan define «RAG» como un catálogo curado y cargado por cita, que vive en el framework como `IA.SDD/Conocimiento/Index-Knowledge.md`. Los índices de este repositorio son los `README.md` de `Reportes/`, `Informes/` y `PROMPTs/DEVs/Fixs/`; los de `PROMPTs/`, `PROMPTs/SDD/` y `PROMPTs/Analisis/` existen vacíos, a propósito: marcan la carpeta.

---

## Matriz de ruteo por intención

| Vengo a… | Leé |
| --- | --- |
| Entender qué es el Framework SDD | `IA.SDD/README.md`, no este repositorio |
| Saber por qué el framework tiene una regla | El `CHANGELOG.md` de `IA.SDD` en la versión que la introdujo, y desde ahí el reporte o el prompt de acá que la originó |
| Ver qué huecos del framework están abiertos | [`Reportes/README.md`](Reportes/README.md), y la columna de estado de cada reporte |
| Reportar un hueco nuevo del framework | Un reporte nuevo en [`Reportes/`](Reportes/), con la forma de los existentes. Evalúa SDD 12.1 o posterior: la serie `00` a `15` no se reanaliza |
| Aplicar un reporte sobre el framework | Una intervención nueva en [`PROMPTs/DEVs/Fixs/`](PROMPTs/DEVs/Fixs/), con la forma y el cierre que fija su [`README.md`](PROMPTs/DEVs/Fixs/README.md) |
| Ver cómo se razonó una intervención ya hecha | Las `OUTPUTs/` de su unidad en `Fixs/`: `00`/`10` verificación y decisión de fondo, `20` plan, `30` verificación criterio por criterio, `evidencia/` con cada comando y su salida, y la mesa con su jurado cuando la hubo |
| Saber de dónde salió una capacidad del framework | La unidad de [`PROMPTs/DEVs/Features/`](PROMPTs/DEVs/Features/) que la pidió; la tabla de abajo da la correspondencia con las versiones |
| Catalogar un conocimiento para la base desacoplada | [`PROMPTs/SDD/Catalogado/`](PROMPTs/SDD/Catalogado/), siguiendo `03` como el caso más completo: conocimiento, fila de índice aparte y constancia de mesa |
| Encontrar el antecedente de un criterio de decisión | [`Informes/`](Informes/). `Memoria-De-Antecedentes-Casos-Resueltos.md` §2.2 la citan los orquestadores de migración y de reanudación y `Mesa-Rules.md` del framework |
| Saber qué cambió en este repositorio | [`CHANGELOG.md`](CHANGELOG.md), y `git log` para lo que no tiene entrada (ver [Estado del árbol](#estado-del-árbol)) |

---

## Correspondencia con las versiones del framework

Lo que se puede rastrear con cita en los dos `CHANGELOG.md`, en los `README.md` de cada unidad o en los propios reportes.

| Unidad de acá | Versión de `IA.SDD` |
| --- | --- |
| `Features/02` renombre del repositorio a `SDD` | 2.0 |
| `Features/03` características de un proyecto web | 2.1 |
| `Features/04` maqueta y sensado de deriva | 2.2 |
| `Features/06` guía de arranque | 2.4 |
| `Features/07` reglas sin prefijo numérico | 2.5 |
| `Features/09` intercambio de las categorías 10 y 11 | 3.0 |
| `Features/10` revisión de hallazgos y normalización del versionado | 3.1, 3.2 y 4.0 |
| `Features/12` gobierno del glosario | 5.1 |
| `Features/13` migración normativa | 6.0 |
| `Fixs/00` reportes `00` a `11` | 7.0 y 8.0 |
| `Fixs/01` reportes `13`, `14` y `12` | 9.19, 10.0 y 11.0, 12.1 |
| `Features/15` base de conocimiento | 12.2, 12.3 y 13.0 |
| `Features/17` guías al día con la capa de conocimiento | 13.1 |
| `Features/18` etapa preplanificadora y mesa evaluadora | 13.7 |
| `Features/19` conformación manual del pull request | 13.9 |
| `Fixs/02` reporte `16` | Sin objeto: el reporte cerró en 13.6 por otra vía |
| `Fixs/04`, `06`, `05`, `03` reportes `26`, `28`, `27`, `25`, en ese orden | 13.11, 13.12, 13.13, 13.14 |
| `Fixs/07` y `08` reportes `29` y `30` | 13.15 y 13.16 |
| `Fixs/09` y `Features/21` reporte `31`, expedientes | 13.18 y expediente `0001` |
| `Catalogado/02` `Knowledge-Bundle-JS` | Expediente `0002`. **No incorporado**: queda acá para que quien use el framework lo sume a su fork |
| `Catalogado/03` `Knowledge-Conformacion-Pull-Request-Automatico` | 13.21. **Incorporado** por decisión del Product Owner, aunque el tool-prompt pedía dejarlo afuera; el motivo está en `IA.SDD/SDD/Devs/Guides/Coherencia-Conformacion-Pull-Request-Automatico.md` |

Las unidades `Features/05` (consulta sin cambios), `08` (no aplicada), `14` (en edición) y `16` (prompt reutilizable) no tienen producto rastreable en el framework. `Features/01` es anterior a `IA.SDD`; `11` coincide por tema con la 4.1 y la 5.0, sin cita que lo pruebe; y `20` derivó en `Catalogado/02`. Los reportes `17` y `19` a `24` siguen abiertos y sin intervención asignada.

---

## Convenciones

- **Una carpeta por unidad de trabajo**, con prefijo de dos dígitos y nombre en Título-Con-Guiones: `NN-Verbo-Objeto`. Adentro, el tool-prompt; cuando la unidad tuvo varios turnos, una secuencia `00-`, `01-`, `02-`.
- **Subcarpetas de unidad**: `INPUTs/` para los insumos, `OUTPUTs/` para lo que produjo la corrida, `History/` para su registro.
- **Forma del tool-prompt**: `# Tool-Prompt — …`, la línea `> **Invocación**: Leer y ejecutar <ruta>` (en los más viejos, «Lee y ejecuta»), el `> **Overview**` y las secciones de contexto, objetivo, solicitudes y reglas. Las reglas que se repiten: no inventar información, toda afirmación respaldada por evidencia verificable y, en los que operan sobre otra cosa, no modificar el Framework SDD.
- **Quién escribe dónde**: el `.md` del prompt y los `INPUTs/` son del dueño. Un agente que ejecuta una unidad escribe en sus `OUTPUTs/`, y el cambio normativo, en `IA.SDD`.
- **Repositorio público**: los repositorios públicos se nombran; los privados, sus clientes y la infraestructura donde corren se ofuscan, como fija `IA.SDD/SDD/Devs/Rules/Expediente-Rules.md` §4 (S2). Antes de un push, barrer lo nuevo con ese criterio.

---

## Estado del árbol

- **Mudanza sin commitear.** Los prompts de `PROMPTs/Features/` y `PROMPTs/Fixs/` se movieron a `PROMPTs/DEVs/Features/` y `PROMPTs/DEVs/Fixs/`, sin cambios de contenido. Este README describe el árbol nuevo. Las líneas de invocación de los prompts, el `CHANGELOG.md` de los dos repositorios y los expedientes de `IA.SDD` siguen citando las rutas anteriores; como con el viejo `Feactures/`, son registro de dónde estaban al ejecutarse.
- **Nombres irregulares en las unidades viejas.** Hay subcarpetas `Hitory/`, `Historial/`, `Evidencias/` y `OUPUTs/` además de las canónicas, y `Features/17-Actualizar-Guides.md` es una carpeta. Se conservan como registro: quien busque por nombre, que busque también esas variantes.
- **Sin entrada en el `CHANGELOG.md`.** Los reportes `16` a `31` y las intervenciones `02` a `09` entraron por commits y pull requests, sin entrada propia. Su registro está en `Reportes/README.md`, en `PROMPTs/DEVs/Fixs/README.md` y en el `CHANGELOG.md` de `IA.SDD`.
