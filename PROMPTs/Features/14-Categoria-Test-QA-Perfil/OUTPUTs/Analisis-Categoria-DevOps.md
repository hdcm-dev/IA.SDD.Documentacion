# Análisis — Alcance de la categoría DevOps en el Framework SDD

**Documento:** Analisis-Categoria-DevOps.md
**Versión:** 1.13
**Estado:** Borrador
**Fecha:** 2026-08-16
**Origen:** `PROMPTs/Features/14-Categoria-Test-QA-Perfil/01-Crear-Debate-Categoria-DevOps.md`
**Naturaleza:** documento de análisis y debate. No es normativo. Su destino es servir de guía a un prompt posterior sobre el `Framework SDD`.

---

## Tabla de contenido

- [1. Qué se debate](#1-qué-se-debate)
- [2. Lo que el framework ya resuelve](#2-lo-que-el-framework-ya-resuelve)
- [3. Los tres huecos reales](#3-los-tres-huecos-reales)
- [4. El debate: dónde vive lo ejecutable](#4-el-debate-dónde-vive-lo-ejecutable)
- [5. Propuesta de materialización](#5-propuesta-de-materialización)
- [6. QA y testing: qué cambia](#6-qa-y-testing-qué-cambia)
- [7. Impacto normativo](#7-impacto-normativo)
- [8. Decisiones](#8-decisiones)
- [9. Anti-patrones propuestos](#9-anti-patrones-propuestos)
- [10. Evidencia consultada](#10-evidencia-consultada)
- [Control de cambios](#control-de-cambios)

---

## 1. Qué se debate

El planteo del contexto es: cuando el Framework SDD termina de correr sobre un producto nuevo, queda un repositorio con el software codeado, y el despliegue se hace aparte. Falta entender la categoría DevOps sobre dos ejes, despliegue y QA/testing, sabiendo que el framework cubre ocho tipos de entrega distintos: para un servicio API, web o front el artefacto es un Dockerfile que después se despliega con docker-compose; para una librería el artefacto es un workflow de publicación en GitHub o en un registro de paquetes; y los workflows de E2E dependen de si el runner tiene o no acceso a IA.

El debate no es «qué le falta a la categoría 09». Es más preciso que eso, y conviene enunciarlo así porque cambia la respuesta:

> La categoría 09 declara **política** completa y correcta. Lo que ningún artefacto del framework produce hoy es el **archivo ejecutable** que materializa esa política. Y lo mismo pasa en la 08 con la batería de tests.

Las tres afirmaciones del contexto —Dockerfile, workflow de publicación, workflow de E2E— caen las tres del mismo lado de esa frontera: son archivos ejecutables. La discusión, entonces, es una sola y no tres.

Dos precisiones que llegaron después del planteo inicial y que acotan el alcance:

- **El framework no emite compose.** El despliegue se separa en su propio repositorio y su propia instancia; el corte queda en el `Dockerfile`. Decisión del PO, fundamentada en §5.3.
- **Al terminar el proyecto tiene que quedar el planteo de los fuentes de test**, con estructura suficiente para escalar a medida que escala el proyecto fuente. Es un requisito de forma, no solo de existencia, y se resuelve en §5.4.

---

## 2. Lo que el framework ya resuelve

Antes de proponer nada conviene inventariar qué está resuelto, porque buena parte de la tensión que el contexto plantea ya tiene respuesta normativa escrita.

### 2.1 Publicar no es desplegar, y está declarado

La distinción que el contexto plantea entre «librería que se publica» y «servicio que se despliega» es exactamente la que `Rules-Devops.md` §2.2 fija por tipo D8: canales `preview`/`stable` sobre feed único para `library` y `cli-tool`; `DEV`/`QA`/`STAGING`/`PROD` para `web-monolith`, `web-microservices`, `rest-api` y `worker-service`; canales más ambiente interno para `desktop-app` y `mobile-app-maui`. Confundirlas está tipificado como anti-patrón en §4.8 («Confundir publicación con despliegue»), y §0 lo declara como uno de los tres déficits del fuente SDD 1.0 que la categoría corrige.

La misma tabla ya asigna el tipo de artefacto publicable: `image-docker` para los desplegables, `paquete-<gestor>` para las librerías, `binarios-github-releases` para CLI. El eje del contexto está cubierto **a nivel de política**.

### 2.2 La categoría opera en dos niveles, y el segundo es donde vive lo transversal

`Rules-Devops.md` §0 y §4.9: se construye por proyecto de código y se publica por unidad de entrega, y para productos con más de una unidad de entrega existe `Pipeline-Producto.md`, cuyo punto 6 es un **gate de integración de producto**, definido como «smoke test del producto levantada con sus artefactos». Ese es el lugar normativo donde encaja el E2E que cruza entregas, y ya existe. No hay que inventarlo.

### 2.3 Las fronteras entre categorías están escritas

- 08 → 09: `Rules-Calidad-Y-Pruebas.md` §1.3 y `Rules-Devops.md` §5.1 —los quality gates se definen en 08 y se **ejecutan** como stages en 09; la DoD no se redefine en 09.
- 09 → 11: `Rules-Devops.md` §0 —09 documenta la política (ambientes, promoción, firma); 11 documenta el procedimiento verificado sobre el sistema construido. Ante contradicción, rige 09.
- Ninguna categoría emite un artefacto de otra: `Master-Prompt.md` §6, punto 4, y es hallazgo P0 del audit de fase.

Estas tres fronteras condicionan cualquier propuesta: lo que se agregue tiene que tener dueño único y no puede duplicar contenido de otra categoría.

---

## 3. Los tres huecos reales

### 3.1 Hueco 1 — La categoría 09 no emite ningún artefacto ejecutable

La tabla maestra de `Rules-Devops.md` §2.1 lista seis artefactos y los seis son `.md`: `pipeline-ci-cd.md`, `estrategia-versionado.md`, `entornos-deploy.md`, `guia-publicacion-<tipo-artefacto>.md`, `supply-chain-seguridad.md` y el `README.md` de sección. `pipeline-ci-cd.md` §4.2 describe stages, matriz de SO y runtime, caché, promotion rules y rollback —en prosa y tablas—. No existe en ninguna parte del framework la emisión de un `Dockerfile`, de un `docker-compose.yml` ni de un `.github/workflows/*.yml`.

La consecuencia es literalmente la que el contexto describe: «el despliegue lo hago aparte». No es una omisión del operador; es lo que el framework especifica hoy.

Vale registrar el contraste, porque es el que habilita la salida: **el framework sí emite artefactos ejecutables en otras dos fases**. La Fase B2 emite una maqueta navegable con `index.html`, `assets/css/`, `assets/js/Datos-Maqueta.js` (`Master-Prompt.md` §6, fila B2). La Fase G esqueleta `/samples` y la Fase I los implementa y los corre (§6, filas G e I). El precedente existe y está probado dentro del framework.

### 3.2 Hueco 2 — Nadie es dueño de escribir los tests, y una precondición dura ya los exige

`Rules-Calidad-Y-Pruebas.md` §2.1 emite siete `.md` más la matriz de sensado. `casos-prueba-referenciales.md` §4.6 cataloga `TC-XXXXX` con setup, pasos, expected output, **actual output** y status. El campo «actual output» solo puede completarse ejecutando un test que alguien tuvo que escribir, y ninguna fase del plan de `Master-Prompt.md` §6 lo produce.

El hueco se vuelve bloqueante en un punto concreto y verificable: `Master-Prompt.md` §7.1 declara como precondición dura de la Fase I que «los tests corren», verificado ejecutando «el comando de test declarado en la categoría 08». La 08 declara el tooling (§4.3 punto 3) pero no produce el proyecto de tests ni el comando existe hasta que alguien lo escribe. **El framework exige, para entrar al tramo II, un artefacto que su tramo I no produce y que ninguna fase declara como suyo.**

Esto reordena la secuencia que el contexto plantea. El contexto dice «termina de codearse el proyecto, luego se crearía la batería de testing E2E y pruebas unitarias». El framework, en cambio, ubica la 08 en la Fase E y la 09 en la Fase F, las dos **antes** del handoff a codificación de §12. No hay contradicción si se separan dos cosas que hoy están mezcladas:

| Momento | Qué se produce | Fase | Estado de la evidencia |
| --- | --- | --- | --- |
| Especificación | Estrategia de testing, pirámide, TC referenciales, DoD, política de pipeline | E y F, pre-handoff | Sin evidencia: el sistema no existe (`Master-Prompt.md` §7) |
| Materialización | Proyecto de tests, workflows, Dockerfile, suite E2E corriendo | Post-handoff, tramo II | Con evidencia real de ejecución (D9) |

La secuencia del contexto y la del framework describen los dos momentos del mismo eje. Lo que falta no es reordenar fases: es declarar que el segundo momento existe y quién lo ejecuta.

### 3.3 Hueco 3 — El runner no es un recurso declarado, y su capacidad de IA no es un flag

`Rules-Devops.md` §4.2 punto 2 pide «matriz de SO y runtime», que es una propiedad del software. El banco de pruebas `<banco-privado-de-pruebas-e2e>` muestra que en un runner propio hay decisiones que no son ni SO ni runtime y que rompen el pipeline si no están declaradas:

- **Etiquetas de runner.** Los dos workflows corren sobre `[self-hosted, i7infra-dev]`.
- **Caché que sobrevive al contenedor efímero.** Chromium sale de `/cache/ms-playwright` vía `PLAYWRIGHT_BROWSERS_PATH`; sin eso, cada corrida reinstala el navegador.
- **Alcanzabilidad de red.** El servicio de IA es `http://my-ai-api:11434` **desde el runner**, no la IP del host: el runner está en una macvlan y no puede hablar con la IP de su propio host.
- **Capacidad de hardware.** Host sin AVX2 ni FMA y sin GPU, inferencia 100 % CPU, con piso de ruido del 10–15 %.

Ninguna de las cuatro tiene lugar declarado en la categoría 09, y las cuatro son propiedades del **entorno de construcción**, no del producto que se especifica. El intake no tiene hoy dónde ponerlas: §17 P.8 pregunta por la plataforma de CI, pero lo hace por unidad de entrega, que es el nivel equivocado para un recurso compartido.

La disponibilidad del servicio de IA, además, es lo que el contexto identifica como condicionante de los workflows de E2E. La resolución de las dos cosas —el recurso y la decisión de usarlo— está en §6.2.

---

## 4. El debate: dónde vive lo ejecutable

Tres posiciones, con lo que cada una cuesta.

### 4.1 Posición A — Categoría nueva, `12-Entrega-Ejecutable`

**A favor.** Separa limpio lo declarativo de lo ejecutable. Un dueño único para Dockerfile, compose, workflows y proyecto de tests.

**En contra, y es decisivo.** El `README.md` del framework, en «Reglas de intervención», tipifica agregar una categoría documental como cambio **major** que obliga a tocar en la misma intervención el master-prompt, `Root-Rules.md` y la guía de usuario. Y rompe las fronteras del §2.3: el Dockerfile materializa la política de 09 y el proyecto de tests materializa la estrategia de 08; ponerlos en una categoría tercera crea un dueño que no es el autor de la política que ejecuta, con la duplicación garantizada que eso trae. El framework ya vivió ese problema y lo tipificó: `Rules-Calidad-Y-Pruebas.md` §3.2, versión 3.2 del control de cambios, documenta el caso del `Acuerdo-Equipo.md` que «cayó en el hueco entre dos reglas y produjo una segunda fuente».

### 4.2 Posición B — Dos pasadas dentro de 08 y 09, con el modelo de la categoría 10

**A favor.** El framework ya tiene resuelto exactamente este problema y en un caso análogo. La categoría 10 emite en la Fase G una **pasada de diseño** —el ejemplo documentado, su contrato de verificación `VER-XXXXX` y su `evidencia` en `No verificado — sin código`— y en la Fase I una **pasada de ejecución** que implementa el sample, lo corre y sobrescribe el campo `evidencia` con la salida real (`Master-Prompt.md` §6, filas G e I, y §7.2). El mecanismo es reutilizable tal cual: la 09 emite su política en la Fase F y su materialización en el tramo II, con el mismo campo de evidencia y el mismo dueño (AG-09). Nada de duplicación, nada de dueño nuevo, y D9 queda satisfecha sin excepciones —un workflow emitido y nunca corrido se declara no verificado, igual que un sample esqueletado—.

**En contra.** Sube major las dos reglas y toca el master-prompt. Es costo real, pero es el costo de cualquier opción que cierre el hueco.

### 4.3 Posición C — Dejarlo fuera de alcance

**A favor.** Es el estado actual y es defendible: SDD se define como framework de especificación, y el `README.md` declara su unidad de trabajo como la documentación viva del producto.

**En contra, y es lo que vuelve insostenible la posición.** No es coherente con el propio framework, que ya cruzó esa frontera dos veces —maqueta ejecutable en B2, samples ejecutados en I— y que en §7.1 **exige tests corriendo** como precondición dura. Si SDD fuera solo especificación, §7.1 no podría pedir la ejecución de un comando de test. La frontera ya está cruzada; lo que falta es declararla.

### 4.4 Veredicto

**Posición B.** El framework tiene el mecanismo, el precedente y el dueño. El hueco no es de arquitectura: es de declaración.

---

## 5. Propuesta de materialización

### 5.1 El modelo de dos pasadas aplicado a 08 y 09

| Categoría | Pasada de diseño (pre-handoff) | Pasada de ejecución (tramo II) |
| --- | --- | --- |
| 08 | Los siete `.md` actuales, sin cambios. `casos-prueba-referenciales.md` declara cada `TC-XXXXX` con `actual output` en `No verificado — sin código` | Proyectos de tests con la estructura de §5.4 y al menos un test vivo por capa; suite corriendo; `actual output` y `status` con la salida real y su fecha |
| 09 | Los cinco `.md` actuales, sin cambios, más el **esqueleto** de los archivos ejecutables con su contrato de verificación | Archivos ejecutables completos; workflow corrido al menos una vez; evidencia de la corrida |

La regla de evidencia se toma literal de `Rules-Examples.md` §0.2 y de `Master-Prompt.md` §7.2: el campo `evidencia` se sobrescribe con la salida real de la corrida en curso y la anterior no se conserva.

Una consecuencia que hay que aceptar explícitamente: con esto, la precondición dura de §7.1 pasa a ser **producto de la pasada de ejecución de la 08**, no un supuesto sobre el repositorio. Hoy §7.1 verifica algo que nadie produce; con la propuesta, verifica el resultado de una fase declarada.

### 5.2 Matriz de artefacto ejecutable por tipo de unidad de entrega

Es el mapeo directo de la tabla de política de `Rules-Devops.md` §2.2 a su archivo ejecutable. Responde en una tabla la pregunta del contexto sobre «si es servicio, Dockerfile; si es librería, workflow de publicación».

| `tipo_unidad_entrega` | Artefacto ejecutable de build | Artefacto ejecutable de publicación | Proyecto de tests | Despliegue de instancia |
| --- | --- | --- | --- | --- |
| library | — | Workflow de publicación al gestor del runtime, disparado por tag | Unitario + contract | No aplica: se publica, no se despliega |
| web-monolith | `Dockerfile` | Workflow de build y push de imagen | Unitario + E2E de navegador | Repositorio de despliegue propio (§5.3) |
| web-microservices | Un `Dockerfile` por servicio | Workflow de build y push, más chart o kustomize | Unitario + contract por servicio | Repositorio de despliegue propio |
| desktop-app | Script de empaquetado del instalador | Workflow de firma y publicación por canal | Unitario + UI | No aplica |
| mobile-app-maui | Script de empaquetado | Workflow de publicación a store, con gate manual por credenciales | Unitario + UI | No aplica |
| rest-api | `Dockerfile` | Workflow de build y push, más publicación del OpenAPI versionado | Unitario + contract sobre OpenAPI | Repositorio de despliegue propio |
| cli-tool | Matriz de compilación multi-OS | Workflow de release con binarios, checksum y firma | Unitario + snapshot de stdout/exit code | No aplica |
| worker-service | `Dockerfile` | Workflow de build y push | Unitario + consumer tests e idempotencia | Repositorio de despliegue propio |

Las tres primeras columnas no introducen ninguna decisión nueva: son la traducción a archivo de lo que `Rules-Devops.md` §2.2 declara como artefacto publicable y de lo que `Rules-Calidad-Y-Pruebas.md` §1.2 y §2.2 declaran como variante de testing por tipo. La cuarta es la frontera de §5.3.

Un matiz que el caso de referencia obliga a registrar. El bot de Discord está declarado `web-monolith` —«panel de administración Blazor Server, bot de moderación embebido y persistencia SQLite, en un solo proceso»— y encaja en su fila: `Dockerfile`, workflow de imagen, E2E de navegador. Pero su unidad de entrega **integra con una plataforma externa como cliente**, y esa integración en E2E se resuelve con un gateway **simulado, sin red ni token**. La regla que se desprende: el proyecto de E2E se define por el tipo y por la UI, y toda integración externa se simula. Un E2E que dependa del servicio real de un tercero no es determinista y cae en el mismo problema que §6.1 describe para la suite asistida.

### 5.3 Dónde corta la frontera: el framework no emite compose

**Decisión tomada por el Product Owner (2026-08-15): el framework no emite `docker-compose.yml`, ni siquiera como ejemplo de referencia.** El corte queda en el `Dockerfile` y en el workflow que publica la imagen.

El fundamento no es teórico: es el modelo de tres estaciones que el workspace ya opera, verificable en un servicio en producción.

| Estación | Ubicación en el caso `Discord.Bot.Moderador` | Qué contiene | Quién la toca |
| --- | --- | --- | --- |
| Desarrollo | `DEV/Discord.Bot.Moderador.Core` | Fuentes, tests, `Dockerfile`, `.github/workflows/`, documentación SDD | Alcance del Framework SDD |
| Proyecto de despliegue | `Repos-Docker/Home/Container.Discord.Bot` | `docker/docker-compose.yml`, guía de instalación, `CHANGELOG.md` del contenedor | Infraestructura, repositorio propio |
| Instancia | `<home>/docker/discord-bot` | El compose parametrizado y `data/discordmoderador.db` | Operación, sin control de versiones del producto |

La tercera estación deja ver por qué el corte va donde va: lo que vive ahí es el compose **ya parametrizado** más la base de datos de esa instancia. Ninguna de las dos cosas es una propiedad del producto. El repositorio de despliegue no es un apéndice del repositorio de desarrollo: tiene su propio ciclo, su propio `CHANGELOG.md` y su propia guía de instalación.

Consecuencias para la categoría 09, que son las que hay que escribir en la regla:

1. El repositorio del producto lleva el `Dockerfile` y el workflow que construye y publica la imagen. Es de 09, pasada de ejecución. En el caso de referencia son `Dockerfile` y `.github/workflows/docker-publish.yml`, que valida los secrets del registro antes de cualquier otra cosa y calcula la versión con auto-versioning.
2. `entornos-deploy.md` declara **qué necesita** una instancia para levantarse —imagen, variables, volúmenes, puertos, healthcheck, dependencias de red— y **dónde vive su proyecto de despliegue**. Es política, y §4.4 ya es su lugar; lo único que falta es el apuntador al repositorio de despliegue, que hoy no está previsto.
3. El compose no se emite en ninguna forma. La imagen publicada es el contrato entre las dos estaciones, y `entornos-deploy.md` es su especificación de consumo.

Esto además elimina una tentación que el análisis anterior dejaba abierta: un compose «de referencia» emitido por el framework envejece sin que nadie lo corra, y termina contradiciendo al compose real. Es una segunda fuente, que es el defecto que el framework más persigue.

### 5.4 El esqueleto de tests: qué se entrega para que escale con el fuente

El segundo pedido del contexto —que al terminar el proyecto quede el planteo de los fuentes de test, para escalarlos a medida que escala el proyecto— tiene una implementación de referencia completa en `DEV/Discord.Bot.Moderador.Core/tests/`, y conviene derivar la regla de ahí en vez de inventarla.

Lo que hay que entregar no es un proyecto de tests vacío. Son seis decisiones estructurales, y las seis están tomadas y probadas en el caso de referencia:

**1. Dos proyectos, no uno.** `DiscordModeradorBot.Servicio.Tests` para unitarios e integración, y `DiscordModeradorBot.Servicio.E2E` para end-to-end. Separados porque tienen costo, tooling y disparador distintos.

**2. El E2E se ejecuta separado del gate de cobertura. El mecanismo es una decisión, no una regla.** En el caso de referencia la separación se resolvió **excluyendo el proyecto de la solución**: el `.csproj` declara en su cabecera que está fuera de `DiscordModeradorBot.slnx` para que el `dotnet test` de la solución no lo arrastre, y se ejecuta por path en su propio job.

Conviene no promover ese mecanismo a regla, por tres motivos.

*Ningún estándar lo dicta.* La pirámide de Fowler, ISTQB e IEEE 829 hablan de **niveles** y de cuándo se ejecuta cada uno; ninguno dice nada sobre la pertenencia de un proyecto a un archivo de solución, que es un artefacto de un ecosistema concreto. Lo que el estándar pide —que el nivel e2e no se mezcle con el unitario en costo, frecuencia ni reporte— se cumple con cualquiera de cuatro mecanismos: exclusión del archivo de solución, filtros por categoría o trait, filtros de solución, o simplemente invocar el proyecto por path en un job aparte. El caso de referencia usa el primero y el cuarto a la vez.

*Escribirlo como regla sería hardcodear un stack.* `Rules-Devops.md` §4.8 ya tipifica ese defecto —es el caso del `Guia-Publicacion-Nuget.md` del fuente SDD 1.0— y la 08 hizo la corrección equivalente al prohibir sufijos de dominio en los nombres. Una regla que diga «el proyecto e2e va fuera de la solución» no significa nada para una entrega en Python o en Rust.

*La exclusión no es gratis, y en este caso ya se cobró.* `coverlet.runsettings` excluye de la cobertura unitaria la capa de presentación —`**/*.razor` y `**/Components/**`— con este argumento: «se cubre por el nivel E2E con conducción headless del navegador, NO por esta suite. Su umbral propio (≥60/50) se verifica en el job/escenario E2E». Pero el job `e2e` de `ci.yml` corre con `--logger trx` y **sin recolección de cobertura**, y `verificar-cobertura.ps1` valida solo el global (75/65) y el módulo de detección (90). **El umbral de presentación que `Rules-Calidad-Y-Pruebas.md` §2.2 exige para `web-monolith` no lo verifica ningún job.** No es un descuido de redacción: es la consecuencia previsible de partir la historia de cobertura en dos y que una de las mitades quede sin dueño.

Lo que sí conviene escribir en la regla son tres propiedades, que son verificables en cualquier stack:

| Propiedad | Qué exige |
| --- | --- |
| P1 | El gate de cobertura no ejecuta el nivel e2e. El mecanismo lo elige la entrega y se registra como ADR en 05 |
| P2 | El nivel e2e corre en su propio job o stage, con su disparador y su reporte propios |
| P3 | **Toda capa con umbral declarado en §2.2 tiene un job que lo verifica.** Si la presentación se cubre por e2e, el job de e2e recolecta y verifica su cobertura |

P3 es la que habría atrapado el hueco del caso de referencia, y hoy no existe en ninguna de las dos reglas: §6 de la 08 exige que la cobertura se reporte por capa, pero no que cada umbral declarado tenga quién lo verifique.

**3. El árbol de tests espeja las capas de la arquitectura.** El proyecto unitario tiene `Dominio/`, `Aplicacion/`, `Infraestructura/` y `Soporte/`. No es prolijidad: `Rules-Calidad-Y-Pruebas.md` §2.2 fija cobertura mínima **por capa**, y §4.10 tipifica como anti-patrón reportar cobertura como número global. Un árbol de tests que no espeja las capas de 05 vuelve inverificable el propio umbral que la categoría declara. Ésta es la regla que hace que el esqueleto escale: cada componente nuevo de una capa tiene un lugar evidente donde va su test.

**4. Cada test E2E es autosuficiente.** `HostServicioE2E` levanta el host real con Kestrel en puerto efímero, base SQLite temporal y gateway simulado, y la base se borra al terminar. Cada test tiene su propio host y su propia base, «así no dependen del orden ni del estado de otros». Es la materialización de la pregunta guía de `Rules-Calidad-Y-Pruebas.md` §5.4 sobre determinismo e independencia de orden.

**5. Degradado tolerante al entorno, con omisión explícita.** Si Playwright no tiene navegador, el test se **omite** en vez de fallar: `NavegadorNoDisponibleException` se traduce a `SaltarPruebaException` mediante un discoverer propio, `HechoSaltable`. En CI los navegadores se instalan y la suite corre de verdad. Esto es exactamente el degradado que §6.2 propone para `usa_testing_asistido_ia`, ya resuelto en código y en el nivel correcto: el test sabe distinguir «no puedo verificar esto acá» de «esto está roto».

**6. Un job de CI separado para E2E, con su propio caché y sus propios artefactos.** El job `e2e` de `ci.yml` instala Chromium con `--with-deps`, corre el proyecto por path y publica los `.trx` y el reporte de Playwright. Su comentario deja anotada la palanca que §6.1 pide: «si se quisiera no-bloqueante para el merge, marcar `continue-on-error`».

Hay un séptimo rasgo, y es el que más importa para SDD porque no es una decisión de testing sino de trazabilidad. **Los artefactos ejecutables citan al documento SDD que materializan, en su cabecera.** `ci.yml` abre con «Materializa los stages y gates bloqueantes de `pipeline-ci-cd_v1.0.md` §2 (G1-G5 + supply-chain) y la DoD de `definition-of-done_v1.0.md`»; los steps llevan identificadores `STAGE-00` a `STAGE-07` que resuelven contra esa numeración; el `.csproj` del E2E cita `estrategia-testing_v1.0.md` §1/§2 y §7. Es D6 aplicada a un archivo que no es documentación, y es lo que permite auditar que el pipeline ejecuta la política que dice ejecutar en vez de otra. **Esta cláusula debería ser obligatoria en la pasada de ejecución**, y es barata: un comentario de cabecera.

Dos observaciones sobre el caso de referencia que conviene registrar sin adornarlas. Primero, todo esto **existe pero no lo emitió ninguna fase declarada de SDD**: lo escribió el ciclo de codificación, después del handoff, sin dueño normativo. Es precisamente el hueco de §3.1 y §3.2, y el hecho de que el resultado sea bueno no vuelve correcta la vía —el mismo argumento que `Master-Prompt.md` §6 punto 3 usa para prohibir que una categoría emita el artefacto de otra—. Segundo, los documentos citados llevan sufijo `_v1.0` en el nombre, nomenclatura de SDD 2.2D que D4 y D5 del framework 4.0 ya prohíben; una migración normativa de ese destino tendría que actualizar también las citas dentro de los workflows, que es un efecto colateral que `Migracion-Rules.md` no contempla hoy.

### 5.5 Especificación del agente de barrido AG-08E

Esta sección está escrita para que el prompt de intervención sobre el framework pueda derivar de ella el archivo de reglas sin volver a discutir el alcance. Todo lo que sigue es propuesta cerrada, salvo lo que se marque como decisión abierta.

#### 5.5.1 Qué es y dónde se ubica

**Qué es.** Un subagente especializado que, una vez cerrado el desarrollo asistido de una entrega con interfaz web, recorre las páginas construidas y emite la batería de tests automatizados que las verifica contra la especificación.

**Dónde se ubica.** Categoría dueña: **08 Calidad y pruebas**. No es una categoría nueva y no agrega carpeta a la numeración `00` a `11`. Su archivo de reglas es transversal, con el mismo estatuto que `Maqueta-Rules.md` y `Deriva-Rules.md`, y se propone `Barrido-Tests-Rules.md`.

**Por qué la 08 y no otra.** `Rules-Calidad-Y-Pruebas.md` §0 ya declara a la categoría **dueña operativa de `Matriz-Sensado-Deriva.md`**, cuya mecánica define `Deriva-Rules.md` y cuyas sondas visuales —`SUP`, `CMP`, `EST`, `NAV`, `DM`— las **emite AG-03M al cerrar la Fase B2**. El §6 de esa regla exige que cada fila de la matriz tenga «método de verificación resuelto (test automatizado o inspección)», y hoy las visuales tienden a resolverse por inspección, es decir, un humano mirando. **AG-08E es el ejecutor que le faltaba a un instrumento que la 08 ya posee.** No hay que buscarle categoría ni fundar una titularidad nueva.

**Qué relación tiene con AG-03M.** Es el molde. `Maqueta-Rules.md` abre declarando «No es una categoría documental nueva: no agrega una carpeta a la numeración `00` a `11`. Es una fase de validación», y despacha un subagente propio con su secuencia de pasos y sus detenciones. AG-08E es su simétrico en el otro extremo de la cadena: AG-03M materializa la especificación en una maqueta **antes** de que exista el código, para que el humano vea; AG-08E verifica lo construido contra esa misma línea de base **después**, para que la deriva se detecte sola.

| Dimensión | AG-03M (Fase B2) | AG-08E (propuesto) |
| --- | --- | --- |
| Archivo de reglas | `Maqueta-Rules.md`, transversal | `Barrido-Tests-Rules.md`, transversal |
| Categoría dueña | 03 | 08 |
| Momento | Entre Fase B y C, sin sistema | Tramo II, con el sistema construido y cerrado |
| Insumo principal | Experiencia de uso de AG-03 | Línea de base visual de AG-03M, CU de la 02, `TC-XXXXX` de AG-08 |
| Produce | Maqueta, línea de base, contrato de datos, bitácora | Scripts de test, `actual output` de cada TC, método de verificación de las sondas visuales |
| Titularidad de lo que produce | De AG-03 | De AG-08 |

**AG-08E no es dueño de nada, es ejecutor.** Los `TC-XXXXX`, los umbrales y la matriz siguen siendo de AG-08. Si AG-08E inventa casos que no están en `Casos-Prueba-Referenciales.md`, el defecto no es del script: es un agente emitiendo el artefacto de otro, que `Master-Prompt.md` §6 punto 4 tipifica como hallazgo P0.

#### 5.5.2 Alcance y condición de activación

**Alcance (decisión del PO, 2026-08-16): interfaces web, y solo sobre páginas que son parte del entregable final.** No cubre CLI, colas de mensajes, API sin portal, escritorio ni móvil, aunque §6.6 muestre que en esos casos también hay E2E posible.

Es un acotamiento del **agente**, no una redefinición de la categoría. La 08 §2.2 sigue asignando porcentaje de e2e a `rest-api`, `cli-tool` y `worker-service`, y esos casos se siguen especificando igual; lo único que cambia es que no los produce AG-08E. Las tres razones para acotar así: el §1.2 del archivo de reglas pasa de necesitar ocho variantes por tipo a una sola condición de activación; el único terreno con evidencia medida en el workspace es el navegador —las dos suites del banco de pruebas y el E2E del bot son las tres de navegador—; y ampliar después es incorporar filas, no rehacer la regla.

| Condición | Cómo se verifica |
| --- | --- |
| La entrega tiene interfaz web final | `tiene_ui_final` == true y `tipo_unidad_entrega` ∈ {`web-monolith`, `web-microservices` con frontend} |
| Las páginas son del entregable final | No son maqueta ni superficie de prueba: son las que el usuario va a usar |
| El desarrollo asistido está cerrado | §5.5.3 |
| Hay confirmación humana | El punto de detención de §8.4 |

#### 5.5.3 El momento: cierre del desarrollo asistido

**El barrido se dispara cuando se da por cerrado el desarrollo asistido por IA de la entrega.** Es un evento único y declarable, no una evaluación de madurez superficie por superficie.

Lo que hace correcta esa definición es que invierte la relación entre el código y los tests, y esa inversión es todo el valor del agente:

| Antes del cierre | Después del cierre |
| --- | --- |
| Las páginas todavía se mueven. Un test escrito acá se rompe en cada cambio y el equipo aprende a ignorar el rojo | La suite existe y es la red de seguridad |
| No hay batería E2E | Los cambios que vengan —fixes, features— **se validan contra la suite** |
| El oráculo es la especificación | El oráculo sigue siendo la especificación, y la suite es su forma ejecutable |

Dicho de otro modo: **el barrido corre una vez, al cierre, y a partir de ahí la suite deja de ser un producto del ciclo y pasa a ser su instrumento.** Un fix posterior no dispara un barrido nuevo: lo verifica la suite existente, y si el fix incorpora superficie nueva, se extiende por el ciclo normal de codificación. Eso descarta la lectura de la versión anterior de este análisis, que proponía una pasada por superficie estabilizada y convertía al agente en un proceso permanente.

Corolario para `Master-Prompt.md` §7.1: la precondición dura de la Fase I exige hoy que «los tests corren». Con el barrido declarado, esa precondición **es la salida de esta fase**, no un supuesto sobre el repositorio. La fase del barrido se ubica entre el cierre del desarrollo asistido y la Fase I.

#### 5.5.4 Secuencia de la fase, con sus detenciones

Cinco pasos. Tres son detenciones, y las tres existen por el mismo motivo: un agente que genera una batería completa sin puntos de control produce un volumen que nadie revisa y que se acepta por cansancio.

**Paso 1 — Confirmación y elección de entorno (detención).** El orquestador informa que la entrega llegó al cierre del desarrollo asistido, pregunta si se corre el barrido, y presenta los entornos de construcción declarados en el intake con sus capacidades para que el humano elija cuál. Si la respuesta es no, la fase se omite y queda registrada la omisión con motivo.

**Paso 2 — Inventario y plan de barrido (detención).** El agente arma y presenta la lista de lo que va a recorrer y de lo que va a producir, **antes de generar una sola línea**:

| Insumo | Qué aporta | Origen |
| --- | --- | --- |
| `Linea-Base-Visual.md` | Las superficies, sus componentes, sus estados y su navegación | 03, Fase B2 |
| `Contrato-Datos-Maqueta.md` | Qué datos entran y salen de cada formulario | 03, Fase B2 |
| CU con criterios Given-When-Then y RN | **El oráculo**: qué tiene que pasar en cada flujo | 02 |
| `Casos-Prueba-Referenciales.md` | Los `TC-XXXXX` ya catalogados con setup, pasos y expected | 08 |
| `Matriz-Sensado-Deriva.md` | Las filas con método de verificación sin resolver | 08 |
| `Estrategia-Testing.md` | Tooling, fixtures, política de datos de prueba y ambiente | 08 |

El plan declara, por cada superficie, qué `TC-XXXXX` la cubren, qué CU los respalda y qué sondas visuales quedarían resueltas. El humano aprueba, recorta o agrega.

**Paso 3 — Generación.** El agente escribe los scripts dentro del esqueleto que AG-08 dejó en la Fase E, respetando las reglas constructivas de §5.5.5. No crea estructura nueva ni casos de prueba nuevos.

**Paso 4 — Corrida y registro de evidencia.** Ejecuta la suite en el entorno elegido y registra: `actual output` y `status` de cada `TC-XXXXX`; método de verificación y evidencia de cada fila de la matriz de sensado que quedó resuelta; y la lista de discrepancias.

**Paso 5 — Cierre con revisión humana (detención).** Presenta la suite generada, su resultado y las discrepancias encontradas. El humano confirma antes de que la suite se congele como red de seguridad. Es el paso que convierte una batería generada en una batería adoptada.

#### 5.5.5 Reglas constructivas del script

Seis, y la primera es la que hace o rompe la fase.

**R1 — Dirección de la verdad.** El sistema construido aporta **cómo se localiza** un control. La especificación aporta **qué tiene que pasar**. Un test cuyo resultado esperado se derivó observando lo que la aplicación hace, y no lo que el CU declara, no es un test: es una fotografía. Sin esta regla, un agente que mira la aplicación terminada produce una suite que canoniza los bugs existentes y que pasa al 100 % desde el primer día.

**R2 — La discrepancia es un hallazgo, no un expected a ajustar.** Cuando lo construido no coincide con lo especificado, se registra en `Matriz-Sensado-Deriva.md` con su umbral, y se resuelve arreglando el código o cambiando la especificación con su ADR. Nunca acomodando el test. `Deriva-Rules.md` ya define el instrumento y los umbrales.

**R3 — Determinismo.** Cada test es reproducible y no depende del orden de ejecución. Es la pregunta guía que `Rules-Calidad-Y-Pruebas.md` §5.4 ya hace, acá exigida al generador.

**R4 — Aislamiento.** Cada test levanta su propio host y su propio almacenamiento efímero, y los descarta al terminar. El patrón está implementado y probado en el caso de referencia.

**R5 — Integraciones externas simuladas.** Ningún test depende del servicio real de un tercero. Un E2E que necesita credenciales ajenas y disponibilidad ajena deja de ser determinista.

**R6 — Trazabilidad en el propio archivo.** Cada script declara en su cabecera el `TC-XXXXX` que materializa y el CU o RN que lo respalda. Es D6 aplicada a un artefacto que no es documentación, y es lo que permite auditar la suite sin leerla entera. El caso de referencia ya lo hace con sus workflows, que citan documento y sección.

#### 5.5.6 Qué produce

| Artefacto | Dónde | Estado al cerrar |
| --- | --- | --- |
| Scripts de test E2E | Dentro del proyecto de tests que AG-08 esqueletó en la Fase E | Corridos al menos una vez |
| `actual output` y `status` de cada `TC-XXXXX` | `Casos-Prueba-Referenciales.md` de la 08 | Con la salida real y su fecha |
| Método de verificación y evidencia de las sondas visuales | `Matriz-Sensado-Deriva.md` de la 08 | Resuelto por comando, ya no por inspección |
| Filas de la matriz de cobertura | `Matriz-Cobertura-Pruebas.md` de la 08 | Actualizadas contra lo construido |
| Registro de discrepancias | `Matriz-Sensado-Deriva.md`, más el registro de decisiones pendientes si hay arbitraje | Cada una con su umbral y su vía de resolución |
| Bitácora de la corrida | Junto al resto de artefactos de la 08 | Con entorno usado, superficies barridas y omisiones con motivo |

#### 5.5.7 Criterios de aceptación de la fase

Clasificados `[enumerable]` e `[interpretativo]` como exigen las reglas del framework desde su versión 3.2, con la política conservadora: ante la duda, interpretativo.

- `[enumerable]` Existe al menos un script por superficie declarada en el plan del paso 2.
- `[enumerable]` Todo `TC-XXXXX` de tipo e2e del catálogo tiene `actual output` con fecha, o motivo declarado de por qué no se pudo verificar.
- `[enumerable]` Ninguna fila de sonda visual de la matriz de sensado quedó en «inspección» sin motivo declarado.
- `[enumerable]` Cada script declara en su cabecera el `TC-XXXXX` y el CU o RN que lo respalda.
- `[enumerable]` La fase registró el entorno de construcción usado y las superficies omitidas con su motivo.
- `[interpretativo]` Ningún resultado esperado se derivó de observar la aplicación en lugar de la especificación.
- `[interpretativo]` Toda discrepancia entre lo construido y lo especificado quedó registrada como hallazgo, y ninguna se resolvió ajustando el expected.
- `[interpretativo]` Los scripts no introducen casos de prueba ausentes de `Casos-Prueba-Referenciales.md`.
- `[interpretativo]` Ningún test depende del servicio real de un tercero, del orden de ejecución ni de estado compartido.

#### 5.5.8 Secciones que debe tener el archivo de reglas

Calcadas de la estructura de `Maqueta-Rules.md`, que es el precedente:

| § | Contenido | De dónde sale |
| --- | --- | --- |
| 0 | Posición en la cadena; declarar que no agrega categoría | §5.5.1 |
| 1 | Especialidad de AG-08E y su relación de subordinación a AG-08 | §5.5.1 |
| 2 | Condición de activación y tabla maestra de lo que produce | §5.5.2 y §5.5.6 |
| 3 | Secuencia de la fase con sus tres detenciones | §5.5.4 |
| 4 | Reglas constructivas del script, R1 a R6 | §5.5.5 |
| 5 | Tratamiento de la discrepancia y su remisión a `Deriva-Rules.md` | R2 |
| 6 | Criterios de aceptación clasificados | §5.5.7 |
| 7 | Anti-patrones | §9 de este análisis |
| 8 | Prompt-snippet del despacho | Construido sobre §5.5.4 y §5.5.5 |
| 9 | Control de cambios | Formato estándar del framework |

#### 5.5.9 Lo que queda abierto

Tres puntos que la intervención tiene que resolver y que este análisis no cierra:

1. **Cómo se declara el cierre del desarrollo asistido.** El evento existe conceptualmente pero el framework no lo tiene declarado en ningún lado. Puede ser una señal explícita del humano en el punto de confirmación del paso 1, o un estado de la entrega en el manifiesto. Lo primero es más simple y no toca el manifiesto.
2. **Dónde se ubica exactamente la fase en el plan de `Master-Prompt.md` §6**, y cómo se relaciona con la Fase I, cuya precondición dura pasa a depender de ella.
3. **Si la suite asistida por IA participa del barrido o solo del taller de selectores.** La distinción de §6.1 sigue vigente: lo que se congela como red de seguridad tiene que ser determinista, cualquiera sea la herramienta con la que se lo redactó.

### 5.6 Los nombres de archivo impuestos por herramienta necesitan excepción a D3

D3 exige Título-Con-Guiones estricto, sin espacios ni acentos, para archivos y carpetas. `Dockerfile`, `docker-compose.yml` y `.github/workflows/ci.yml` no cumplen y **no pueden cumplir**: sus nombres los impone la herramienta que los lee.

El framework ya tiene el precedente resuelto: la Fase B2 emite `index.html`, `assets/css/` y `assets/js/Maqueta.js` sin que eso se lea como violación de D3, y `/samples` lleva la estructura que el runtime imponga. Lo que falta es que la excepción esté **escrita** en vez de tolerada. Formulación sugerida: D3 rige sobre los artefactos documentales del framework; los artefactos ejecutables cuyo nombre está fijado por la herramienta que los consume conservan el nombre canónico de esa herramienta, y la carpeta que los agrupa sí respeta D3 cuando el nombre es libre.

### 5.7 Ejemplo integrado: qué queda en el repositorio de un front web

Sirve para que el prompt de intervención no deje ambigüedad sobre quién emite qué. Caso: una entrega `web-monolith` con interfaz final, `requiere_maqueta` en true, corrida completa hasta el cierre del desarrollo asistido.

| Qué queda en el repositorio | Quién lo emitió | Cuándo |
| --- | --- | --- |
| Proyecto de tests unitarios y de integración, con su árbol por capas y sus fixtures | AG-08, esqueleto | Fase E, antes del código |
| Proyecto de tests E2E, con sus fixtures de soporte y su degradado por omisión | AG-08, esqueleto | Fase E, antes del código |
| Los tests unitarios y de integración concretos | Ciclo de codificación | Sprint a sprint |
| **Los scripts E2E** | **AG-08E, barrido** | **Al cerrarse el desarrollo asistido** |
| Segundo proyecto E2E asistido por modelo | AG-08E, solo si `usa_testing_asistido_ia` está en true | Ídem |
| `Dockerfile` | AG-09, pasada de ejecución | Tramo II |
| Workflow de CI con el job del gate y el job de E2E | AG-09, pasada de ejecución | Tramo II |
| Workflow de build y push de imagen | AG-09, pasada de ejecución | Tramo II |
| Workflow de disparo manual de la suite asistida | AG-09, solo si el flag está en true | Ídem |

Tres precisiones que la tabla deja ver y que conviene no perder.

**El barrido emite solo E2E; los dos proyectos existen desde antes.** La pregunta «¿se genera solo el proyecto E2E?» tiene respuesta doble: el **barrido** produce solo E2E, pero el **esqueleto** de la Fase E produce los dos proyectos, y los unitarios los llena el ciclo de codificación. Al cerrar, el repositorio tiene las dos suites pobladas, con autores distintos.

**El framework no dicta Playwright.** `Rules-Calidad-Y-Pruebas.md` §4.3 punto 3 exige declarar el tooling «sin atar el documento a productos comerciales concretos», y el intake §17 P.6 pregunta «¿Frameworks por nivel?». O sea que la herramienta concreta la declara el producto en su intake y la regla la trata como parámetro. Lo que el framework sí fija es el **rol**: la suite determinista es la red de seguridad y es gate bloqueante, cualquiera sea el driver con que se la escribió.

**Playwright y Stagehand no son alternativas del mismo casillero.** Es la distinción de §6.1 aplicada a este caso: la suite determinista se emite **siempre**; la asistida se emite **solo si el flag está en true**, es un **segundo proyecto separado** —en el banco de pruebas son incluso de runtimes distintos, .NET y Node—, corre por disparo manual y no bloquea. Su producto son los selectores que después se congelan en la determinista. Un producto que active el flag termina con dos proyectos E2E, no con uno escrito en Stagehand.

**El sistema bajo prueba es el producto levantado, no el front solo.** Es la precisión que sigue, y conviene leerla antes de escribir la regla.

### 5.8 El sistema bajo prueba es el producto levantado

Una versión anterior de este análisis trataba el caso «front separado del backend» como un journey que cruza entregas y que quedaba fuera del alcance del agente. Estaba mal planteado, y el error es de los que se pagan caro porque dejaba afuera el caso normal en vez del excepcional.

**Un front va acompañado de su backend. No es la excepción: es la condición.** Ni siquiera se puede codear el front sin la API, y el barrido se dispara con el producto terminado. Un agente que solo supiera manejar un front aislado no serviría para casi ningún producto real.

La precisión que hay que escribir en la regla es de definición, y se sigue de §6.6:

> El E2E de una superficie web **incluye por definición el backend que la sirve y su persistencia**. Un test de front con la API simulada no es E2E: es un test de integración del front. Lo que hace que una prueba sea end-to-end es que no sustituye sus componentes internos, y para un front el backend es un componente interno del producto, no un tercero.

Lo que sí se sustituye sigue siendo lo mismo que fija R5 de §5.5.5: los **servicios de terceros** ajenos al producto. La frontera es de propiedad, no de proceso — si el producto lo construye y lo despliega el mismo equipo, entra en el sistema bajo prueba.

#### Qué cambia con esto

**El alcance del agente se define por superficie de conducción, no por unidad de entrega.** AG-08E conduce por la interfaz web y ejercita lo que haya detrás, compongan eso una o varias unidades de entrega. Es una simplificación, no una ampliación: desaparece el caso raro que había que tratar aparte.

**El hueco de nivel producto se achica.** §6.4 identificaba los scripts del E2E que cruza entregas como lo único sin dueño. Con esta definición **sí tienen productor** —AG-08E—, y lo que queda pendiente es solo dónde se registran: el gate de integración de `Pipeline-Producto.md` §4.9 punto 6 es exactamente lo que estos scripts satisfacen, así que la regla tiene que declarar que ese gate se cumple con la suite que emitió el barrido, en vez de pedir un smoke test aparte.

**Dónde viven los scripts.** Con la superficie de conducción como criterio, la respuesta es simple y corrige lo que §6.7 dejaba ambiguo: viven con la unidad de entrega que aporta la interfaz. El repositorio propio queda reservado al caso en que no hay una única superficie de conducción —varios fronts, o un journey de servicio a servicio sin interfaz—, que es bastante más raro que lo que aquella sección sugería.

#### Cómo se levanta el producto para correr la suite

Es la consecuencia operativa, y toca la decisión de §8.1, así que conviene resolverla explícitamente para que no parezca una contradicción.

| Caso | Cómo levanta el producto la suite |
| --- | --- |
| Monolito con front y back en un proceso | Host en proceso con puerto efímero y almacenamiento temporal, como el `HostServicioE2E` del caso de referencia |
| Front y back desplegables separados | El **arnés de prueba** levanta las dependencias: contenedores efímeros gestionados desde el propio proyecto de tests, o servicios del job de CI |

**Eso no contradice la decisión de no emitir compose.** Son dos cosas distintas y la diferencia es de propósito y de ciclo de vida: el compose de despliegue describe una instancia que vive en un host y sobrevive a la corrida, y por eso pertenece al repositorio de infraestructura; el arnés de prueba levanta dependencias efímeras que nacen y mueren con la suite, se declara en el proyecto de tests y se versiona con él. El primero es despliegue; el segundo es fixture.

La regla de AG-08E tiene que declarar cuál de los dos modos usa la entrega, y eso sale de la 05 y del manifiesto —cuántos procesos desplegables componen el producto—, no de una decisión del agente.

---

## 6. QA y testing: qué cambia

### 6.1 Dos suites, dos roles, y solo una es gate

El banco de pruebas del runner ya midió esto y el resultado es inequívoco. La suite determinista (Playwright + xUnit) corre en cada push a `main` y en cada PR, y cuesta ~3 s los 6 casos. La suite asistida por IA corre **solo a mano** (`workflow_dispatch`) y cuesta ~600 s por celda con 5 primitivas. El motivo del disparo manual está declarado y es de diseño: «un modelo no es determinista y una prueba que a veces pasa erosiona la confianza en el tablero entero».

El rol de cada una también está declarado: la determinista es «la red de seguridad»; la asistida es «el taller», y su producto son los selectores que después se congelan en la suite determinista.

Traducido a la estructura de 08 y 09, esto obliga a una distinción que hoy no existe. `Rules-Devops.md` §4.7 tiene una única tabla de stages y su columna «Bloqueante» dice «Sí» en las siete filas. Hace falta una **segunda clase de stage**: no bloqueante, de disparo manual, cuyo output es insumo de autoría y no veredicto de calidad. Sin esa clase, la suite asistida solo tiene dos destinos posibles y los dos son malos: entra como gate y rompe el tablero con falsos rojos, o queda fuera del framework y no se documenta.

### 6.2 Dos declaraciones distintas en el intake: la decisión y el recurso

La versión 1.0 de este análisis proponía un flag `runner_con_ia` de ámbito «entorno de construcción», y eso obligaba a extender el conjunto cerrado de niveles de `Master-Prompt.md` §4 —producto, unidad de entrega, proyecto de código—, que es una detención por arbitraje. La formulación era mala, y el motivo es que mezclaba dos cosas de naturaleza distinta en un solo campo.

**Son dos declaraciones, y cada una tiene su nivel natural.**

| Qué se declara | Naturaleza | Nivel | Dónde va en el intake |
| --- | --- | --- | --- |
| Si esta entrega usa pruebas asistidas por IA | Decisión de estrategia de testing | Unidad de entrega | §17 P.6, junto a la pirámide y los frameworks por nivel |
| Qué runners hay disponibles y con qué capacidades | Recurso de infraestructura compartido | Producto | Subsección nueva de nivel producto, referenciada desde §17 P.8. Una fila por entorno; **cuál se usa para el barrido se elige al llegar a la categoría** (§8.4) |

Separadas así, **el problema de nivel desaparece y no hay conjunto cerrado que extender**. El flag de gating es uno solo, vive en el nivel que la tabla de §4 ya admite, y la capacidad del runner deja de ser un flag para ser lo que realmente es: un recurso declarado, como la estructura de repositorio de §16.

Que el runner sea de nivel producto y no de unidad de entrega tiene fundamento propio: es infraestructura compartida por todas las entregas del producto —y, en la práctica del workspace, por varios productos—. Repetir su declaración N veces en §17 produciría N copias de un dato único, que es la forma más común de que dos de esas copias se contradigan.

Flag resultante, en el formato de `Master-Prompt.md` §4:

| Flag | Ámbito | Origen | Regla | Impacto |
| --- | --- | --- | --- | --- |
| `usa_testing_asistido_ia` | unidad de entrega | §17 P.6 de la unidad de entrega | true si la estrategia de testing declara pruebas asistidas por modelo. Requiere que el entorno de construcción de nivel producto declare un servicio de inferencia; si no lo declara, es intake incompleto y aplica la detención de §2 | Si true, 08 suma la suite asistida con alcance de autoría y 09 emite su workflow de disparo manual y no bloqueante. Si false, no se emite ninguna de las dos y la suite determinista es la única fuente de E2E |

Subsección de intake propuesta, de nivel producto, **con una fila por entorno de construcción disponible** y con los campos que la evidencia del banco de pruebas demostró necesarios:

| Campo | Por qué es necesario | Valor en el caso medido |
| --- | --- | --- |
| Plataforma de CI | Ya se pregunta en P.8, pero por entrega; acá se declara una vez | GitHub Actions |
| Tipo de runner y etiquetas | El workflow las necesita literales en `runs-on` | `self-hosted`, `i7infra-dev` |
| Cachés que sobreviven al contenedor efímero | Sin declararlas, cada corrida reinstala el navegador | `/cache/ms-playwright` vía `PLAYWRIGHT_BROWSERS_PATH` |
| Servicio de inferencia disponible | Es la precondición de `usa_testing_asistido_ia` | Sí |
| Endpoint **tal como se resuelve desde el runner** | La IP del host es inalcanzable desde una macvlan | `http://my-ai-api:11434` |
| Modelo y sus restricciones de invocación | `think: false` y streaming son obligatorios; sin streaming el fetch aborta a los 300 s | `qwen3.5:4b` |
| Capacidad de cómputo | Fija qué es viable y qué no | i7-3770K sin AVX2 ni FMA, sin GPU, inferencia 100 % CPU |

Dos reglas que van con la declaración, las dos respaldadas por evidencia:

- **El degradado es total.** Con `usa_testing_asistido_ia` en false no se emite un workflow que falle por falta de servicio: no se emite nada. Un workflow que siempre falla es peor que su ausencia.
- **El endpoint es obligatorio, no opcional.** La trampa ya está pagada y documentada: desde el runner el servicio es `http://my-ai-api:11434`, no la IP del host. Un booleano sin endpoint reproduce ese error en cada producto nuevo.

Y un condicionante de alcance que conviene registrar aunque incomode: con inferencia 100 % CPU, sin AVX2 ni GPU, ~600 s por celda y un piso de ruido del 10–15 %, la suite asistida no escala a una batería completa. Su uso viable es el que el propio banco de pruebas identificó —taller de autoría de selectores—, y el framework debería documentarla con ese alcance y no con otro. Prometer una batería E2E asistida por IA sobre este hardware sería una afirmación sin respaldo.

### 6.3 La suite asistida es la ejecutora natural del sensado de deriva visual

Esta es la síntesis con más valor de los dos insumos, y no es evidente hasta que se ponen uno al lado del otro.

`Rules-Calidad-Y-Pruebas.md` §0 declara dos clases de sonda en `Matriz-Sensado-Deriva.md`: las **visuales** (`SUP`, `CMP`, `EST`, `NAV`, `DM`), que emite AG-03M al cerrar la Fase B2 y que «miden si lo construido se parece a lo que el humano aprobó mirando»; y las de **contrato y comportamiento** (`VER-XXXXX`), que aporta la 10. El criterio de aceptación correspondiente exige que cada fila tenga «método de verificación resuelto (test automatizado o inspección)».

El problema práctico de las sondas visuales es que su método de verificación tiende a caer en «inspección», es decir, un humano mirando. Y acá aparece la coincidencia: la suite asistida localiza los controles **describiéndolos en castellano**, y el modelo elige cuál es —a diferencia de la determinista, que los localiza por `data-testid`—. Una sonda visual del tipo «la superficie de solicitud de turno muestra el paso 2 con sus tres campos y el panel de errores» es, literalmente, una descripción en castellano de un control. Es la forma de entrada nativa de la suite asistida.

La consecuencia es que la suite asistida no es un experimento paralelo: es el candidato natural a **resolver el método de verificación de las sondas visuales** que hoy se resuelven por inspección humana, sin dejar de ser no bloqueante. Su no determinismo, que la descalifica como gate, es tolerable en un instrumento de sensado cuyo resultado un humano revisa. Merece verificarse con una prueba acotada antes de escribirlo como regla; queda planteado como hipótesis con fundamento, no como hecho.

### 6.4 Mapa de intervención del E2E en la cadena

Antes de decidir dónde se agrega algo conviene ver dónde interviene hoy. El mapa sale de rastrear «e2e» y «end-to-end» en los dieciocho archivos de reglas, no de reconstruirlo de memoria: aparece en seis, y con pesos muy distintos —doce menciones en la 08, dos en la 09, una suelta en la 06, la 07 y las reglas de intake—.

| Categoría o fase | Rol respecto del E2E | Con qué artefacto concreto | Nivel |
| --- | --- | --- | --- |
| 02 Especificación funcional | **Oráculo.** Aporta qué tiene que pasar | CU con criterios Given-When-Then y RN, que la tabla CU↔criterio↔test de la 08 §4.9 referencia | Unidad de entrega |
| 03 UX-UI-DX + Fase B2 | **Inventario de superficies.** Aporta qué hay que recorrer | `Linea-Base-Visual.md` con `SUP`, `CMP`, `EST`, `NAV`, `DM`, y `Contrato-Datos-Maqueta.md` | Unidad de entrega |
| 05 Arquitectura | **Objetivos medibles y capas.** Aporta qué se mide y cómo se organiza el árbol de tests | `NFR-XXXXX` con métrica numérica; la descomposición en capas que fija los umbrales de cobertura | Unidad de entrega + producto |
| 06 Backlog y 07 Plan de sprint | **Ninguno propio.** Usan «end-to-end» para dimensionar una US y para el walking skeleton, no como nivel de testing | Mención incidental | Unidad de entrega |
| **08 Calidad y pruebas** | **Dueña.** Es la única categoría que define el E2E | Porcentaje en la pirámide por tipo D8; `TC-XXXXX` de tipo e2e; matriz de cobertura; criterios de validación; DoD; `Matriz-Sensado-Deriva.md` | Unidad de entrega |
| 09 DevOps, nivel entrega | **Ejecutor.** Lo corre y decide si bloquea | Stage o job del pipeline; la pregunta guía §5.1 exige «un stage por nivel de la pirámide» | Unidad de entrega |
| 09 DevOps, nivel producto | **Dueña del E2E que cruza entregas** | Gate de integración de `Pipeline-Producto.md` §4.9 punto 6 | Producto |
| 10 Examples | **Vecino, no E2E.** Aporta el mecanismo de evidencia | `VER-XXXXX`: comando exacto, aserción evaluable y evidencia con fecha | Unidad de entrega |
| 11 Documentación | **Cita, no define.** La `Guia-Contribucion` explica cómo correr los tests | Frontera declarada en la 08 §0: ante criterios distintos, rige la 08 | Unidad de entrega + producto |

Tres lecturas que el mapa deja claras.

**La 08 es dueña única, y el E2E no está huérfano.** La pirámide de §2.2 ya le asigna porcentaje por tipo —10 % en `web-monolith` y `rest-api`, 15 % en `desktop-app` y `mobile-app-maui` con los UI tests contados ahí, 10 % en `cli-tool` con el snapshot de CLI, 5 % en `library` y `worker-service`— y §4.6 lo admite como tipo de `TC-XXXXX`. Lo que falta no es una categoría donde meterlo: es la pasada de ejecución que lo materializa. El E2E asistido por IA entra en la misma casa como capacidad opcional, no como nivel nuevo de la pirámide.

**El gate de integración de producto existe pero no dice con qué se cumple.** `Pipeline-Producto.md` §4.9 punto 6 lo define como «smoke test del producto levantada con sus artefactos», y ninguna regla declara dónde viven esos archivos ni quién los escribe. §5.8 le asigna productor —AG-08E, porque el sistema bajo prueba de una superficie web ya incluye su backend— y lo que queda pendiente es solo declarar en la regla que ese gate se cumple con la suite del barrido, en vez de pedir un smoke test aparte.

**`VER-XXXXX` es el vecino más cercano y conviene no confundirlo.** Un contrato de verificación trae comando, aserción evaluable y evidencia con fecha, y `Deriva-Rules.md` §2.4 destaca que su método de verificación es «siempre automatizable», a diferencia de una sonda visual. Pero verifica que **un sample corre**, no que **un journey de usuario se completa**. Son mecanismos hermanos con objeto distinto: el `VER-XXXXX` es el molde del campo de evidencia que §5.1 propone reutilizar, no un E2E encubierto.

#### Una polisemia que conviene desambiguar

El rastreo dejó a la vista que **«end-to-end» designa dos cosas distintas dentro del framework**, y las dos son legítimas:

| Uso | Qué designa | Dónde aparece |
| --- | --- | --- |
| Nivel de testing | El escalón superior de la pirámide: journey completo con el sistema levantado | 08 §2.2, §4.3, §4.9; 09 §5.1 |
| Alcance de una demostración | Un sample o un incremento que ejercita el flujo completo | 10, con `compose-end-to-end` como valor admitido de `<Progresion>` y «el sample ejecuta el flujo principal del CU end-to-end»; 06 «capacidad funcional end-to-end»; 07 «walking skeleton end-to-end»; `Intake-Rules.md` «valor end-to-end en el primer sprint» |

`Vocabulario-Rules.md` §9 gobierna exactamente este caso. Y su criterio negativo aplica: **no es un defecto que haya que corregir calificando todas las ocurrencias**, porque los contextos son disjuntos —nadie lee «walking skeleton end-to-end» como un nivel de pirámide—. Lo que sí corresponde es declararlo en el glosario técnico de la 11 con sus dos referentes, y resolver la forma desnuda en los artefactos que se leen por secciones. La razón práctica es concreta: el barrido de §8.3 lo va a ejecutar un agente, y un agente que lea «end-to-end» en un plan de sprint puede creer que le están pidiendo un nivel de la pirámide.

### 6.5 Qué dicen los estándares sobre dónde cae el E2E

El mapa anterior describe dónde interviene hoy en SDD. Esta sección responde una pregunta distinta: dónde lo pondrían los estándares que la propia 08 §1.1 declara adoptar —ISTQB, IEEE 829, ISO/IEC 25010, la pirámide de Fowler y la Scrum Guide—. Las dos respuestas no coinciden, y la diferencia es informativa.

**La primera precisión es que «E2E» no es un término de ninguno de esos estándares.** Es vernáculo de industria. ISTQB no tiene un nivel llamado end-to-end: tiene cuatro niveles —componente, integración, **sistema** y **aceptación**— y lo que la industria llama E2E cae en los dos últimos según qué se esté verificando. Un journey completo ejercitado contra el sistema desplegado es **testing de sistema**; el mismo journey evaluado contra el criterio de negocio del usuario es **testing de aceptación**. La pirámide de Fowler tampoco lo nombra así: su escalón superior es «UI tests» o «broad-stack tests».

Eso importa acá por una razón concreta: los dos niveles de ISTQB tienen **fuentes de verdad distintas**, y esa distinción es la que ordena la respuesta.

**Lo que dicta el modelo en V.** Es el estándar que responde más directamente a la pregunta, porque su tesis es exactamente que cada nivel de prueba se empareja con un nivel de especificación:

| Nivel de prueba | Se deriva de | Categoría SDD equivalente |
| --- | --- | --- |
| Componente / unitario | Diseño detallado | 05 Arquitectura |
| Integración | Arquitectura y contratos | 05 Arquitectura |
| Sistema | Especificación del sistema y NFR | 05 Arquitectura + 02 |
| **Aceptación** | **Requisitos de usuario** | **02 Especificación funcional** |

Es decir: bajo el modelo en V, **el E2E de aceptación pertenece al nivel de la 02**, no al de la 08. La 02 es la que declara los CU con criterios Given-When-Then, y un criterio Given-When-Then *es* el caso de aceptación escrito en prosa formalizable.

**Lo que dicta Specification by Example y BDD.** Refuerza lo mismo y va más lejos: los criterios de aceptación ejecutables no son documentación *sobre* la especificación, son la especificación misma en forma ejecutable. Los archivos `.feature` viven con la especificación funcional, no con la infraestructura de tests. Vale registrar que la 08 §4.3 punto 4 ya pregunta «dónde viven los archivos `.feature` o equivalentes» y deja la respuesta abierta, con lo cual el framework tiene la pregunta hecha y no contestada. Y no es un detalle menor de disciplina: SDD toma su nombre de *Specification-Driven Development*.

**Lo que dictan los cuadrantes ágiles.** Marick, y después Crispin y Gregory, ordenan las pruebas en dos ejes —orientadas a negocio contra orientadas a tecnología, y que apoyan al equipo contra que critican al producto—:

| Cuadrante | Qué contiene | Dónde cae en SDD |
| --- | --- | --- |
| Q1 técnico / apoya | Unitarias, componente | 08, cubierto |
| Q2 negocio / apoya | Ejemplos funcionales, pruebas de historia, prototipos y **maquetas** | 02 y 03 + Fase B2, cubierto |
| Q3 negocio / critica | **Exploratorio, escenarios, UAT, usabilidad** | **Sin lugar en SDD** |
| Q4 técnico / critica | Performance, carga, seguridad, `-ilities` | 05 aporta NFR, 08 planifica, 09 ejecuta |

El Q2 incluye la maqueta, y es una validación bonita del diseño del framework: la Fase B2 es exactamente una práctica de Q2, aunque `Maqueta-Rules.md` no la nombre así.

El Q3 es el hallazgo. **SDD no tiene ningún artefacto para prueba exploratoria ni para aceptación por un humano.** La 08 emite `Criterios-Validacion.md`, que define «sistema validado para release» con criterios numéricos y automatizables, y ahí se agota. Los cuadrantes sostienen que Q3 es irreemplazable por automatización, precisamente porque su valor está en encontrar lo que nadie especificó. Un framework que automatiza el barrido de lo especificado —que es lo que resuelve §8.3— necesita el Q3 más, no menos: cuanto más completa la suite generada desde la especificación, más se parece el verde de la suite a «cumple lo que escribimos» y menos a «funciona».

**Dos observaciones sobre las referencias normativas de la 08**, ninguna de las cuales invalida nada de lo que la regla dice:

- IEEE 829, que §1.1 cita para la especificación de planes y casos de prueba, fue **superado por ISO/IEC/IEEE 29119-3**. La estructura documental que la 08 adopta sigue siendo válida y reconocible; simplemente la referencia quedó datada. Actualizarla es una errata de §1.1, no un cambio de contenido.
- La 08 declara alinearse con ISTQB «para vocabulario de testing» y sin embargo su vocabulario de niveles es el de la pirámide de Fowler —unit, integration, e2e, snapshot—, no el de ISTQB —componente, integración, sistema, aceptación—. No es un error: la pirámide es más útil para dimensionar esfuerzo, que es lo que la §2.2 hace. Pero conviene que la regla lo declare en vez de dejar la contradicción implícita entre dos alineamientos.

**Síntesis: qué dictan los estándares para SDD.** Traducido a las doce categorías, el E2E se reparte en tres, y ninguna de las tres es opcional:

| Qué | Estándar que lo dicta | Categoría |
| --- | --- | --- |
| **Qué journey se verifica y con qué criterio** | Modelo en V (aceptación ↔ requisitos de usuario); BDD | **02**, que ya lo produce como CU con Given-When-Then |
| **Con qué nivel, qué proporción, qué tooling y qué cobertura** | ISTQB (estrategia y plan), Fowler (pirámide), 29119-3 (plan de pruebas) | **08**, que ya es su dueña |
| **Cuándo corre, en qué ambiente y si bloquea** | ISTQB (entorno y criterios de entrada/salida), práctica de CI/CD | **09** |
| Los `-ilities` medidos end-to-end | ISO/IEC 25010, Q4 | **05** los declara, **08** los planifica, **09** los mide |
| Exploratorio y aceptación humana | Cuadrantes, Q3 | **Ninguna hoy** |

La conclusión práctica es que **SDD ya está alineado en lo esencial y le falta declararlo**: la 02 es la fuente de verdad del E2E aunque ninguna regla lo diga con esas palabras, y la 08 se comporta como dueña de la estrategia, que es su rol correcto. El único desalineamiento real con los estándares es la ausencia de Q3.

### 6.6 E2E no es lo mismo que UI: alcance y driver son ejes distintos

Conviene fijarlo porque de acá se desprende cómo tiene que variar el barrido por tipo de entrega.

**E2E designa el alcance, no el medio.** Lo que define una prueba end-to-end es que ejercita el sistema completo, con sus capas reales conectadas y sin sustituir sus componentes internos: base de datos real, proceso levantado, cableado real. El **driver** —por dónde se lo empuja— es una decisión independiente:

| Driver | Con qué se maneja | En qué tipo de entrega |
| --- | --- | --- |
| Navegador | Playwright, Selenium, Cypress, o Stagehand con un modelo eligiendo el localizador | `web-monolith`, `web-microservices` con frontend |
| Interfaz de escritorio o móvil | Appium, FlaUI, el framework del runtime | `desktop-app`, `mobile-app-maui` |
| HTTP | Cliente HTTP contra el servicio levantado: `POST` y después `GET` del mismo recurso | `rest-api` |
| Línea de comandos | Ejecutar el binario y verificar stdout, stderr y exit code | `cli-tool` |
| Cola de mensajes | Publicar un mensaje y verificar el efecto persistido y el mensaje de salida | `worker-service` |
| API pública de la librería | Llamar la superficie pública con dependencias reales | `library`, cuando aplica |

**La propia 08 lo da por sentado, y es la mejor evidencia de que el eje es ése.** Su §2.2 asigna porcentaje de e2e a tipos que no tienen interfaz de usuario: 10 % a `rest-api`, 10 % a `cli-tool` —donde aclara «snapshot CLI en e2e», es decir, el snapshot del stdout **es** el e2e—, 5 % a `worker-service`. Si E2E fuera sinónimo de manejar una UI, esas tres filas no existirían. Y el gate de integración de producto de la 09 §4.9 punto 6 está definido como «smoke test del producto levantada con sus artefactos», sin decir por dónde se la empuja, que es lo correcto: depende de qué compone el producto.

El caso del bot ilustra el matiz que en la práctica todos aceptan. Su E2E usa Playwright porque la superficie bajo prueba es el panel, pero `HostServicioE2E` levanta el host real **con el gateway simulado**. O sea que sustituye una dependencia externa. En rigor ISTQB llamaría a eso testing de sistema y reservaría «end-to-end» para la cadena sin ninguna sustitución; en la práctica de industria, sustituir servicios de terceros y llamarlo E2E es lo normal, y es lo correcto —un E2E que dependa del servicio real de un tercero deja de ser determinista, que es el anti-patrón ya registrado en §9—.

#### Tres consecuencias que hay que escribir

**1. El barrido varía por tipo, y «recorrer los formularios» es solo su variante con UI.** El §1.2 de `Barrido-Tests-Rules.md` tiene que declarar qué superficie recorre el AG-08E en cada caso:

| `tipo_unidad_entrega` | Qué recorre el barrido | De dónde saca el inventario |
| --- | --- | --- |
| Con UI final | Las superficies y sus estados | `Linea-Base-Visual.md` y `Contrato-Datos-Maqueta.md` de la Fase B2 |
| `rest-api` | Los endpoints y sus contratos | Contrato OpenAPI versionado de la 05, CU de la 02 |
| `cli-tool` | Los subcomandos y sus combinaciones de flags | La 02 y la superficie declarada en la 05 |
| `worker-service` | Los tipos de mensaje y sus handlers | Contratos de la 05, CU de la 02 |
| `library` | La superficie pública | Contratos y extensibilidad de la 05, `VER-XXXXX` de la 10 |

Esto corrige un sesgo del mapa de §6.4: ahí la 03 y la Fase B2 figuran como «inventario de superficies», y eso vale **solo cuando hay UI**. En una entrega sin interfaz el inventario lo aportan la 02 y la 05, y la Fase B2 ni siquiera se ejecuta.

**2. El testing asistido por IA sí es específico de UI, y eso acota el flag.** Playwright y Stagehand manejan los dos un navegador; lo que Stagehand agrega es un modelo que elige el localizador a partir de una descripción en castellano. Esa capacidad no tiene análogo útil en un driver de cola de mensajes o de CLI, donde el «localizador» es un nombre de cola o un flag y no hay ambigüedad que resolver. Por lo tanto:

> El valor propuesto de `usa_testing_asistido_ia` es false cuando `tiene_ui_final` es false. Ofrecerlo en una entrega sin interfaz es ofrecer una capacidad que no aplica.

Eso refina la regla de cálculo del flag de §6.2 y encadena bien con §6.3: la suite asistida es candidata a resolver las sondas **visuales** de la matriz de sensado, que son las que solo existen cuando hubo Fase B2.

**3. Los dos ejes son ortogonales y conviene nombrarlos por separado.** Una entrega puede tener UI y no tener E2E de navegador —si sus journeys críticos se verifican por HTTP contra el backend—, y puede no tener UI y sí tener E2E. Confundirlos produce dos errores simétricos que vale la pena tipificar: creer que una entrega sin UI no necesita E2E, y creer que toda prueba que abre un navegador es E2E cuando puede ser un test de componente visual aislado.

### 6.7 Si conviene un repositorio aparte para el E2E

Existe como práctica, pero no es lo habitual, y lo que decide no es la costumbre sino una condición estructural. Conviene enunciarla en el vocabulario del framework, porque así deja de ser opinión:

> El E2E vive con la unidad de entrega que aporta la **superficie de conducción**: aquella por la que se empuja el sistema. Que el journey ejercite además otras entregas no cambia dónde vive, porque §5.8 establece que el backend que sirve a un front es parte del sistema bajo prueba y no un tercero.

El criterio anterior de este análisis —«si el journey cruza entregas, ninguna es su dueña»— era impracticable: un front siempre necesita su backend, así que ese supuesto excepcional era en realidad el caso normal, y aplicarlo habría mandado casi toda suite E2E a un repositorio aparte. Que es justamente lo contrario de lo que conviene.

Lo que conviene es tenerlo cerca del código: un E2E que vive en otro repositorio pierde lo más valioso —que el PR que cambia un formulario actualiza su test en el mismo commit— y obliga a coordinar versiones entre repos. Ése es el modo en que las suites separadas se pudren: son «el repo del otro», nadie las actualiza en el mismo cambio que las rompe, y terminan rojas de forma crónica hasta que se apagan.

El repositorio propio queda para el caso en que **no hay una única superficie de conducción**: varios fronts que se ejercitan juntos, o un journey de servicio a servicio sin interfaz. Es bastante más raro de lo que la formulación anterior sugería. La decisión se registra como ADR en 05 de nivel producto.

Vale notar la simetría con §5.3, porque es el mismo criterio aplicado a otra cosa: ahí el compose se va a un repositorio aparte **porque su ciclo de vida es el de la infraestructura, no el del producto**; acá el E2E se queda **porque su ciclo de vida es exactamente el del código que prueba**. En los dos casos la pregunta que decide es la misma: ¿cambia junto con el código, o cambia por su cuenta?

### 6.8 El E2E que cruza unidades de entrega ya tiene lugar

No hace falta artefacto nuevo. `Rules-Devops.md` §4.9 punto 6 define el gate de integración de producto como «smoke test del producto levantada con sus artefactos», en `Pipeline-Producto.md`, obligatorio para productos con más de una unidad de entrega. El E2E que atraviesa entregas es ese gate. Lo único que falta es que su pasada de ejecución produzca el workflow que lo corre, que es el mismo mecanismo de §5.1.

---

## 7. Impacto normativo

Estimación del costo de la Posición B, según la tabla «Reglas de intervención sobre el framework» del `README.md`.

| Archivo | Cambio | Severidad | Fundamento |
| --- | --- | --- | --- |
| `Rules-Devops.md` (4.0) | Pasada de ejecución, matriz de artefactos ejecutables por D8, clase de stage no bloqueante, runner como recurso declarado en `entornos-deploy.md` | **Major** | Cambia el conjunto de artefactos que produce y agrega gating por tipo D8 |
| `Rules-Calidad-Y-Pruebas.md` (4.1) | Pasada de ejecución de la batería de tests; dos clases de suite E2E con su rol | **Major** | Ídem: cambia el conjunto de artefactos |
| `Master-Prompt.md` | Filas nuevas de pasada de ejecución en §6; flag `usa_testing_asistido_ia` en §4; §7.1 pasa a verificar producto de fase declarada | **Major** | Agrega fases al plan |
| `PRODUCT-INTAKE-template.md` | Subsección de nivel producto para el entorno de construcción (§6.2); P.6 suma la declaración de testing asistido; P.8 referencia el entorno en vez de redeclararlo | **Major** | El `README.md` computa la versión del conjunto contando también las plantillas de intake |
| `Intake-Rules.md` | Validación bloqueante: `usa_testing_asistido_ia` true sin servicio de inferencia declarado es intake incompleto | Minor | Agrega un criterio de validación sin cambiar la estructura del intake |
| `Barrido-Tests-Rules.md` (nuevo) | Cuerpo de reglas de AG-08E, con la estructura de §5.5 | Alta nueva | Regla transversal nueva, no categoría. Mismo estatuto que `Maqueta-Rules.md` |
| `Root-Rules.md` | Excepción a D3 para nombres impuestos por herramienta; layout de salida de los ejecutables y de los scripts de E2E de nivel producto | **Major** | Toca el layout canónico y roza una invariante |
| `SDD-User-Guide.md` | Tramo II con sus dos pasadas nuevas | Acompaña | Exigido en la misma intervención al agregar fases |
| Nota de coherencia | Alcance, inventario, verificación de invariantes, trazabilidad, observaciones, veredicto | Obligatoria | Intervención sobre varios archivos |
| `CHANGELOG.md` y `_legacy/<version>/` | Entrada nueva y copia del conjunto normativo superado | Obligatorio | Es el mecanismo de versionado del framework |

Sobre la severidad de las dos reglas de categoría hay una lectura alternativa defendible: la tabla del `README.md` admite «agregar un artefacto a una categoría» como **minor**. La razón para no tomarla es que acá no se agrega un artefacto sino una **pasada** con su propio momento de ejecución, su propia clase de evidencia y su propio gating por tipo D8, y la fila de major menciona expresamente el cambio de gating por tipo D8. Queda igualmente como punto a confirmar por quien intervenga el framework.

---

## 8. Decisiones

Se enuncian con la forma de `Master-Prompt.md` §7.0: son decisiones que interrumpen, no notas al pie. Las dos primeras están tomadas; las tres siguientes llevan recomendación fundada y esperan confirmación.

### 8.1 Resuelta — Alcance del corte de despliegue

El framework **no emite compose**, ni productivo ni de referencia. Corta en el `Dockerfile` y el workflow de imagen; el proyecto de despliegue es un repositorio aparte con su propio ciclo, y la instancia es territorio de operación. Fundamento y modelo de tres estaciones en §5.3. Lo que queda por escribir en la regla es el apuntador de `entornos-deploy.md` al repositorio de despliegue.

### 8.2 Resuelta — Cómo se declara la capacidad de IA

La decisión de usar pruebas asistidas se declara **por unidad de entrega en §17 P.6**, y el runner con sus capacidades se declara **una vez a nivel producto**, referenciado desde §17 P.8. Desarrollo en §6.2.

Vale registrar por qué esta resolución es mejor que la que el análisis proponía, porque el patrón se repite: la pregunta original era «¿en qué nivel va el flag?», y la respuesta correcta fue que no era un flag. **Un dato que no condiciona qué se genera sino qué es posible generar no es gating: es un recurso declarado.** El framework ya distingue las dos cosas —§16 declara la estructura de repositorio como recurso y no como flag—, así que no hay conjunto cerrado que extender ni arbitraje que hacer. La detención se disuelve.

### 8.3 Resuelta — Quién escribe el proyecto de tests

**Decisión del PO (2026-08-15): los escribe el agente, en una pasada al terminar la solución, recorriendo las superficies construidas y armando los scripts contra la especificación.**

Queda en tres momentos, no en dos:

| Momento | Quién | Cuándo | Qué produce |
| --- | --- | --- | --- |
| Esqueleto | AG-08 | Fase E, pre-handoff | Los dos proyectos, el árbol por capas, los fixtures de soporte, el degradado por omisión. Se deriva de insumos que ya existen sin código: las capas de 05, la pirámide y los umbrales de §2.2, el tipo D8 |
| Barrido de generación | AG-08E | Al cerrarse el desarrollo asistido de la entrega | Recorre las superficies construidas y emite los scripts de test dentro del esqueleto |
| Verificación | AG-08 | Cierre de la pasada | `actual output` y `status` de cada `TC-XXXXX`; matriz de cobertura contra lo construido |

A partir de ese cierre la relación se invierte: los fixes y features que vengan después **se validan contra la suite**, y no disparan un barrido nuevo. Desarrollo en §5.5.3.

**El barrido no descubre las superficies: las tiene declaradas.** Es lo que evita que sea un crawler a ciegas. El inventario de insumos, la secuencia con sus detenciones, las reglas constructivas y los criterios de aceptación están en **§5.5**, escritos como especificación cerrada. Acá quedan solo las tres consecuencias de la decisión de titularidad:

1. **El esqueleto sigue siendo previo.** El barrido escribe *dentro* de una estructura que no diseñó, igual que el codificador escribe dentro de una arquitectura que no diseñó. Es lo que preserva la titularidad de `Master-Prompt.md` §6 punto 4 y lo que responde al pedido de que el planteo quede armado para escalar.
2. **La regla que hace o rompe la pasada es la dirección de la verdad** —el sistema aporta el localizador, la especificación aporta el resultado esperado— y la discrepancia entre ambos es hallazgo de deriva, no un expected a ajustar. Son R1 y R2 de §5.5.5.
3. **La precondición de la Fase I cambia de naturaleza.** Hoy §7.1 exige «los tests corren» como supuesto sobre el repositorio; con el barrido declarado, eso pasa a ser la salida de esta fase.

### 8.4 Resuelta — La suite asistida entra, y se confirma al llegar a la categoría

**Decisión del PO (2026-08-15): entra al framework, y el orquestador pregunta al llegar a la categoría** si se desea correr el agente especializado en construir este tipo de test y cuál es el runner apropiado para hacerlo.

Eso cambia el momento de la decisión, no el mecanismo de §6.2. Queda así:

| Qué | Cuándo | Quién decide |
| --- | --- | --- |
| Los entornos de construcción disponibles, con sus capacidades | Intake, nivel producto | El que completa el intake |
| Valor propuesto de `usa_testing_asistido_ia` | Al derivar los flags, §4 | El orquestador, por regla |
| **Confirmación de correr el agente y elección del runner** | **Al llegar a la fase del barrido** | El humano |

**El patrón ya existe en el framework y no hay que inventarlo.** `requiere_maqueta` se calcula con una regla que **propone** un valor y lo **confirma el humano**, y el paso 1 de la Fase B2 le ofrece al humano de qué modelo UX-UI partir leyendo el catálogo. Acá es lo mismo: el orquestador propone, lista los entornos declarados en el intake con sus capacidades, y el humano confirma o cambia.

Hay una diferencia con `requiere_maqueta` que conviene declarar en vez de disimular: aquel se confirma al aprobar el plan inicial, y éste se confirmaría bastante más tarde. `Master-Prompt.md` §4 dice que los flags son inmutables una vez confirmados y que un cambio obliga a retroceder a la fase más temprana afectada. La razón por la que acá diferir no rompe nada es concreta y vale como criterio general:

> Un flag puede confirmarse tan tarde como la última fase que no dependa de él. `usa_testing_asistido_ia` no condiciona ninguna categoría anterior al barrido: nada aguas arriba se bifurca por su valor.

Y diferir compra dos cosas que decidir al inicio no puede dar. Al aprobar el plan todavía no se sabe cuánta superficie de interfaz terminó teniendo el producto, que es lo que determina si el asistido rinde. Y la disponibilidad de un runner es un hecho del momento, no de seis semanas atrás: el servicio de inferencia puede haberse caído, haberse mudado o haber cambiado de modelo.

De ahí se sigue un ajuste sobre §6.2: la subsección de intake declara **los entornos de construcción disponibles**, en plural, con una fila por runner y sus capacidades. Elegir entre ellos es la pregunta que se hace al llegar a la categoría.

Los dos límites de la capacidad van escritos en la regla, no en una nota: es **siempre no bloqueante**, y su alcance declarado es **taller de autoría**, no batería de regresión.

### 8.5 Recomendada — Una sola intervención, major

**Recomendación: una intervención, con severidad major, publicada como una versión del framework.**

La alternativa razonable es partirla en dos —primero el esqueleto de tests en la 08, después los ejecutables en la 09—, y tiene a favor que el estado intermedio es coherente: un repositorio con proyectos de test bien estructurados y sin CI todavía. Lo que la descarta es que las dos pasadas comparten el **mismo mecanismo**: la pasada de ejecución, el campo de evidencia, la cláusula de trazabilidad del artefacto ejecutable al documento. Definirlo dos veces, con dos meses de distancia, es cómo se producen dos formulaciones que divergen. El framework ya tiene ese antecedente documentado en `Rules-Calidad-Y-Pruebas.md` 3.2: un criterio replicado en once reglas mandando a nueve destinos distintos.

Sobre la severidad: major, por lo que ya argumenta §7. La lectura alternativa —«agregar un artefacto» es minor— no aplica porque lo que se agrega es una pasada con su propio momento, su clase de evidencia y su gating por tipo D8.

---

## 9. Anti-patrones propuestos

Para incorporar a `Rules-Devops.md` §4.8 y a `Rules-Calidad-Y-Pruebas.md` §4.10 si la intervención avanza. Los catorce están respaldados por la evidencia citada en §10.

| Anti-patrón | Problema | Solución |
| --- | --- | --- |
| Política de pipeline sin archivo que la ejecute | `pipeline-ci-cd.md` describe siete stages y el repositorio no tiene ningún workflow; la política se lee como si el pipeline existiera | Pasada de ejecución con evidencia de corrida real, o declaración explícita de `No verificado — sin código` |
| Prueba no determinista como gate bloqueante | Un test que a veces pasa erosiona la confianza en el tablero entero | Clase de stage no bloqueante y de disparo manual para la suite asistida |
| Compose en el repositorio del producto | Filtra puertos, volúmenes y red de un operador al artefacto genérico; y un compose emitido que nadie corre envejece hasta contradecir al real, que es una segunda fuente | Corte en el `Dockerfile` y el workflow de imagen; el compose vive en el repositorio de despliegue y su parametrización, en la instancia |
| Gate de cobertura que arrastra el nivel e2e | El gate unitario ejecuta tests que necesitan navegador y levantar el host; se vuelve lento y frágil | Separar la ejecución del e2e por el mecanismo que el stack ofrezca, registrado como ADR. El mecanismo no se impone desde la regla |
| E2E de front con el backend simulado | Se llama end-to-end a un test que sustituye el componente central del producto; pasa en verde mientras la integración real está rota | El backend que sirve al front es parte del sistema bajo prueba. Solo se simulan servicios de terceros ajenos al producto |
| Confundir E2E con manejo de UI | Se concluye que una entrega sin interfaz no necesita e2e, o se cuenta como e2e un test de componente visual aislado | E2E designa el alcance —sistema completo, capas reales—; el driver (navegador, HTTP, CLI, cola) depende del tipo de entrega |
| Test escrito mirando la aplicación en vez de la especificación | El expected se deriva de lo que el sistema hace; la suite canoniza los bugs existentes y pasa al 100 % desde el primer día | El sistema aporta el localizador; el CU aporta el resultado esperado. La discrepancia entre ambos es hallazgo de deriva, no un expected a corregir |
| Umbral de capa declarado que ningún job verifica | La cobertura de una capa se excluye de la suite unitaria «porque la cubre el e2e», y el job de e2e no recolecta cobertura: el umbral queda escrito y sin verificar | Cada capa con umbral en §2.2 tiene un job que lo mide y lo bloquea (propiedad P3 de §5.4) |
| Test que falla cuando el entorno no puede verificarlo | Sin navegador instalado la suite entera se pone roja localmente, y el equipo aprende a ignorar el rojo | Omisión explícita con motivo; el test distingue «no puedo verificar acá» de «esto está roto» |
| Árbol de tests que no espeja las capas | La cobertura por capa que 08 §2.2 exige se vuelve inverificable, y el esqueleto no dice dónde va el test del componente nuevo | Un directorio de tests por capa de la arquitectura de 05, con al menos un test vivo en cada uno |
| Artefacto ejecutable sin cita al documento que materializa | Nadie puede auditar si el pipeline ejecuta la política declarada o alguna otra | Comentario de cabecera con documento y sección, e identificadores de stage que resuelvan contra `pipeline-ci-cd.md` |
| E2E contra el servicio real de un tercero | La suite depende de disponibilidad, credenciales y datos ajenos; deja de ser determinista | Simular la integración externa en el fixture, sin red ni token |
| Servicio de IA declarado por IP del host | Desde un runner en macvlan la IP del host es inalcanzable; el workflow falla en un punto que no es el que se está probando | Declarar el endpoint tal como se resuelve **desde el runner**, con su nombre de servicio |
| Esquema con rama de escape en la herramienta asistida | Un modelo capaz devuelve `{"action": null}` de forma silenciosa y con JSON válido, y la prueba «pasa» sin hacer nada | Esquemas sin rama nula; toda primitiva declara acción o falla |

---

## 10. Evidencia consultada

Toda afirmación de este documento se apoya en uno de estos archivos, leídos el 2026-08-15.

| Fuente | Qué aporta |
| --- | --- |
| `IA.SDD/README.md` | Modelo de tres repositorios, mapa de las doce categorías, invariantes D1-D9, reglas de intervención y su severidad |
| `IA.SDD/SDD/Devs/Rules/Rules-Devops.md` (4.0) | §0 posición y frontera con 11; §2.1 tabla maestra de seis artefactos `.md`; §2.2 modelo de ambientes y artefacto publicable por D8; §4.2 estructura del pipeline; §4.7 tabla de stages con columna bloqueante; §4.8 anti-patrones; §4.9 pipeline de producto y gate de integración |
| `IA.SDD/SDD/Devs/Rules/Rules-Calidad-Y-Pruebas.md` (4.1) | §0 dos clases de sonda; §2.1 tabla maestra; §4.3 tooling; §4.6 catálogo de TC con `actual output`; §6 criterios sobre la matriz de sensado |
| `IA.SDD/SDD/Devs/Orchestrator/Master-Prompt.md` | §4 tabla de flags y sus niveles; §6 plan de fases A-J y la regla «ninguna categoría emite un artefacto de otra»; §7 separación en dos tramos; §7.0 detención por arbitraje; §7.1 precondición dura; §7.2 tratamiento de la evidencia; §12 handoff |
| `<banco-privado-de-pruebas-e2e>/README.md` | Las dos suites y sus disparadores; costo medido 3 s contra ~600 s; rol de red de seguridad y rol de taller; etiquetas `[self-hosted, i7infra-dev]`; caché `/cache/ms-playwright`; endpoint `http://my-ai-api:11434` y la macvlan; hardware sin AVX2 ni GPU; piso de ruido 10–15 %; la trampa del esquema con rama nula |
| `DEV/Discord.Bot.Moderador.Core` | Caso de referencia del estado objetivo. `Dockerfile`; `.github/workflows/` con `ci.yml`, `docker-publish.yml`, `publish.yml` y `benchmark.yml`; `scripts/ci/verificar-cobertura.ps1`; `tests/` con proyecto unitario por capas y proyecto E2E standalone; `SDD2.2D/docs/` con las categorías 08 y 09 generadas. Las citas cruzadas de los workflows a `pipeline-ci-cd_v1.0.md` §2 y de `.csproj` a `estrategia-testing_v1.0.md` §1/§2/§7 |
| `Repos-Docker/Home/Container.Discord.Bot` | Segunda estación del modelo de §5.3: `docker/docker-compose.yml`, guía de instalación y `CHANGELOG.md` propios, en repositorio separado. Su `README.md` documenta la tercera estación, `<home>/docker/discord-bot`, con el compose parametrizado y la base de datos de la instancia |

Lo que este documento **no** afirma, por no tener evidencia: que la suite asistida resuelva efectivamente las sondas visuales de la matriz de sensado (§6.3 lo plantea como hipótesis a verificar); que la separación en tres estaciones de §5.3 esté hoy escrita en alguna regla del framework (está operando, no está normada); y que los artefactos ejecutables del caso de referencia hayan sido emitidos por una fase declarada de SDD (no lo fueron: los escribió el ciclo de codificación, y ése es exactamente el hueco de §3.1 y §3.2).

---

## Control de cambios

| Versión | Fecha | Descripción |
| --- | --- | --- |
| 1.0 | 2026-08-15 | Análisis inicial: los tres huecos, el debate de tres posiciones, la propuesta de dos pasadas y el tratamiento de la suite asistida por IA. |
| 1.1 | 2026-08-15 | Cierre de la decisión de alcance del despliegue por el PO: el framework no emite compose en ninguna forma. §5.3 se reescribe sobre el modelo de tres estaciones verificado en `Discord.Bot.Moderador`. Se incorpora §5.4 con las seis decisiones estructurales del esqueleto de tests y la cláusula de trazabilidad de los artefactos ejecutables, derivadas del mismo caso. §5.2 suma la columna de proyecto de tests. Cinco anti-patrones nuevos en §9. |
| 1.13 | 2026-08-16 | **Corrección de fondo (§5.8): el sistema bajo prueba es el producto levantado, no el front solo.** La versión anterior trataba «front separado del backend» como journey que cruza entregas y quedaba fuera del alcance del agente, lo que dejaba afuera el caso normal en vez del excepcional: un front va siempre con su backend y ni siquiera se codea sin la API. Se declara que el E2E de una superficie web incluye por definición el backend que la sirve y su persistencia, y que solo se simulan terceros ajenos al producto. Consecuencias: el alcance del agente se define por superficie de conducción y no por unidad de entrega; el gate de integración de producto pasa a tener productor; §6.7 corrige su criterio de repositorio propio, que con el criterio anterior habría mandado afuera a casi toda suite; y se resuelve cómo se levanta el producto para correr la suite —arnés de prueba efímero declarado en el proyecto de tests— sin contradecir la decisión de no emitir compose, porque despliegue y fixture tienen propósito y ciclo de vida distintos. Anti-patrón nuevo en §9. |
| 1.12 | 2026-08-16 | §5.7 agrega el ejemplo integrado de un front web: tabla de qué queda en el repositorio y quién lo emitió, para que el prompt de intervención no deje ambigüedad de titularidad. Precisa que el barrido emite solo E2E mientras el esqueleto de la Fase E emite los dos proyectos; que el framework no dicta la herramienta —la declara el intake §17 P.6— sino el rol; que la determinista y la asistida son dos proyectos separados y no alternativas; y que el E2E de un front que necesita su backend levantado cruza entregas y cae fuera del alcance acotado del agente. |
| 1.11 | 2026-08-16 | **§5.5 se reescribe como especificación cerrada del agente AG-08E**, redactada para que el prompt de intervención derive de ella el archivo de reglas sin rediscutir el alcance: qué es y por qué queda en la 08 (es el ejecutor que le faltaba a las sondas visuales de la matriz de sensado, de la que la 08 ya es dueña operativa), alcance acotado a interfaz web, momento de disparo, secuencia de cinco pasos con tres detenciones, seis reglas constructivas, artefactos que produce, criterios de aceptación clasificados, secciones del archivo de reglas y tres puntos abiertos. El criterio de estabilidad se reemplaza por el que fijó el PO —el cierre del desarrollo asistido— y con él el barrido pasa a ser un evento único: los cambios posteriores se validan contra la suite en vez de disparar barridos nuevos. §8.3 se poda para no duplicar. |
| 1.10 | 2026-08-16 | Acotamiento del alcance por el PO: el barrido cubre interfaces web y solo sobre páginas del entregable final ya estabilizadas. §5.5.0 declara la condición de activación y por qué se acota el agente y no la categoría —la 08 §2.2 sigue asignando e2e a los tipos sin UI, que se escriben como hasta ahora—. §5.5.1 ancla «estabilizada» en tres señales que el framework ya emite, con confirmación humana en el punto de §8.4, y acepta que el barrido sea una pasada por superficie y no una al final. §5.5.2 ubica el agente: con el alcance acotado es el ejecutor que le faltaba a las sondas visuales de `Matriz-Sensado-Deriva.md`, de la que la 08 ya se declara dueña operativa; no se agrega categoría. |
| 1.9 | 2026-08-16 | Distinción entre alcance y driver (§6.6): E2E designa el sistema completo con capas reales, y el medio por el que se lo empuja —navegador, HTTP, CLI, cola de mensajes, API pública— depende del tipo de entrega. Tres consecuencias escritas: la variante del barrido por tipo, que corrige el sesgo hacia UI del mapa de §6.4; el valor propuesto de `usa_testing_asistido_ia` en false cuando `tiene_ui_final` es false, porque la capacidad de elegir localizador por descripción solo aplica a drivers de interfaz; y la ortogonalidad de los dos ejes. Anti-patrón nuevo en §9. |
| 1.8 | 2026-08-16 | Encuadre normativo del E2E (§6.5): qué dictan ISTQB, el modelo en V, Specification by Example y los cuadrantes ágiles sobre en qué nivel de especificación cae. Conclusión: la fuente de verdad del E2E de aceptación es la 02, la estrategia es de la 08 y la ejecución de la 09, y SDD ya está alineado en lo esencial sin declararlo. Se registra el único desalineamiento real —ausencia de artefactos de Q3, exploratorio y aceptación humana— y dos erratas de referencia en la 08 §1.1: IEEE 829 superado por ISO/IEC/IEEE 29119-3, y el alineamiento simultáneo a ISTQB y a Fowler con vocabularios de nivel distintos. |
| 1.7 | 2026-08-16 | Mapa de intervención del E2E en la cadena (§6.4), levantado rastreando «e2e» y «end-to-end» en los dieciocho archivos de reglas: nueve filas con el rol de cada categoría, la constatación de que la 08 es dueña única y de que lo único sin dueño son los scripts del E2E que cruza entregas, y la distinción entre `VER-XXXXX` y E2E. Se registra además la polisemia de «end-to-end» —nivel de la pirámide contra alcance de una demostración— con el tratamiento que `Vocabulario-Rules.md` §9 prescribe para contextos disjuntos. |
| 1.6 | 2026-08-15 | Cuerpo de reglas del agente del barrido y ubicación del E2E. §5.5 propone `Barrido-Tests-Rules.md` con AG-08E calcado de `Maqueta-Rules.md` / AG-03M —el precedente del framework para un agente especializado con fase y reglas propias que no abre una categoría nueva—, con su tabla de secciones y la cláusula de titularidad. §6.4 responde en qué categoría vive el E2E (ya vive en la 08; falta la pasada de ejecución) y fija el criterio del repositorio propio: el E2E vive con la unidad de entrega cuyo journey verifica, y solo se separa cuando el journey cruza entregas. |
| 1.5 | 2026-08-15 | Cierre de 8.4 por el PO: la suite asistida entra al framework y la decisión de correr el agente especializado, más la elección del runner, se confirman **al llegar a la categoría**, con el patrón propone-el-orquestador / confirma-el-humano que `requiere_maqueta` y el paso 1 de la Fase B2 ya usan. Se declara el criterio que lo habilita —un flag puede confirmarse tan tarde como la última fase que no dependa de él— y la subsección de intake pasa a declarar los entornos de construcción en plural, una fila por runner. |
| 1.4 | 2026-08-15 | Cierre de 8.3 por el PO: el barrido de generación de tests lo hace el agente al terminar la solución, recorriendo las superficies construidas contra la especificación. Se declara el inventario de insumos del barrido —línea de base visual, contrato de datos, CU con Given-When-Then, TC referenciales, matriz de sensado—, la cláusula de dirección de la verdad (el sistema aporta el localizador, la especificación aporta el resultado esperado), el tratamiento de la discrepancia como hallazgo de deriva y el ajuste que §7.1 necesita. Anti-patrón nuevo en §9. |
| 1.3 | 2026-08-15 | Corrección de §5.4 punto 2. La versión 1.1 promovía a patrón el mecanismo del caso de referencia —proyecto e2e fuera del archivo de solución—, y no corresponde: ningún estándar de testing se pronuncia sobre pertenencia a un archivo de solución, y escribirlo como regla hardcodearía un ecosistema en una regla que cubre ocho tipos de entrega. Se reemplaza por tres propiedades verificables en cualquier stack (P1 a P3), con el mecanismo registrado como ADR. Origen: la pregunta sobre si conviene la exclusión, cuya verificación encontró que el umbral de cobertura de presentación del caso de referencia no lo verifica ningún job. Dos anti-patrones reformulados en §9. |
| 1.2 | 2026-08-15 | Resolución de las decisiones abiertas. §6.2 se reescribe: la capacidad de IA deja de ser un flag de ámbito nuevo y se parte en dos declaraciones de intake —la decisión en §17 P.6 por unidad de entrega, el runner como recurso de nivel producto—, con lo que la detención por extensión de conjunto cerrado se disuelve. §8 pasa de «decisiones pendientes» a «decisiones», con dos resueltas y tres recomendadas: el proyecto de tests se parte en esqueleto (AG-08, pre-handoff) y tests concretos (codificación, tramo II); la suite asistida entra como capacidad opcional apagada por defecto; la intervención se hace de una sola vez y en major. §7 suma el impacto sobre la plantilla de intake y sobre `Intake-Rules.md`. |
