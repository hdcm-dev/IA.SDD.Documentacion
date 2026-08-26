# Tool-Prompt — Análisis y Fix de los reportes 12 a 14

> **Invocación**: Leer y ejecutar `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Fixs/01-Fix-Reportes-12-14/Fix-Analizar-Reportes-12-14.md`
>
> **Overview**: Análisis y Fix de los tres reportes que quedaron fuera del cierre de SDD 7.0

---

## Contexto

  Leer `/IA/SDD/IA.SDD/README.md`, trata sobre un `Framework SDD` (SDD, Spec-Driven Development) para especificar y codear por asistencia de IA.

  Los doce primeros reportes ya fueron aplicados sobre el framework en **SDD 7.0**, como una sola intervención. Estos **tres quedaron fuera de ese cierre** y siguen **para evaluación**, sin ninguna modificación aplicada:

  - `/IA/SDD/IA.SDD.Documentacion/Reportes/12-La-Compuerta-Declarada-Y-La-Compuerta-Ejecutada.md`

  - `/IA/SDD/IA.SDD.Documentacion/Reportes/13-El-Estrato-Del-Hallazgo-Y-La-Legitimidad-De-La-Detencion.md`

  - `/IA/SDD/IA.SDD.Documentacion/Reportes/14-El-Item-Obligatorio-Contestado-Con-Un-Diferimiento.md`

  Leer también `/IA/SDD/IA.SDD.Documentacion/Reportes/README.md`, que declara cómo se usa cada sección de un reporte dentro de un prompt de intervención, y `/IA/SDD/IA.SDD/CHANGELOG.md`, porque **parte de lo que los tres piden puede haber entrado ya** entre la 9.13 y la 9.19.

  **Los tres son del mismo eje y por eso se tratan juntos**: el método declara algo y no comprueba que haya ocurrido. El `12` lo dice de una compuerta que se declara y no se corre; el `13`, de un hallazgo que se clasifica por cómo se verifica y no por quién puede cerrarlo; el `14`, de un ítem obligatorio contestado con la promesa de contestarlo. Tratarlos por separado produciría tres mecanismos donde probablemente alcance uno.

---

## Objetivos

  Evaluar el `Framework SDD` en base a los tres reportes dados en el contexto para determinar un plan de correcciones y/o ajustes, y posteriormente aplicar dicho plan.

---

## Solicitudes

  1. Leer y evaluar [SDD User Guide].

  2. **Verificar primero qué ya está resuelto.** Cada reporte declara la versión del framework que evaluó —el `14` evaluó **SDD 9.19**— y el framework siguió publicando. Por cada propuesta de cada reporte, comprobar contra los archivos vivos si ya entró, y **declarar el resultado aunque sea que no entró**. Una intervención que reescribe lo que ya está hecho es peor que no haberla corrido.

  3. Analizar los tres reportes y catalogarlos agrupándolos en problemáticas comunes, **prestando atención a si los tres son el mismo hueco visto desde tres lugares**. Si lo son, el plan lo declara y propone **un** mecanismo, no tres.

  4. Por cada grupo, diagnosticar dónde se produce el fallo en base a las evidencias reportadas y a las reglas existentes. Ir generando resultados con las posibles correcciones junto con sus evidencias en `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Fixs/01-Fix-Reportes-12-14/OUTPUTs`, para luego utilizarlos en un plan de corrección unificado.

  5. Analizar todos los resultados extraídos en `OUTPUTs`, evaluar que las correcciones sean coherentes entre sí y con lo que la 9.13 a la 9.19 ya incorporaron, y generar un plan de aplicación.

  6. **Respetar lo que cada reporte declara que NO sabe.** Los tres tienen una sección de límites; el `14` declara que su medición es de **un** destino y que no propone la lista de ítems donde diferir sea ilegítimo. Esa lista es trabajo de esta intervención y **se construye mirando las quince reglas**, no se hereda del reporte.

  7. Aplicar el plan, y **corroborar y verificar que el plan aplicado se corresponda con el plan propuesto**.

  8. Verificar la corrección contra los criterios que cada reporte declara en su sección «cómo verificar que la corrección funcionó». El `14` aporta cuatro enumerables y uno interpretativo, y el decisivo es: **alguna compuerta levanta un ítem diferido cuyo evento de cierre ya ocurrió**. Sin eso, el lazo no cierra.

  9. Declarar el impacto sobre destinos existentes. Si la corrección vuelve visibles diferimientos ya vencidos, un destino con historia puede iluminar varios de golpe: **eso es una migración y no una regla nueva**, y el plan dice cuál de las dos cosas está proponiendo.

---

## Reglas

  - No inventar información.
  - Toda afirmación debe estar respaldada por evidencia verificable.
  - En base a las solicitudes, ordená las ideas mejorando ese plan en la edición de un nuevo prompt utilizando las mejores técnicas de prompting de la industria, incorporando las dos reglas dadas:
   ```
   - No inventar información.
   - Toda afirmación debe estar respaldada por evidencia verificable.
   ```
   y este prompt debe tomar todo lo dado en el contexto.
  - Ejecutar el prompt generado.
