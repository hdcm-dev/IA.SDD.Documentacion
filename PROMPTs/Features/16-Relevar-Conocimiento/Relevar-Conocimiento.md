# Tool-Prompt — Relevamiento de conocimiento

> **Invocación**: `Leer y ejecutar /IA/SDD/IA.SDD.Documentacion/PROMPTs/Features/16-Relevar-Conocimiento/Relevar-Conocimiento.md`, completando antes el bloque de parámetros.
>
> **Overview**: Caracteriza un artefacto externo —un template, una arquitectura, una convención de nomenclatura, un componente reusable— y lo incorpora como documento a la base de conocimiento de la organización, con el formato que el `Framework SDD` regula.

---

## Parámetros de la invocación

Completar antes de ejecutar. Los cuatro son obligatorios.

```yaml
que_capturar: <qué conocimiento se quiere capturar, en una oración>
de_donde: <ruta del artefacto o del proyecto del que se lo extrae>
base_de_conocimiento: <ruta raíz de la base de la organización>
archivo_de_reglas: <ruta a Rules-Base-Conocimiento.md del Framework SDD>
```

Opcionales, y si no se declaran los deriva el paso 1:

```yaml
consumidor: <categoría 00 a 11, transversal, o subagente de fase como AG-00031>
naturaleza: <canonico | propio>
alias: <alias citable propuesto>
```

---

## Insumos a leer obligatoriamente

1. **`Rules-Base-Conocimiento.md`**, entero. Es la norma que este prompt aplica y **no se resume acá**:
   un prompt que reescribe su regla crea una segunda fuente y las dos se desincronizan.
2. El artefacto o proyecto de `de_donde`.
3. El `Index-Knowledge.md` de `base_de_conocimiento`, si ya existe. Si no existe, se crea en el paso 5.

**No se lee nada más.** En particular, no se leen los archivos de reglas de categoría del framework: lo
que este prompt produce **no es una regla** y no tiene que parecerse a una.

---

## Objetivo

Producir **dos artefactos, y sólo dos**, los dos dentro de `base_de_conocimiento`:

1. `Knowledge-<Tema>.md`, con la cabecera de §4.1 y las secciones de §4.2 del archivo de reglas.
2. La fila correspondiente en su `Index-Knowledge.md`, con las columnas de §7.1.

**No se escribe nada en el repositorio del `Framework SDD`.** Una captura no es una intervención sobre
el framework: no emite nota de coherencia, no toca su `CHANGELOG.md` y no copia nada a `_legacy/`.

---

## Secuencia

### Paso 1 — Orientación

Responder las cuatro preguntas de §5.1 del archivo de reglas, y **declarar las respuestas por escrito
antes de mirar el artefacto en detalle**.

De las cuatro, la que decide el resto es **la naturaleza**:

- **`canonico`** — lo caracterizado tiene nombre establecido en la industria (`Patron-DAO`,
  `Clean-Architecture`, `CQRS`, `Atomic-Design`). El documento escribe **el delta**: qué variante se
  adopta, qué convenciones locales rigen, qué decisiones ya están tomadas, qué anti-patrones se vieron
  acá. **No reexplica el patrón.**
- **`propio`** — no hay nombre establecido y el agente que lo lea no sabe nada. El documento escribe
  **todo**: identidad, estructura, contrato de uso y esqueletos.

**Este paso es bloqueante.** Sin orientación declarada, el relevamiento produce un resumen del proyecto
en lugar de conocimiento reutilizable, y el resultado **parece un documento válido**, que es lo que lo
vuelve el modo de falla más caro.

### Paso 2 — Relevamiento

Recorrer el artefacto respondiendo las preguntas §5.2 a §5.5 del archivo de reglas, en orden. Son
trece y cubren identidad y frontera, estructura y contrato, decisiones contra accidentes, y composición
con el piso mínimo del framework.

Dos de ellas deciden qué entra y qué no, y conviene no apurarlas:

- **«¿Qué se rompe si se ignora esta convención?»** Lo que no se puede contestar probablemente no sea
  una convención sino una costumbre, y no va al documento.
- **«¿Qué de lo que se ve es decisión y qué es accidente?»** El accidente no se documenta como si fuera
  decisión: se omite, o se declara como deuda del artefacto.

### Paso 3 — Composición con el piso

Si lo relevado **contradice algo que el framework fija**, resolver con §0.4 del archivo de reglas antes
de escribir, porque cambia la cabecera del documento:

| Situación | Resultado |
| --- | --- |
| El ítem del framework está rotulado como **decisión de stack** | **Sustitución.** Va al campo `sustituye` de la cabecera y del índice, con la referencia literal |
| El ítem **no** está rotulado | **Desviación.** Manda la regla del framework. Se declara en §8 del documento con su justificación |
| No contradice, especializa | Va `hereda-de`, y **sólo se escribe el delta** |

**La sustitución la habilita el framework por adelantado, no este prompt.** Si el rótulo no está, no se
inventa: se declara desviación y se sigue.

### Paso 4 — Destilación

Redactar contra §4 del archivo de reglas: cabecera de §4.1, secciones de §4.2, las siete propiedades de
forma de §4.4, evitando los seis anti-patrones de §4.5.

Bajo el techo de §6.2. **Superarlo no se justifica: se parte el documento en dos** y los dos se declaran
hermanos en su §9.

Cerrar con las tres preguntas de §5.6 antes de pasar al alta: si un agente que nunca vio el artefacto
puede usarlo leyendo sólo esto, si hay algo repetido de otro documento de la base, y si entra bajo el
techo.

### Paso 5 — Alta

Escribir el documento y su fila en `Index-Knowledge.md`, con las diez columnas de §7.1. Si el índice no
existe todavía, crearlo con el encabezado de esas columnas.

**Antes de devolver, correr la lista de §6.1 completa y declarar el resultado de cada ítem**, los trece,
con su marca `[enumerable]` o `[interpretativo]`.

---

## Detenciones

Detenerse y preguntar, en estos tres casos y en ningún otro:

| Caso | Por qué no se resuelve solo |
| --- | --- |
| La orientación del paso 1 no se puede completar con lo declarado en los parámetros | Seguir produce un resumen de proyecto, que es peor que no producir nada |
| El artefacto contiene dos temas independientes | Son dos documentos, y cuál se captura primero es una decisión de quien pidió la captura |
| Lo relevado contradice un ítem del framework y **no está claro si el ítem es método o decisión de stack** | Elegir mal deja una sustitución donde correspondía una desviación, o al revés |

Todo lo demás —nombres, orden de secciones, qué ejemplo se usa, cuánto detalle lleva un esqueleto— se
resuelve sin preguntar.

---

## Devolución

1. Las respuestas del paso 1, textuales.
2. La ruta del documento creado y su alias.
3. La fila del índice, tal como quedó.
4. El resultado de los trece ítems de §6.1.
5. **Lo que se dejó afuera y por qué**, que es lo que permite auditar la captura sin releer el artefacto.

---

## Reglas

- **No inventar información.** Lo que no se pudo verificar en el artefacto no entra al documento.
- **Describir el artefacto, no el método del framework.** Criterios de aceptación, nomenclatura de
  artefactos generados y gating por tipo D8 son del framework y no se redefinen desde acá.
- **No escribir en el repositorio del `Framework SDD`.**
- **No resumir el archivo de reglas dentro del documento producido.** Se lo cita.
- **La compuerta de ofuscación no corre acá.** La base es privada y D7 no la alcanza. Rige sólo si algún
  día se promueve un documento al catálogo público del framework.
