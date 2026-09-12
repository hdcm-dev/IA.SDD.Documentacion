# Expediente 06 — Plan compuesto, contradicciones y cierre

> **Este documento lo escribe el orquestador**, no una comisión. Todo lo que agrega a los expedientes
> `01` a `05` está marcado como propio, y toda medición que afirma lleva su comando.
> **Estado: cerrado con plan corregido.** La refutación (`05`) entró y cambió tres cosas.

---

## 1. Qué produjo la mesa

| # | Parte del plan | Origen | Estado |
|---|---|---|---|
| **P-1** | El caso se emite como **reporte `28`** de la serie, no como arista de `24`, `26` o `27` | Requisitos §4 | **Aprobado** — resistió el ataque 4 |
| **P-2** | **Primer criterio `[enumerable]`** de `Vocabulario-Rules.md` §10: toda afirmación de colisión cita el barrido que la sostiene | Verificación §5 | **Se corrige** — §7 |
| **P-3** | El remedio del caso: **no renombrar**. Familia calificada `procedencia` / `procedencia del hueco` | Terminología §2.5 | **Se rehace el costeo** — §7 · **P0** |
| **P-4** | **No se crea** un registro de términos acuñados | Terminología §3 | **Aprobado** |
| **P-5** | **Hallazgo aparte contra `Vocabulario-Rules.md`** por su contradicción interna §1/cabecera vs §8 vs §9.6 | Refutador §1 | **Nuevo** — E2, P1 |
| **ESC-1** | La jurisdicción de `Vocabulario-Rules.md` §9 sobre este término | Lector sin contexto §5 | **RESUELTA por la mesa, no escalada** — §4 |

---

## 2. Las mediciones que se sostienen, verificadas por el orquestador

Las reproduje por mi cuenta antes de usarlas. Cada una con su comando.

**2.1 · `Vocabulario-Rules.md` es la única regla del framework sin comprobaciones mecánicas.**

```bash
for f in SDD/Devs/Rules/*.md; do
  e=$(grep -Ec '^\s*- \[ \] `?\[enumerable\]`?' "$f")
  i=$(grep -Ec '^\s*- \[ \] `?\[interpretativo\]`?' "$f")
  [ $((e+i)) -gt 0 ] && printf "%-34s enum=%-3s interp=%s\n" "$(basename $f)" "$e" "$i"
done
```

19 reglas usan el esquema. **Dieciocho aportan entre 1 y 21 enumerables. `Vocabulario-Rules.md` aporta
0 sobre 13.** No es que lo léxico sea inmecanizable por naturaleza: es que a esta regla no se le pidió.

**2.2 · La checklist que el despacho citó como §4.7 es §6.**

```
### 4.5 Destinos sin procedencia declarada   → 3 ocurrencias
### 4.6 Migración parcial como estado final  → 2
## 6. Criterios de aceptación                → 3
## 7. Anti-patrones a evitar                 → 2
### 4.7 La revisión de apartamientos         → 0
```

**§4.7 tiene cero.** El dato que el orquestador le pasó a la mesa —«§4.7, ocho usos desnudos en la misma
checklist»— era falso en la sección y en el número. Dos comisiones lo levantaron por separado.

**2.3 · `Root-Rules.md` no tiene una sola ocurrencia de `procedencia`.** Es donde viviría el campo del
reporte `27`. **Verificado: cero.**

---

## 3. El hecho incómodo, y por qué queda escrito

**El despacho de esta mesa llevaba cuatro datos y tres estaban mal.** Los tres los corrigieron las
comisiones, dos de ellas por separado y sin verse.

Eso no es un detalle de proceso: **es la evidencia central del caso**. La mesa se convocó porque un
agente afirmó sin verificar, y el despacho que la convocó volvió a hacerlo, tres veces, en el mismo acto
de denunciarlo. `Vocabulario-Rules.md` §9.4 lo nombra con precisión —*«el patrón queda primado […] se
aplica al siguiente término sin volver a verificar la premisa»*— y acá el patrón se primó **sobre el
propio análisis del patrón**.

**Un reporte que omitiera esto sería más prolijo y valdría menos.** El precedente de forma es el reporte
`24`, que incluyó entre su evidencia un error del propio orquestador cometido mientras escribía el
informe de los otros casos.

---

## 4. ESC-1 · La jurisdicción — resuelta por la mesa, no escalada

### 4.1 La contradicción

`Vocabulario-Rules.md` se contradice **consigo mismo** sobre su propio alcance:

| Dónde | Qué dice | Lectura |
|---|---|---|
| **Cabecera**, `Archivo target`, y **§1** | *«todo artefacto del framework y toda documentación que el framework genera»* | **Amplia** |
| **§8**, «Alcance de esta regla, declarado» | *«gobierna los términos del framework que colisionan con el vocabulario del dominio de un cliente: los seis de §2 […] **No gobierna el resto del vocabulario propio del framework**»* | **Acotada** |

`procedencia` no es ninguno de los seis. Y verificado: **tampoco está en el glosario operativo de
`Master-Prompt.md` §15**, al que §8 lo remite — y ese glosario **no tiene criterio de colisión**.

### 4.2 Por qué se iba a escalar, y por qué al final no

`Root-Rules.md` §13 es el mecanismo del framework para conflictos entre reglas, y su criterio es uno
solo: *«una regla que viaja en la lista de insumos obligatorios de todo despacho desplaza a una que no
viaja»*. **No alcanza acá**: no hay dos reglas, hay **una regla contra sí misma**, y la cabecera y §8
viajan siempre juntas. §13 declara que en ese caso el conflicto **se detiene**, lo que la ponía en el
disparador 1 de `Mesa-Rules.md` §7 y la mandaba al Product Owner.

**El refutador la cerró sin escalarla, con un tercer texto que nadie había traído.** `Vocabulario-Rules.md`
**§9.6 ya aplica §9 a «migración»**, que **tampoco** es uno de los seis de §2 ni un caso de colisión con
vocabulario de cliente: es colisión framework-contra-framework, exactamente la clase de caso que
`procedencia` es. **Si §9 gobernara sólo los seis términos, §9.6 no podría existir donde está.**

**Resolución**: manda la lectura amplia. **§8 quedó desactualizado** y es un defecto de la regla, no una
ambigüedad legítima. Ancla **E2** —dos citas literales que se contradicen—, severidad **P1**, y sale como
`P-5`: un hallazgo propio contra `Vocabulario-Rules.md`, independiente del caso `procedencia`.

**Por qué esto importa más allá del caso.** La escalada estaba escrita, con sus tres opciones y su campo
`SI NO RESPONDÉS`, lista para irse al Product Owner. **Un texto más la disolvió.** Es la medida exacta de
lo que el reporte `26` sostiene: una consulta que llega al humano no prueba que la respuesta no estuviera
en el árbol — prueba que nadie terminó de buscarla.

## 5. El mecanismo para llegar a una conclusión cerrada

**El Product Owner pidió que, si algo no se puede verificar, se proponga un mecanismo.** Éste es, y no
es nuevo: son tres piezas del framework encadenadas, y la mesa las recorrió en orden.

| Paso | Pieza | Qué decide | Resultado acá |
|---|---|---|---|
| 1 | `Master-Prompt.md` §8.1, la pregunta previa | ¿Tiene respuesta en el árbol, sostenible con cita literal? | **No.** Las dos lecturas tienen cita literal, y se contradicen |
| 2 | `Root-Rules.md` §13, precedencia | ¿Cuál de las dos reglas viaja en todo despacho? | **No aplica.** Es una regla contra sí misma |
| 3 | `Mesa-Rules.md` §7, disparador 1 | ¿Es ambigüedad de intención irresoluble por evidencia? | **No, y ése es el punto.** El refutador encontró el tercer texto (§9.6) que desempata. **No se escala** |
| 4 | El refutador, `Mesa-Rules.md` §5.1 | ¿Alguien atacó la premisa antes de elevarla? | **Sí.** Disolvió la escalada con una cita |

**Lo que hace que esto sea una conclusión cerrada no es el paso 3 sino el 4.** La escalada estaba
redactada y a punto de salir; el refutador la disolvió con una cita que ninguna de las cuatro comisiones
había traído. **El paso que cierra es el que ataca la premisa de la escalada antes de mandarla**, y el
campo `SI NO RESPONDÉS` es la red de abajo para cuando ni siquiera eso alcanza.

**Y hay una comprobación que queda pendiente y se declara en vez de darse por hecha**: el criterio de
`P-2` sólo se puede escribir **después** de ESC-1, porque no se sabe en qué archivo va. Escribirlo antes
sería decidir la jurisdicción por la puerta de atrás.

---

## 6. Lo que esta mesa NO resolvió

- **El costeo real de `P-3`**, que es el `P0` abierto de §7. La dirección está bien; el número hay que
  rehacerlo antes de aprobar.
- **Dónde vive el criterio de `P-2`**, que depende de si se quiere que gobierne también la escritura de
  reportes. Si se quiere, va también en `Mesa-Rules.md`.
- **La mecanización del resto de los 13 criterios** de §10. Requisitos lo declaró **fuera de alcance**
  de este caso, a propósito: es un proyecto propio y no debe volverse prerrequisito de éste.

---

## 7. Lo que la refutación cambió

### 7.1 · P0 — `P-3` declaraba costo cero y el costo no es cero

**`Migracion-Rules.md` declara que su contexto de lectura es el archivo entero**, y lo declara en su
propia línea 7 para justificar por qué ahí «migración» va desnuda: *«en este contexto de lectura no hay
otro referente con el que colisione»*. Y `Master-Prompt-Migracion.md` lo confirma del otro lado: *«`Migracion-Rules.md`, **íntegra**. Es la regla que gobierna esta corrida»*.

**Entonces el granulado por sección de §9.6 no se puede copiar acá.** Meter un segundo referente en
cualquier punto de ese archivo rompe la premisa con la que el archivo se justifica a sí mismo, y obliga a
calificar sus 16 ocurrencias — más las 19 de `Master-Prompt-Migracion.md`, que la misma corrida lee
junto con ella. **Unas 35 ocurrencias en dos archivos, no cero.**

**La dirección del remedio no cambia** —la familia calificada sigue siendo la forma correcta y más barata
de §9.3—. Lo que cambia es que **hay que costearla de nuevo** y decidir con el número verdadero a la
vista, que es exactamente lo que `P-3` no hizo.

**Y el refutador nombra por qué duele**: es *«el mismo defecto que convocó la mesa — una afirmación de
bajo costo, presentada como verificada, que no se contrastó contra el mecanismo de lectura que la propia
regla declara»*.

### 7.2 · `P-2` es cosmético para el caso que lo originó

`Vocabulario-Rules.md` §10 lo verifica **el auditor de cada fase**, y escribir un reporte de hallazgos
contra el framework **no es una fase**: no tiene auditor. El criterio, escrito donde está, **no alcanza al
acto que lo motivó**. Si se quiere que lo alcance, hay que declararlo también en `Mesa-Rules.md`, que sí
gobierna esa producción. Además le falta una cláusula: **exigir el comando reproducible**, no una prosa
que diga «revisé tal sección».

### 7.3 · Dos citas más mal, y las dos adentro de los reportes

| Dónde | Decía | Es |
|---|---|---|
| Reporte `26` §2.1 | `Migracion-Rules.md` **§4.7** | §4.5, §4.6 y la checklist de §6. §4.7 tiene **cero** ocurrencias |
| Reporte `27` §2.1 | `Intake-Rules.md` **§1.1** | **§2.1**, línea 39. §1.1 no existe en ese archivo |

**Las dos son del orquestador**, las dos se corrigieron en el mismo acto de recibir la refutación, y las
dos quedaron declaradas en el control de cambios de su reporte. **Con éstas, el recuento de esta mesa es
de cinco citas o números mal, todos del orquestador, todos detectados por relectura ajena.** Ese número
es el dato más duro que el reporte `28` tiene para ofrecer.

### 7.4 · Los ataques que no prosperaron

- **`P-1` resiste**: el `28` no es arista del `24`. Comparte corrida con `26`/`27` y **no artefacto** con
  ninguno de los tres, que es el criterio con el AND.
- **`P-4` resiste**: rechazar el registro de términos no le devuelve el problema al Product Owner, porque
  su requisito lo atiende el reporte `26` por otra vía —la procedencia derivada del snapshot—, y ese
  reporte el plan no lo toca.
- **`P-2` se salva en su naturaleza**, aunque no en su ubicación: no promete impedir un `grep` mentiroso,
  promete convertir una afirmación silenciosa en una **reproducible**, que es el estándar D9 que el
  framework ya usa.

---

## Control de cambios

| Versión | Fecha | Cambios | Autor |
|---|---|---|---|
| 2.0 | 2026-09-12 | **Entra la refutación.** Trae un **P0** —`P-3` declaraba costo retroactivo cero y el costo ronda las 35 ocurrencias, porque `Migracion-Rules.md` declara el archivo entero como su contexto de lectura—, degrada `P-2` a cosmético para el caso que lo originó, y agrega `P-5`. **Y cierra `ESC-1` sin escalarla**: §9.6 ya aplica §9 a un término que no es de los seis, así que §8 está desactualizado y la contradicción es un hallazgo E2/P1, no una ambigüedad legítima. La escalada estaba escrita y lista para salir al Product Owner; **un texto que nadie había traído la disolvió**. | Orquestador, sobre el expediente `05` |
| 1.0 | 2026-09-12 | Apertura del expediente. Vuelca los cuatro informes verbatim, consolida el plan compuesto `P-1` a `P-4`, y declara `ESC-1` con su cadena de decisión de tres pasos y su default. Deja constancia de que **el despacho de esta mesa llevaba tres datos mal** y de que las comisiones los corrigieron, porque eso es evidencia del caso y no ruido de proceso. La refutación quedaba en curso. | Orquestador |
