# Tool-Prompt — Crear etapa preplanificadora

> **Invocación**: Leer y ejecutar `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Features/18-Migracion-Planificacion/Crear-Estapa-Pre-Planificadora-Migracion.md`
>
> **Overview**:  Introducir una etapa integral preplanificadora en `Framework SDD` antes de empezar a migrar

---

## Contexto

  Leer `/IA/SDD/IA.SDD/README.md` trata sobre un `Framework SDD`.

  Leer y no ejecutar `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Features/18-Migracion-Planificacion/INPUTs/Mesa-Evaluadora.md`, es un promp que trata sobre una `Comisión de análisis de tratamiento de problemas` o `Mesa evaluadora`, y que propone una lógica de tratamiento muy eficaz para resolver problemas complejos.

  Actualmente tanto el script que reanuda el proceso del `Framework SDD` propone al iniciar `reanudar`(`/IA/SDD/IA.SDD/PROMPTS/PROMPT-Agente-Reanudacion-SDD.md`), que lleva a reanudar, continuar o `migrar` (`/IA/SDD/IA.SDD/PROMPTS/PROMPT-Agente-Migracion-SDD.md`), etc.

  En todas estas etapas, en especial la de reparar , migrar o continuar, le falta integrar un prompt que evalue la situación actual, planifique y luego trate las incongruencias o temas complejos que van surgiendo al aplicar o al hacer una evaluación previa de implicancias sobre la aplicación del plan, tratamiento y corrección previa ante de aplicar el plan de reparación o evaluación. 

  Actualmente entra en rondas solicitando o consultando sobre temas que se suponen que ya fueron resueltas previo a entrar en un reanudar el proceso, haciendo consultas que realmente el agente IA debería poder resolver por si solo por no tener un contexto bien preanlizado, y por no tener un entorno de analisis y debate para encontrar las decisiones y como se resolvieron sus cuestiones. El framework no hace una mirada analÍtica y estrategica completa de la especificación/implementación ya existente del producto actual antes de retomarlo. 

---

## Objetivos

  Introducir el concepto planteado en `Mesa evaluadora`como motor de orquestación en el caso de reanudar ante un proyecto ya existente, previo a reparar, migrar , o continuar.

---

## Solicitudes

  1. Evaluar el prompt de reanudar y el de migración de `Framework`, evaluar el concepto propuesto por el prompt `Mesa evaluadora` e integrar dicho prompt como parte del motor de orquestación de la migración/reparar/continuar según el contexto planteado y los objetivos planteados.

  2. Determinar en que momento conviene aplicar correctamente la mesa evaluadora `Mesa evaluadora` como un recurso previo a evaluar el proyecto para componer el plan a aplicar, o bien crear y aprobar un plan de migración durante la etapa de migración. La idea viene a que creo que es necesario encontrar un concenso de expertos antes de generar un plan de cambios y o ante el analisis de problemas, valiendo de reportes individuales y la conformación de emesas de evaluación y aplicación de decisiones por concenso como tambien la refutación por parte de agentes especializados en el tema. Podes usar este prompt `Mesa evaluadora` para tratar esta idea que te propongo en este prompt. Podés consultar informes y casos que ya haya aplicado este `Framework SDD`

---

## Reglas

  - No inventar información. 
  - Toda afirmación debe estar respaldada por evidencia verificable.
