# Tool-Prompt — Análisis y Fix del reporte 31

> **Invocación**: Leer y ejecutar `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Fixs/09-Fix-Reporte-31/Fix-Analizar-Reporte-31.md`
>
> **Overview**: Evaluar el `Framework SDD` contra el reporte **31**, que dice que el método no expedienta sus casos. Decidir si el caso entra como figura normada y con qué forma mínima, y aplicarlo sobre el framework.

---

## Contexto

Leer `/IA/SDD/IA.SDD/README.md`: es un `Framework SDD` (Spec-Driven Development) para especificar y programar con asistencia de IA.

**Se aplica un solo reporte:**

- [`31-El-Metodo-No-Expedienta-Sus-Casos.md`](../../../Reportes/31-El-Metodo-No-Expedienta-Sus-Casos.md), en estado **Abierto** y evaluado contra SDD **13.16**.

**Su evidencia primaria no es un resumen: es un expediente.** Está en `/IA/SDD/IA.SDD/Expedientes/0001-Expedientes-Como-Comportamiento-Del-Framework/`, en la rama `expedientes/0001-caso` si todavía no se fusionó. **Leelo entero y en orden de folio.** Las piezas de las que depende la intervención son:

| Pieza | Qué contiene |
|---|---|
| `ev-07` | La presentación original del Product Owner. Rige sobre el folio 001, por lo que dice el folio 012 |
| 013 | La consolidación en 18 raíces y el plan compuesto |
| 014 | La refutación: 14 ataques y la forma mínima alternativa |
| 015 | El veredicto: forma aprobada por pregunta, las escaladas E-1 a E-3 y la deuda D-1 a D-6 |
| 016 | El dictamen: Q1 a Q12, los criterios A1 a A10, D-7 y las capas a tocar |
| `ev-06` | La réplica del panel |

**Por qué no entran otros reportes.** Verificar el estado en [`Reportes/README.md`](../../../Reportes/README.md). No entra ninguno más.

**Sobre qué versión se aplica, que es lo primero que cambia.** El reporte evaluó la 13.16. Mientras tanto se preparó la **13.17** en la rama `conocimiento/mesa-de-expertos-a-pedido` (`cab03ed`), que da de alta `Conocimiento/Knowledge-Mesa-De-Expertos-A-Pedido.md` y describe en su §2.3 la carpeta del expediente de mesa. **Esta intervención se numera como la siguiente a la vigente en el momento de aplicarla**, que probablemente sea la 13.18. Verificarlo en `CHANGELOG.md` de `main`, no en este párrafo.

### La trampa principal

**Convertir un buen hábito en una ceremonia que nadie completa.** Ya pasó dentro del propio caso:

- El plan compuesto del presidente pedía **47 campos, 4 archivos, N+1 commits y 12 pasos** para un caso de dos folios. El refutador lo midió (folio 014, R-01) y el jurado lo reemplazó por **18 campos** (folio 015, Q3).
- El primer ejemplar prometía «un folio por commit» y un trailer en el mensaje, y **no los cumplió en ninguno de sus commits** (R-04).
- El segundo ejemplar, el de la migración de `Lab-Geometria`, ya tenía **seis evidencias fuera de su índice escrito a mano**.

**El criterio para no caer en la trampa tiene dos partes:**

1. La forma mínima de un expediente **se llena en minutos**.
2. Su verificación es **enumerable**, con comandos que viven en el texto de la regla. Nada de un verificador distribuido: reporte `12`, guía §II.7.

**Todo campo que pueda leerse del árbol o del control de versiones no se escribe a mano** (`Root-Rules.md` §10). **Todo paso que agregues pesalo contra el presupuesto de nueve** de la guía, Parte IV, «paso o prosa».

### Otras trampas

- **Tratar como literal lo que no lo es.** La presentación «literal» del folio 001 estaba normalizada, reordenada y recortada, y la del expediente de la migración también. Toda cita del Product Owner sale de `ev-07`.
- **Duplicar `Audit/`.** Un expediente que copie el registro de mesa o los informes vuelve a abrir la discusión de `Mesa-Rules.md` l.164-168 sobre un tercer contenedor. **Se folia por enlace.**
- **Tocar el ciclo de origen.** `Master-Prompt.md` §8.2 y `Root-Rules.md` §12 **no se modifican** (R-10): se calcula, no se declara.
- **Postergar seguridad cuando ya hay algo sellado.** El expediente `0001` contiene rutas de host y un nombre propio copiado de un destino. S2 corre **antes de cualquier push** de su rama (E-2).

---

## Permisos y límites

- **Acá SÍ se escribe sobre `/IA/SDD/IA.SDD/`.** Es el propósito de esta intervención y no se extiende a nada más.
- **`PROMPTs/` es del usuario y es de sólo lectura**, salvo la carpeta `OUTPUTs` de esta intervención y la fila `09` de `PROMPTs/Fixs/README.md`.
- **No se toca ningún repositorio de destino.** `Lab-Geometria`, su worktree de migración y `RPI.VideoControl` se leen.
- **El expediente `0001` no se reescribe.** Si la intervención tiene algo que agregarle, va como folio nuevo en su rama.
- Se trabaja sobre árbol limpio.

---

## Objetivo

Decidir si el método adopta **el caso** como figura normada. Si la respuesta es sí, darle lo que el dictamen aprobó y la intervención verifique:

- lugar, condición de apertura, forma mínima, estados derivados e inmutabilidad observable;
- custodia del original de lo que aporta el Product Owner;
- vínculo entre evidencia y especificación;
- «ante un problema, mesa y no detención» escrito donde el orquestador tropieza;
- punto de continuación.

Todo esto **sin que la forma mínima deje de llenarse en minutos**, y alineando la 13.17.

**Una decisión negativa con fundamento también es un desenlace válido** (precedente: reporte `12`).

---

## Solicitudes

**1 · Verificar primero qué ya está resuelto.**
- Por cada cita del reporte y del dictamen, abrir el archivo vigente en `main` y decir si sigue siendo literal.
- **Correr los comandos del reporte, §2, y pegar la salida.**
- Confirmar la versión vigente (`CHANGELOG.md`) y si la 13.17 ya se fusionó.

**2 · Tomar el lote como resuelto, no como pregunta.** Las tres escaladas del folio 015 §5 **se resolvieron con el conjunto en el folio 018** y no se elevaron:
- **E-1 → A.** Los expedientes del framework viven en `IA.SDD/Expedientes/`, por la ruta literal del Product Owner en `ev-07`. **Esta intervención declara la reformulación de `README.md` l.152** en su nota de coherencia.
- **E-2 → A.** El nombre copiado era un dato personal y ya está redactado (S2 aplicada en el folio 018). La fuente en `Lab-Geometria` la trata el Product Owner después de la migración: **no la toques**.
- **E-3 → insumo de esta intervención, no pregunta.** La presentación del Product Owner (`ev-07`) dice que «las pruebas que aporse yo o las que obtuviesen los agentes quedarian como prte de las especificaciones». Es intención declarada y fechada. **Si D9 suma una oración para la aprobación dada por conversación, y con qué forma, lo decide la mesa de la solicitud 5, con esa cita como restricción dura del contrato de entrada.** Si la suma, el salto es major con bloque de impacto; si no, minor. En los dos casos el fundamento se escribe.

**No vuelvas a preguntar nada de esto al Product Owner.**

**3 · Respetar las cinco cosas que el reporte declara que no afirma (§6).** En particular:
- no mudar nada de `Audit/` ni de `OUTPUTs/`;
- no tocar el ciclo de origen;
- no reabrir el reporte `12`.

**4 · Decidir la pregunta de fondo (§5.1), y decidirla primero.** ¿Se adopta el caso como figura normada, con la forma mínima del dictamen?
- Si la respuesta es no: decir dónde queda un caso que atraviesa corridas y cómo se custodia la palabra del Product Owner.
- Si la respuesta es sí: seguir.

**5 · Convocar la mesa del ciclo siguiente**, que el expediente dejó pendiente. `Mesa-Rules.md` §0.0 se cumple: hay corpus previo (el expediente), estado leído y plan por aprobar.
- **Con Seguridad (AG-00050), Formal y Trazabilidad documental (AG-00110)**, las tres postergadas por cupo (D-2, D-5, D-6).
- **Con un jurado de cinco agentes distintos**, no uno solo: el ciclo anterior se declaró sospechoso de homogeneidad (81 %).
- **Asentar las cartas antes de despachar** (folio 017).
- **Antes de volver a despachar a alguien, comprobar si el despacho anterior terminó** (folio 003).

**6 · Las doce preguntas del dictamen, una por una**, con fundamento escrito aunque la decisión sea no hacer nada:

| # | Pregunta | Qué verificar antes de aplicar |
|---|---|---|
| Q1 | Dónde vive | La exclusión del snapshot nombrada en §VI.5. La reformulación declarada de `README.md` l.152, según E-1 |
| Q2 | Cuándo se abre, y cuándo no | Que la condición se pueda observar **al abrir** y excluya la mesa con registro en `Audit/` y la detención resuelta en el lote |
| Q3 | Forma mínima y completa | **Contar los campos de un caso de dos folios: no más de 18** |
| Q4 | Identificador | **Colisión medida con comando** (`Vocabulario-Rules.md` §9.4), **incluida la rama `migracion/a-13.16`**. Número local de cinco dígitos y familia excluida, **sin tocar D3** |
| Q5 | Estados | Mapeo tipo → estado **total**, verificado por enumeración, con Formal |
| Q6 | Inmutabilidad y foliatura | S1 sobre la carpeta entera contra la rama principal ya fusionada. S3 sobre la fusión. Sin folio por commit ni trailer obligatorio |
| Q7 | Evidencia | Medición contra observación. Huella sólo para lo no versionado. Testimonio **clasificado por contenido**, y la oración de D9 decidida con la restricción dura de E-3. S2 con Seguridad |
| Q8 | Evidencia → especificación | Una sola vía declarada, la fila de control de cambios. La inversa, con `git grep` |
| Q9 | Relación con `Audit/` y con los reportes | Folio por enlace. `Mesa-Rules.md` §8 criterio 1 cuando el registro es el expediente |
| Q10 | Retroactivo | Forma histórica para los adelantos y el precedente. Nada se reescribe |
| Q11 | Mesa y no detención | **Acotado** a ambigüedad y arbitraje. Confirmación de plan y T4 **excluidas por nombre**. Modificación declarada de `Master-Prompt-Migracion.md` l.46 |
| Q12 | Punto de continuación | En el pase del último folio. La reanudación lo lee en R0, paso 4 |

**7 · Reutilizar antes de inventar.** Las piezas existentes son:
- `Audit/`, el origen del hecho y el lote de §7.0;
- D9 y su tipo `humano`;
- `Root-Rules.md` §9.5, para excluir una familia;
- la frontera de §II.7;
- el ítem diferido de §12.2 para la deuda.

**Si se crea algo nuevo, decir por qué ninguna de esas piezas alcanzaba.**

**8 · Diagnosticar y producir evidencia en `OUTPUTs`**: las solicitudes 1 y 2 con sus comandos, la decisión de la solicitud 4, el registro de la mesa de la solicitud 5, el plan y la verificación.

**9 · Plan de aplicación.** Por cada cambio: artefacto, versión, severidad, qué se preserva y a qué destinos alcanza. **Minor, salvo que E-3 se conteste que sí**, y en ese caso major con bloque de impacto.

**10 · Aplicar y corroborar.** Tomar el snapshot `_legacy/<vigente>/` con el conjunto **entero** antes de editar (guía §VI.5).
- **Verificar que el snapshot que se toma no contiene `Expedientes/`** una vez aplicada la exclusión.
- **Verificar que `_legacy/<vigente>/` no contiene la versión nueva** de ningún archivo tocado.

**11 · Alinear la 13.17** (D-3): `Knowledge-Mesa-De-Expertos-A-Pedido.md` §2.3, §3.2 («evidencia E4»), §5.2, §5.3 y §6, con su fila de control de cambios. Si la 13.17 no se fusionó todavía, **declarar el orden** y no fusionarla desde acá.

**12 · Verificar contra los cinco criterios de §7 del reporte, uno por uno.**
- **El decisivo es el 1**: abrir un expediente de dos folios usando sólo el framework, contar los campos y correr A1 a A10 **con los comandos que la regla trae**.
- **El 4 protege contra la trampa de la inmutabilidad**: un clon, un borrado en `evidencia/` y el criterio que falla.

**13 · Cerrar el circuito documental:**
- el reporte `31` pasa a `RESUELTO en SDD <versión>`, con su sección «Cómo se resolvió»;
- `Reportes/README.md`;
- `CHANGELOG.md`, con el impacto medido;
- la fila `09` de `PROMPTs/Fixs/README.md`;
- **un folio de resolución en el expediente `0001`** que cite la versión publicada y declare el expediente como forma histórica (Q10).

**14 · Declarar qué les exige a los destinos.**
- A `Lab-Geometria`: su `EXP-0001` queda como forma histórica, y **D-1 es de la corrida de migración, no de esta intervención**.
- A `RPI.VideoControl`: su `SDD/Docs/Audit/evidencia/` convive.

---

## Reglas

- **No inventar información.**
- **Toda afirmación de recuento, sección o colisión lleva al lado su comando y su salida** (13.12).
- **La forma mínima se llena en minutos y se verifica enumerando.** Si no, no alcanzó.
- **Toda cita del Product Owner sale del original con su huella.**
- **Declarar lo que no se pudo verificar.**
- **Una decisión negativa es un desenlace válido y se escribe.**
