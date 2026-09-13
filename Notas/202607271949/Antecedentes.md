
## respuesta de la mesa

Lo que la mesa estableció, y que R0 no podía ver
La disyuntiva con la que te presenté el estado era falsa. La etapa i no «ocurrió» ni «no ocurrió»: está abierta desde el 2026-08-27 (PR #95 «arranca la etapa i»; el informe del 2026-08-27 §10.3 la declara como salida D arrancada). El defecto es más preciso y más barato: el entregable de una etapa abierta cambió el 2026-09-06 y ningún documento lo absorbió.

Nueve roles, 55 hallazgos, 42 procedentes, 14 parches, 5 escaladas. Lo que más pesa:

I-1 aprueba en verde contra el despliegue real — reproducido: el guion solo comprueba que deploy-front-ftp.yml exista. La puerta de la etapa podría cerrarse sin haber medido nada.
El mismo main se publicó dos veces el mismo día, a dos topologías: el filtro del flujo FTP cubre exactamente las rutas que tocó el PR #187.
X-10 —«túnel saliente con dominio propio»— es una exclusión vigente del intake y una incógnita «viva» en §22, y es literalmente lo que desplegaste.
25 líneas del corpus afirman hoy en presente algo falso sobre el canal de publicación; Pipeline-CI-CD.md 3.8 se emitió ayer sin tocarlo.
Cuatro contradicciones entre especialistas, todas dirimidas. Una fue contra el especialista que la sostuvo: ADR-14003 no está «superado» — su campo 5 dice vigente, y «superado» ni siquiera es un valor válido del conjunto cerrado.
Lo que necesito de vos
Cinco escaladas agrupadas (§9 del registro), cada una con opciones, recomendación y qué hace la mesa si no respondés: E-01 qué es el entregable de la etapa i ahora (bloquea 3 de los 14 parches); E-02 la API quedó públicamente alcanzable, con cinco puntos sin credencial y sin límite de tasa; E-03 los secretos de FTP vivos; E-04 qué evento dispara una etiqueta de versión; E-05 el estado durable del front sin respaldo.

Y la decisión de R2: la recomendación es A · reparar primero, y después D, con la alternativa razonable (D directo) y su motivo para descartarla. Once de los catorce parches no dependen de ninguna escalada y se pueden aplicar en cuanto digas.

>

lo que paso, y es lo que presentaria como argumento a la mesa , y es lo que la mesa debio deducir, durante la fase de desarrollo se trabajo bajo un requerimiento muy claro de que el despliegue debia hacerse el front en somee.com y el back en un servidor local de i7infra dockerizado, y ahi tenia sus razones - luego se finalizo y se desplego de esa manera - finalmente se termino el producto y se cambio el despliegue porque i7infra ahora tiene un dominio pago en cloudflare y se cuenta con la posiblidad de desplegar mediante un tunel bajo un dominio publico - cosa que de esta manera satisface mejor la razon de porque el primer despliegue - no obstante , quedo como decision mantener el yml para hacer el despliegue del front por ftp hacia somee, la razon de esto ultimo fue dejarlo como alternativa y como antecedente de despliegue , - lo que estoy viendo , por tus cuestionamiento - que esto no se acento adecuadamente en la documentación de especificación, y que por eso, ahora la mesa no pudo plantear un plan de migración adecuado, o al menos, llego a una suerte de encrusijada, - veo  que me parece que el `Framework SDD` no es cicliclo, entonces al surgir nuevos casos, no se generan nuevos backlog de sprint o nuevogs backlog funcionales y/o tecnicos, es decir el software como producto evloluciona, y esa evlocuión no se registra como otro cilclo de ajustes y nuevas caracteristicas -Plantea esto en la mesa, porque tal vez el `framework SDD` necesite un plan de ajustes en este sentido así cuando, tanto en sus fases ciclicas de desarrollo, como posterior en sus fases de migración pueden ver ese marco evolutivo y entender que es lo que se tiene que adaptar de todo esa documentación, si son cuestiones de nomenclatura, si son cuestiones de enmarcamiento de la documentación o si son cuestiones de estructurales del propio del proyecto, y aquí en esto último, es diferente, porque ahi se reconoceria su estado actual y de ahi se replantearia un nuevo ciclo de backlog tanto tecnicos/funcionales y de sprint. Plantea este caso a la mesa, van a necesitar especialistas en metodologias agiles y manejo de proyecot, si el framework requiere ajustes reportalo en `/IA/SDD/IA.SDD.Documentacion/Reportes` , si se genera nuevo reporte aprovecha y arma el proximo prompt de aplicación en `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Fixs` podes usar lo que ya fue hecho en esas dos carpetas para guiarte el como y las nomenclaturas usadas (leete esto `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Fixs/README.md`)

por otro lado , ahora tenemos un planteo de reestructurar la solucion y sus proyectos bajo un nuevo arbol dentro de la solución de visual studio, - estos otro ciclo que debe iniciarse en el cual adapte y reexprese lo que estaba bajo la nueva estructura propeusta.

a ver si esto responde parte de tus preguntas


>

ok, pero te aclaro, algo en la fase de reanudación y en la aplicación de la migración - en especial en la fase de migración, se debe evaluar si se requiere reestructurar el intake - por eso se debe entender si hay nuevas funcionalidades y/o decisiones de diseños añadida durante el ciclo de especificación y/o codificación. 

si se reestructura y surgen huecos de especificación - se debe evaluar de dejarlos de tal forma que sean correlacionables con el ciclo de diseño y/codeo en su historial - esto planteaselo a la mesa, que lo debatan como tema central entorno a estos temas . porque lo que no quiero que cuando migre me llene de preguntas fuera de contexto como suele pasar en cuanto a que los agentes se encuentran con situaciones que han generados ellos y de golpe me descargan a mi problemas que han generado ellos y que pudieron haber resuelto si el analisis se hubiese hecho sobre todo el conjunto y luego afinando donde corresponda - aqui es importante la habilidad de correlacionar que se atribuya a algun agente de los que hay o que se sume alguno nuevo en la orquestacion si se considera necesario.

lanza la mesa con mis planteos y a haber si llegan a un plan y que se evalue y corrija en base a sobre como sería su aplicacion del plan

>>
El error que corregí
El reporte 25 decía que ADR-08007 «agrega el séptimo miembro del contrato de la fachada». El ADR decide exactamente lo contrario — su título es «no en una séptima función» y su tabla descarta esa salida porque el recuento de seis lo fijaste vos y está citado en cinco documentos. El hueco existe igual (el intake no tiene ninguna ocurrencia del aviso), pero es más fino: el contrato ganó una dirección de vuelta y subió de versión. Reporte a 1.2. Y eso mismo pasó a ser la vara: un mecanismo que sólo mire recuentos no lo encuentra.

Los dos P0 de aplicación
El cruce que proponía la migración da CERO filas hoy sobre tu destino: todos los ADR de producto son anteriores a la última entrada del intake. Comparar contra una fecha global del documento no puede detectar un hueco en una sección que ninguna entrada posterior tocó. Recalibrado a fecha por sección.

Tu requisito duro tenía una trampa: el campo Procedencia lo iba a declarar el mismo agente que quizá no se dio cuenta de que generó el problema — habría escrito «preexistente» de buena fe y el requisito quedaba cumplido en la letra. El refutador encontró la pieza que ya existe: el método archiva el estado previo antes de despachar. Entonces la procedencia se calcula, no se declara: si el hecho no está en ese archivo, es propio, diga lo que diga el agente. Y ante la duda, se declara propia — misma asimetría de costos que el método ya usa.

El plan, en orden y con su modo de falla
Parte	Corrección	Si se aplica mal
1.º	Escalada	Procedencia derivada; pregunta previa en dos pasos; el registro agrupa toda detención de la fase antes de la primera salida	La cuenta de detenciones «propias» tiende a cero: nadie se autoincrimina
2.º	Correlación	Campo de dirección en la figura existente (no figura nueva); disolución del rol atada al contador que ya existe	El rol nunca se disuelve y presiona el techo del panel
3.º	Migración	Fila en el plan que M1 ya emite, con fuente y propuesta; se pliega al reporte 25	Tabla vacía sobre un intake con huecos: auditoría en verde que contradice la lectura manual
También quedó dirimido el agrupamiento: la parte de migración se pliega al reporte 25 (misma corrida y artefacto compartido), y correlación y escalada van como dos reportes nuevos separados — el 26 y el 27.

Lo que falta decidir es tuyo: si escribo esos dos reportes ahora y después arrancamos por la intervención de escalada, que es la primera del orden y la que hace que las otras dos no te lleguen como preguntas sueltas.