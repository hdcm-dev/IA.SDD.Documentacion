# Informe de comisión — Seguridad (AG-00050)

**Comisión:** Seguridad (AG-00050), postergada del ciclo anterior (folio 002 §3.3, deuda D-2). Siglas `M9-SEG-NN`.
**Fecha:** 2026-09-13.
**Modo:** a ciegas, sólo lectura. Temporales en `scratchpad/mesa/tmp-seg/`.

**Base leída.** Contrato de entrada; `plan/Expediente-Rules.md` 1.0 (entera) y `plan/20-Plan-De-Aplicacion.md`; folios 016 y 018 del expediente 0001 (enteros), `ev-07` y su `.meta.txt`, `SHA256SUMS`; norma 13.17 en `IA.SDD-i09` (`main` = `a501857`): `Rules-Base-Conocimiento.md` §2.2, `Mesa-Rules.md` §6.1, §7.1 y §8, `Master-Prompt.md` §8.1 (origen del hecho), `Maqueta-Rules.md` l.310, `Index-Modelos-UX-UI.md` l.61, `Coherencia-Conformacion-Pull-Request-Manual.md` §7, `SDD-Development-Guide.md` Parte IV («paso o prosa»); `ev-01`, `ev-02`, `ev-03` del presidente; el caso de dos folios (`a1a10.sh` corrido); destinos por `git grep`/`git show`: `Lab-Geometria` `main` `d12fb1c`, `RPI.VideoControl` `HEAD` `9aabe5c`, y además `IA.SDD.Documentacion` `HEAD` `3f78a5c` porque la pregunta 2 del mandato («qué pasa con lo ya publicado») no se contesta sin mirar dónde más vive el mismo dato.

**Fuentes externas.** GitHub Docs, «Removing sensitive data from a repository» (consultada el 2026-09-13; citas literales en M9-SEG-01). No consulté ninguna norma numerada (ISO 27001/27701, NIST SP 800-53) porque ninguna cambia la conclusión: todo lo que sigue se sostiene con E1 sobre los repositorios.

**Aclaración de conducta.** El dato personal de E-2 (el nombre de cuenta) lo vi en el original pre-redacción; en este informe aparece sólo como «[nombre de cuenta redactado]», y las rutas de host van con `<u>` en lugar del usuario. Los comandos que lo localizan van con su salida en recuento, no en texto.

---

## Hallazgos

### M9-SEG-01 · P1 · E1 — La redacción S2 del 0001 no retiró nada: los originales siguen públicos por SHA, y el folio 018 publica dónde están

**Qué muestra la medición.** `IA.SDD` es público y los siete commits del PR #66, anteriores al squash `650053e`, siguen accesibles sin autenticación, incluidos los seis anteriores a la redacción (`e8c84d9`…`8512a45`):

```
$ curl -s -o /dev/null -w '%{http_code}\n' https://api.github.com/repos/hdcm-dev/IA.SDD
200
$ curl -s https://api.github.com/repos/hdcm-dev/IA.SDD/pulls/66/commits | python3 -c '...'   (anónimo)
7
e8c84d9 Expediente 0001: apertura, presentación del Product Owner y convocatoria de mesa
7301a8f Expediente 0001: constancia de dos convocatorias e informes del panel (folios 00
3c2f401 Expediente 0001: la presentación 001 no es literal, y consolidación con plan com
b92c64b Expediente 0001: refutación del plan (folio 014) y cartas despachadas (ev-08)
34b6b54 Expediente 0001: veredicto, dictamen y corrección del índice (folios 015 a 017)
8512a45 Expediente 0001: el índice de evidencia remite a los manifiestos (folio 017)
c22eaae Expediente 0001: resolución del lote y redacción S2 (folio 018)
$ for c in 34b6b54 8512a45; do curl -s -o /dev/null -w "$c %{http_code}\n" https://api.github.com/repos/hdcm-dev/IA.SDD/commits/$c; done
34b6b54 200
8512a45 200
$ curl -s https://raw.githubusercontent.com/hdcm-dev/IA.SDD/8512a45/Expedientes/0001-…/actuaciones/005-informe-evidencia-digital.md -o 005-orig.md
$ sha256sum 005-orig.md | cut -c1-16
daf465b5ea42d743          ← es la columna «antes» del folio 018 §3 para el folio 005
$ grep -ci <u> 005-orig.md ; grep -c '[nombre de cuenta redactado]' 005-orig.md   (recuentos; el nombre no se transcribe)
3
1
$ git merge-base --is-ancestor 8512a45 main && echo si || echo no ; git cat-file -t 8512a45
no
commit                    ← existe, colgante; en GitHub, alcanzable por SHA y por el PR
```

Y el folio 018 §3, ya en `main`, dice literalmente: *«El historial de la rama conserva los originales (commits `e8c84d9` a `8512a45`). No se reescribió ningún commit. Si el historial publicado no debe contenerlos, lo resuelve el Product Owner al fusionar con squash.»* El squash **no** lo resolvió: el rango citado es un puntero público al original sin redactar.

**Lo que la regla dice y lo que le falta.** S2 (§4) afirma «retirar algo ya publicado exige reescribir la historia», y el fundamento «corre antes del push» es correcto. Pero se queda corto en el sentido que importa para seguridad: **reescribir la historia tampoco alcanza**. GitHub Docs, literal: *«if the sensitive data you need to remove is a secret (e.g. password/token/credential) […] as a first step you need to revoke and/or rotate that secret»*; y los datos siguen accesibles *«Directly via their SHA-1 hashes in cached views on GitHub; Through any pull requests that reference them»*, y sólo se retiran *«by contacting us through the GitHub Support portal»*. La regla no nombra ninguna de las dos respuestas (revocar; pedir el retiro al proveedor) y el plan #18 (folio 019) sólo «asienta el residuo de S2 (cuatro piezas)», que es el residuo del árbol, no el de la historia.

**Inventario de lo ya publicado, para la pregunta 2 del mandato** (todo con E1):

| Dónde | Qué | Medición |
| --- | --- | --- |
| `IA.SDD` PR #66, commits colgantes | el nombre de cuenta (E-2) y rutas de host en 33 piezas, originales | arriba |
| `IA.SDD` `main` `a501857`, `Expedientes/` | usuario del host en la ruta del scratchpad, 4 piezas | `git grep -ci "$(id -un)" main -- Expedientes \| wc -l` → `4` |
| `Lab-Geometria` `main` `d12fb1c` (público: `api.github.com/repos/hdcm-dev/Lab-Geometria` → `200`) | el nombre de cuenta, fuente de E-2, 1 archivo; usuario del host en `SDD/Expedientes/` (el `EXP-0001`, forma histórica), 8 líneas en 3 archivos; en todo el repo, 23 archivos | `git -C Lab-Geometria grep -l '<nombre>' main \| wc -l` → `1` · `git -C Lab-Geometria grep -ci <u> main -- SDD/Expedientes` → `1`, `2`, `5` · `git -C Lab-Geometria grep -il <u> main \| wc -l` → `23` |
| `IA.SDD.Documentacion` `HEAD` `3f78a5c` (público, `200`) | usuario del host en 28 archivos | `git -C IA.SDD.Documentacion grep -il <u> HEAD \| wc -l` → `28` |

El folio 018 §1 (E-2) dejó la fuente de `Lab-Geometria` «para que la trate el Product Owner después de la migración»; la migración ya se fusionó (PR #205 y #206, contrato de entrada) y ese ítem no tiene evento de cierre en ningún lado del plan.

**Impacto si no se corrige.** La compuerta S2 se lee como suficiente («lo que se redacta deja constancia») cuando en el único caso real la redacción fue cosmética: el dato personal de un tercero sigue público y el expediente publica la dirección para encontrarlo. La próxima vez que se selle una credencial, la regla va a inducir redactar en vez de revocar.

**Dirección de la corrección.** (a) S2 declara que **lo que llegó a un push se considera publicado aunque se reescriba o se aplaste**, y separa la respuesta por clase de dato (ver M9-SEG-06): credencial → revocar o rotar, siempre; dato personal de un tercero en repositorio público → solicitud de retiro al proveedor de hosting, decidida por el Product Owner, con constancia; ruta o usuario del host → constancia, sin reescritura. (b) El folio 019 del plan #18 asienta que los commits `e8c84d9`…`8512a45` siguen accesibles y que la decisión de pedir su retiro es del Product Owner (escalada, no default); y no vuelve a copiar el nombre ni la ruta. (c) La deuda de E-2 sobre `Lab-Geometria` recibe dueño y evento de cierre (no está en `pendientes_declarados`). Fuera de mi competencia: en qué instrumento se registra esa deuda (Trazabilidad).

---

### M9-SEG-02 · P1 · E1 — El comando enumerable de §7 (`git grep -c '/home/' -- Expedientes` → 0) da 7 falsos positivos y 0 verdaderos positivos sobre el único caso real, y corre sobre el árbol de trabajo

```
$ cd IA.SDD-i09 && git grep -c '/home/' -- Expedientes | wc -l         (tal como está escrito: índice/árbol, no un commit)
7
$ git grep -n '/home/' main -- Expedientes | cut -c1-120
…/actuaciones/011-informe-requisitos.md:64:… (`README.md` l.152) …          ← cita de prosa
…/actuaciones/014-refutacion-del-plan-compuesto.md:142:$ grep -rcF '/home/' <expediente> …   ← el comando de medición
…/actuaciones/014-…:143:$ git -C IA.SDD-exp1 grep -cF '/home/' HEAD -- Expedientes …
…/actuaciones/015-veredicto-del-jurado.md:31:…
…/actuaciones/018-providencia-…:24:Toda ruta `/home/<usuario>/workspaces/…`        ← la propia constancia S2
…/evidencia/ev-06-segunda-convocatoria/V1.md:103:… `/home/…` …
…/evidencia/ev-06-segunda-convocatoria/V2.md:162:… `grep -rn "/home/" Expedientes` …
$ git grep -ni <u> main -- Expedientes | cut -d: -f1 | sort -u | wc -l     (los verdaderos positivos)
4
$ git grep -n '/home/' main -- Expedientes | grep -ci <u>
0
```

Los cuatro verdaderos positivos son la ruta del scratchpad `/tmp/claude-1000/-home-<u>-workspaces-…`: el host codificado con guiones. La redacción del folio 018 §2 sustituyó sólo `/home/<usuario>/workspaces/…`, y por eso las cuatro piezas pasaron. **El comando de la regla mide el patrón que la redacción ya limpió y no el que se le escapó**; y todo folio que documente S2 (como el 018) lo hace fallar para siempre.

Además, §3.4 de la misma regla manda que una medición sea «sobre un commit, nunca sobre el árbol de trabajo», y el comando de §7 no nombra commit. Y no mira la historia: un árbol limpio con un commit anterior sucio (exactamente el caso del PR #66) pasa.

**Comando que sí funciona, probado sobre los mismos datos** (ningún valor escrito a mano: el usuario sale de `id -un`, la base de `Master-Prompt.md` §12.1 T0):

```
$ git grep -cE '(/|-)home[/-][A-Za-z0-9]+' main -- Expedientes         (patrón: ruta de host real, en las dos codificaciones)
…/ev-06-segunda-convocatoria/N2.md:1
…/ev-08-cartas-despachadas/08-Núcleo--comisión-de-verificación.md:1
…/ev-08-cartas-despachadas/16-Núcleo--comisión-de-verificación.md:1
…/ev-08-cartas-despachadas/18-Refutador-del-plan-compuesto.md:1        ← 4/4, 0 falsos positivos
$ git grep -ci "$(id -un)" main -- Expedientes | wc -l                  (el usuario del host, derivado)
4
$ git log -p --format= 650053e^..650053e -- Expedientes | grep -cE '^\+.*((/|-)home[/-][A-Za-z0-9]+|/Users/|C:\\\\Users)'   (lo que sale en el push: líneas agregadas del rango)
4
$ git log -p --format= origin/main..HEAD -- Expedientes | grep -cE '^\+.*(/home/|/Users/|C:\\\\Users|-home-)'   (rama actual, sin nada por empujar)
0
```

**Impacto si no se corrige.** La compuerta declara «0 antes del push» sobre un comando que ni detecta el leak observado ni puede dar cero en un expediente que cumple S2 con constancia. Se va a ignorar o a «pasar» a mano.

**Dirección.** La detección de S2 es una sola línea con dos partes, sobre el **rango que se va a empujar** (`<base>..HEAD`, líneas agregadas) y no sobre el árbol: el patrón de ruta de host en sus codificaciones (`/home/<x>`, `-home-<x>`, `/Users/<x>`, `C:\Users\<x>`) y el usuario del host tomado de `id -un`. Si el presidente prefiere una sola: `git log -p --format= <base>..HEAD -- Expedientes | grep -iE "^\+.*((/|-)home[/-][a-z0-9]+|/Users/|$(id -un))"` → vacío. Credenciales y nombres de cuenta no admiten patrón universal: van como lista declarada por el caso (ver M9-SEG-06).

---

### M9-SEG-03 · P2 · E2 — S2 se presenta como «la compuerta de `Rules-Base-Conocimiento.md` §2.2 extendida», pero esa compuerta cubre otra cosa, con otro fundamento y sin comando

`Rules-Base-Conocimiento.md` l.162-166 (`main`): *«La compuerta de ofuscación corre, y es bloqueante. `IA.SDD` es un repositorio público. Ningún documento puede llevar nombres de clientes, datos reales, assets del proyecto de origen ni decisiones que sólo tengan sentido en su dominio. […] se verifica igual: búsqueda de términos del dominio, del cliente y del stack de origen, con los falsos positivos léxicos declarados uno por uno.»*

S2 (§4 del borrador): *«Credenciales, datos personales, rutas del directorio personal del host, nombres de cuentas: nada de eso se publica. […] Es la compuerta de `Rules-Base-Conocimiento.md` §2.2, que alcanzaba sólo a `Conocimiento/`, extendida a `Expedientes/`.»*

Tres desajustes:

1. **Las listas son disjuntas.** §2.2 es ofuscación de dominio y cliente (D7); S2 es datos sensibles. Ninguno de los cuatro ítems de S2 está en §2.2, y ninguno de los cuatro de §2.2 está en S2.
2. **El fundamento no se transfiere.** §2.2 se justifica en «`IA.SDD` es un repositorio público» (igual que `Maqueta-Rules.md` l.310 e `Index-Modelos-UX-UI.md` l.61). Un destino puede ser privado (`RPI.VideoControl` → `404`), así que una regla de destino no puede heredar ese motivo; necesita el propio (ver M9-SEG-07).
3. **§2.2 no es enumerable**: «búsqueda de términos del dominio» con falsos positivos declarados uno por uno es una revisión humana. S2 promete «se verifica enumerando».

Y hay un cuarto punto que la extensión literal volvería contradictorio: §2.2 prohíbe «nombres de clientes» y «decisiones que sólo tengan sentido en su dominio», mientras que §2 del borrador declara que `Expedientes/` del framework «nombra otros repositorios, ramas y rutas como texto». Medido en `main`: el expediente 0001 nombra un repositorio privado y su organización 32 veces y 1 vez:

```
$ git grep -c 'RPI.VideoControl' main -- Expedientes | wc -l
32
$ git grep -n '<organización de infraestructura del PO>' main -- Expedientes | cut -c1-160
…/actuaciones/005-informe-evidencia-digital.md:212:hdcm-dev/IA.SDD 200 · … · <organización de infraestructura del PO>/<destino privado> 404
$ curl -s -o /dev/null -w '%{http_code}\n' https://api.github.com/repos/<organización de infraestructura del PO>/<destino privado>
404
```

Hoy es un laboratorio y el daño es nulo; el día que un destino sea un cliente real, un expediente del framework público va a publicar su nombre y sus decisiones por diseño, y §2.2 —la única regla que lo prohíbe— habrá sido «extendida» sin que nadie la aplique.

**Respuesta a la pregunta 1 del mandato.** Ni citarla como extensión ni editarla. Editar §2.2 para que diga `Expedientes/` importaría a los expedientes una obligación (ofuscar dominio y cliente) que un expediente de caso no puede cumplir sin dejar de ser registro; citarla como «la misma compuerta» hace creer que está cubierto lo que no está. **S2 se escribe autónoma**: su lista, su fundamento propio (M9-SEG-07), su comando (M9-SEG-02), y cita §2.2 sólo como precedente de forma («corre antes y es bloqueante»). Y declara explícitamente qué hace con el dominio del destino en `Expedientes/` del framework público: o el caso del framework nombra al destino por su nombre y el Product Owner lo acepta al abrir (default hoy, con los dos laboratorios), o se abre con alias. Esa decisión es del Product Owner, no de la mesa.

---

### M9-SEG-04 · P1 · E3 — Un testimonio que S2 obliga a redactar no tiene forma: «byte a byte, sin recortar» y A8 chocan con S2

§3.3: el bloque literal va «byte a byte […] sin recortar», con `Huella` = SHA-256 del bloque «obtenido con el comando de A8». S2: «Credenciales, datos personales […]: nada de eso se publica. Lo que se redacta deja una constancia con la huella del original». Un mensaje de chat del Product Owner con una credencial adentro —el caso más ordinario que existe— cae en los dos a la vez, y el criterio mecánico decide:

```
orig='dale, usá la clave ghp_EJEMPLOxxxx1234 para el deploy y avisame'    (construido)
red='dale, usá la clave [credencial redactada] para el deploy y avisame'
# Folio con el bloque redactado y Huella = SHA-256 del original (lo que S2 pide asentar):
== A8 → HUELLA X/actuaciones/001-presentacion-a.md      (falla)
# Folio con el bloque redactado y Huella = SHA-256 del bloque redactado:
== A8 → (vacío)                                          (pasa, pero la huella del original no está en ningún campo)
== §7 sobre ese folio: grep -c '/home/' → 0              (la credencial no la ve nadie)
```

El único camino que cumple A8 pierde la huella del original, que es lo que S2 exige; el que cumple S2 falla A8. La regla no dice cuál de los dos gana ni con qué campo se asienta la segunda huella. Es la misma clase de defecto que el folio 018 §3 ya arrastra en el 0001: *«Sus cabeceras siguen mostrando la huella del cuerpo original, que ya no coincide con el texto: es a propósito»*, sin campo para la vigente.

**Impacto.** El primer testimonio con un dato sensible va a quedar o publicado entero (para pasar A8) o con una huella falsa (para «cumplir» S2). Las dos salidas son las que la figura existe para evitar.

**Dirección.** Un testimonio admite **una sola transformación declarada**: la marca de redacción S2 (`[… redactado]`), y sólo ésa. `Huella` es siempre la del bloque publicado (es lo que A8 puede verificar); cuando hubo redacción, el folio lleva además `Huella del original` y la constancia de custodia (M9-SEG-05). Y la revisión S2 del testimonio ocurre **al asentar**, no al empujar: es el único momento en que el original todavía no está en ningún commit. Fuera de mi competencia: nombre y posición del campo (Formal).

---

### M9-SEG-05 · P2 · E1 — La «custodia fuera del repositorio» del 0001 es un tmpfs de sesión sin nombre en el folio; la cadena se verifica hoy y no mañana

El folio 018 §3 dice: *«Originales: custodia local del orquestador, fuera del repositorio, con el manifiesto `HUELLAS-ANTES.txt` de las 33 piezas.»* No dice dónde. Medido:

```
$ find /tmp/claude-1000 /home/<u>/workspaces/workspace-dev/IA -name HUELLAS-ANTES.txt
/tmp/claude-1000/-home-<u>-workspaces-workspace-dev/eb413e91-…/scratchpad/exp0001-originales/HUELLAS-ANTES.txt
$ mount | grep -E ' /tmp '
tmpfs on /tmp type tmpfs (rw,nosuid,nodev,…)                ← memoria; desaparece al reiniciar
$ cd …/exp0001-originales/exp && sha256sum -c ../HUELLAS-ANTES.txt | grep -c 'coincide\|OK$'
33                                                          ← hoy verifica 33/33
$ git grep -c 'HUELLAS-ANTES' main -- Expedientes | wc -l
0                                                           ← el manifiesto no está en el expediente
```

La huella «en el expediente» son 33 prefijos de 16 caracteres en una tabla del folio 018, no un manifiesto verificable con `sha256sum -c`; el objeto está en un directorio de sesión de un agente, en RAM. Con ironía medible: el único lugar durable donde hoy existen los originales es GitHub (M9-SEG-01).

**Respuesta a la pregunta 4 del mandato.** §3.4 («la huella va en el expediente y el objeto donde se custodie») cubre la idea, no la cadena. Para que sea verificable faltan tres cosas: (1) el **manifiesto completo** (`sha256sum` de 64 caracteres, con ruta) como pieza de `evidencia/`, porque ésa es «la huella en el expediente» y A9 la puede comprobar; (2) el **lugar de custodia nombrado y durable** en la constancia, y que no sea el scratchpad de un agente: el scratchpad es de la sesión, no del Product Owner, y un agente no custodia nada más allá de su corrida; (3) **quién custodia**, que sólo puede ser una persona (el Product Owner) o un lugar suyo. Sin (2) y (3), «custodia fuera del repositorio» es una frase.

**Dirección.** §3.4 y S2 nombran la tríada manifiesto en `evidencia/` + lugar durable declarado + custodio humano; y declaran que un directorio temporal de sesión **no es custodia**. La cabecera de un folio redactado no queda con la huella vieja «a propósito»: el folio nuevo (S1) trae la vigente (junta con M9-SEG-04).

---

### M9-SEG-06 · P2 · E4 + E1 — S2 pone en una sola bolsa cuatro datos de severidad y respuesta distintas, y A9 pide «Quién» como si un nombre no fuera dato personal

S2 lista «credenciales, datos personales, rutas del directorio personal del host, nombres de cuentas» y les da un solo tratamiento: «nada de eso se publica; lo que se redacta deja constancia». Pero:

- Una **credencial** empujada está comprometida y la respuesta es **revocar** (GitHub Docs, cita en M9-SEG-01); redactarla es lo de menos. La regla no dice «revocar» en ninguna línea.
- Un **dato personal de un tercero** (E-2) en repositorio público es un problema con dueño humano y eventual obligación legal; su respuesta es la solicitud de retiro y una decisión del Product Owner.
- El **usuario del host** en una ruta es higiene: el mismo identificador está público en 28 archivos de `IA.SDD.Documentacion` y 23 de `Lab-Geometria` (medido en M9-SEG-01). Redactarlo en cuatro piezas del expediente no cambia la exposición; sí justifica el paso antes del push, no una reescritura después.
- «**Nombres de cuentas**» es ambiguo: ¿cuenta de sistema (`pi`, `saimon`), cuenta de un usuario real del producto (el caso E-2), cuenta de GitHub del Product Owner (que ya es el autor público de cada commit)? El 0001 usó el término para el segundo caso; la regla lo deja abierto.

Y A9 exige que cada evidencia abra con «`Quién` la obtuvo». Si eso se lee como el nombre de una persona, la regla induce un dato personal por pieza. El propio `ev-07.meta.txt` lo resolvió bien sin que nadie lo pidiera: `Adquirió: presidente de mesa`.

**Impacto.** Ante una credencial sellada, el orquestador va a hacer lo que la regla dice (redactar y dejar constancia) y no lo que hace falta (revocar). Ante un nombre, va a tratarlo como una ruta.

**Dirección.** Tres clases con su respuesta pegada al paso: **secreto** (revocar, siempre, y después redactar), **dato personal de persona identificable** (no se asienta; si llegó al push, escalada al Product Owner con la opción de retiro), **identificador del entorno** (ruta, usuario, host: se redacta antes del push; si pasó, constancia y nada más). «Nombres de cuentas» se reemplaza por lo que se quiso decir. `Quién` en A9 y `Autor` en la cabecera se declaran **rol o identificador de agente** (`AG-NNNNN`, «presidente de mesa», «Product Owner»), nunca nombre propio. Cabe en el presupuesto: sigue siendo un paso («antes del push, S2») con fundamento pegado y tres filas.

---

### M9-SEG-07 · P2 · E1 — S2 no distingue público de privado, y no debe hacerlo para la compuerta; sí para la respuesta, y el observable existe sin preguntar

**Respuesta a la pregunta 3 del mandato.** La compuerta tiene que ser la misma en los dos casos, por dos razones que son E1 y no opinión: (a) el plan propone **conservación permanente** de los expedientes (D-7), y la visibilidad de un repositorio cambia con un clic mientras el expediente no cambia nunca (S1); (b) los mismos identificadores viajan entre repositorios: la ruta de host y el usuario que están en el `RPI.VideoControl` privado están también en tres repositorios públicos (M9-SEG-01). Una compuerta condicionada a «si es público» protege el repositorio y no el dato.

Lo que sí depende de la visibilidad es **la respuesta a lo ya empujado** (M9-SEG-06): en un repositorio privado, la constancia alcanza; en uno público, para un secreto o un dato personal, no.

**Cómo lo observa un agente sin preguntar.** Con dos datos derivados: el remoto (`git remote get-url origin`) y una sonda anónima al proveedor. El folio 005 l.212 del 0001 ya lo hizo exactamente así:

```
$ git -C RPI.VideoControl remote get-url origin
https://…@github.com/<organización de infraestructura del PO>/<destino privado>.git
$ curl -s -o /dev/null -w '%{http_code}\n' https://api.github.com/repos/<organización de infraestructura del PO>/<destino privado>
404                    ← privado (o inexistente para un anónimo, que a estos efectos es lo mismo)
$ curl -s -o /dev/null -w '%{http_code}\n' https://api.github.com/repos/hdcm-dev/Lab-Geometria
200                    ← público
```

Es una **observación** (§3.4), no una medición: vale con fecha y hora, y se asienta como tal. Nada que preguntar al Product Owner.

Un matiz que la regla debe nombrar, porque los destinos lo muestran: `RPI.VideoControl` tiene dos `/home/` que **no** son el host del orquestador sino rutas del propio banco de pruebas del producto (detalles de infraestructura, no transcriptos), y un expediente de infraestructura va a citar rutas de un dispositivo con toda legitimidad. S2 dice «rutas del directorio personal **del host**»: hay que decir de cuál host (el que corre al orquestador), para que el comando de M9-SEG-02 tenga excepción declarada y no se «pase» a mano.

**Dirección.** S2 fija su fundamento propio (permanencia + visibilidad mutable) en vez de heredar «`IA.SDD` es público»; declara la sonda de visibilidad como observación que condiciona sólo la respuesta; y precisa «host» = la máquina donde corre el orquestador, con la excepción del objeto del caso declarada en la pieza.

---

### M9-SEG-08 · P3 · E1 — El mecanismo que la regla manda —cartas e informes verbatim— es el que trajo las cuatro fugas, y S2 no dice que la redacción es la única edición admitida a un verbatim

§3.5: «el texto que se despacha se asienta en `evidencia/` antes de despachar, verbatim». §3: un informe entra «sin editar». Las cuatro piezas con el usuario del host en `main` son tres cartas de `ev-08` y un informe de réplica de `ev-06` (M9-SEG-02, lista de archivos): la ruta del scratchpad estaba en la carta porque el presidente la escribió ahí para decirle al agente dónde podía crear temporales, y el agente la copió al informe. Es decir: **S2 y «verbatim» se pisan en el tramo entre adquisición y push**, y la regla no dice cuál cede. El folio 018 lo resolvió redactando cartas e informes ya asentados, que S1 (todavía sin push) permitía, pero sin norma que lo ampare.

**Respuesta a la pregunta 5 del mandato, que es la misma tensión en el testimonio.** Publicar el literal byte a byte de un chat en un repositorio público tiene un riesgo que la regla no nombra y que no es técnico: **el Product Owner escribe en la conversación como quien no está siendo publicado**. Su mensaje trae lo que trae —una clave pegada, el nombre de un usuario de producción, el de un tercero, una IP interna, un juicio sobre una persona— y §3.3 lo convierte en pieza pública inmutable con huella. En el 0001 no pasó (`ev-07` → `1486` bytes, `cb39bbd64dd919e3…`, coincide con el `.meta.txt`; sin dato sensible, verificado); en el caso construido de M9-SEG-04 pasa al primer intento. Lo que falta no es una advertencia: es que **el asiento literal de un testimonio sea un acto que el Product Owner sabe que ocurre**, porque lo dijo una vez (`ev-07`: «las pruebas que aporse yo […] quedarian como prte de las especificaciones») y no cada vez. Dónde se declara eso (intake, contrato de entrada, prompt-snippet) es de otra comisión.

**Dirección.** S2 declara que la redacción con marca es **la única edición admitida** sobre una pieza verbatim (carta, informe, testimonio), que se hace **al asentar** y deja constancia; y que el presidente **no pone en una carta** lo que después no puede publicar (una ruta de scratchpad se pasa como variable: el 018 §2 ya lo hizo con `W=/`). Es prosa con un paso ya existente, no un paso nuevo.

---

## Respuestas a las preguntas del mandato

**Pregunta única: ¿S2 tal como está alcanza, y es aplicable en minutos sin verificador aparte?** No alcanza y hoy no es aplicable: su enumerable no detecta el único caso real y no puede dar cero en un expediente que cumple S2 con constancia (M9-SEG-02); no dice qué es cada dato ni qué respuesta lleva (M9-SEG-06); no resuelve el choque con «byte a byte» y A8 (M9-SEG-04); y trata «reescribir la historia» como el peor caso cuando el peor caso —lo empujado no se retira— ya ocurrió (M9-SEG-01). **Sí puede ser aplicable en minutos sin verificador**: una línea de `git log -p <base>..HEAD | grep` sobre patrones derivados, más una lista corta de tres clases con su respuesta. No suma pasos al presupuesto: reemplaza el paso «S2 antes del push» que ya está, con su fundamento pegado.

1. **¿Basta citar §2.2 o hay que editarla?** Ninguna de las dos (M9-SEG-03). S2 autónoma; §2.2 como precedente de forma; y una decisión explícita del Product Owner sobre el nombre del destino en `Expedientes/` del framework público.
2. **¿Qué hace la regla con lo ya publicado, y qué exige al 0001?** Hoy: nada, salvo la mención «forma histórica» de §5.1 y el «residuo» del folio 019. Lo que corresponde, sin reescribir el 0001 (R7, `Master-Prompt.md` §8.1): un folio 019 que **diga la verdad completa** —los originales siguen accesibles por SHA y por el PR, el squash no los retiró, y la decisión de pedir el retiro a GitHub es del Product Owner—, que no repita el dato ni la ruta, y que registre la deuda de E-2 sobre `Lab-Geometria` con dueño y evento de cierre (M9-SEG-01). Para la ruta con el usuario del host: constancia y nada más (M9-SEG-06); el mismo identificador es público en 51 archivos de otros dos repositorios.
3. **¿Público vs. privado?** La compuerta no distingue; la respuesta sí; el observable es remoto + sonda anónima, asentado como observación (M9-SEG-07).
4. **¿La huella cubre la custodia externa?** La idea sí, la cadena no: falta el manifiesto en `evidencia/`, el lugar durable nombrado y el custodio humano; un scratchpad de sesión en tmpfs no es custodia (M9-SEG-05).
5. **¿El literal byte a byte de un chat tiene un riesgo que la regla no nombra?** Sí: el Product Owner no escribe como quien está siendo publicado, y la regla convierte cada mensaje en pieza pública inmutable sin que él lo sepa cada vez; más el choque mecánico con A8 cuando hay que redactar (M9-SEG-04, M9-SEG-08).

**El anti-patrón de §7.** El comando `git grep -c '/home/' -- Expedientes` → 0 **no es el correcto**: 7 falsos positivos y 0 verdaderos positivos sobre el 0001, corre sobre el árbol y no sobre lo que se empuja. El correcto, probado: `git log -p --format= <base>..HEAD -- Expedientes | grep -iE "^\+.*((/|-)home[/-][a-z0-9]+|/Users/|C:\\\\Users|$(id -un))"` → vacío, con `<base>` la de `Master-Prompt.md` §12.1 T0 (M9-SEG-02).

**Fuera de mi competencia, y lo digo:** el nombre y la posición de los campos nuevos (`Huella del original`, la marca de redacción), en qué instrumento se registra la deuda de E-2, y si la aceptación del Product Owner de que sus palabras se publican va al intake o al contrato de entrada.

---

## Lo que revisé y está bien

1. **S2 «antes del push y no después», como paso con fundamento.** Es la decisión correcta y cabe en el presupuesto de nueve pasos de la guía (Parte IV): se lee ejecutando, su omisión hace daño, es olvidable, y tiene comprobación. Lo que falla es el comando, no el lugar ni la forma.
2. **`ev-07` está limpio y su cadena cierra.** `git show main:…/ev-07-presentacion-original.txt | sha256sum` → `cb39bbd64dd919e3…`, `1486` bytes, iguales al `.meta.txt` y a `SHA256SUMS-ev-07`; el `.meta.txt` declara canal, marca de tiempo con zona, medio de adquisición y «sin credenciales ni datos personales», y el `Adquirió:` es un rol y no una persona. Es la forma que A9 y §3.3 deberían citar como ejemplar.
3. **La redacción del folio 018 fue completa sobre el patrón que eligió, y el manifiesto de custodia verifica hoy.** `git grep -n '/home/' main -- Expedientes | grep -ci <u>` → `0` (ninguna ruta `/home/<u>/` sobrevivió); `sha256sum -c HUELLAS-ANTES.txt` → 33/33. El defecto está en el patrón (M9-SEG-02) y en el lugar de custodia (M9-SEG-05), no en la ejecución.

---

## Solicitudes de convocatoria

- **Trazabilidad documental (AG-00110):** la deuda de E-2 sobre `Lab-Geometria` (folio 018 §1: «la trata el Product Owner después de la migración») no está en `pendientes_declarados` del contrato de entrada ni en el plan, y la migración ya se fusionó. Señal: dueño y evento de cierre ausentes; ubicación: `Expedientes/0001-…/actuaciones/018-…md` §1 y `plan/20-Plan-De-Aplicacion.md` #18.
- **Formal:** dos campos que S2 necesita y §3 no tiene —la huella del original cuando hubo redacción, y la marca de redacción como única transformación admitida— y el ajuste de A8 y A9 en consecuencia. Ubicación: `plan/Expediente-Rules.md` §3.3, §3.4, §6 A8/A9.
- **Requisitos / Product Owner (por el presidente):** dos decisiones que no son de la mesa: si pide a GitHub el retiro de los commits `e8c84d9`…`8512a45` del PR #66 (M9-SEG-01), y si acepta que `Expedientes/` del framework público nombre a los destinos por su nombre, incluido uno privado (M9-SEG-03).
