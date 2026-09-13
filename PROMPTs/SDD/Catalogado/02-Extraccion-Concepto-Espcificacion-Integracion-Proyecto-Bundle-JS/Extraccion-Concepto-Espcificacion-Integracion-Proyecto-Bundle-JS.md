# Tool-Prompt — Extracción de comportamientos. 

> **Invocación**: Leer y ejecutar `/IA/SDD/IA.SDD.Documentacion/PROMPTs/SDD/Catalogado/02-Extraccion-Concepto-Espcificacion-Integracion-Proyecto-Bundle-JS/Extraccion-Concepto-Espcificacion-Integracion-Proyecto-Bundle-JS.md`
>
> **Overview**:  Extracción de comportamientos como base de conocimiento en  diseño de bundle javascript .

---

## Contexto

  Leer `/IA/SDD/IA.SDD/README.md`, trata sobre `Framework SDD`.

  Leer `/IA/SDD/IA.SDD/Conocimiento/README.md`, trata sobre la `estructura de como se guarda en la base de conocimientos desacoplada` sobre procedimientos y forma de hacer las cosas que pueden estar al alcance de los requerimientos necesarios por parte del desarrollo del diseño por especificación.

  Leer `/IA/SDD/IA.SDD.Documentacion/PROMPTs/SDD/Catalogado/02-Extraccion-Concepto-Espcificacion-Integracion-Proyecto-Bundle-JS/INPUTs/Bundle-JS-En-Solucion-Blazor.md`, trata sobre `Desarrollo de proyectos No .NET` y cuenta sobre como se esta trabajando con proyectos no .NET que estan fuera del arbol de la solución .NET. con el caso concreto de bundle javascript.

  Actualmente es necesario **Generar conocimiento sobre aspectos constructivos, constitutivos y metologicos de una solución .NET en lo que respecta a como se va a diseñar, integrar y desarrollar en conjunto con otros proyectos en otras tecnologías no .NET dentro del árbol de solución de visualstudio .NET** con el fin de transmitir el conocimiento a otros Frameworks SDD similares pero con diferente forma estructurar sus soluciones y proyectos .NET. En esta base de conocimiento a generar es neceario extraer tambien **el como se genera la base contractual entre los diferentes artefactos generados** y **como se esctructuran y relacionan estos artefactos entre si con los demas artefactos de origen .NET** durante la fase de desarrollo e integración con los proyectos .NET.  Para dar un ejemplo breve de este parrafo, para un requerimiento particular de necesitar mostrar una visualización gráfica que requiera manejos especializados en la intereración para con el navegador web, blazor aquí no siempre puede cumplir con esto, y se requiere muchas veces código javascript para lograr siertas funcionalidades visuales, y tambien en la que puede requerir integrar apis javascirpt externas (como es el caso de googlemaps), y deriva en contar con artefactos javascript en el que se le pasan los datos definidos por DTOs y este artefacto opera sobre la visualización independizandose de los por menores propios de la logica de negocio y presentación especifica del sistema general solicitado (en nuestro caso .NET). Un ejemplo sería, en resumen, que podría representar un mapa de ocupación de sillas, las aplicaciones blazor arman un json con los datos llaman a traves de métodos de un main.js a un bundle javascript el cual se encargará de pintar en la pantalla o bien registrar callback blazor en la clase de interfaz en main.js para luego cuando el bundle.js dispare dichos callback ante eventos propio de la interacción del cliente con el DOM. Esta tematica se amplia en `Desarrollo de proyectos No .NET`.


---

## Objetivos

  Especificar sobre como diseñar e integrar proyectos agenos a .NET dentro del arbol de solución de .NET. 
  Especificar metodologías de desarrollo para proyectos agenos .NET integrados en el marco de desarrollo, integración, autoajuste por parte de agentes IA en las fases de especifición, implementación mediante código, diagnostico de detección de errores y evaluación de diseño de contratos. Todo esto deberá ser útil en las fases de autoajustes de contratos, o diangosticos de fallas de contratos por parte de los agentes.

---

## Solicitudes

  Teniendo en cuenta quiero que generes un documento como dicta: `estructura de como se guarda en la base de conocimientos desacoplada`, con la base de conocimiento a como el `framework SDD` en como se resuelve proyectos agenos a .NET bajo el arbol de una solución .NET, en este caso particular sobre la diseño, implementación e integración de bundles javascritps y toda la métologia que abarcan la naturaleza de dichos proyectos no .NET:

  Generá un documento con el conocimiento estructurado que capture la metodología de diseño, estructuración de los proyectos no .NET dentro del árbol de la solución .NET, estilos y formas de codificación, formas de establecer contratos entre los diferentes entornos e integración de los mismos, diagnostico y evaluación apoyados mediante proyectos PoC (Proof of Concept). El objetivo debe estar pensado para que los agentes IA, bajo sus especialidades y tareas asignadas puedan guiarse en la ejecuión de este tipo de casos particualres tal como si lo hicie un agente humano según lo que dicta el `Framework SDD` en lo que se ha descripto en el contexto.  Catalogalo a este conocimiento como: `Bundle-JS`.

  Es muy importante, que el documento de conocimiento generado no debe dictar como se estructura la solución .NET, no debe condicionar el framework destino en cautno a como se debe estructurar la solución .NET, sino debe instrurir al agente como integrar soluciones no .NET en el árbol de solución de .NET, asegurando que los agentes especializados, según que tarea desempeñen, sobrelleven de manera efectiva y fiel las tareas de diseño e integracion del bundle javascript. En resumen y según lo que dicta `Framework SDD`, los agentes deberan ser capaces de:
  - **Crear el proyecto bundle javascript**, en typescript, javascript, etc siguiendo como se describe el `Framework SDD` para resolver la funcionalidad demandada. Este arrojará dos artefactos: main.js y el bundle javascript, repspetando metodos ,clases y objetivos de cada elemento de programación utilizado
  - **Crear la PoC HTML** - bajo la estructura que dicta  `Framework SDD`  y que es útil para los agentes que luego van a implementar el main.js y el bundle javascript dentro de la libreria de clases blazor .net , pero también para los agentes que debe diagnosticar y testear fallos.
  - **Crear la libreria de clases .NET Blazor**, que será quien integre el main.js y el bundle javascript. Este en un futuro puede llegar a convertir en un nuget para compartir con otros proyectos, pero ahora queda fuera del alcance este objetivo de convertirse en un nuget.
  - **Crear la PoC Blazor .NET** para integrar la libreria de clases .NET Blazor, la finalidad es la misma que la PoC HTML enfocada a la diagnosticación, diseño relativo a la integración de los artefactos javascript con las proyectos .NET.

  Doy un ejemplo de como no interferir en cuanto al framework maneja sus propio saber de estructurar los proyectos .net. con esto: Si otro framework consume este documento de conocimiento, y este framework estructura sus PoC en una carpeta `/demos` no debería el documento de conocimiento condicionar a que ese framework ubique los proyectos PoC en otra carpeta comos sería `/samples`.

  Este documento markdown de base de conocimiento, no quiero que quede incorporado directamente en el repositorio del `Framework SDD`, y se genere interdependencia o acoplamiento en ambos sentidos (Framework vs base de conocimeinto), así que dejalo en `/IA/SDD/IA.SDD.Documentacion/PROMPTs/SDD/Catalogado/02-Extraccion-Concepto-Espcificacion-Integracion-Proyecto-Bundle-JS/OUTPUTs`, así luego el cliente que use `Framework SDD` sume dichos documentos en su fork de este framework o lo incopore a su propio framework SDD.

  Basate en `/IA/PROMPTs/IA.Prompts/Base/Mesa-Evaluadora.md` para organizar una mesa evaluadora, y planificadora para relevar caracteristicas, clasificarlas, estructurarlas y clasificarlas adecuadamente y transcribirlas. Incopora los especialista necesarios, dales toda la autoridad para tomar decisiones necesarias para cumplir con los objetivos y/o necesidades demandadas. Que la mesa evaluadora levante un expediente dentro de una carpeta nuemrada  en `/IA/SDD/IA.SDD/Expedientes`, en cuanto a la carpeta del expediente, fijate los expedientes que hay para seguir la misma nomenclatura de nombrado de dicha carpeta.

---

## Reglas

  - No inventar información. 
  - Toda afirmación debe estar respaldada por evidencia verificable.
  - No modificar el `Framework SDD`