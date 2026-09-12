# 30 — Verificación del plan aplicado (solicitudes 9, 10 y 12)

Comando y salida completos en `evidencia/ev-04-post-fix.{sh,out}`.

## Corroboración de que lo aplicado es lo propuesto

Los siete cambios de `OUTPUTs/20` están en el árbol: versión 5.3, las dos filas de §2.1 sin tocar,
§3.3 reescrita con las tres bandas y el caso mixto, §5.2/§5.5 nombrando la unidad de conteo, §6
reclasificado con su comando, §8 con «cada proyecto de código», fila 5.3 de control de cambios. El
`git diff --stat` confirma un solo archivo tocado, 47 líneas agregadas y 10 quitadas. El snapshot
`_legacy/13.14/SDD/Devs/Rules/Rules-Backlog-Tecnico.md` quedó tomado antes de editar.

## Veredicto de los cinco criterios de §7 del reporte

1. **Las seis menciones dicen lo mismo.** **Cumplido.** El comando por texto (ya no por línea fija,
   declarado en `OUTPUTs/00`) devuelve una sola unidad —proyecto de código— y un solo número de
   bandas —tres— en las cinco secciones que fijan el umbral (§2.1 ×2, §3.3, §6, §8); §5.2 y §5.5
   nombran ahora la misma unidad en su pregunta. El grep de «unidad de entrega» pegado a un umbral
   de US/BT no devuelve nada.
2. **El criterio de §6 se decide con un comando y está `[enumerable]`.** **Cumplido.** Ver la cita
   completa en `evidencia/ev-04-post-fix.out`.
3. **Sobre `Lab-Geometria`, un solo resultado sin leer dos secciones juntas.** **Cumplido y
   verificado contra un caso real, no hipotético.** Aplicando solo §2.1+§3.3 corregidas sobre
   `fase-k` (`OUTPUTs/00`, §2): `GeometriaFactory-Api` bloque `0` = 35 BT > 30 → obligatorio,
   bloques `2`/`4`/`6` = 16/21/26 → recomendado; no hace falta mirar §6 para saber qué archivo debe
   existir, ni existe una segunda lectura que dé otro número.
4. **El caso mixto está contemplado.** **Cumplido.** §3.3 declara la forma —proyecto que cruza en
   archivo, proyecto que no cruza inline, en el mismo documento— y la declara **correcta y no
   transitoria**, con el fundamento de por qué no conviene forzar a toda la unidad.
5. **El impacto sobre destinos existentes está medido**, con el recuento por destino. **Cumplido**,
   en `OUTPUTs/00` (comparación por-proyecto vs. por-unidad, tres destinos, cinco documentos) y en
   la fila 5.3 del control de cambios de la regla, que resume la severidad (minor) y por qué.

**Los cinco criterios de §7 quedan cumplidos, sin ninguno a medias** — a diferencia de otros
reportes de esta serie, acá no hay una pieza que dependa de una corrida futura para verificarse: el
caso real (`GeometriaFactory-Api`, fase `k`) ya estaba en curso al escribir el reporte y siguió
avanzando durante esta misma intervención.

## Qué le exige a `Lab-Geometria` (solicitud 12)

**Alcanza con las 35 BT del proyecto `GeometriaFactory-Api` en archivos individuales bajo
`tareas-tecnicas/`. No hace falta nada más**, y se verificó en vivo:

- Los otros tres proyectos de la misma unidad (`Domain` 16, `Application` 21, `Infrastructure` 26)
  siguen en banda **recomendada** (15 a 30), no obligatoria: pueden seguir inline en el mismo
  `Backlog-Tecnico.md` sin incumplir nada.
- La unidad `GeometriaFactory-Web` no está alcanzada en absoluto: sus dos proyectos de código suman
  23 y 18 BT, los dos en banda recomendada.
- Las US de las dos unidades ya estaban resueltas antes de este reporte: cada proyecto de código de
  `GeometriaFactory-Api` supera 20 US y ya tiene sus 114 archivos; el bloque `10` de
  `GeometriaFactory-Web` supera 20 y ya tiene sus 30; el bloque `12` (17 US) está en banda
  recomendada y sigue inline, lo cual es conforme.
- Al momento de esta medición (`fase-k` en `77d145ec0375667085afec76679234c342dafff7`), el proyecto
  ya tenía sus 35 archivos `BT-000XX` bajo `tareas-tecnicas/`: la corrección del framework confirma
  el trabajo que el destino ya estaba haciendo, no le agrega alcance nuevo.

## Lo no verificado, declarado

- **`RPI.VideoControl` no resuelve `DEC-00003`** (si sus BT deben repartirse por proyecto de código
  o no) y esta intervención no lo hace por él: es una decisión pendiente del propio destino sobre su
  esquema de identificadores, no del umbral de archivos individuales que gobierna este reporte. Bajo
  cualquier resultado de esa decisión, sus 20 BT totales siguen en banda recomendada y no cambian el
  veredicto de este reporte.
- **No se corrió una migración real de `Lab-Geometria` con la regla 5.3 en la mano** —la fase `k`
  sigue en curso, en la rama de otro agente—; lo verificado es que la regla corregida, aplicada a
  mano sobre el estado commiteado de esa rama, da el mismo resultado que el agente ya está
  produciendo. Una corrida completa de la fase `k` con la regla nueva vigente queda para cuando esa
  fase cierre, fuera del alcance de esta intervención (que no toca `Lab-Geometria`).
- **El recuento de `SelfHosted.Service.Core`** no aporta nada al umbral porque su categoría 06 no
  está generada; se declara para que no se lea como recuento omitido por descuido.
