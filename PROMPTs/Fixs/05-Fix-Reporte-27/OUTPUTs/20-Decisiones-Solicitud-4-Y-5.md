# OUTPUT 20 — Decisión de la solicitud 4 y desenlace de las seis preguntas de §5

**Intervención:** `05-Fix-Reporte-27`
**Fecha:** 2026-09-12

---

## 1 · Solicitud 4 — qué pasa con los 118 huecos ya declarados (decidida primero)

**Las tres salidas posibles, evaluadas contra el caso real:**

| Salida | Costo medido | Decisión |
|---|---|---|
| Exigir el campo retroactivo | Eleva al humano, en la primera migración que corra sobre cualquier destino con huecos —que son todos—, el volumen completo. Sobre `Lab-Geometria`: **118** preguntas de una sola vez, exactamente lo que el mecanismo viene a evitar (reporte `27` §5.4, textual) | **Descartada** |
| Dejar vacío con «anterior al mecanismo» sin más | Pierde información que el commit todavía tiene: el texto literal de un hueco es buscable en git, y descartar esa búsqueda tira un dato recuperable | **Descartada como única salida**, aunque su valor terminal se reutiliza para el caso que no resuelve |
| Derivar donde se pueda, marcar no derivable donde no | Probado sobre una fila real (abajo): resuelve en **menos de un segundo** de cómputo. El costo no está en el comando sino en elegir, por fila, un fragmento de texto estable | **Adoptada**, con el valor terminal de la salida anterior para el caso que no resuelve |

### 1.1 La prueba sobre el caso real

```bash
cd Lab-Geometria
git log archivo/reanudacion-6-2026-09-12 --oneline -S"La vigencia exacta del acceso firmado"
```

Salida (8 commits, el más antiguo al final):

```
e877e6f docs(sdd): M4 corte 06 — la estimación se cierra por lectura, no por decisión
eadb8d6 docs(sdd): A3 — 57 filas son ocho decisiones tuyas, y veinte se cierran leyendo
6ca9b5f docs(sdd): M4 · los apartamientos reciben su estado, y el layout anterior sale del nivel producto
aa1f2f2 plan de la etapa a, previo al punto de control
b7d5643 resumen ejecutivo de check-out
818997f Fase D de los cuatro proyectos restantes
0a71935 Fase C de Infrastructure y Api, e intake 1.18
8520aa7 Fase B de GeometriaFactory-Api
```

**El commit más antiguo, `8520aa7 Fase B de GeometriaFactory-Api`, es el ciclo de origen derivado** de
`PD-04` de `Pipeline-CI-CD.md` de `GeometriaFactory-Api` («la vigencia exacta del acceso firmado»),
sin abrir el hueco a mano. Tiempo medido: `real 0m0,927s` (con `--all` sin acotar el path, que es lo que
se necesita cuando la consolidación movió el archivo de carpeta).

**Fallo intencional registrado, y es parte de la medición**: la primera corrida acotando el `path`
(`-- SDD/Docs/.../Pipeline-CI-CD.md`) no devolvió nada — el archivo cambió de ruta en al menos una
consolidación intermedia, y `-S` con `path` sólo mira commits donde ese path exacto existía. **La forma
correcta es sin acotar el path**, buscando en toda la historia de la rama. Se declara porque es
exactamente el tipo de detalle que separa un mecanismo que funciona en la demo de uno que funciona en
el caso real.

### 1.2 Por qué no se ejecuta sobre las 118

`Lab-Geometria` es un destino y esta intervención no lo toca, por norma explícita del prompt que la
convoca. Derivar las 118 exige, por cada fila, elegir un fragmento de texto suficientemente literal y
estable — trabajo de una migración concreta sobre ese destino, no de esta regla del framework. El
mecanismo queda escrito y medido (`Migracion-Rules.md` §4.9); su ejecución completa es el criterio 4 del
reporte, declarado **a medias** en la verificación final.

---

## 2 · Las seis preguntas de §5, con fundamento

### §5.1 — El campo

**Sí.** `ciclo de origen`: fase, unidad de trabajo y base de la corrida, calculados por el orquestador
y no por el agente, con el mismo fundamento del reporte `26` §5.3 (declarado a mano se llena de buena fe
y se lee como verificación sin serlo).

**Se congela, no se recalcula** — la diferencia con el origen del hecho que el prompt de esta
intervención pide medir explícitamente (§7 de las solicitudes). El origen del hecho vive dentro de una
corrida; el ciclo de origen de un hueco sobrevive a la corrida que lo escribió, y cada corrida futura
que lo lea tiene su propia base de la corrida, distinta de la que generó el hueco. Remitir el campo a
«la base de la corrida» sin más apuntaría, en una lectura posterior, a un commit equivocado.

### §5.2 — El estado del producto

**No como campo declarado.** Se deriva del commit del ciclo de origen (`git show
{{base}}:{{manifiesto}}`, sobre su bloque de procedencia): es un dato que un commit ya contiene, y
`Root-Rules.md` §10 prohíbe declarar lo que se puede derivar — el mismo criterio con el que esa sección
prohíbe un recuento en prosa cuando la tabla ya lo dice. Declarar un segundo campo sería mantener dos
declaraciones del mismo hecho.

### §5.3 — La clasificación

**Sí**, `Migracion-Rules.md` §4.8: compara la versión del framework que exige el contenido faltante
(leída del control de cambios de la regla citada) contra la que regía en el destino en el ciclo de
origen (derivada del commit, §5.2). **Hueco del ciclo** si la exigencia es anterior o igual → se
completa. **Hueco de norma posterior** si es posterior → se declara deuda. Sólo eleva al humano el que
ninguna de las dos alcanza.

### §5.4 — El tratamiento retroactivo

Resuelto en la sección 1 de este documento: derivar donde se pueda, marcar `no derivable — anterior al
mecanismo` donde no, sin exigir retroactivo ni vaciar sin más.

### §5.5 — El criterio enumerable

**Sí.** Tres piezas: la fila de escalamiento P1 en `Root-Rules.md` §12.2 (un hueco declarado desde SDD
8.7 sin ciclo de origen), los dos criterios de `Migracion-Rules.md` §6 (todo hueco con el campo queda
clasificado, y el número elevado es menor que el total; todo hueco sin el campo queda con uno de los
dos resultados de §4.9), y la comprobación 8 de `Master-Prompt.md` §10.0 (presencia del campo en los
huecos que la fase escribe).

### §5.6 — El rol

**Ninguno nuevo.** El orquestador que ya calcula el origen del hecho (`Master-Prompt.md` §8.1) calcula
el ciclo de origen con el mismo mecanismo y dos datos más (fase, unidad de trabajo) — `Master-Prompt.md`
§8.2. Confirma la posición del propio reporte: el dato primero, y con el dato puesto el rol dejó de
hacer falta. Contestada **después** de §5.1, como el reporte exige.

---

## 3 · Reutilización evaluada antes de inventar (solicitud 6)

**`Deriva-Rules.md`, tipo de evidencia `ejecucion`.** Ancla una afirmación a un momento verificable —
fecha, salida, artefacto versionado—, y es la prueba de que el framework sabe fechar cuando decide
hacerlo. **No alcanza directo**: es un valor del campo `evidencia` de un contrato de verificación de la
categoría 10 (`VER-XXXXX`), no un campo de los tres instrumentos de huecos, y no lleva fase ni unidad de
trabajo. Se reutiliza el **patrón** (anclar a un momento reproducible), no el artefacto.

**`SDD-Development-Guide.md` §III.4**, las tres preguntas de agregar un instrumento:

- **¿Corre una vez, por unidad o por incremento?** Corre **una vez por hueco declarado**, en cualquier
  fase.
- **¿Qué precondición?** Que la base de la corrida esté publicada (`Master-Prompt.md` §12.1 T0), la
  misma precondición que ya exige el origen del hecho.
- **¿Qué se regenera y qué se preserva?** Nada se regenera: el campo se escribe una sola vez y no se
  recalcula, por la razón de la sección 1.

§III.4 es de agregar una **fase**, y esto no es una fase — se responden sus preguntas porque
transfieren bien al caso de un campo nuevo, y se declara **por qué ninguna de las dos piezas alcanzaba
sola**: `Deriva-Rules.md` fecha lo que se hizo, no lo que falta; §III.4 pregunta sobre fases, y este
mecanismo vive dentro de la mecánica de despacho, no como fase propia. Se ensambla con la pieza que el
reporte `26` ya dejó resuelta (la base de la corrida) en lugar de inventar una tercera.

---

## 4 · Relación con los reportes `25` y `26` (solicitud 7)

**Con el `25`.** Separables, y siguen siéndolo. El `25` trata el disparador del ciclo —qué evento hace
que el método reciba un cambio de alcance de producto después del handoff—; el `27` trata el formato
del hueco **dentro** de un ciclo ya disparado, sea por la razón que sea. Nada de lo que esta
intervención tocó (los tres archivos de la tabla de la nota de coherencia) sugiere que compartan
artefacto: el `25` es un hueco de disparador y no toca `Root-Rules.md` §11/§12 ni `Migracion-Rules.md`
§4.

**Con el `26`.** Los dos piden un dato que se calcula y no se declara, y **se reutiliza la misma pieza
entera**: la base de la corrida de `Master-Prompt.md` §12.1, publicada por T0 desde la 13.11. No se creó
ninguna pieza paralela. **El caso que distingue a los dos, cuidado explícitamente**: el origen del hecho
es de una corrida y se recalcula; el ciclo de origen de un hueco sobrevive a la corrida y se congela.
Tratar el ciclo de origen como el origen del hecho —recalculable— habría sido correcto mientras la
corrida seguía viva y falso en la primera corrida siguiente que leyera el hueco.
