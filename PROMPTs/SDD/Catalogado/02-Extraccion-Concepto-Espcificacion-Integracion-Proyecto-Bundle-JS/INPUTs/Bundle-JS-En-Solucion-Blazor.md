# Bundle JS dentro de una solución Blazor según el Framework SDD

**Versión:** 0.2
**Fecha:** 2026-09-13
**Estado:** en construcción (se amplía a medida que avanza la conversación de análisis)
**Upstream:** [`Extraccion-Concepto-Espcificacion-Integracion-Proyecto-Bundle-JS.md`](../Extraccion-Concepto-Espcificacion-Integracion-Proyecto-Bundle-JS.md)
**Framework analizado:** `/IA/SDD/IA.SDD/` (conjunto vigente, 13.15 según memoria de proyecto; verificar en `CHANGELOG.md`)

---

## 1. Hipótesis de trabajo

Un producto con una solución web Blazor que requiere un **bundle JavaScript** propio encargado de
mostrar un **mapa de asientos ocupados**. La pregunta es cómo queda el árbol del repositorio destino
aplicando el Framework SDD.

---

## 2. Conceptos del framework que deciden la respuesta

### 2.1 Dos ejes: unidad de entrega y proyecto de código

El producto se compone de **unidades de entrega** (lo que se despliega o publica) y se construye con
**proyectos de código** (lo que se compila). La relación es de muchos a muchos.

| Pregunta | Si la respuesta es sí |
|---|---|
| ¿Se despliega o se publica de forma independiente, y alguien lo consume directamente? | Es una unidad de entrega |
| ¿Produce un artefacto de compilación propio y declara sus propias dependencias? | Es un proyecto de código |

Evidencia: `SDD/Devs/Intake/PRODUCT-INTAKE-template.md` §13.

### 2.2 El tipo D8 es de la entrega, no del proyecto de código

Los ocho valores cerrados (`library`, `web-monolith`, `web-microservices`, `desktop-app`,
`mobile-app-maui`, `rest-api`, `cli-tool`, `worker-service`) son atributo de la unidad de entrega.
Los proyectos de código no llevan D8.

Evidencia: `README.md` invariante D8; `PRODUCT-MANIFEST-template.md` §2.A y §2.B;
`PRODUCT-INTAKE-template.md` §13.2.

### 2.3 Solución de código y grafos

- La tabla de proyectos de código se agrupa **por solución de código**; cada solución delimita un
  comando de construcción. Evidencia: `PRODUCT-MANIFEST-template.md` §2.B.
- *Solución de código* incluye explícitamente el *workspace* de npm. Evidencia:
  `SDD/Devs/Rules/Vocabulario-Rules.md` (tabla de términos, fila «Solución de código»).
- Hay dos grafos distintos: **integración** (runtime, ordena la generación de documentación) y
  **compilación** (ordena el build). Una dependencia entre soluciones distintas no es arista del
  grafo de compilación sino consumo de artefacto publicado. Evidencia:
  `PRODUCT-MANIFEST-template.md` §3 y control de cambios 5.0; `Master-Prompt.md` §3.5.

### 2.4 Layout de salida y casos de aplanado

El proyecto de código **no es un nivel de carpetas** de `SDD/Docs/`; se inventaría una sola vez en
`Producto/Vista-Producto.md`. Los casos de aplanado:

| Composición | Resultado |
|---|---|
| Una unidad de entrega | Categorías 02–11 directo bajo `SDD/Docs/` |
| Una unidad y un proyecto de código | Además desaparece el inventario del eje de construcción |
| Una unidad y varios proyectos de código | Directo bajo `SDD/Docs/`, pero `Producto/Vista-Producto.md` sí se emite |
| Varias unidades de entrega | Layout completo con `Unidades-Entrega/<Nombre>/` |

Evidencia: `SDD/Devs/Orchestrator/Master-Prompt.md` §3.5.

### 2.5 Nombres de código

`<Raiz-Codigo>.<Sufijo>`; sufijo orientativo `.Web` para `web-monolith`. Si la entrega es
`redistribuible: true`, el proyecto que la publica usa el prefijo de organización (`Aplicada` por
defecto) en lugar de la raíz. Evidencia: `PRODUCT-MANIFEST-template.md` §2.1;
`PRODUCT-INTAKE-template.md` §13.3 y §16.

### 2.6 Maqueta frente a producto

La maqueta de la Fase B2 es HTML, CSS y JavaScript vanilla sin proceso de build, en
`SDD/Maquetas/<Nombre>/`, hermana de `SDD/Docs/`. No es el producto. Evidencia:
`SDD/Devs/Rules/Maqueta-Rules.md` §4.1 y §7; `Master-Prompt.md` §3.5 y tabla de fases (fila B2).

---

## 3. Clasificación del bundle

El bundle (con `package.json` y su herramienta de empaquetado) produce un artefacto propio y declara
sus dependencias: **es un proyecto de código** (§2.1). Si además es unidad de entrega depende de un
único dato: si se publica por separado.

---

## 4. Caso A — el bundle viaja solo dentro de la app Blazor

- Unidad de entrega: `Mapa-De-Asientos`, `web-monolith`.
- Proyectos de código: `Teatro.Reservas.Web` (Blazor) y `Teatro.Reservas.MapaAsientos` (bundle JS).
  Los nombres `Teatro.Reservas.*` son ilustrativos: la `Raiz-Codigo` se declara en el intake.
- Caso de aplanado: una unidad y varios proyectos de código (§2.4).

```text
Mapa-De-Asientos/
├── AGENTS.md                              # emitido por la cat. 11 (Master-Prompt §3.5)
├── src/
│   ├── Teatro.Reservas.Web/               # Blazor; consume el bundle en wwwroot/js/
│   └── Teatro.Reservas.MapaAsientos/      # bundle JS: package.json, src/, build → dist/
├── tests/
│   ├── Teatro.Reservas.Web.Tests/
│   └── Teatro.Reservas.MapaAsientos.Tests/
├── samples/                               # web-monolith (Rules-Examples.md, tabla de /samples)
│   ├── 01-datos-seed/
│   └── 02-tema-custom/                    # solo si hay punto de extensión visual
└── SDD/
    ├── Intake/
    │   ├── PRODUCT-INTAKE-Mapa-De-Asientos.md
    │   └── PRODUCT-MANIFEST-Mapa-De-Asientos.md
    ├── Maquetas/
    │   └── Mapa-De-Asientos/              # Fase B2
    │       ├── index.html
    │       ├── assets/css/
    │       ├── assets/js/Datos-Maqueta.js
    │       ├── assets/js/Maqueta.js
    │       └── README.md
    └── Docs/
        ├── README.md
        ├── 00-Contexto/
        ├── 01-Necesidades-Negocio/
        ├── Producto/
        │   ├── Vista-Producto.md          # inventario de los dos proyectos y matriz de composición
        │   ├── 07-Plan-Sprint/
        │   └── 11-Documentacion/
        ├── 02-Especificacion-Funcional/
        ├── 03-UX-UI-DX/
        ├── 05-Arquitectura-Tecnica/
        ├── 06-Backlog-Tecnico/
        ├── 07-Plan-Sprint/
        ├── 08-Calidad-Y-Pruebas/
        ├── 09-Devops/
        ├── 10-Examples/
        ├── 11-Documentacion/
        └── Audit/
```

Observaciones:

1. `04-Prompts-AI/` se omite porque `usa_llm` es false. Evidencia: `Master-Prompt.md` §3.5.
2. Hay **dos soluciones de código** (el `.sln` y el workspace npm). La tabla del manifiesto se emite
   por solución, y el uso del `dist/` por `.Web` se declara como consumo de artefacto publicado, no
   como arista de compilación (§2.3).
3. `Pipeline-Producto.md` no se emite: es de nivel producto solo con más de un proyecto de código
   según la fila H de la tabla de fases, pero el caso de una sola unidad lo omite según §3.5.
   **Punto a verificar**: las dos fuentes no dicen lo mismo para este caso.
4. La base de conocimiento carga `Conocimiento/Knowledge-Template-Blazor-Interactive-Server-SDD-Default.md`
   si su condición de carga evalúa verdadera. Evidencia: `Master-Prompt.md` (nota «Base de
   conocimiento»); `Conocimiento/Index-Knowledge.md`. Ver PA-03.

---

## 5. Caso B — el bundle se publica aparte (paquete npm)

El bundle pasa a ser también unidad de entrega `library` con `redistribuible: true`:

- `src/Aplicada.MapaAsientos/` por el prefijo de organización (§2.5).
- Sin aplanado: `SDD/Docs/Unidades-Entrega/Mapa-De-Asientos/` y
  `SDD/Docs/Unidades-Entrega/Aplicada-Mapa-Asientos/`, cada una con 02–11.
- `Producto/Pipeline-Producto.md` se emite.
- La 09 de la library incluye `guia-publicacion-paquete-npm.md`. Evidencia: `Rules-Devops.md` §2.2.
- Samples de `library`: `01-basico-consola/`, `02-intermedio-con-extensiones/`,
  `03-avanzado-integracion-real/`. Evidencia: `Rules-Examples.md`.
- La 03 de la library es variante DX si `tiene_ui_final` es false. Evidencia: `Master-Prompt.md`,
  tabla de fases fila 03.

---

## 6. Juicio del analista (no es evidencia del framework)

- Mientras no exista un segundo consumidor del mapa, corresponde el caso A: el caso B duplica las
  categorías 02–11 para una entrega que nadie consume por separado.
- Incorporar el bundle al `.sln` como proyecto `.esproj` dejaría una sola solución de código y
  convertiría el consumo en arista de compilación. Esto **no está en el framework**: sería una
  decisión a registrar como ADR en la 05.

---

## 7. Preguntas abiertas

| Id | Pregunta | Estado |
|---|---|---|
| PA-01 | ¿Dónde fija el framework la estructura interna de un proyecto de código no .NET (carpetas, toolchain)? | Abierta |
| PA-02 | Divergencia sobre `Pipeline-Producto.md` en el caso de una unidad y varios proyectos (§4, obs. 3) | Abierta |
| PA-03 | Condición de carga del template Blazor en `Index-Knowledge.md` | **Resuelta**: «proyectos de código `web-monolith` sobre stack .NET con interfaz Blazor Web App en render mode Interactive Server, sin librería de componentes de terceros» (`Conocimiento/Index-Knowledge.md`, fila del alias). Carga para la unidad `web-monolith`, consumidores 03 y 05 |
| PA-04 | ¿El mapa (bundle + RCL) se declara unidad de entrega `library`, aunque no sea redistribuible? Decide si las dos PoC tienen lugar normativo (§8.3) | Abierta, decisión del PO |

---

## 8. Desarrollo del bundle: las dos PoC

### 8.1 Planteo del PO

El desarrollo del bundle se valida con dos pruebas de concepto:

1. **PoC HTML**: una página que, a través de un `main.js`, invoca los artefactos del bundle **como lo
   haría Blazor**, sin .NET.
2. **PoC Blazor**: un componente Blazor que consume los dos archivos JavaScript que produce el
   proyecto del bundle.

Se prevé además un **proyecto de clases de páginas Blazor** (Razor Class Library) que encapsula la
integración con esos dos JavaScript.

### 8.2 Qué dice el framework (evidencia)

- **El término «PoC» no existe en el conjunto normativo.** Búsqueda de `PoC`, «prueba de concepto» y
  *proof of concept* sobre el árbol vigente, excluido `_legacy/`: la única aparición es un documento
  de entrada de ejemplo (`Examples/New-Solution/.../INPUTs/Requerimientos-Tecnicos.md` §9, «PT-01 ·
  Fluidez del lienzo»), no una regla.
- **Lo más cercano en las reglas son tres figuras distintas:**

| Figura | Qué es | Evidencia |
|---|---|---|
| *Spike* | Ítem de backlog `BT` de tipo spike, con caja temporal; su salida alimenta una ADR y no decide por sí solo | `Rules-Backlog-Tecnico.md` (tipo de BT y ejemplo BT-00012); `Marco-Teorico-SDD.md` §6.6 |
| Maqueta (Fase B2) | HTML/CSS/JS vanilla **sin build**, con datos hardcodeados; valida experiencia y modelo de datos. No es el producto | `Maqueta-Rules.md` §1.2, §4.1, §7 |
| Sample | Código ejecutable en `/samples/NN-<Progresion>/` con dos aristas: A, referencia de integración; B, arnés de autovalidación con `Contrato de verificación`. Se genera en dos pasadas: diseño, pre-código, y ejecución, durante la codificación | `Rules-Examples.md` §0.1, §0.2, §4.6 |

- **La maqueta no es la PoC HTML.** No consume artefactos compilados y prohíbe el build salvo ADR
  (`Maqueta-Rules.md` §7). La PoC HTML consume el `dist/` del bundle.
- **Los samples dependen de la unidad de entrega**, no del proyecto de código. La obligación la
  decide `redistribuible`: obligatoria si es true, recomendada si es false y no hay portal de
  developers (`Rules-Examples.md` §0). Una `library` que viaja dentro de la publicación de otro
  proyecto no tiene integrador por gestor de paquetes (`Rules-Examples.md` §0).
- **Los samples tipo de `web-monolith`** son datos seed y tema custom (`Rules-Examples.md` §1.2,
  §2.2): ninguno es una PoC de integración de un componente.
- **Los samples tipo de `library`** son apps consumidoras progresivas: básico, intermedio y avanzado
  (`Rules-Examples.md` §1.2, §2.2).
- **La maqueta de una `library`** solo corresponde si es librería de componentes visuales, como
  catálogo navegable (`Maqueta-Rules.md` §1.2).

### 8.3 Encaje propuesto (juicio del analista, apoyado en §8.2)

Las dos PoC encajan como **samples de la categoría 10**, no como maqueta ni como spike. Para eso el
mapa tiene que ser una unidad de entrega: con el caso A de §4, donde el mapa es solo un proyecto de
código dentro de `web-monolith`, los samples de la categoría 10 serían los de la app y no los del mapa.

- **Unidad de entrega nueva**: `Mapa-Asientos`, `library` con `redistribuible: false`. Samples
  recomendados y declarados voluntariamente.
- **Proyectos de código que la componen**: el bundle JS y la RCL.
- **La app** `web-monolith` sigue igual y consume la RCL.

| PoC del PO | Sample | Arista A (qué ilustra) | Arista B (qué verifica) |
|---|---|---|---|
| PoC HTML | `samples/01-basico-html-sin-blazor/` | Cómo se invoca el módulo JS | Que el contrato JS (las funciones que la RCL invoca) responde igual sin .NET |
| PoC Blazor | `samples/02-intermedio-componente-blazor/` | Cómo se usa el componente en una app | Que la RCL carga los dos JS y el mapa refleja la ocupación |

Consecuencias:

- **El contrato JS del mapa es un contrato de compilación** entre el bundle y la RCL
  (`PRODUCT-INTAKE-template.md` §14). Vive en la 05 de la unidad `Mapa-Asientos`. Las dos PoC lo
  verifican desde lados distintos: por eso tienen sentido las dos y no una sola.
- **El `main.js` de la PoC HTML tiene que imitar las invocaciones que hace la RCL**, no una API
  propia. Si divergen, la PoC HTML deja de probar lo que usa Blazor. Es la misma razón por la que
  `Rules-Examples.md` §0.1 prohíbe partir el sample en una versión ilustrativa y otra verificable.
- **Con esta composición el caso A de §4 se reemplaza por dos unidades de entrega** (`web-monolith` y
  `library`), lo que implica el layout completo con `Unidades-Entrega/`. El caso B de §5 sigue
  separado: es el mismo layout con `redistribuible: true` y publicación a un gestor de paquetes.

### 8.4 Árbol del código resultante

Los nombres `Teatro.Reservas.*` son ilustrativos. El sufijo de la RCL no está en el mapa orientativo
de sufijos, que no es cerrado (`PRODUCT-MANIFEST-template.md` §2.1).

```text
src/
├── Teatro.Reservas.MapaAsientos/           # proyecto de código JS (workspace npm)
│   ├── package.json
│   ├── src/
│   └── dist/                               # los dos artefactos JavaScript
├── Teatro.Reservas.MapaAsientos.Blazor/    # RCL (solución .NET): componente e interop con los dos JS
│   ├── MapaAsientos.razor
│   ├── MapaAsientos.razor.cs
│   └── wwwroot/js/                         # recibe el dist/ del bundle
└── Teatro.Reservas.Web/                    # web-monolith; referencia la RCL
samples/
├── 01-basico-html-sin-blazor/              # PoC HTML: index.html + main.js sobre dist/
└── 02-intermedio-componente-blazor/        # PoC Blazor: app mínima con el componente
tests/
├── Teatro.Reservas.MapaAsientos.Tests/
└── Teatro.Reservas.MapaAsientos.Blazor.Tests/
```

Grafos:

- **Compilación, dentro del `.sln`**: `Web → MapaAsientos.Blazor`.
- **Entre el workspace npm y la RCL**: consumo de artefacto publicado, no arista
  (`PRODUCT-MANIFEST-template.md` §3).
- **Orden de build**: bundle → RCL → Web (`Rules-Devops.md`, orden topológico).

---

## Control de cambios

| Versión | Fecha | Cambio |
|---|---|---|
| 0.1 | 2026-09-13 | Primera versión: clasificación del bundle, casos A y B, árbol del repositorio destino |
| 0.2 | 2026-09-13 | §8: las dos PoC del bundle. El término no existe en el framework; encaje como samples de la categoría 10 de una unidad `library` no redistribuible con bundle JS y RCL. PA-03 resuelta; se abre PA-04 |
