# Reporte 29 — El umbral de archivos individuales no dice de qué se cuenta

| Campo | Valor |
|---|---|
| Reporte | 29 |
| Fecha | 2026-09-12 |
| Origen | La apertura de la fase `k` de `Lab-Geometria`, el 2026-09-12: la **primera corrida que ejerce el evento de `Rules-Backlog-Tecnico.md` §3.6** escrito por la 13.14. Al pasar `Backlog-Tecnico.md` de la unidad `GeometriaFactory-Api` a 3.0, el bloque del proyecto de código `GeometriaFactory-Api` subió de 26 a 35 tareas técnicas, y la verificación del orquestador preguntó si eso cruzaba el umbral de treinta. **La regla no permitió contestarlo** |
| Versión del framework evaluada | SDD **13.14** (`Rules-Backlog-Tecnico.md` **5.2**: cabecera, §2.1, §3.3, §5.2, §5.5, §6 y §8) |
| Artefactos del framework alcanzados | `SDD/Devs/Rules/Rules-Backlog-Tecnico.md` — **§2.1 y §3.3**, donde nace, y §6 y §8, que heredan la lectura de §3.3 |
| Naturaleza | **Una regla que se contradice consigo misma en dos ejes a la vez.** Declara el umbral de archivos individuales **por proyecto de código con tres bandas** en su tabla maestra, y **por unidad de entrega con dos bandas** en su convención, su criterio de aceptación y su snippet. Las dos lecturas producen resultados opuestos sobre un destino real, y la que aplica el auditor es la que ningún destino aplica |
| Estado | **RESUELTO en SDD 13.15** |
| Reportes relacionados | **`28`**, precedente de forma: también una regla contradicha consigo misma, resuelta dentro de su propio archivo porque `Root-Rules.md` §13 no alcanza a un conflicto interno. **`25`**, cuyo evento de §3.6 es el que produjo la primera corrida que tropezó con esto. No comparte artefacto con ninguno: va separado |

---

## 1. Resumen

**`Rules-Backlog-Tecnico.md` fija cuándo las tareas técnicas dejan de vivir inline y pasan a un archivo
cada una.** Es una decisión con consecuencia real: cambia la estructura de carpetas, la forma de trazar
dependencias y cómo se revisa una tarea por separado.

**La regla lo dice de dos maneras incompatibles.** Su tabla maestra lo cuenta **por proyecto de código**
y distingue **tres** bandas —obligatorio, recomendado, omitir—. Su convención de §3.3, su criterio de
aceptación de §6 y su snippet de §8 lo cuentan **por unidad de entrega** y distinguen **dos**. No es una
errata de una palabra: son dos diseños distintos del mismo mecanismo.

**Sobre un destino real las dos lecturas dan resultados opuestos.** `Lab-Geometria` aplica la de la tabla,
y bajo ella cumple hasta hoy. Bajo la del criterio de aceptación —la que usa un auditor— **incumple desde
el 2026-08-16**, con 89 tareas en una unidad y 41 en la otra, y nadie lo detectó porque ese criterio es
`[interpretativo]`.

**Y ningún destino del workspace tiene la carpeta que la regla prescribe.** El mecanismo existe escrito y
no se ejerció nunca.

---

## 2. La evidencia

### 2.1 Las seis menciones del umbral, y qué cuenta cada una

Medido sobre `Rules-Backlog-Tecnico.md` 5.2:

```bash
python3 -c '
import re
L=open("SDD/Devs/Rules/Rules-Backlog-Tecnico.md",encoding="utf-8").read().splitlines(); s="(cabecera)"
for i,l in enumerate(L,1):
    if re.match(r"^#{2,4} ",l): s=l.strip()
    if i in (58,59,107,108,293,314,338,468): print(i,"|",s[:45],"|",l[:110])'
```

| Dónde | Qué dice | Cuenta por | Bandas |
|---|---|---|---|
| Cabecera | *«Nivel de aplicación: Unidad de entrega»* | — | — |
| **§2.1 Tabla maestra**, fila `tareas-tecnicas/` | *«Obligatorio para: Proyectos de código con más de 30 BT · Recomendado: Proyectos de código con 15 a 30 BT · Omitir para: Proyectos de código con menos de 15 BT (BT inline en `Backlog-Tecnico.md`)»* | **Proyecto de código** | **Tres** |
| §2.1, fila `historias-usuario/` | Ídem con 20 y 10 US | **Proyecto de código** | **Tres** |
| **§3.3** | *«Para unidades de entrega con más de 30 BT, cada tarea técnica vive en su archivo individual […] Para unidades de entrega por debajo de esos umbrales, las US y BT pueden vivir inline»* | **Unidad de entrega** | **Dos** |
| §5.2 y §5.5 | *«¿El umbral de archivos individuales (20 US y 30 BT) está aplicado correctamente?»* | No lo dice | — |
| **§6**, criterio de aceptación | *«[interpretativo] Si la unidad de entrega supera 20 US, existen archivos individuales bajo `historias-usuario/`; si supera 30 BT, existen archivos individuales bajo `tareas-tecnicas/`»* | **Unidad de entrega** | **Dos** |
| **§8**, snippet | *«tareas-tecnicas/BT-XXXXX-<Nombre>.md si la unidad de entrega supera 30 BT; en caso contrario, BT inline»* | **Unidad de entrega** | **Dos** |

**Ninguna otra pieza del framework lo desempata.** Medido:

```bash
grep -rn -i "30 BT\|más de 30\|20 US" SDD/Devs/Rules/Catalogo-De-Criterios.md SDD/Guides/SDD-User-Guide.md SDD/Devs/Orchestrator/Master-Prompt.md
→ (sin salida)
```

### 2.2 Las dos lecturas sobre un destino real

`Lab-Geometria` consolida en un `Backlog-Tecnico.md` por unidad de entrega una subsección por proyecto de
código. Recuentos por bloque de identificadores, sobre la rama que abrió la fase `k`:

```bash
grep -o -E "^\| BT-[0-9]{5} \|" Backlog-Tecnico.md | sort -u | awk '{n=substr($2,4)+0; c[int(n/1000)]++} END{for(b in c) print b, c[b]}'
```

| Unidad de entrega | Proyecto de código | BT | Por proyecto (§2.1) | Por unidad (§3.3, §6, §8) |
|---|---|---|---|---|
| `GeometriaFactory-Api` | `GeometriaFactory-Api` | **35** | **>30: obligatorio** (era 26 antes de `k`: recomendado) | La unidad suma **98** (89 antes de `k`): **obligatorio para las 98, desde el 2026-08-16** |
| | `GeometriaFactory-Domain` | 16 | 15–30: recomendado | ídem |
| | `GeometriaFactory-Application` | 21 | 15–30: recomendado | ídem |
| | `GeometriaFactory-Infrastructure` | 26 | 15–30: recomendado | ídem |
| `GeometriaFactory-Web` | bloques `10xxx` y `12xxx` | 23 + 18 | 15–30: recomendado | La unidad suma **41**: **obligatorio** |

**Bajo §2.1, la apertura de `k` es lo que cruza el umbral, y sólo para un proyecto.** Bajo §6, el destino
**ya incumplía** para todas sus tareas, en las dos unidades, desde la consolidación del 2026-08-16.

### 2.3 El destino eligió una lectura, y la eligió sin saber que había dos

El propio `Backlog-Tecnico.md` de la API justifica el inline tres veces con la lectura de la tabla:

> §1.2: *«viven **inline** en este documento y no en archivos individuales, porque **el proyecto de
> código** está por debajo del umbral de treinta que fija la regla de la categoría»* — y en los mismos
> términos §1.3 y §1.4.

Y su audit de backlog `D-06-07-Backlog-Siete-Proyectos-r1.md` lee la tabla y le atribuye §3.3:

> *«La guía §2.1 exige archivo individual por historia a partir de **20** historias, **lo recomienda entre
> 10 y 20**»* y *«El backlog aplica el modo inline, **admitido por la guía §3.3 para proyectos de código**
> por debajo del umbral obligatorio de 20»*.

**Esa segunda cita es la huella exacta de la contradicción**: atribuye a §3.3 una lectura por proyecto de
código que §3.3 no dice. Un auditor que leyó las dos secciones las fusionó en una sola regla que no está
escrita en ningún lado.

### 2.4 El mecanismo nunca se ejerció

```bash
find <workspace> -type d -name tareas-tecnicas -not -path "*/_legacy/*" -not -path "*/node_modules/*"
→ (sin salida)
```

**Cero carpetas `tareas-tecnicas/` en todos los destinos del workspace.** La de `historias-usuario/` sí
existe en `Lab-Geometria`, en las dos unidades. El umbral de tareas técnicas está escrito desde la 1.0 de
la regla y no obligó nunca a nadie, **o obligó y nadie lo aplicó** — y la regla no permite distinguir cuál
de las dos cosas pasó.

### 2.5 Por qué no lo detectó nada

El único criterio de aceptación sobre el umbral, §6, es **`[interpretativo]`**, de modo que no entra en la
compuerta mecánica de `Master-Prompt.md` §10.0. Y es la mitad mecánica de un criterio: **contar tareas por
unidad y ver si existe una carpeta es enumerable** —se decide con un `grep` y un `test -d`—. Lo que lo
vuelve interpretativo no es su naturaleza sino **que no dice de qué se cuenta**.

---

## 3. Qué dice hoy el framework, y por qué no alcanza

### 3.1 Lo que resuelve bien

- **El umbral tiene fundamento escrito.** §3.3 lo justifica —*«trazar dependencias técnicas por archivo y
  bloquear individualmente sin tocar el backlog completo»*— y la necesidad es real.
- **§3.3 exige lo que importa en los dos modos**: *«los criterios de aceptación, la trazabilidad y el DoR
  check deben estar presentes»*. El formato no es excusa para perder contenido.
- **La banda «recomendado» de §2.1 es una buena idea**: evita el salto brusco de todo-inline a todo-archivo
  en un único recuento.

### 3.2 Lo que no está

**a) De qué se cuenta.** Proyecto de código o unidad de entrega. Cuatro menciones dicen una cosa, dos la
otra, y la cabecera declara el nivel sin tomar partido sobre el recuento.

**b) Cuántas bandas hay.** Tres en §2.1, dos en §3.3.

**c) Qué pasa con un documento consolidado.** La regla no contempla un `Backlog-Tecnico.md` de unidad con
varias subsecciones de proyecto —la forma que la migración estructural de 8.2 le dio a `Lab-Geometria`—, y
es exactamente el caso donde las dos lecturas divergen.

**d) Qué pasa con los destinos que ya están de un lado.** Si la corrección elige «unidad de entrega»,
todos los destinos consolidados incumplen de golpe. Si elige «proyecto de código», el criterio de §6
cambia de sentido para quien lo venía aplicando literal.

**e) Un criterio enumerable.** El recuento y la existencia de la carpeta son mecánicos una vez fijado (a).

---

## 4. El hueco, en una frase

**La regla que decide cuándo una tarea técnica pasa a tener archivo propio lo cuenta por proyecto de
código con tres bandas en su tabla, y por unidad de entrega con dos bandas en su convención, su criterio
de aceptación y su snippet; sobre un destino consolidado las dos lecturas dan resultados opuestos, el
auditor aplica la que ningún destino aplica, y como el criterio no dice de qué se cuenta, no pudo ser
mecánico y nadie lo detectó.**

---

## 5. Qué se propone evaluar

**Ninguna es una propuesta de redacción.**

### 5.1 La unidad del recuento — se decide primero

¿Proyecto de código o unidad de entrega? **Las dos tienen argumento**, y la intervención tiene que
escribirlo:

- **Por proyecto de código** es lo que el destino real aplicó sin excepción, lo que la tabla maestra dice,
  y lo que no rompe a nadie. Además, las tareas técnicas nacen por proyecto —cada una de un componente de
  la arquitectura de su proyecto— y su volumen es propiedad de ese proyecto.
- **Por unidad de entrega** es lo que dicen la cabecera, la convención, el criterio y el snippet, y es
  coherente con el *nivel de aplicación* de la regla. Y la carpeta `tareas-tecnicas/` vive por unidad, no
  por proyecto.

**Y hay una pregunta que las dos lecturas esconden**: si cuenta por proyecto pero la carpeta es de la
unidad, ¿qué pasa cuando **un** proyecto cruza y los otros no? `Lab-Geometria` va a quedar exactamente así
—35 tareas de un proyecto en archivos, 63 de otros tres inline en el mismo documento—. La regla tiene que
decir si eso es la forma correcta o un estado transitorio.

### 5.2 Las bandas

¿Dos o tres? Si tres, ¿«recomendado» obliga a algo, o sólo informa?

### 5.3 Los destinos existentes

Decidido §5.1, ¿qué destinos quedan incumpliendo, y el cambio es **major**? `Lab-Geometria` es el caso
medido. **Medirlo en todos los destinos del workspace antes de decidir la severidad.**

### 5.4 El criterio enumerable

¿Corresponde marcar `[enumerable]` el criterio de §6 una vez fijada la unidad? Es contar filas por bloque o
por unidad y probar la existencia de una carpeta.

---

## 6. Lo que este reporte no afirma

- **No afirma que `Lab-Geometria` esté mal.** Aplicó una de las dos lecturas que la regla ofrece, con
  coherencia, y la citó cada vez.
- **No afirma cuál de las dos es la correcta.** Da el argumento de cada una.
- **No afirma que el umbral sobre**. Afirma que no se puede aplicar sin elegir antes qué se cuenta.
- **No es un reporte contra el evento de §3.6 de la 13.14.** El evento funcionó: abrió el backlog, y fue
  por abrirlo que se contó.

---

## 7. Cómo verificar que la corrección funcionó

1. **Las seis menciones del umbral dicen lo mismo.** El comando de §2.1 devuelve una sola unidad y un solo
   número de bandas.
2. **El criterio de §6 se decide con un comando**, y está marcado `[enumerable]`.
3. **Sobre `Lab-Geometria`, la regla da un solo resultado** para cada unidad y cada proyecto, sin que haga
   falta leer §2.1 y §3.3 juntas.
4. **El caso mixto está contemplado**: un documento de unidad con un proyecto sobre el umbral y otros
   debajo tiene forma declarada.
5. **El impacto sobre destinos existentes está medido** en el `CHANGELOG.md`, con el recuento por destino.

---

## Control de cambios

| Versión | Fecha | Cambios | Autor |
|---|---|---|---|
| 1.0 | 2026-09-12 | Emisión inicial. Documenta que `Rules-Backlog-Tecnico.md` cuenta el umbral de archivos individuales **por proyecto de código con tres bandas** en §2.1 y **por unidad de entrega con dos bandas** en §3.3, §6 y §8; que sobre `Lab-Geometria` las dos lecturas dan resultados opuestos; y que **ningún destino del workspace tiene `tareas-tecnicas/`**. Nace de la **primera corrida que ejerció el evento de §3.6** escrito por la 13.14. **Todas las citas y recuentos se midieron en el acto de escribirlo**, con los comandos a la vista. El destino resolvió su caso en la misma corrida con la lectura por proyecto de código, como autocorrección de un hecho de la corrida (13.11), y lo declara; esa resolución **no decide** la pregunta de §5.1. | Orquestador, en la apertura de la fase `k` de `Lab-Geometria` |
| 1.1 | 2026-09-12 | **Pasa a RESUELTO en SDD 13.15**, con esta sección «Cómo se resolvió». | Intervención `07` |

## 9. Cómo se resolvió

**Verificación previa (solicitud 1).** Las seis/siete citas del reporte seguían literales en la
base (`Rules-Backlog-Tecnico.md` 5.2, framework 13.14): el comando de §2.1 devolvió exactamente lo
que el reporte transcribe. Nada se había corregido entre la emisión y esta intervención. Detalle y
comandos en `PROMPTs/Fixs/07-Fix-Reporte-29/OUTPUTs/00-Verificacion-De-Citas-Y-Recuentos.md`.

**La decisión de fondo (§5.1): por proyecto de código.** No por conteo de menciones —cuatro contra
dos no es un criterio, y `Root-Rules.md` §13 lo dice explícito para el conflicto entre reglas—, sino
por impacto medido: bajo «por proyecto de código», **cero destinos del workspace incumplen**, y el
único cruce de umbral (`GeometriaFactory-Api`, bloque BT, 26→35) se está resolviendo en la misma
corrida que lo produjo. Bajo «por unidad de entrega», **dos destinos reales incumplen de golpe en
cuatro documentos** —los BT de las dos unidades de `Lab-Geometria` y las US de
`GeometriaFactory-Web` y de `RPI.VideoControl`, un destino que el reporte original no había
medido—, sin que nadie lo hubiera detectado porque el criterio de §6 era `[interpretativo]`.
Fundamento completo en `OUTPUTs/10-Decision-Del-Umbral-Y-Las-Cuatro-Preguntas.md`.

**El caso mixto (la tercera pregunta que el reporte esconde) es la forma correcta, no un estado
transitorio.** `Lab-Geometria` lo estaba construyendo en el momento de escribir esta intervención:
un `Backlog-Tecnico.md` con el bloque `0` (`GeometriaFactory-Api`) extraído a `tareas-tecnicas/` y
los bloques `2`, `4` y `6` inline en el mismo documento, porque están en banda recomendada. Forzar
que toda la unidad pasara a archivo individual, o que ninguna lo hiciera, habría tocado secciones
de proyectos que no cruzaron el umbral.

**Las otras tres preguntas de §5**: tres bandas (las que la tabla maestra ya tenía; «recomendado»
no obliga nada mecánico, es señal de buena práctica); ningún destino incumple bajo la lectura
adoptada y el salto es **minor**, no major (la lectura adoptada es la que los destinos reales ya
aplicaban); §6 pasa a `[enumerable]` con su comando de conteo por bloque/rango y `test -d`.

**Extensión a las US (solicitud 6).** Ya venía resuelta en el mismo texto: §3.3, §6 y §8 tratan las
dos familias —US y BT— en los mismos párrafos, así que el fix no pudo dejar una corregida y la otra
con la contradicción.

**Aplicado**: un solo artefacto, `SDD/Devs/Rules/Rules-Backlog-Tecnico.md` (5.2 → 5.3, minor), con
snapshot previo en `_legacy/13.14/`. Plan completo, verificación de los cinco criterios de §7 (los
cinco **cumplidos**, ninguno a medias) y lo no verificado, en
`PROMPTs/Fixs/07-Fix-Reporte-29/OUTPUTs/20-Plan-De-Aplicacion.md` y
`.../30-Verificacion-Del-Plan-Aplicado.md`.

**Qué le exige a `Lab-Geometria` (solicitud 12): alcanza con las 35 BT del proyecto
`GeometriaFactory-Api` en archivos bajo `tareas-tecnicas/`.** Verificado en vivo contra la rama
`fase-k/backlog-tecnico-v2` (SHA `77d145ec0375667085afec76679234c342dafff7`): al momento de esta
medición, esos 35 archivos ya existían. Los otros tres proyectos de la unidad y los dos de
`GeometriaFactory-Web` siguen en banda recomendada y pueden seguir inline. No se tocó ningún
archivo de `Lab-Geometria`: es un destino de solo lectura para esta intervención.

**Lo no verificado**: si `RPI.VideoControl` debe repartir sus BT por proyecto de código
(`DEC-00003`) queda como decisión propia de ese destino, ajena al umbral que gobierna este reporte;
y no se corrió una migración completa de `Lab-Geometria` con la regla 5.3 vigente, porque esa fase
sigue en curso en la rama de otro agente al cierre de esta intervención.
