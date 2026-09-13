# Informe — Comisión N1, Requisitos (núcleo permanente, `Mesa-Rules.md` §5.1)

## 1. Cabecera

| Campo | Valor |
|---|---|
| Comisión | N1 — Requisitos (núcleo permanente). Siglas `M9-REQ-NN`. Trabajé a ciegas, sin informes de otras comisiones. Sólo lectura en todos los repositorios; ningún archivo escrito |
| Fecha | 2026-09-13 |
| Base leída, plan | `scratchpad/mesa/00-contrato-de-entrada.md`; `scratchpad/plan/Expediente-Rules.md` (borrador 1.0, 360 líneas) entero; `scratchpad/plan/20-Plan-De-Aplicacion.md` entero |
| Base leída, expediente 0001 | `IA.SDD-i09` rama `intervencion/09-reporte-31` = `main` `a501857`. Folios 011, 014 §5 y R-04, 015, 016 y 018 enteros; `ev-07-presentacion-original.txt` byte a byte (`cat -A`, 1486 bytes, SHA-256 `cb39bbd6…dd1c`, coincide con `SHA256SUMS-ev-07`) y su `.meta.txt` |
| Base leída, norma 13.17 | `Deriva-Rules.md` §0–§1 entero (l.1-80); `README.md` invariantes (l.105-131), reglas de intervención (l.140-152); `Mesa-Rules.md` §6.1 y §7.1 enteros, índice de secciones; `SDD-Development-Guide.md` §III.8 entero y Parte IV l.600-680 («paso o prosa», «reglas escritas a partir de un caso», «impacto»); `Master-Prompt.md` §8.1 l.876-1000; `Master-Prompt-Reanudacion.md` por grep; `Conocimiento/Knowledge-Mesa-De-Expertos-A-Pedido.md` §2.3 |
| Evidencia del presidente | `ev-01`, `ev-02`, `ev-03` enteros. Caso de dos folios: corrí `a1a10.sh` sobre `scratchpad/caso` (salida en §3, M9-REQ-04) |
| Destinos | `Lab-Geometria` `main` `d12fb1c`: `git show` del folio 002 de `EXP-0001` y `git grep` del OK de la fase `k`. `RPI.VideoControl`: no lo necesité para mi mandato |
| Fuentes externas | Ninguna consultada. Las normas que nombro en M9-REQ-08 son las que **los folios 004–006 ya nombran**; no las abrí ni afirmo nada sobre su contenido |

---

## 2. Hallazgos

### M9-REQ-01 · P1 · E2 — La opción A de E-3 no la puede decidir esta mesa: modificar D9 exige «decisión explícita del responsable», y el lote se resolvió sin elevarlo al Product Owner

**Anclas.**

- `README.md` l.145: *«Modificar una invariante D1 a D9 | … Requiere decisión explícita del responsable y nota de coherencia»*.
- Folio 018, cabecera: *«Autor | Presidente de mesa, sobre la instrucción del orquestador de la sesión, que resolvió el lote **con el conjunto** y sin elevarlo al Product Owner»*; §1 E-3: *«No es pregunta: es insumo de la intervención 09 … lo decide la mesa de la intervención 09»*.
- Folio 015 E-3, `SI NO RESPONDÉS`: *«Rige B, porque una invariante no se modifica sin decisión explícita (README.md)»*.
- Plan, «Las dos decisiones abiertas», 1: *«Propuesta del presidente, marcada como propia: **A**»*; fila 15: `Deriva-Rules.md` 5.4 → 6.0.
- `ev-07`, byte a byte: no contiene «D9», «Deriva», «invariante» ni «evidencia» (`grep -ciE 'D9|deriva|invariante|evidencia' ev-07-presentacion-original.txt` → `0`).

**Qué pasa.** La cadena de autoridad para tocar D9 es: jurado → `SI NO RESPONDÉS = B` → el Product Owner elige. El folio 018 cortó esa cadena al convertir la escalada en «insumo de la mesa». Una mesa —esta— no es «el responsable» de `README.md` l.145; es un órgano que **propone parches** (`Mesa-Rules.md` §1.2, «Aprobar: el jurado sobre el parche, **o el humano si §7 dispara**»). El disparador 7 disparó (folio 015 E-3). Si esta mesa aprueba A, la 13.18 modifica una invariante por decisión de un agente, exactamente lo que `README.md` prohíbe, y `ev-07` no lo cubre: el Product Owner pidió que sus pruebas queden como parte de las especificaciones, no que se toque D9.

**Impacto si no se corrige.** Un major sobre una invariante sin la decisión que la norma exige; el primer destino que audite contra D9 6.0 lo hace sobre una regla cuya legitimidad es discutible, y la propia figura del expediente —que nace para custodiar la palabra del Product Owner— se estrena decidiendo en su lugar.

**Dirección.** E-3 vuelve a ser **escalada al Product Owner**, una sola, con las opciones A y C (ver §3, pregunta 2) y `SI NO RESPONDÉS = C`. La mesa aprueba C como texto de la 13.18 (minor) y deja A **preparada** como parche condicionado a la respuesta. B se descarta con fundamento en R5. Nada se bloquea: C ya está escrito en el borrador (§3.3, tabla, fila «aprobación»).

---

### M9-REQ-02 · P1 · E2 — «Acordate en saber dónde estás parada» no tiene lugar en la regla: §1 dice «el que lo trata», §2 dice «donde ocurre el caso», y un caso que atraviesa dos repositorios no tiene regla de radicación

**Anclas.**

```
$ grep -n -E 'que lo trata|ocurre el caso|donde ocurre' plan/Expediente-Rules.md
46:   nació en otra corrida (otra base, otra rama) o en otro repositorio que el que lo trata, o la presentación
76:| **Destino** | `SDD/Expedientes/<NNNNN>-<Titulo>/`, hermana de `SDD/Docs/` | Es donde ocurre el caso. …
$ grep -n -iE 'parad' plan/Expediente-Rules.md plan/20-Plan-De-Aplicacion.md
(vacío)
```

`ev-07`, byte a byte: *«acordate en saber donde estas parada - para el caso de migrar `Lab-Geometria` , lleva tus expedientes dentro de un carpeta numerada en `/PROG2/Geometria/Lab-Geometria/SDD/Expedientes` - ahora si planteaste una mesa en `IA.SDD`   , lleva su expediente de reportes `/IA/SDD/IA.SDD/Expedientes` de igualmanera»*.

**Qué pasa.** El Product Owner dio el criterio de radicación con dos ejemplos: **el repositorio donde estás trabajando** (donde migrás, donde planteaste la mesa). La regla usa dos formulaciones distintas y ninguna es ésa: «donde ocurre el caso» (§2) es ambiguo para el caso que la propia regla toma como condición de apertura —§1 condición 1, *«el caso atraviesa … más de un repositorio»*—: ¿ocurre en el que originó el hecho o en el que lo trata? El expediente 0001 es el ejemplo: el caso ocurre en el framework, se trató en el framework y sus salidas (reporte 31, prompt 09) viven en `IA.SDD.Documentacion`. El folio 011 (N1-02) ya señaló que «repositorio de la mesa» y «repositorio del caso» son dos criterios distintos; el dictamen lo resolvió para el framework (E-1 = A) pero no enunció el criterio general, y la regla tampoco.

**Impacto si no se corrige.** Dos corridas sobre un caso que atraviesa repositorios pueden abrir dos expedientes, uno en cada repositorio, sin que ninguna incumpla la letra. Es la clase de defecto que §0 de la regla declara como origen de la figura («dos corridas la inventaron con dos formas distintas»).

**Dirección.** §2 fija un solo criterio, el del Product Owner: el expediente se radica en el repositorio **donde corre la corrida que trata el caso** («donde estás parada»); el otro repositorio se nombra como texto en la carátula (`Origen`) y, si allí también hay expediente, cada uno cita al otro por ruta calificada (§3.1). Y §1 condición 1 usa la misma palabra que §2.

---

### M9-REQ-03 · P2 · E2 — El Product Owner pidió «un README.md que describa el caso tratado»; la carátula lo prohíbe: cinco campos, «Nada más», y ninguno describe

**Anclas.**

- `ev-07`: *«dentro se ubique un README.md que describa el caso tratado»*.
- Regla §3, l.117-120: *«Cinco filas … el número, el título, la fecha de apertura, el origen … y la base … Después de la tabla, la línea de remisión. **Nada más**: ni estado, ni índice, ni commit del último folio, ni huellas»*.
- A2: `for c in Número Título Apertura Origen Base; …` — ningún campo descriptivo.
- Caso de dos folios, `README.md`: el único contenido descriptivo es `| Título | Enlace roto en el roadmap |`.
- Dictamen Q3 (4-1): README con 5 campos; el juez de impacto disintió por «quien no estuvo tiene que abrir el último folio».

**Qué pasa.** La rechazada fue la **carátula con datos derivados** (estado, índice, huellas: R-01, E1), y la regla lo resuelve bien. Pero el «Nada más» arrastró también lo que el Product Owner pidió en letra: una descripción. Un `Objeto` de una o dos oraciones **no es derivable del árbol ni de git** (`Root-Rules.md` §10 no lo alcanza), no se desincroniza (es fijo desde la apertura, como el título) y es lo que un lector sin contexto necesita para decidir si abre el expediente. El folio 011 Q3 lo pedía («número, título, **objeto**, origen…»); el 014 §5 lo dejó caer sin motivarlo, y el jurado votó el conteo, no la ausencia de descripción.

**Impacto si no se corrige.** Con expedientes numerados y títulos de cuatro palabras, el listado de `SDD/Expedientes/` no dice de qué trata cada uno; la reanudación (R0 paso 4, plan fila 4) va a listar «expedientes abiertos» por título y pase, y para saber de qué se trata habrá que abrir el folio 001. Es la lección del folio 003 que el juez disidente de Q3 nombró.

**Dirección.** Una sexta fila fija, `Objeto`, de una a tres oraciones, escrita al abrir y **fija como el título** (un cambio de objeto es un folio, no una edición). A2 suma la palabra. El conteo pasa a diecinueve; si se quiere conservar «dieciocho», el título absorbe la descripción y §3 lo declara: «el título describe el caso; no es una etiqueta». Cualquiera de las dos cumple la letra de `ev-07`; hoy no la cumple ninguna.

---

### M9-REQ-04 · P2 · E2 — S1 cambió el momento del sellado sin declararlo: el dictamen dice «después del primer push»; la regla dice «después de la fusión»

**Anclas.**

```
$ grep -n -oE 'después del primer push|después de la fusión|después de que la fusión|Antes de la fusión|Antes del primer push' \
    actuaciones/014-*.md actuaciones/016-*.md plan/Expediente-Rules.md
016-dictamen.md:30:después del primer push
016-dictamen.md:30:Antes del primer push
016-dictamen.md:50:después del primer push
014-refutacion-del-plan-compuesto.md:211:después de la fusión      (← «se evalúa contra la rama principal después de la fusión»)
014-refutacion-del-plan-compuesto.md:212:después del primer push   (← «lo que protege la foja es "ninguna pieza cambia después del primer push"»)
014-refutacion-del-plan-compuesto.md:556:después del primer push
014-refutacion-del-plan-compuesto.md:557:Antes del primer push
Expediente-Rules.md:244:después de la fusión
Expediente-Rules.md:245:después de que la fusión
Expediente-Rules.md:247:Antes de la fusión
Expediente-Rules.md:250:Antes del primer push        (← sólo S2)
Expediente-Rules.md:306:después de la fusión          (← A7)
Expediente-Rules.md:306:Antes de la fusión
Expediente-Rules.md:349:Antes del primer push        (← snippet, sólo S2)
```

Dictamen Q6 (5-0): *«ninguna pieza … se modifica … **después del primer push**; se comprueba … **contra la rama principal ya fusionada**. … Antes del primer push la inmutabilidad se declara no observable»*. El 014 distinguía las dos cosas: el **momento** (push) y **dónde se comprueba** (main). La regla fundió las dos en «fusión» y dice en §4 S1 que *«Antes de la fusión … lo que pasó en el árbol de trabajo no deja rastro que nadie pueda verificar»* — que es falso para una rama publicada: sus commits son verificables por cualquiera hasta que se aplaste, y S3 existe justamente para que no se aplaste.

Corrí A7 tal como está en la regla sobre el caso de dos folios, al que le agregué en la historia una evidencia y su borrado posterior a la creación del README (commits `1c420f5`, `1d6a3dc`, ya presentes en `scratchpad/caso`):

```
$ bash a1a10.sh scratchpad/caso SDD/Expedientes/00001-Enlace-Roto-En-Roadmap
== A7
(fusión: b621d58)
1d6a3dc borro evidencia
```

A7 funciona **midiendo desde el commit de alta del README en `main`**, no desde el push: sobre una rama fusionada sin aplastar detecta lo que cambió después del alta —que es lo que el dictamen quería—, pero la prosa de S1 autoriza lo contrario («antes de la fusión … no observable»). Prosa y comprobación se contradicen dentro de la misma sección.

**Impacto si no se corrige.** Ventana entre push y fusión en la que un folio publicado se puede reescribir «legalmente» según S1 y A7 lo va a marcar igual (si no hubo squash). El primer expediente que lo haga va a discutir la letra contra el comando. Además, el expediente 0001 redactó siete folios en la rama después de asentados (folio 018 §3: *«Los folios 005, 006, 007, 010, 011, 014 y 015 quedan redactados»*), en una rama que no había sido pusheada: bajo la letra del dictamen fue lícito; bajo la letra de la regla también. No es ése el problema; el problema es que el cambio de letra no se declaró y cambia el momento.

**Dirección.** Restituir el momento del dictamen («después del primer push») y conservar el «contra la rama principal» como lugar de la comprobación, o declarar el cambio con su motivo en §4 y en la fila 1.0 del control de cambios (es una decisión cerrada 5-0 que sólo se reabre con E1/E2; el E2 lo tiene que aportar la intervención, no darlo por hecho).

---

### M9-REQ-05 · P2 · E2 + C — La condición de apertura de Q2 se estrechó dos veces sin declararlo, y «ante la duda, no se abre» va contra «de forma sistemática» sin ningún caso medido

**Anclas.**

- Dictamen Q2 (4-1): *«Se abre cuando el caso atraviesa más de una corrida o más de un repositorio, **o entra al árbol material externo: testimonio, captura o archivo aportado**»*.
- Regla §1 condición 2: *«Entra al árbol material externo que tiene que preservarse **y ningún artefacto con casa lo aloja**»*.
- Regla §1 l.66-68: *«**Ante la duda, no se abre** … Un expediente abierto de más cuesta mantener; uno abierto tarde cuesta una constancia»*.
- `ev-07`: *«los expedientes y casos que se armen se documenten **de forma sistematica**»*.
- Regla §5: *«Todo patrón que una regla generalice desde un caso declara **cuántos casos lo sostienen**»*.
- `grep -n -iE 'ante la duda' actuaciones/013-*.md actuaciones/014-*.md actuaciones/016-*.md` → vacío.

**Qué pasa.** (a) La cláusula «y ningún artefacto con casa lo aloja» convierte la condición 2 en una pregunta interpretativa («¿tiene casa?») que el jurado quiso evitar al aprobar una condición **observable al abrir** (R-02). El voto disidente de Q2 (juez CB: «esa rama abre un expediente por cada mensaje del Product Owner») explica la intención, pero el dictamen no la incorporó y la regla no declara que se aparta de la forma aprobada. (b) «Ante la duda, no se abre» no está en ningún folio: es previsión del redactor, en una regla que exige a las demás declarar cuántos casos sostienen cada patrón; para éste son cero. Y su dirección es la contraria a la del pedido: el Product Owner pidió sistematicidad porque lo que encontró fue **ausencia** de expedientes (reporte 31: nueve archivos, tres directorios, una rama para reconstruir una fase), no exceso. El costo que la regla nombra para el error simétrico —«uno abierto tarde cuesta una constancia»— es el mismo que la regla ya cubre con §5.1; no hace falta el sesgo, alcanza el mecanismo.

**Impacto si no se corrige.** La asimetría de `Master-Prompt.md` §8.1 («detener es barato para el agente y caro para el humano») se repite acá al revés: no abrir es barato para el agente y caro para quien reconstruye. El reporte 31 nació de eso.

**Dirección.** Condición 2 con la letra de Q2, y la exclusión «lo que tiene casa» donde ya está (la lista de «No se abre»), que es enumerable por tipo de artefacto y no por juicio. La oración «ante la duda» se reemplaza por la constancia de incorporación de antecedentes como **mecanismo neutro** («un caso que resulta atravesar otra corrida abre entonces, con constancia»), sin recomendar un lado; y si se conserva el sesgo, se declara «cero casos lo sostienen» como la propia §5 exige.

---

### M9-REQ-06 · P2 · E2 — Q11 ordenó cablear el orden previo a la detención también en la reanudación; el plan no lo hace

**Anclas.**

```
$ sed -n 35p actuaciones/016-dictamen.md | grep -o 'Cableado.*reanudación'
Cableado** en `Master-Prompt-Migracion.md` M4 (l.291) y **modificación declarada** de l.46 («no la reconvoca dos veces»), y en la reanudación
$ sed -n 20p plan/20-Plan-De-Aplicacion.md | grep -c '§8.1'
0
```

Plan fila 4 (`Master-Prompt-Reanudacion.md` 1.13 → 1.14): sólo R0 paso 4 (expedientes abiertos) y §5 (punto de continuación). Plan fila 3 (`Master-Prompt-Migracion.md`): sí cablea M4 y l.46. Folio 011 N1-07 ya había señalado el simétrico: *«qué pasa cuando la mesa misma no puede convocarse porque falta el estado leído (§0.0, cláusula 2)»*, y `Master-Prompt-Reanudacion.md` §0 tiene su propia detención («Si el árbol se contradice, lo declara y se detiene»), que no es ni confirmación de plan ni T4.

**Qué pasa.** El dictamen (5-0 en Q11) pidió tres cableados; el plan hace dos. Puede ser que la intervención considere que basta con que `Master-Prompt.md` §8.1 «la leen los tres orquestadores» (l.878-880). Si es así, hay que **declararlo** en la fila 4 y explicar por qué la migración sí necesita cableado propio y la reanudación no; si no, falta la fila.

**Impacto si no se corrige.** El único orquestador que arranca sin corrida en curso —el que más detenciones por contradicción del árbol emite— queda fuera del orden «mesa antes de detención» que el Product Owner pidió («en vez de pararte, arma una mesa»).

**Dirección.** O una línea en la fila 4 que cablee el orden de §8.1 en la detención de `Master-Prompt-Reanudacion.md` §0 (acotado como en Q11), o una línea que declare por qué la cita a §8.1 de la reanudación (8 ocurrencias medidas: `grep -c '§8.1' Master-Prompt-Reanudacion.md` → 8) ya lo cubre.

---

### M9-REQ-07 · P2 · E2 — «Se va expedientando todo su tratamiento» no tiene criterio de aceptación: la constancia que folia `Audit/` por enlace es forma completa, sin criterio A ni I que la exija cuando corresponde

**Anclas.**

- `ev-07`: *«partiendo de informes que presentan el caso y luego se va expedientando **todo su tratamiento**»*.
- Regla §3, forma completa: *«una **constancia** que folia por `ruta@commit` los artefactos de `Audit/` … que el caso produjo o tocó (§5)»*, precedida de *«cuando corresponde y sólo entonces»*.
- Regla §6: A1–A10 no miran el contenido de ninguna constancia; I1–I4 tampoco (`grep -n -E 'ruta@commit' plan/Expediente-Rules.md` → l.67, 139, 277, 291, 325: cinco menciones, ninguna en §6).
- Regla §7, anti-patrón «Se copia el registro de mesa…»: detección `grep -rl '^## 2. Contrato de entrada' actuaciones/` → vacío — detecta la **copia**, no la **ausencia** del enlace.

**Qué pasa.** La decisión J-04 (5-0) de que el tratamiento viva en `Audit/` y el expediente lo folie por enlace es cerrada y no la discuto. Lo que falta es la mitad que hace que el Product Owner obtenga lo que pidió: que **desde el expediente se llegue a todo el tratamiento**. Hoy un expediente de destino cuyo caso convocó una mesa puede tener `presentacion` + `resolucion` y ningún enlace al registro de mesa, y cumple A1–A10 e I1–I4. Es el simétrico que la guía Parte IV pide preguntar: la regla protege contra duplicar (`Audit/` dentro del expediente) y no contra omitir.

**Impacto si no se corrige.** Reconstruir el tratamiento vuelve a exigir `grep` por identificadores en `Audit/`, que es la medición del reporte 31 que fundó la figura.

**Dirección.** Un criterio interpretativo I5 («todo artefacto de `Audit/` que el caso produjo está foliado por `ruta@commit` en una constancia») o, mejor, enumerable: a partir de la vía única de §5, `git grep -l 'Expedientes/<NNNNN>-' -- SDD/Docs/Audit` da los artefactos que citan el expediente, y cada uno debe aparecer en `actuaciones/` como `ruta@commit`. El comando queda en §6, sin guion aparte (R3).

---

### M9-REQ-08 · P3 · E2 — «Mejorala en base a los estándares de la industria y la academia» no deja rastro en la regla: los folios nombran diez normas y la regla ninguna

**Anclas.**

```
$ grep -n -iE 'est[aá]ndar|\bISO\b|industria|academia|RFC|NIST|IEEE' plan/Expediente-Rules.md
(vacío)
$ grep -hoE '\bISO(/IEC)?[ /-]?[0-9]{4,5}(-[0-9])?|NIST SP [0-9-]+|RFC [0-9]+|IEEE [0-9]+' actuaciones/00[4-9]-*.md actuaciones/01[01]-*.md | sort -u | tr '\n' ';'
IEEE 1012;IEEE 29119;IEEE 29148;ISO 15489-1;ISO 23081-1;ISO 9001;ISO/IEC 27037;NIST SP 800-86;RFC 3161;RFC 3227;
```

`README.md` l.152: *«los estándares de industria se nombran, no se enlazan»* — nombrarlos está permitido y es la forma prevista.

**Qué pasa.** El Product Owner dio un mandato explícito de fundamento («arregla esa idea y mejorala en base a los estándares…»). Las comisiones V1 y V2 lo cumplieron (folios 004 y 005 nombran gestión documental y evidencia digital por su número), pero la regla —que es lo que va a leer quien la aplique y quien la audite— no dice qué tomó de dónde. Un lector que abra `Expediente-Rules.md` no puede saber que la foliatura, la carátula fija, el original byte a byte con huella y la cadena de custodia responden a prácticas nombradas, y no a preferencias del redactor. No pido más texto normativo: pido **trazabilidad del mandato**, que es competencia de requisitos.

**Impacto si no se corrige.** El pasaje de `ev-07` queda cumplido en los folios y no en el producto; la próxima mesa que revise la regla no tiene contra qué contrastar «mejor».

**Dirección.** Una fila en el control de cambios (§9) o una nota de dos líneas en §0 que nombre, como texto y sin enlace, qué práctica sostiene qué sección (foliatura y carátula; custodia y huella; clasificación de la evidencia), citando el folio del 0001 del que sale. Sin abrir ni resumir las normas.

---

## 3. Respuestas a las preguntas del mandato

### Pregunta 1 — Cada pasaje de `ev-07` contra la regla y el plan

| Pasaje de `ev-07` (byte a byte) | Dónde queda | Con qué se verifica | Estado |
|---|---|---|---|
| «se documenten de forma sistematica dentro de lo que sería <repo>/SDD/Expedientes» | Regla §2 (destino `SDD/Expedientes/`; framework `Expedientes/` en la raíz, que es el literal «`/IA/SDD/IA.SDD/Expedientes`»); «sistemática» = condición de §1 | A1 (carpeta, cinco dígitos); I1 (la condición se aplicó) | Cumple en ubicación. En sistematicidad, ver M9-REQ-05: la regla sesga hacia no abrir |
| «cada caso se vaya numerando» | §3.1 (cinco dígitos, correlativo, nunca reciclado) | A1 (`uniq -d` vacío) | Cumple. El ancho no lo pidió el Product Owner: sale de D3, declarado |
| «un README.md que describa el caso tratado» | §3 carátula: cinco campos, «Nada más» | A2 | **No cumple la letra**: ningún campo describe (M9-REQ-03) |
| «tal como se hacen en los juicios, mesas o comisiones de investigaciones» | §3.2 seis tipos (`presentacion`, `providencia`, `informe`, `constancia`, `resolucion`, `archivo`), §3.1 foliatura, §4 sellado | A3, A4, A5, A6, A7 | Cumple. Es la parte mejor resuelta del borrador |
| «partiendo de informes que presentan el caso» | §3.2: el folio 001 es `presentacion`; §3.3 el original byte a byte | A3 (desde 001), A8 (huella) | Cumple |
| «y luego se va expedientando todo su tratamiento» | §5: `Audit/` es la fuente, el expediente folia por enlace; constancia `ruta@commit` en forma completa | **Ninguno** | Cumple a medias: la vía existe, no se verifica (M9-REQ-07) |
| «las pruebas que aporse yo o las que obtuviesen los agentes quedarian como prte de las especificaciones» | §0 tabla («No convierte la evidencia en especificación»), §3.3 (clasificación por contenido), §3.4 (dos clases), §5 (funda; vía única por control de cambios) | A8, A9, A10, I3, I4 | Cumple en la lectura del dictamen (Q8, 5-0: «funda, no se vuelve»). La parte «pruebas que aporte yo» = aprobaciones depende de E-3 (pregunta 2) |
| «arregla esa idea y mejorala en base a los etandares de la industria y la academia» | En los folios 004–006 del 0001; en la regla, en ningún lado | Ninguno | Cumplido en el proceso, invisible en el producto (M9-REQ-08) |
| «cuando te encuentres con un problema , en vez de pararte, arma una mesa adecuada … evalua realmente si necesitas preguntarme algo o es una mala interpretación analizando todo el conjunto del problema» | Plan filas 2 (`Master-Prompt.md` §8.1, orden de cinco pasos, acotado a ambigüedad y arbitraje) y 3 (`Master-Prompt-Migracion.md` M4 y l.46). «Evaluá si necesitás preguntarme» ya es la pregunta previa y el origen del hecho de §8.1 (l.966-1000, leídas) | Ninguno enumerable; es comportamiento del orquestador | Cumple con el acotamiento de R-08 (correcto: T1 y T4 no se frenan). Falta la reanudación (M9-REQ-06) |
| «acordate en saber donde estas parada … lleva tus expedientes … `/PROG2/Geometria/Lab-Geometria/SDD/Expedientes` … si planteaste una mesa en `IA.SDD` … `/IA/SDD/IA.SDD/Expedientes`» | Las dos rutas están (§2). El **criterio** («donde estás parada») no está: §1 dice «el que lo trata», §2 «donde ocurre» | Ninguno | **No cumple** para el caso que atraviesa repositorios (M9-REQ-02) |
| «tenes el ok de la fase K, y todo lo demas hace lo vos, … me centraria primero en migrar Lab-Geometria - cuando termines con este luego podes seguir migrando con RPI.VideoControl» | Fuera del alcance de la regla: es una aprobación y una instrucción de orden para la corrida de migración. Es el ejemplar real de §3.3 fila «aprobación» y de E-3 | — | No es pedido para la figura. Lo anoto porque es la prueba de que un mismo mensaje mezcla los tres pasajes de §3.3 (aprobación, pedido, instrucción), y la regla lo resuelve bien clasificando por pasaje |

### Pregunta 2 — E-3: opción A, B, o una C

**Lo que el Product Owner pidió, con la letra.** «Las pruebas que aporte yo … quedarían como parte de las especificaciones». No nombra D9 ni pide tocar ninguna invariante. Pide un **efecto**: que lo que él aporta cuente. La opción A produce ese efecto por la vía más pesada (major, invariante); no es «más de lo que pidió» en efecto, es **más de lo que pidió en medio**, y el medio tiene un dueño que no es la mesa (M9-REQ-01).

**La letra de `Deriva-Rules.md` §1, leída entera.** l.53: `humano` es *«una aprobación explícita **registrada** con fecha»*. l.55: no es evidencia *«una **captura** de una conversación»*. La palabra que distingue es **registrada** contra **captura**. Una captura es lo que uno pega sin procedencia: no tiene quién, ni cuándo con zona, ni por dónde llegó, ni integridad. El asiento de §3.3 tiene las cuatro cosas: bloque literal, `Canal`, `Fecha-hora` con zona, `Huella`. **Registrar es exactamente el acto que convierte la captura en aprobación registrada.** El jurado leyó choque E1 «para este caso» (R-07), y lo entiendo así: el choque existe si se lee l.55 aislada; no existe si se lee con l.53, porque l.53 admite la aprobación registrada y l.55 excluye la no registrada. No es contradicción en la invariante; es una **frontera que la invariante no traza** —dónde termina «captura» y empieza «registro»—, y trazarla no modifica D9: la aplica.

**Opción B** («una aprobación por conversación no es evidencia D9») **no cumple R5**: la única prueba que el Product Owner aporta de manera habitual es su aprobación (§0 de la regla lo dice: «la prueba más frecuente del Product Owner —una aprobación dada en la conversación—»); dejarla fuera de D9 es dejar sus pruebas fuera de las especificaciones. Y tiene consecuencia medida en un destino: el cierre de la fase `k` de `Lab-Geometria` (`git grep` sobre `main` `d12fb1c`: `Roadmap-Producto.md` l.66, 97 y 182; `Mini-Plan.md` l.470) se sostiene en «tenés el ok de la fase K», y bajo B queda sin estatus de evidencia. B se descarta.

**Opción C, que cumple sin tocar la invariante.** D9 intacta; `Expediente-Rules.md` §3.3 —que ya está escrita así en el borrador— declara que el asiento con original, canal, fecha-hora con zona y huella **es** «la aprobación explícita registrada con fecha» de l.53, y que lo que l.55 excluye es la captura **sin ese registro**. La cita D9 resultante es `[EV-XXXXX | humano | SDD/Expedientes/<NNNNN>-…/actuaciones/NNN-… | bloque testimonio | <fecha>]`, que cumple las cuatro condiciones de D9 (localizable, reproducible por la huella, contemporánea por la fecha-hora, independiente porque la escribió el Product Owner y no el agente que afirma). Severidad **minor**. Costo de C, que hay que declarar: un auditor que lea sólo `Deriva-Rules.md` puede dudar; por eso C lleva, en `Master-Prompt.md` §10 o donde el auditor lee sus criterios, una remisión a `Expediente-Rules.md` §3.3 —eso no toca D9—. Y **A queda preparada como parche** para cuando el Product Owner decida: es el default sensato para `SI NO RESPONDÉS`, como el jurado ya había fijado B por la misma razón (README l.145).

**Respuesta en una línea.** A es lo que el Product Owner necesita, pero no lo que puede decidir esta mesa; B contradice R5; C cumple R5 hoy, minor, y deja A a quien le corresponde.

**Nota medida sobre el caso real, para quien decida.** El folio 002 de `EXP-0001` en `Lab-Geometria` (`git show main:SDD/Expedientes/0001-Migracion-Normativa-A-13.16/actuaciones/002-testimonio-ok-fase-k.md`) transcribe «tenés el ok de la fase K» con tilde; `ev-07` dice «tenes el ok de la fase K,» sin tilde y con coma. Es la normalización que §3.3 prohíbe, en el ejemplar que cerró una fase. Sostiene la necesidad de la huella (A8) con un caso, no con previsión; y es D-1, no de esta mesa.

### Pregunta 3 — Q1 a Q12: aplicadas como se aprobaron, o cambiadas

| Q | ¿Como el folio 015 §4 la aprobó? | Observación |
|---|---|---|
| Q1 | Sí | Destino `SDD/Expedientes/`; framework en raíz (E-1 = A); exclusión §VI.5 declarada (plan fila 8); l.152 reformulada y declarada (fila 9). Un matiz: el dictamen dice «Ningún archivo ejecutable suelto: la evidencia lleva su comando dentro del archivo»; A9 acepta cualquier extensión que abra con `Comando`. Es compatible si el comando está dentro; no lo cuento como cambio |
| Q2 | **Cambiada sin declarar** | Condición 2 estrechada con «y ningún artefacto con casa lo aloja»; «ante la duda, no se abre» agregado (M9-REQ-05). Fundamento visible: el voto disidente CB de Q2. No está declarado como apartamiento |
| Q3 | Sí, con un agregado | Dieciocho campos, tres archivos, verificado sobre el caso (README 5; 001: 4+1+3; 002: 4+1). Agregado: «la pregunta exacta» (§3.3 punto 3), que en el caso más frecuente —la aprobación responde a un lote— es un decimonoveno campo no contado. Ver pregunta 4 |
| Q4 | Sí | Número local, sin `EXP-`, excluido con motivo; colisión medida incluida la migración ya fusionada (`ev-02`: `EXP-` en 20 archivos y `EV-` en 9 de `Lab-Geometria`; 45 de `EV-` en RPI). La cita desde afuera pasó de «`<repositorio> <carpeta>`» a «`<repositorio>/<carpeta>`»: equivalente, y mejor porque A10 la reconoce |
| Q5 | Sí | Seis tipos, mapeo total, `Suspende hasta:`, `Motivo:`, reapertura por `presentacion` con `Corrige` |
| Q6 | **Cambiada sin declarar** | Momento de S1: «primer push» → «fusión» (M9-REQ-04). Lo demás (carpeta entera, renombres, `Corrige`, sin trailer, S3) como se aprobó |
| Q7 | Sí | Dos clases; huella sólo para lo no versionado; clasificación por contenido; S2 antes del push; corrida descartada se conserva. La oración de D9 sujeta a E-3 (pregunta 2) |
| Q8 | Sí | Funda, no se vuelve; vía única por control de cambios; inversa por `git grep`; ciclo de origen intacto; «cuántos casos lo sostienen» |
| Q9 | Sí | `Audit/` fuente, folia por enlace; `Mesa-Rules.md` §8 criterio 1 (plan fila 5); reporte = pase |
| Q10 | Sí | Forma histórica para 0001 y `EXP-0001`, sin renombrar; incorporación de antecedentes por `ruta@commit`. Plan fila 18 agrega folio 019 y una fila al índice del README del 0001: el dictamen §9 lo prevé («cuando la aplique, este expediente queda como forma histórica») y R7 dice «no se reescribe», no «no se folia». Compatible |
| Q11 | **Incompleta** | Orden de cinco pasos acotado a §9 y §7.0, exclusiones por nombre, l.46 declarada: sí. Falta el cableado en la reanudación (M9-REQ-06) |
| Q12 | Sí | Pase en el último folio; README remite; R0 paso 4 lee expedientes abiertos (plan fila 4) |

### Pregunta 4 — Lo que la regla agrega sin que `ev-07` ni el dictamen lo pidieran

| Agregado | ¿Pedido? | ¿Caso medido o previsión? | Juicio |
|---|---|---|---|
| «Ante la duda, no se abre» (§1) | No | Previsión; cero folios lo mencionan | Va contra «sistemática»; M9-REQ-05 |
| «y ningún artefacto con casa lo aloja» (§1 cond. 2) | No en esa forma | Voto disidente de Q2 (E2), no declarado | M9-REQ-05 |
| La carta del despacho en `evidencia/` antes de despachar (§3.5) | **Sí**: dictamen Q3, forma completa | Medido: folio 017 («cartas tardías»), `ev-08`; y el re-despacho doble del 0001 (§3 de la regla) | Se sostiene; no es agregado |
| «La pregunta exacta» que el testimonio responde (§3.3 punto 3) | No | Previsión razonable, sin caso en los folios (`grep -i 'pregunta exacta'` en 013/014/016 → vacío) | Es un campo más en el caso más frecuente. Dirección: o se cuenta (diecinueve) o se absorbe en `Canal` («respuesta al lote de §7.0 del <fecha>») |
| `evidencia/` con subcarpetas (A9, paréntesis) | No | Medido en el 0001 (`ev-06/`, `ev-08/`), que es forma histórica | Compatible con `find -type f`; pero `NNN-<slug>` «por posición» dentro de subcarpetas no dice si la posición es global o por carpeta. Una oración |
| El pase nombra los despachos abiertos y su carta (§3) | **Sí**: Q3 y Q12, forma completa | Medido: doble despacho del 0001 | Se sostiene |
| Testimonio «de cualquier parte cuya palabra funda algo» (§3.3) | No; el dictamen dice «del Product Owner» | Previsión, pero es el enunciado sobre la propiedad y no sobre el caso (guía Parte IV) | Se sostiene: es el simétrico bien preguntado |
| Plan fila 5, `Mesa-Rules.md` §7.1: la respuesta a una escalada se asienta con la forma de §3.3 | No en el dictamen (lista §0.0, §2.1, §8 c.1) | Deriva de Q2 («la custodia no depende de que se abra») | Se sostiene por §III.8: es el lugar donde la aprobación **se produce**; sin eso, §3.3 rige «donde se asiente» y nadie lo asienta |
| Anti-patrón «El ciclo de origen de un hueco cita el expediente» (§7) | Sí, Q8 / R-10 | E1 (`Root-Rules.md` l.680) | Se sostiene |
| Autosuficiencia: «`Expedientes/` nombra … como texto, sin enlaces» (§2) | Sí, Q1 y E-1 | E2 (l.152) | Se sostiene |

### Pregunta 5 — Los 18 artefactos: necesarios para que la figura funcione, o propagación que puede esperar

Criterio: `SDD-Development-Guide.md` §III.8 («el cableado es la línea del esqueleto de despacho»; un mecanismo transversal que no se declara donde se ejecuta no se ejecuta) y Parte IV («¿Cuántos archivos toca? Si son más de tres o cuatro, conviene segmentar en etapas con nota de coherencia entre cada una»).

| # | Artefacto | Clase | Por qué |
|---|---|---|---|
| 1 | `Expediente-Rules.md` | **Necesario** | La figura |
| 2 | `Master-Prompt.md` §3.5, §8.1, §12.1 T1, §15 | **Necesario** | §III.8 paso 2: es el cableado. §3.5 (layout) y §8.1 (Q11) son donde se ejecuta; §12.1 T1 (S3) es donde el humano fusiona y decide sabiéndolo; §15 el término |
| 3 | `Master-Prompt-Migracion.md` l.46, M4 | **Necesario** | Q11 ejecuta en M4; l.46 sin modificar contradice a §8.1 nuevo |
| 4 | `Master-Prompt-Reanudacion.md` R0 paso 4, §5 | **Necesario e incompleto** | Q12 ejecuta en R0; falta Q11 (M9-REQ-06) |
| 5 | `Mesa-Rules.md` §0.0, §2.1, §8 c.1, §7.1 | **Necesario** (§8 c.1 y §7.1); propagación (§0.0, §2.1 nota) | Sin §8 c.1 el criterio da falso en el framework (R-14, E1); sin §7.1 la aprobación no se asienta donde se produce. §0.0 y la nota de §2.1 son remisiones: pueden esperar sin que nada falle |
| 6 | `Migracion-Rules.md` §2.2 | **Necesario** | M4 recorre `SDD/Docs/`; el silencio sobre `SDD/Expedientes/` es lo que el folio 011 N1-08 midió; una migración sin esa fila puede renumerar |
| 7 | `Root-Rules.md` §9.2 | **Necesario** | §9.5: toda familia viva queda alcanzada o excluida con motivo; el número de expediente es una familia viva desde el primer expediente |
| 8 | Guía §VI.5 | **Necesario**; §VI.3 c.2, §III.8 ejemplo, l.145 | Propagación | El snapshot se toma leyendo §VI.5: sin la exclusión, `_legacy/13.18/` copia `Expedientes/` (la premisa falsa de N1-01). Lo demás de la fila es didáctico y D-7 |
| 9 | `README.md` | **Necesario** (anatomía, autosuficiencia l.152) | Propagación (fila de reglas de intervención, modelo de tres repos) | E-1 = A exige la reformulación declarada de l.152; sin ella `main` publica una propiedad falsa |
| 10 | `_legacy/README.md` | Propagación | Espejo de §VI.5; una fila; puede ir en la misma etapa que 8 sin costo |
| 11 | `SDD-User-Guide.md` F-17 | **Necesario** por §III.8 paso 4 | El Product Owner es quien percibe el mecanismo: él lo pidió. Puede ser la etapa siguiente si se declara |
| 12 | `Catalogo-De-Criterios.md` | Propagación | Índice derivado; su propia regla probablemente lo exige, pero nada se ejecuta desde ahí |
| 13 | `Knowledge-Mesa-De-Expertos-A-Pedido.md` | **Necesario** | D-3; la 13.17 l.159 dice «testimonio … E4» y contradice §3.3; su l.45 ya promete «si el framework adopta una norma, esa norma gobierna y este documento se alinea». No alinearlo publica dos formas, que es el defecto de origen |
| 14 | `Index-Knowledge.md` | Propagación | Una celda de versión |
| 15 | `Deriva-Rules.md` | **Condicionado** al Product Owner (M9-REQ-01) | Bajo C no se toca |
| 16 | Nota de coherencia | **Necesario** | `README.md` l.147: toda intervención sobre varios archivos |
| 17 | `CHANGELOG.md` | **Necesario** | Publicar versión (l.148) |
| 18 | Folio 019 del 0001 | **Necesario** | El pase del folio 018 dice «Sigue: intervención 09»; sin 019 el I2 del 0001 —aunque forma histórica— queda diciendo que sigue algo que ya pasó |

**Lectura.** Doce necesarios (1–4, 5 parcial, 6–9 parcial, 11, 13, 16–18), cinco propagación (5 parcial, 8 parcial, 9 parcial, 10, 12, 14), uno condicionado (15). Son más de «tres o cuatro» por bastante: la guía sugiere etapas. Una partición que respeta «se declara donde se ejecuta»: **etapa 1** (la figura y su cableado: 1, 2, 3, 4, 5 §8/§7.1, 6, 7, 8 §VI.5, 9 l.152 y anatomía, 13, 16, 17, 18); **etapa 2** (lo que el usuario y los índices ven: 5 §0.0/§2.1, 8 resto, 9 resto, 10, 11, 12, 14), con su nota. La 15 va cuando conteste el Product Owner. Sobre el presupuesto de nueve pasos: el orden de Q11 son cinco pasos en una subsección nueva de §8.1, que hoy no tiene procedimiento numerado (l.876-1000 leídas: tablas y prosa); no lo desborda. Los pasos de la forma mínima son cinco (014 §5) y la regla no los enumera como procedimiento: el snippet §8 los lleva en prosa, que es la forma correcta para lo que «se lee decidiendo».

---

## 4. Lo que revisé y está bien

1. **La forma mínima cumple R4 y se verifica enumerando.** Conté sobre el caso: README 5 (`Número`, `Título`, `Apertura`, `Origen`, `Base`), folio 001 4+1+3, folio 002 4+1 = 18; tres archivos; A1–A10 corren desde la raíz con lo que está escrito en §6 (salida completa: A1 `0`, A2–A6 vacío, A7 detecta el borrado posterior, A8–A10 vacío). Ningún campo se lee del árbol ni de git salvo `Base` y `Fecha`, que un aplastamiento de historia vuelve no derivables, y S3 lo declara. R3 se cumple: no hay guion; `a1a10.sh` es del presidente, no de la regla.
2. **La clasificación del testimonio por pasaje (§3.3) es lo que el propio `ev-07` exige.** Un solo mensaje trae una aprobación («tenes el ok de la fase K»), instrucciones de orden («me centraria primero en migrar Lab-Geometria»), un pedido normativo («Vamos a adoptar…») y un mandato a la mesa («mejorala en base a…»). Clasificar por canal los habría tratado igual; por pasaje, cada uno va a donde corresponde. Y el original byte a byte con huella tiene su caso medido en los dos ejemplares (folio 012; folio 002 de `EXP-0001`, con tilde donde el original no la tiene).
3. **El acotamiento de Q11** a ambigüedad y arbitraje, con la confirmación de plan y T4 excluidas por nombre, es la lectura correcta de «en vez de pararte»: el Product Owner no pidió que no le confirmen planes ni que no le entreguen traspasos; pidió que no le trasladen problemas que el árbol contesta. El folio 011 N1-07 lo había enunciado así y el plan lo aplica sin agrandarlo.

---

## 5. Solicitudes de convocatoria

| Especialidad | Señal y ubicación | Qué no puedo afirmar |
|---|---|---|
| **Verificación (N2)** | M9-REQ-07: hace falta un criterio que compruebe la foliatura por enlace de `Audit/`; propongo dirección, no comando final. M9-REQ-04: prosa de S1 contra A7 dentro de §4/§6 | Si el comando que sugiero (cruce de `git grep -l 'Expedientes/<NNNNN>-' -- SDD/Docs/Audit` contra `ruta@commit` en `actuaciones/`) es enumerable sin guion y no reabre el reporte 12 (R3) |
| **Formal (D-5)** | M9-REQ-05: la condición 2 de §1 con «y ningún artefacto con casa lo aloja» deja de ser observable al abrir; «tiene casa» es un juicio | Si la condición sigue siendo decidible al abrir con esa cláusula |
| **Seguridad (D-2)** | Pregunta 2, opción C: la cita D9 `humano` apunta a un folio con testimonio literal del Product Owner en un repositorio público | Si el bloque literal de una aprobación puede contener datos que S2 debería tratar, y qué pasa con la huella cuando se redacta (§4 S2 lo prevé para evidencia; no lo dice para el bloque `testimonio` dentro de un folio) |
| **Trazabilidad documental (D-6)** | M9-REQ-02: la cita cruzada entre dos expedientes de dos repositorios sobre un mismo caso; A10 declara que «la lee una persona» | Si la ruta calificada `<repositorio>/SDD/Expedientes/…` alcanza como identificador estable entre repositorios cuando el caso vive en los dos |
