# 10 — La decisión de fondo y las otras tres preguntas de §5 (solicitudes 3, 4, 5 y 6)

## Solicitud 3 — respetar lo que el reporte no afirma

`Lab-Geometria` no es el que se equivocó. Los recuentos de `OUTPUTs/00` lo confirman: aplicó la
tabla maestra de §2.1 con coherencia en las dos categorías —US y BT— y en las dos unidades, y su
propio `Backlog-Tecnico.md` la cita tres veces (§1.2 a §1.4, transcripto en el reporte). Esta
intervención no reescribe esa historia: donde la corrección coincide con lo que el destino ya
hacía, el destino queda **alcanzado por confirmación**, no por corrección.

## Solicitud 4 — la unidad del recuento (§5.1)

**Decisión: por proyecto de código.** No es un desenlace negativo (el precedente del reporte `12`
no aplica acá: hay una respuesta positiva y con fundamento en el árbol).

### Los dos argumentos del reporte, pesados

- **Por proyecto de código** es lo que dice la tabla maestra de §2.1 desde la versión 1.0 de la
  regla (`Rules-Backlog-Tecnico.md`, control de cambios), lo que `Lab-Geometria` y `RPI.VideoControl`
  aplican sin excepción, y lo que no rompe a ningún destino medido (`OUTPUTs/00`).
- **Por unidad de entrega** es lo que dicen la cabecera (nivel de aplicación), la convención de
  §3.3, el criterio de §6 y el snippet de §8 hasta esta intervención, y es cierto que la carpeta
  `tareas-tecnicas/`/`historias-usuario/` vive **una vez por unidad**, no una vez por proyecto.

### Por qué gana «por proyecto de código», y no por conteo de menciones

**El criterio no es cuántas secciones dicen cada cosa** (`Root-Rules.md` §13 lo prohíbe
explícitamente para el conflicto entre reglas, y el mismo argumento vale acá para el conflicto
interno a una regla: cuatro contra dos no es un criterio). El criterio es **el impacto medido sobre
el árbol**, con `ORIGEN DEL HECHO` contra la base:

1. **Bajo «por proyecto de código», cero destinos incumplen.** El único cruce de umbral
   (`GeometriaFactory-Api`, bloque BT) se resuelve en la misma corrida que lo produjo, que es el
   comportamiento que la regla busca desde su origen (§3.3: «permite trazar dependencias técnicas
   por archivo... sin tocar el backlog completo»).
2. **Bajo «por unidad de entrega», dos destinos reales incumplen de golpe, en cuatro documentos**:
   los BT de las dos unidades de `Lab-Geometria` (98 y 41, cero archivos, desde el 2026-08-16 según
   el propio reporte) y las US de `GeometriaFactory-Web` y de `RPI.VideoControl` (47 con solo 30
   archivadas, 55 con solo 25). Nadie lo había detectado porque el criterio de §6 era
   `[interpretativo]` — es la evidencia central del propio reporte, ahora extendida a US y a un
   segundo destino.
3. **La tercera pregunta que el reporte esconde, contestada con el árbol**: la carpeta
   `tareas-tecnicas/` es de la unidad y el conteo es del proyecto, y eso produce el caso mixto
   —un `Backlog-Tecnico.md` con un proyecto en archivos y otros inline—. `Lab-Geometria` lo está
   construyendo ahora mismo (`OUTPUTs/00`, §2): es la forma real, no una hipótesis. **Es la forma
   correcta y no un estado transitorio**, por el mismo argumento con que §3.6 ya distingue un
   cambio estructural de uno de enmarcamiento: reescribir las secciones de los proyectos que no
   cruzaron el umbral, solo porque otro proyecto de la misma unidad lo cruzó, tocaría contenido que
   no cambió — el mismo defecto que `Rules-Backlog-Tecnico.md` §3.6 corrige del otro lado (no
   reabrir lo que no cambió de alcance).

**No hace falta arbitraje de `Master-Prompt.md` §8.1.** La contradicción es interna a un archivo
(como el precedente del reporte `28`, `Root-Rules.md` §13 no alcanza), y tiene respuesta en el
árbol: el impacto medido decide sin requerir intención de producto. Se aplica igual la regla de
`Root-Rules.md` §13 en espíritu —la que más destinos reales sostiene sin romper gana, no la que
tiene más menciones—, aunque §13 en la letra rige entre dos reglas distintas y esta es una regla
sola que se equivocó de eje en tres de sus seis apariciones.

## Solicitud 5 — las otras tres preguntas de §5

### §5.2 — Las bandas: tres, y qué obliga «recomendado»

**Tres bandas**, las que la tabla maestra de §2.1 ya tenía y que ninguno de los tres destinos
medidos contradice: evita el salto brusco de todo-inline a todo-archivo (fundamento que el propio
§3.1 del cuerpo de la regla ya declaraba como ventaja de la banda intermedia). **«Recomendado» no
obliga nada mecánico**: no es el umbral que dispara el criterio de aceptación de §6 ni la
compuerta, es una señal de buena práctica para el equipo que redacta. Se deja escrito así, en la
letra de §3.3 («es recomendado y no obligatorio»), para que no se lea como una tercera obligación
encubierta.

### §5.3 — Los destinos existentes: ninguno incumple bajo la decisión adoptada; y no es major

Medido en `OUTPUTs/00` sobre los tres destinos con categoría 06 activa: bajo «por proyecto de
código», **cero incumplen**. El bloque `0` de `GeometriaFactory-Api` cruzó el umbral con la
apertura de `k` y ya está resolviéndolo con archivos individuales, que es exactamente lo que la
regla corregida exige — no un incumplimiento sino el mecanismo funcionando.

**No es major.** El criterio de `Root-Rules.md` para major —«la documentación generada con la
versión anterior deja de cumplir»— no se activa: la lectura adoptada es la que los tres destinos ya
aplicaban de hecho (`Lab-Geometria` con cita explícita, `RPI.VideoControl` sin declararlo pero sin
excepción, `SAI.Service.Core` trivialmente porque su unidad es un solo proyecto). Lo único que
cambia de estado es lo contrario de una ruptura: el `Backlog-Tecnico.md` de la API, que bajo la
lectura vieja (§6 literal, por unidad) **parecía incumplir desde el 2026-08-16** con 89 tareas sin
archivo, pasa a cumplir, porque esa lectura nunca fue la que la tabla maestra —la pieza que sí
tenía tres bandas correctas— pretendió imponer. Sube **minor**.

### §5.4 — El criterio enumerable: sí, con el comando de §6

Fijada la unidad de recuento, §6 pasa de `[interpretativo]` a `[enumerable]`: contar por proyecto
de código (bloque de identificador, rango declarado, o la sección que el producto ya usa para
organizarlos — la atribución no la inventa esta regla, la toma del producto) y probar la existencia
de la carpeta con `test -d`. El comando queda escrito en la propia regla (§6, ver `OUTPUTs/30`).

## Solicitud 6 — extender la decisión a las US

**Ya está extendida.** La tabla maestra de §2.1 ya contaba las US por proyecto de código con tres
bandas (20/10, igual que las BT con 30/15) desde siempre; la misma contradicción con §3.3/§6/§8
existía para US y el reporte no la había medido —la solicitud 2 la reprodujo en `OUTPUTs/00`—. El
fix de §3.3, §6 y §8 en `Rules-Backlog-Tecnico.md` toca **las dos familias en el mismo texto**, no
solo BT: sería exactamente el hallazgo que la solicitud 6 previene —dejar las US con la
contradicción mientras se corrigen las BT— y no ocurrió porque las tres secciones tratan ambas
familias en los mismos párrafos.

## Detenciones

**Ninguna.** La solicitud 4, la que el prompt marca como la que puede requerir intención de
producto, se contestó con el árbol: impacto medido, cero destinos rotos bajo la lectura adoptada,
tercero-que-esconde resuelto con un caso real en curso. No hay `ORIGEN DEL HECHO` que declarar
porque no hay detención que abrir.
