# Conformación automática del pull request — el agente cierra su propia unidad de trabajo

**Alias:** Conformacion-Pull-Request-Automatico
**Naturaleza:** canonico
**Tema:** Ciclo de entrega de una unidad de trabajo cerrado por el propio agente orquestador: compuerta, rama, pull request abierto por API, informe con el enlace, guarda de merge sobre los controles, merge y borrado de la rama remota por el agente, preparación del repositorio local y continuación sin acuse humano, con retorno al ciclo manual ante una reserva
**Consumidor:** transversal
**Condicion-de-carga:** —
**Hereda-de:** Conformacion-Pull-Request-Manual
**Sustituye:** —
**Compatible-con:** Rules-Base-Conocimiento.md 2.2
**Versión:** 1.0
**Estado:** Vigente
**Fecha:** 2026-09-19

---

## 0. Propósito y alcance

Caracteriza **la variante del traspaso en la que el agente orquestador conforma el pull request de
punta a punta**: lo abre, publica el informe con su enlace, lo fusiona, borra la rama remota, deja el
repositorio local listo para la unidad siguiente y **sigue sin esperar al agente humano**.

**Hereda de `Conformacion-Pull-Request-Manual` y escribe sólo el delta**: quién ejecuta los turnos 5 a
7, con qué guarda, y cuándo el agente devuelve el merge al humano. Lo que no cambia se lee en el padre.

**No es la variante por defecto, y no se activa sola.** Se carga sólo por cita explícita del alias, y
**sólo vale si la delegación del merge está asentada** en el repositorio destino (§3.1). Sin ese asiento
rige el padre.

**Qué queda explícitamente afuera:**

| Qué | Dónde vive |
| --- | --- |
| Los turnos que no cambian —compuerta, unidad, rama, árbol limpio— | `Conformacion-Pull-Request-Manual` §2 y §3, y la norma que cita |
| Los formatos literales de la compuerta y del cierre de unidad | `Master-Prompt.md` §12.1 T0, §8.1 y T4, por la misma razón que el padre no los copia |
| La norma del traspaso, que sigue diciendo que el agente no fusiona | `Master-Prompt.md` §12.1 T1. Este documento es una **desviación declarada** (§8), no una sustitución |
| Si el trabajo entregado está bien | El audit de cada orquestador y los controles automáticos del repositorio |
| Configuración de la plataforma: protección de rama, controles obligatorios, borrado automático de ramas, nombres | La categoría 09 del producto. Este documento **lee** su resultado |
| Etiquetar, publicar o desplegar después del merge | La categoría 09 del producto |

**§5 supera por sí sola el techo de `Rules-Base-Conocimiento.md` §6.2**, y es la excepción que esa
regla admite, con el precedente de `Knowledge-Bundle-JS` §0.3: la guarda, el merge y el borrado son una
sola secuencia —cada paso aborta si el anterior no dio— y partirla la vuelve inútil. El resto del
documento está bajo 250 líneas.

**Verificación de ofuscación.** El relevamiento salió de la práctica de un taller sobre varios
repositorios reales, privados y públicos. Se buscaron y **no aparecen**: nombres de organizaciones, de
cuentas y de repositorios, números de pull request, identificadores de commit, nombres de producto y de
dominio, rutas del equipo. Falsos positivos léxicos declarados: «principal» (rama principal, término del
padre), «plataforma» (genérico), `<owner>/<repo>` (marcador), `mergeable_state`, `workflow_runs`,
`head_sha`, `permissions.push` (nombres de campo de la familia de API del esqueleto, §1).

## 1. Identidad del artefacto

| | |
| --- | --- |
| **Qué es** | Una convención de proceso de **un solo actor operativo**, el agente orquestador, sobre un repositorio con remoto y una plataforma que expone pull requests por API HTTP |
| **Actor A** | **Agente orquestador.** Ejecuta los ocho turnos del padre; el acuse desaparece |
| **Actor B** | **Agente humano.** Deja de estar en el camino: **delega** el merge, recibe el informe de cada unidad y **recupera el merge** cada vez que el agente declara una reserva |
| **Unidad de intercambio** | La del padre: una fase, una consolidación, una reparación, un tramo de un plan aprobado o un incremento posterior al handoff |
| **Familia de API del esqueleto** | La de la plataforma sobre la que se midió: estado de fusión en `mergeable` / `mergeable_state`, corridas de controles por `head_sha`, merge por `PUT …/merge` con `sha`. **En otra plataforma el contrato de §3 se traduce, el esqueleto no se corre tal cual** |
| **Supuestos** | La credencial con que el agente empuja alcanza para abrir, fusionar y borrar; la plataforma informa el estado de los controles; el humano **decidió** la delegación y quedó escrita |

**La propiedad que sostiene el resto:** el merge deja de ser el punto donde alguien que no escribió el
cambio lo mira. **Esa pérdida no se niega: se compensa** con la guarda mecánica de §3.3 y la devolución
por reserva de §3.4, que el agente no puede saltear.

**`Base`**, que el padre y el cierre usan: el commit sobre el que la primera compuerta de la corrida dio
«en orden». No cambia en toda la corrida; cada republicación de la compuerta repite la misma.

## 2. Estructura

El ciclo del padre, con los turnos que cambian:

| # | Quién | Qué produce | Cambia |
| --- | --- | --- | --- |
| 1 | Orquestador | Compuerta de arranque, publicada siempre | No |
| 2 | Orquestador | Unidad declarada antes de empezar, una sola | No |
| 3 | Orquestador | Rama, escritura, commits, push | No |
| 4 | Orquestador | Comprueba el permiso, **abre el pull request por API** y publica el **informe con el enlace**, antes de fusionar | Sí: lo abre el agente |
| 4b | Orquestador | **Evalúa reservas** (§3.4). Si hay una, **sigue por el padre desde su turno 5**: se detiene y pide el merge | Nuevo |
| 5 | Orquestador | **Guarda de merge** (§3.3) y, si pasa, **fusiona con commit de merge atado a la cabeza auditada** | Sí: lo hacía el humano |
| 6 | Orquestador | Si el merge dio, **borra la rama remota** y comprueba que no está | Sí: lo hacía el humano. **El acuse desaparece** |
| 7 | Orquestador | Verifica y prepara, como el padre —principal al día, referencias podadas, rama local borrada, commit alcanzable, trabajo ajeno declarado— y **lee los controles del commit de merge**. Se hace entero aunque no haya acuse: lo que verifica es la plataforma, no al humano | Sí: suma la lectura de controles |
| 8 | Orquestador | **Publica el cierre del ciclo** (§5.3) con la compuerta y continúa con lo que el turno 4 declaró | Sí: sin esperar acuse |

## 3. Contrato de uso

### 3.1 La delegación, antes que nada

- **Es del proyecto, no del framework.** La decide el responsable del producto y se asienta **con
  fecha y con quién lo decidió** en un lugar versionado del repositorio destino —carta de cambios,
  convenciones o categoría 09—. Un permiso dicho en una conversación y no escrito no alcanza: la sesión
  siguiente no lo ve.
- **Fija sus parámetros**: el techo de espera y el intervalo de relectura de la guarda (§3.3). Este
  documento no propone valores.
- **Declara su excepción.** La forma observada: «si hay un cuestionamiento particular sobre la unidad,
  se para y se hace manual». §3.4 la convierte en lista.
- **Se cita en cada informe** (§5.3): ruta, fecha y responsable. **Si el agente no la encuentra, rige el
  padre.** Es la única comprobación posible sin tocar el índice ni el intake.
- **Es revocable por unidad**, sin derogarla.

### 3.2 La credencial

| Obligación | Qué pasa si se ignora |
| --- | --- |
| Obtenerla del mismo almacén que usa `git` para empujar, **eligiendo la cuenta con acceso al dueño del repositorio**, no la primera que aparezca | Con varias cuentas guardadas se toma la primera: «repositorio no encontrado» sobre uno que existe, o lectura permitida y escritura denegada |
| Comprobar `permissions.push` sobre el repositorio **antes del turno 4** | La API responde a la lectura y rechaza el push o el merge a mitad del ciclo |
| **No exponerla**: ni en la salida, ni en archivos, ni en el informe, **ni en los argumentos de un proceso** —se pasa el encabezado por un descriptor, no por la línea de comando— | Los argumentos de un proceso los ve cualquier otro proceso del equipo mientras corre |
| Usarla **sólo** para el pull request de la unidad en curso | La delegación cubre el trámite de esa unidad, no la administración del repositorio |

El ciclo usa cuatro operaciones: leer el repositorio, abrir el pull request, fusionarlo y borrar la
rama. **Si la credencial alcanza más que eso** —en la práctica medida tenía permiso de administración—,
**lo asume el proyecto en su delegación**; el documento no impone una credencial distinta de la de `git`.

### 3.3 La guarda de merge

Se evalúa en un bucle de relectura con el techo y el intervalo de §3.1, y **inmediatamente antes** de
fusionar se relee una última vez. Cada condición es explícita y termina el proceso por sí misma:

| # | Condición | Si no se cumple |
| --- | --- | --- |
| G1 | El pull request está abierto y su `head.sha` es **el mismo SHA auditado** | Cambió la cabeza: se reinicia la guarda sobre la nueva, o reserva |
| G2 | `mergeable == true` **y** `mergeable_state == clean`. **Todo otro valor rechaza**; `unknown` o nulo es «todavía calcula» | Calcula: relee. Cualquier otro: reserva |
| G3 | Hay **al menos una** corrida de controles para ese SHA, y **todas terminaron en éxito** | En curso: relee. Alguna fallida: reserva. **Ninguna: reserva** —no hubo controles, es un efecto no medido— |
| G4 | No hay reserva declarada en el turno 4b | Reserva |
| — | Se agotó el techo de espera | Reserva |

**La guarda no confía en el manejo de errores del intérprete.** Se escribe como condición explícita, en
su propia línea, y no depende de que el intérprete aborte ante error. La forma observada que falló: una
comparación suelta dentro de un comando en segundo plano; el pull request se fusionó con los controles
en rojo.

**El merge se ata a la cabeza auditada**: la llamada lleva el SHA, y la plataforma la rechaza si la cabeza
cambió entre la lectura y el merge. **Su respuesta se lee**: si no dice que fusionó, nada de lo que sigue
se ejecuta —en particular, no se borra la rama.

### 3.4 Las reservas: cuándo el merge vuelve al humano

Una **reserva** es un motivo para que alguien que no escribió el cambio lo mire. Si aparece, el agente
**no fusiona**: entrega el cierre del padre con el enlace, pide el merge en una línea y **el ciclo sigue
por el padre desde su turno 5**, acuse incluido.

| Reserva | Ejemplo |
| --- | --- |
| **Una decisión que no le corresponde al agente** | El cierre lleva una decisión pendiente sobre el contenido entregado: fusionar sería decidirla |
| **Un efecto que no pudo medir** | Nada ejecutó lo que el cambio toca, o la cabeza no tuvo controles |
| **Un cambio irreversible no verificado** | Migración de datos, contrato público, borrado |
| **La guarda no pasa** | Controles en rojo, estado distinto de `clean`, techo agotado, merge rechazado |
| **Un cuestionamiento particular del humano sobre la unidad** | Lo dijo al declararla o durante la corrida |

**Una falla que ya estaba en la principal también es reserva**: no se fusiona, se deja comentario en el
pull request con la evidencia de que la falla es anterior a la rama, y el merge vuelve al humano.

**Un defecto propio no es reserva:** se corrige en la misma unidad y se declara, como en el padre. **Una
reserva no es falla del ciclo:** es la compensación funcionando.

### 3.5 Prohibiciones que se suman a las del padre

| Prohibido | Qué pasa si se hace |
| --- | --- |
| Fusionar sin delegación asentada y encontrada | El agente se arroga el único control ajeno sin que nadie lo haya cedido |
| Fusionar sin que G1 a G4 pasen en la última relectura | Entra código sin los controles que la delegación supone |
| Borrar la rama sin haber leído que el merge dio | Se pierde el puntero remoto de un trabajo que no entró |
| Borrar otra rama que la cabeza del propio pull request, o una cabeza de otro repositorio | Un borrado remoto no se deshace desde la plataforma |
| **Aplastar la historia** (`squash`) cuando la rama lleva un expediente de caso | Se pierde el orden de incorporación de sus folios (`Expediente-Rules.md` §4, S3) |
| Fusionar sin haber publicado antes el informe con el enlace | El humano pierde el único punto donde podía mirar, aunque sea después |
| Encadenar la unidad siguiente con los controles del commit de merge fallando | Lo que se construye encima hereda la falla |
| Correr dos unidades en paralelo sobre el mismo checkout | El checkout es global al árbol: los commits de una caen en la rama de la otra. Cada corrida paralela va en su propio `git worktree` |

**Atribución.** La plataforma registra como autor del merge a la **cuenta dueña de la credencial**, que
suele ser la del humano: mirando la plataforma, un merge del agente y uno del humano **no se distinguen**.
Los distingue el cierre del ciclo, que dice «fusionado por el agente». Por eso no es opcional.

## 4. Decisiones ya tomadas

| Bifurcación | Cómo se resolvió | Criterio |
| --- | --- | --- |
| ¿El informe con el enlace se publica antes o después del merge? | **Antes**, y el cierre del ciclo después | El humano conserva un punto de observación aunque ya no bloquee |
| ¿Qué método de merge? | **Commit de merge**, nunca `squash` ni `rebase` por defecto | Conserva la historia; con expediente es obligatorio; y la rama local se borra con la verificación normal de «fusionada» |
| ¿Se acepta un estado de fusión que no sea `clean`? | **No, ninguno** | `unstable` es controles fallando: aceptarlo ya produjo seis fusiones encadenadas sobre un control roto |
| ¿Se miran los controles después del merge? | **Sí**, los del commit de merge en la principal | Hay controles que sólo corren sobre la principal |

**Puntos de variación**, contra la tabla del padre: **quién fusiona** —el agente, con guarda; el humano
ante reserva—; **quién borra la rama** —el agente, por API, y comprueba—; **reanudación** —sin acuse,
por la verificación inmediata del turno 7—; **publicación del estado** —al abrir, al informar el pull
request y al cerrar el ciclo—. **Granularidad y concurrencia** no cambian; en paralelo, sólo en
`worktree` propio.

## 5. Esqueletos de referencia

### 5.1 Preparación: plataforma, credencial y permiso

Marcadores: `<rama>`, `<principal>`. `API` es la base de la API de la plataforma que aloja el remoto.
El encabezado se pasa por un descriptor (`-H @<(…)`), de modo que la credencial no queda en los
argumentos de ningún proceso; `printf` es interno del intérprete.

```bash
REPO=$(git remote get-url origin | sed -E 's#^(https://[^/]+/|git@[^:]+:)##; s#\.git$##')  # <owner>/<repo>
T=$(printf 'protocol=https\nhost=<host>\nusername=<cuenta con acceso al dueño>\n\n' \
    | git credential fill | sed -n 's/^password=//p')
auth() { printf 'Authorization: Bearer %s\n' "$T"; }
api() { curl -s -H @<(auth) -H 'Accept: application/vnd.github+json' "$@"; }

push=$(api "$API/repos/$REPO" | jq -r '.permissions.push')
if [ "$push" != true ]; then echo "SE DETIENE: la credencial no puede escribir en $REPO"; exit 1; fi
```

### 5.2 La secuencia de los turnos 4 a 7

```bash
# Turno 4 — abrir el pull request; publicar el informe (§5.3) con html_url ANTES de seguir
pr=$(api -X POST "$API/repos/$REPO/pulls" \
      -d "$(jq -n --arg h "<rama>" --arg b "<principal>" --arg t "<título>" --arg c "<cuerpo>" \
            '{head:$h, base:$b, title:$t, body:$c}')")
N=$(jq -r .number <<<"$pr");  SHA=$(jq -r .head.sha <<<"$pr");  URL=$(jq -r .html_url <<<"$pr")

# Turno 5 — guarda en bucle (TECHO e INTERVALO los fija la delegación, §3.1)
fin=$(( $(date +%s) + TECHO ))
while :; do
  p=$(api "$API/repos/$REPO/pulls/$N")
  st=$(jq -r .mergeable_state <<<"$p");  mg=$(jq -r .mergeable <<<"$p")
  hd=$(jq -r .head.sha <<<"$p");         ab=$(jq -r .state <<<"$p")
  r=$(api "$API/repos/$REPO/actions/runs?head_sha=$SHA&per_page=100")
  n=$(jq '.workflow_runs | length' <<<"$r")
  enc=$(jq '[.workflow_runs[] | select(.status != "completed")] | length' <<<"$r")
  mal=$(jq '[.workflow_runs[] | select(.status == "completed" and .conclusion != "success")] | length' <<<"$r")
  if [ "$ab" != open ];        then echo "RESERVA: el PR no está abierto"; exit 1; fi
  if [ "$hd" != "$SHA" ];      then echo "RESERVA: la cabeza cambió"; exit 1; fi
  if [ "$mal" -gt 0 ];         then echo "RESERVA: $mal controles fallidos"; exit 1; fi
  if [ "$n" -eq 0 ] && [ "$(date +%s)" -ge "$fin" ]; then echo "RESERVA: sin controles"; exit 1; fi
  if [ "$n" -gt 0 ] && [ "$enc" -eq 0 ] && [ "$mg" = true ] && [ "$st" = clean ]; then break; fi
  if [ "$st" != unknown ] && [ "$mg" != null ] && [ "$enc" -eq 0 ] && [ "$n" -gt 0 ]; then
    echo "RESERVA: estado de fusión $st"; exit 1; fi
  if [ "$(date +%s)" -ge "$fin" ]; then echo "RESERVA: techo de espera agotado"; exit 1; fi
  sleep "$INTERVALO"
done
# (G4: si el turno 4b declaró reserva, este bloque no se ejecuta)

m=$(api -X PUT "$API/repos/$REPO/pulls/$N/merge" \
      -d "$(jq -n --arg s "$SHA" '{merge_method:"merge", sha:$s}')")
if [ "$(jq -r .merged <<<"$m")" != true ]; then
  echo "RESERVA: merge rechazado: $(jq -r .message <<<"$m")"; exit 1; fi
MSHA=$(jq -r .sha <<<"$m")

# Turno 6 — borrar SÓLO la cabeza del propio PR, si está en el mismo repositorio, y comprobar
hrepo=$(jq -r .head.repo.full_name <<<"$p");  href=$(jq -r .head.ref <<<"$p")
if [ "$hrepo" = "$REPO" ]; then
  api -X DELETE "$API/repos/$REPO/git/refs/heads/$href" >/dev/null
  c=$(curl -s -o /dev/null -w '%{http_code}' -H @<(auth) "$API/repos/$REPO/git/ref/heads/$href")
  if [ "$c" != 404 ]; then echo "SE DETIENE: la rama remota sigue ($c)"; exit 1; fi
fi

# Turno 7 — preparar el local, verificar y leer los controles del commit de merge
git switch <principal> && git pull --ff-only && git fetch --prune
if ! git merge-base --is-ancestor "$SHA" origin/<principal>; then echo "SE DETIENE: no alcanzable"; exit 1; fi
git branch -d <rama>
# relee con el mismo bucle sobre head_sha=$MSHA; si alguno falla: se declara y no se encadena
```

**Con cero corridas la guarda no aprueba**: espera hasta el techo y termina en reserva. Por eso cuenta
las corridas antes de mirar su resultado: una expresión de «todas en éxito» sobre una lista vacía da
verdadero.

### 5.3 Los dos bloques que publica

**El informe del turno 4** es el cierre de unidad del padre, con el enlace y dos líneas más. Se escribe
**fuera de un bloque cercado** para que el enlace quede clicable:

- **Merge:** delegado — se fusiona si la guarda pasa y no hay reserva.
- **Delegación:** `<ruta del asiento>`, `<fecha>`, `<quién la decidió>`.

**El cierre del ciclo del turno 8**, en el mismo formato:

- **Ciclo cerrado —** `<unidad>`
- **PR:** `<enlace>` — **fusionado por el agente**, commit de merge `<MSHA>`
- **Guarda:** estado `clean`; controles de `<SHA>`: `<n>` en éxito
- **Rama remota:** borrada y comprobada (404)
- **Local:** `<principal>` al día, rama local borrada, `<SHA>` alcanzable
- **Controles del commit de merge:** `<n> en éxito | fallidos: cuáles>`
- **Trabajo ajeno en la principal:** `<ninguno | qué trajo>`
- **Compuerta de arranque** republicada, con la misma `Base`
- **Sigue:** `<el paso que el turno 4 declaró>`

Cuando hay reserva, en lugar del cierre del ciclo va el del padre, con **«Qué necesito de vos: el merge
— reserva: `<cuál>`»**.

## 6. Criterios de aceptación

- [ ] `[enumerable]` La delegación está asentada en el repositorio destino, con fecha y responsable, y cada informe del turno 4 la cita.
- [ ] `[enumerable]` El permiso de escritura se comprobó antes del primer pull request de la corrida.
- [ ] `[enumerable]` Cada pull request fusionado por el agente tiene su informe con enlace publicado **antes** del merge, y su cierre del ciclo después.
- [ ] `[enumerable]` Ningún merge del agente se hizo con estado distinto de `clean`, sin corridas de controles para la cabeza, o con alguna sin éxito.
- [ ] `[enumerable]` Cada merge del agente lleva el SHA auditado, y su respuesta dice que fusionó antes de cualquier borrado.
- [ ] `[enumerable]` Ninguna rama con expediente se fusionó con `squash`.
- [ ] `[enumerable]` Después de cada ciclo la rama remota no existe, la local tampoco, y la cabeza es alcanzable desde la principal remota.
- [ ] `[enumerable]` Cada cierre del ciclo declara los controles del commit de merge y republica la compuerta con la `Base` de la corrida.
- [ ] `[interpretativo]` Cada reserva de §3.4 que apareció produjo una detención con el merge devuelto, y no un merge.
- [ ] `[interpretativo]` Ninguna credencial aparece en la salida, en archivos ni en argumentos de proceso.

## 7. Anti-patrones

| Anti-patrón | Por qué |
| --- | --- |
| **Creer que sin cliente de la plataforma no se puede** | Bloqueó el ciclo durante semanas sin haberse medido: la credencial de `git` y la API por HTTP alcanzan |
| **Aceptar `unstable` como fusionable** | Es controles fallando. Ocurrió, y encima se fusionaron cinco pull requests más |
| **Guarda que depende del aborto implícito del intérprete** | Dentro de un comando en segundo plano no aborta: el merge sale igual |
| **«Todas en éxito» sobre la lista de corridas sin mirar si está vacía** | Da verdadero sin ningún control |
| **Declarar verde leyendo sólo el estado del pull request** | Hay que leer las corridas de la cabeza y, después del merge, las del commit fusionado |
| **Borrar la rama sin leer la respuesta del merge** | Si el merge fue rechazado, se pierde el puntero remoto del trabajo |
| **Fusionar todo sin frenar nunca** | La compensación de §3.4 se volvió fórmula; la delegación perdió su condición |

## 8. Frontera con las reglas

**Este documento contradice una regla del framework, y lo declara.** `Master-Prompt.md` §12.1 **T1**
dice que el agente no fusiona, «no hay excepción». Ningún ítem de §12.1 está rotulado como decisión de
stack, así que por `Rules-Base-Conocimiento.md` §0.4 esta variante **no puede sustituirlo**: es una
**desviación**, y **manda la regla del framework** salvo que esté justificada. La justificación:

- **El motivo de T1 se reconoce**: el merge es el único control ajeno. Lo que se hace es **declarar qué
  se pierde y con qué se compensa** (§1, §3.3, §3.4) en lugar de que la regla diga una cosa y la práctica
  haga otra.
- **La desviación la decide el responsable de cada proyecto, no este documento** (§3.1). Un orquestador
  que cargue el alias sin delegación asentada y encontrada aplica T1.
- **Lo demás de §12.1 se cumple**: T0, T2, T3, la forma de T4 y los pasos de T5.

**Límite anotado, no resuelto acá:** mientras T1 no se rotule como decisión de stack, esta variante será
siempre desviación; rotularlo es intervenir el framework. **§6 no define criterios de nada que el
framework genere**: se verifica sobre la plataforma, el repositorio y el intercambio.

## 9. Trazabilidad

| | |
| --- | --- |
| **Índice** | `Index-Knowledge.md` de la base que lo incorpore |
| **Padre** | `Knowledge-Conformacion-Pull-Request-Manual.md` (`Hereda-de`) |
| **Hermanos** | Ninguno |
| **Consumidor** | `transversal`. Se cita desde el intake del producto, como el padre, y requiere la delegación de §3.1 |
| **Artefacto de referencia** | Ninguno versionado. De §5 se ejecutaron contra la plataforma la preparación y las lecturas; la guarda, el merge y el borrado se probaron contra una API simulada en nueve escenarios —siete que deben detenerse, uno de rama viva y el camino feliz— |
| **Origen de lo caracterizado** | La práctica de un taller que delegó el merge al agente en varios repositorios; su reglamentación en las convenciones de uno de ellos («delegación del merge al agente — sólo por decisión explícita del responsable»); y las fallas medidas que dieron forma a la guarda |

## 10. Control de cambios

| Versión | Fecha | Cambios |
| --- | --- | --- |
| 1.0 | 2026-09-19 | Emisión inicial. Cataloga, como especialización del traspaso manual, la variante en la que el agente abre, fusiona y borra la rama del pull request y sigue sin acuse, con la guarda de merge y las reservas que devuelven el merge al humano, y declara la desviación de `Master-Prompt.md` §12.1 T1. Pasó por una mesa evaluadora de siete especialistas y un jurado de cinco funciones antes de emitirse. |
