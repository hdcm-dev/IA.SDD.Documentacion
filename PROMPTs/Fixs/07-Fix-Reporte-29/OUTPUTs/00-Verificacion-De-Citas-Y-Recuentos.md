# 00 — Verificación de citas y reproducción de recuentos (solicitudes 1 y 2)

Comandos y salidas completos en `evidencia/ev-01-citas.{sh,out}`, `evidencia/ev-02-lab-geometria.{sh,out}`
y `evidencia/ev-03-otros-destinos.{sh,out}`. Acá se resume lo que cada uno prueba.

## 1. Las citas del reporte siguen literales en la base

Base: `IA.SDD` en `main` (SHA `9167e68f3a3f75992a0fff338ffcb00cd5936bc4` — coincide con
`Lab-Geometria` en el mismo commit por casualidad de hash corto, son repositorios distintos, se
publica igual el SHA de cada uno más abajo), `Rules-Backlog-Tecnico.md` 5.2, framework SDD 13.14.

El comando de §2.1 del reporte (`evidencia/ev-01-citas.sh`), corrido contra `git show main:...`,
devuelve exactamente las mismas ocho líneas y los mismos textos que el reporte transcribe:
cabecera silente, §2.1 con «proyecto de código» y tres bandas en las dos filas, §3.3 con «unidad
de entrega» y dos bandas, §5.2 y §5.5 sin nombrar la unidad, §6 con «unidad de entrega»
`[interpretativo]`, §8 con «unidad de entrega». El `grep` de desempate contra
`Catalogo-De-Criterios.md`, `SDD-User-Guide.md` y `Master-Prompt.md` sigue sin salida.

**Nada de esto se resolvió entre la emisión del reporte y esta intervención.** Las seis/siete
menciones seguían contradictorias al empezar; no hubo trabajo previo que reproducir de más.

**Declarado, porque el comando de números fijos ya no sirve después de esta intervención**: los
números de línea 58, 59, 107, 108, 293, 314, 338 y 468 son los de `Rules-Backlog-Tecnico.md` 5.2 y
dejan de apuntar a las mismas frases en la 5.3, porque §3.3 creció (agrega el párrafo del
documento consolidado) y el resto se corrió en consecuencia. La reproducción contra la versión
nueva se hace por texto (`grep -n "más de 20 US\|más de 30 BT\|..."`, en el archivo final), no por
número de línea; ver `OUTPUTs/30`.

## 2. Recuentos reproducidos sobre `Lab-Geometria` (solo lectura, objetos commiteados)

**SHA leídos**: `main` = `9167e68f3a3f75992a0fff338ffcb00cd5936bc4`; `fase-k/backlog-tecnico-v2` =
`77d145ec0375667085afec76679234c342dafff7` en el momento de la medición (`git -C
.../Lab-Geometria rev-parse fase-k/backlog-tecnico-v2`). La rama sigue moviéndose mientras el otro
agente trabaja: este SHA es el que se leyó, no una promesa de que siga siendo el último.

| Unidad | Proyecto de código | BT (main) | BT (fase-k) | US (Product-Backlog) | US con archivo |
|---|---|---|---|---|---|
| GeometriaFactory-Api | GeometriaFactory-Api (bloque `0`) | 26 | **35** | 30 | 30 |
| | GeometriaFactory-Domain (bloque `2`) | 16 | 16 | 27 | 27 |
| | GeometriaFactory-Application (bloque `4`) | 21 | 21 | 32 | 32 |
| | GeometriaFactory-Infrastructure (bloque `6`) | 26 | 26 | 25 | 25 |
| GeometriaFactory-Web | bloque `10` | 23 | — | 30 | 30 |
| | bloque `12` | 18 | — | 17 | 0 |

Coincide exactamente con los números que el reporte cita en su §2.2 (26→35 para el bloque `0`, 16,
21, 26 para el resto de la API; 23+18=41 para Web). La ampliación pedida por la solicitud 2 —los
mismos recuentos para US— no estaba en el reporte y se agrega acá: confirma que **ya había la misma
tensión para las US antes de que el reporte se escribiera**, solo que nunca cruzó ningún umbral por
unidad de entrega en falso porque cada proyecto de código de la API ya superaba los 20 por sí solo
y ya tenía archivo individual (114 de 114); el único hueco real bajo lectura por unidad está en el
bloque `12` de Web (17 US inline, por debajo de su propio umbral de proyecto, pero la unidad Web
suma 47 > 20).

**Carpetas.** `historias-usuario/` existe en las dos unidades desde antes de esta intervención.
`tareas-tecnicas/` **no existía en ningún lado del workspace** al abrir esta intervención y
**aparece por primera vez durante esta misma sesión**, en `fase-k`, con exactamente 35 archivos —
uno por cada `BT-000XX` del bloque `0`—, obra del agente que mueve el backlog técnico de la API
mientras se escribe este documento. Es la corroboración en vivo de la solicitud 12: el fix que la
API estaba aplicando coincide, dato por dato, con lo que la lectura por proyecto de código exige.

## 3. Todos los destinos del workspace con `SDD/Docs/`, y `tareas-tecnicas/`/`historias-usuario/`

Comando de §2.4 del reporte, reproducido y ampliado a `historias-usuario/` (`evidencia/ev-03-otros-destinos.sh`):

- **Cuatro destinos** con `SDD/Docs/`: `RPI.VideoControl`, `Lab-Geometria`, `SAI.Service.Core`,
  `SelfHosted.Service.Core`.
- `tareas-tecnicas/` **solo existe en `Lab-Geometria`, en `fase-k`** (0 en el resto del workspace,
  como medía el reporte, y 0 en `main` de `Lab-Geometria` también).
- `historias-usuario/` existe en `Lab-Geometria` (dos unidades), `RPI.VideoControl` y
  `SAI.Service.Core`. `SelfHosted.Service.Core` todavía no generó la categoría 06.
- Se encontró además una carpeta `historias-usuario/` bajo
  `IA/TEMP/Ejemplos_IA_SDD2.1D_Sistema_Georreferencia/SDD2.1D/docs/proyectos/geovial-api/`. **Queda
  fuera de esta medición y se declara por qué**: la ruta no es `SDD/Docs/` sino `SDD2.1D/docs/`, la
  cabecera de sus artefactos declara `**Proyecto:**` en vez de `**Unidad de entrega:**` —es
  anterior a la 8.0, que introdujo la unidad de entrega— y vive en `IA/TEMP/`, la carpeta de
  ejemplos y plantillas históricas del framework, no de destinos reales.

### Recuento por destino, con la lectura vigente hoy y con la corregida

| Destino | Unidad(es) | BT por unidad | BT por proyecto | US por unidad | US por proyecto | Archivos ya existentes |
|---|---|---|---|---|---|---|
| `RPI.VideoControl` | 1 (5 proyectos) | 20 (15–30, recomendado bajo cualquier lectura) | 20 repartidos en un solo rango sin atribución por proyecto (`DEC-00003`, pendiente del propio destino) | **55** (>20, obligatorio bajo unidad) | Web 25 (obligatorio), Domain 5 y PinMap 5 (omitir), Application 9 (omitir), Infrastructure 11 (recomendado) | 25 US (las de `Web`) |
| `Lab-Geometria` — `GeometriaFactory-Api` | 1 (4 proyectos) | **98** post-`k` (>30, obligatorio bajo unidad) | 35 obligatorio, 16/21/26 recomendado | 114 (>20, obligatorio bajo unidad) | los cuatro proyectos ya superan 20 cada uno | 114 US, 35 BT (post-`k`) |
| `Lab-Geometria` — `GeometriaFactory-Web` | 1 (2 proyectos) | 41 (>30, obligatorio bajo unidad) | 23 y 18, ambos recomendado | **47** (>20, obligatorio bajo unidad) | 30 obligatorio (bloque `10`), 17 recomendado (bloque `12`) | 30 US, 0 BT |
| `SAI.Service.Core` | 1 (= 1 proyecto, sin split) | 30 (recomendado bajo cualquier lectura, exactamente en el límite) | ídem | 26 (obligatorio bajo cualquier lectura) | ídem | 26 US |
| `SelfHosted.Service.Core` | — | no aplica: la categoría 06 no está generada | — | no aplica | — | — |

**Lectura por proyecto de código: cero destinos incumplen.** El único cruce de umbral
(`GeometriaFactory-Api`, bloque `0`, BT) se está resolviendo en la misma corrida que lo detectó,
que es exactamente el comportamiento que la regla busca.

**Lectura por unidad de entrega: cuatro incumplimientos, en dos destinos, sin que nadie los
hubiera detectado antes de este reporte** (`[interpretativo]`, nadie lo corrió como compuerta):
`GeometriaFactory-Api` y `GeometriaFactory-Web` por BT (98 y 41, cero archivos), `GeometriaFactory-Web`
por US (47, solo 30 archivados) y `RPI.VideoControl` por US (55, solo 25 archivados). Esto alimenta
la decisión de la solicitud 4 y el veredicto de la solicitud 5.3 en `OUTPUTs/10`.
