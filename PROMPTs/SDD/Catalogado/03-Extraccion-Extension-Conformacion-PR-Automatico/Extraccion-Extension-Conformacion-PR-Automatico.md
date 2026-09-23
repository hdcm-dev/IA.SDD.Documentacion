# Tool-Prompt — Extracción de comportamientos. 

> **Invocación**: Leer y ejecutar `/IA/SDD/IA.SDD.Documentacion/PROMPTs/SDD/Catalogado/03-Extraccion-Extension-Conformacion-PR-Automatico/Extraccion-Extension-Conformacion-PR-Automatico.md`
>
> **Overview**:  Extracción de comportamientos y/o extension como base de conocimiento sobre la conformación de los pullrequest de forma automática sin interversión de agentes humanos

---

## Contexto

  Leer `/IA/SDD/IA.SDD/README.md`, trata sobre `Framework SDD`.

  Leer `/IA/SDD/IA.SDD/Conocimiento/README.md`, trata sobre la `estructura de como se guarda en la base de conocimientos desacoplada` sobre procedimientos y forma de hacer las cosas que pueden estar al alcance de los requerimientos necesarios por parte del desarrollo del diseño por especificación.

  Leer `/IA/SDD/IA.SDD/Conocimiento/Knowledge-Conformacion-Pull-Request-Manual.md`, es un ejemplo de conocimiento actual donde el pull request se hace de forma manual, el agente IA lanza el enlace con el pull request, el agente humano hace el merge y delete de la rama en github y le avisa al agente ia, y el agente ia continua.

  Actualmente es necesario **Generar conocimientos similares pero el flujo debe ser totalmente automatico, realizado por el agente IA orquestador**.


---

## Objetivos

  Especificar el conocimiento sobre la conformación de los pullrequest de forma automática sin interversión de agentes humanos

---

## Solicitudes

  Teniendo en cuenta quiero que generes dos documentos como dicta: `estructura de como se guarda en la base de conocimientos desacoplada`, con la base de conocimiento en base a los proyectos dados en el contexto, extrayendo como se conforman los pullrequest de forma automática sin intervensión de agentes humandos.

  El objetivo debe estar pensado para que un agente IA pueda ejecutar la conformación del pullrequest sin intervención del agente humano tal como si los hiciesen ahora los agentes orquestadores del `Framework SDD`. Catalogalo a este como: `Conformacion-Pull-Request-Automatico` 

  Intenta extraer, catalogar y estructurar lo mejor que puedas la conformación del pull request de forma automática de tal manera que cuando los agentes orquestadores lancen el pullrequest, muestre el informe con su enlace al pullrequest iniciado como se hace `Conformacion-Pull-Request-Manual` pero ellos hagan el merge del PR y el delete de la rama asociada al PR remota en GitHub, y luego preparen el repositorio local para seguir con las proximas tareas y sigan sin intervención del agente humando. Hacelo de forma similar llegando a algo como se llegó con el catalogado para la `Conformacion-Pull-Request-Manual`. No dudes en incluir ejemplos y lo necesarios para que los agentes IA interprenten adecuadamente lo logrado y lo que se quiere lograr.

  Este documento, no quiero que quede incorporado directamente en el repositorio del `Framework SDD`, y se genere interdependencia o acoplamiento, así que dejalos en `/IA/SDD/IA.SDD.Documentacion/PROMPTs/SDD/Catalogado/03-Extraccion-Extension-Conformacion-PR-Automatico/OUTPUTs`, así luego el cliente que use `Framework SDD` sume dicho documento en su fork de este framework o lo incopore a su propio framework SDD.
  
  Basate en `/IA/PROMPTs/IA.Prompts/Base/Mesa-Evaluadora.md` para organizar una mesa evaluadora, y planificadora para relevar caracteristicas, clasificarlas, estructurarlas y clasificarlas adecuadamente y transcribirlas. Incopora los especialista necesarios, dales toda la autoridad para tomar decisiones necesarias para cumplir con los objetivos y/o necesidades demandadas.

---

## Reglas

  - No inventar información. 
  - Toda afirmación debe estar respaldada por evidencia verificable.
  - No modificar el `Framework SDD`