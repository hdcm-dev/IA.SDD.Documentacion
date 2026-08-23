# Tool-Prompt — Actualizar las guías del Framework SDD

> **Invocación**:
> - `Lee y ejecuta /IA/SDD/IA.SDD.Documentacion/PROMPTs/Features/17-Actualizar-Guides.md/02-Mejora-Continuar-Mesa-Evaluadora.md`
>
> **Uso**: poner al día las guías de `IA.SDD/SDD/Guides/` y el marco teórico contra el estado real del framework, bajo el marco de mesa evaluadora. La capa de conocimiento entró en la 13.0 y **ninguna guía la menciona**.

---

## Contexto

Leer primero, en este orden:

1. `/IA/SDD/IA.SDD/README.md` — el modelo de tres repositorios, las invariantes D1 a D9 y las reglas de intervención y publicación.
2. `/IA/SDD/IA.SDD/CHANGELOG.md`, entradas **12.2, 12.3 y 13.0** — qué se incorporó y por qué.
3. `/IA/SDD/IA.SDD/SDD/Devs/Rules/Rules-Base-Conocimiento.md` — el archivo de reglas de la capa nueva.
4. `/IA/SDD/IA.SDD/Conocimiento/README.md` — la carpeta anexa y la propiedad que hay que preservar.

**Dónde estoy.** El framework incorporó en tres versiones seguidas una capa que no existía: una **base de conocimiento**, `Conocimiento/`, carpeta anexa donde vive el **oficio** —cómo se construye tal o cual cosa, según la casa— separado del **método**, que es lo que el framework ya gobernaba. El desacoplamiento es verificable y hay que enunciarlo así: **el framework corre con esa carpeta vacía y ninguna regla nombra un documento de conocimiento**. El mecanismo de extensión es el fork.

**El hueco, medido.** `grep -rc "Rules-Base-Conocimiento\|Conocimiento/\|AG-00980"` sobre `SDD/Guides/*.md` y sobre `SDD/Devs/Guides/Marco-Teorico-SDD.md` devuelve **0 en los cuatro archivos**. Las guías describen un framework que ya no es el que está publicado.

**Qué se busca.** Que las cuatro guías cuenten la capa nueva **en el nivel que a cada audiencia le corresponde**, sin duplicar entre ellas y sin convertir ninguna en una segunda fuente de lo que el archivo de reglas ya dice.

---

## Objetivos

1. **Relevar el desfasaje** entre lo que las guías declaran y lo que el framework publica hoy, con cita de archivo y línea en los dos lados. No sólo lo de la capa de conocimiento: todo lo que las entradas 12.x y 13.0 hayan movido.

2. **Actualizar los cuatro documentos** con el reparto que les corresponde por audiencia:

   | Documento | Audiencia | Qué le toca contar |
   |---|---|---|
   | `SDD-Getting-Started-Guide.md` | Quien arranca | Que la carpeta existe y que **se puede ignorar**. Nada más |
   | `SDD-User-Guide.md` | Quien genera un producto | Cómo se cita un alias desde el intake y qué pasa cuando se cita. El árbol del repositorio con `Conocimiento/` |
   | `SDD-Development-Guide.md` | Quien extiende el framework | El eje de extensión nuevo: cómo se incorpora un documento, qué obligaciones de intervención dispara, y que la carpeta **entra en el snapshot** |
   | `Marco-Teorico-SDD.md` | Quien audita el método | El encuadre: método contra oficio, y por qué el oficio no puede vivir en el conjunto normativo |

3. **Preservar la propiedad que sostiene el diseño**: que el framework funcione con `Conocimiento/` vacía. Si al escribir alguna guía queda sugiriendo que la capa es obligatoria, la redacción está mal.

4. **Dejar un procedimiento rápido** —el de la sección de abajo— verificado contra el árbol real, no supuesto.

---

## Solicitudes

### 1. Ejecutar bajo el marco de mesa evaluadora

El marco completo está en `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Features/15-RAG/05-Mejora-Continuar-Mesa-Evaluadora.md`. **Se lo cita, no se lo copia acá**: dos copias de un marco se desincronizan, y este archivo llevaba una.

Contrato de entrada de §2 del marco, ya completo para este caso:

```yaml
objeto:
  artefacto: documentación
  ruta/id: IA.SDD/SDD/Guides/*.md y SDD/Devs/Guides/Marco-Teorico-SDD.md
  version: conjunto 13.0
  capas_derivadas: [ninguna: las guías no generan artefactos]
objetivo: que las cuatro guías describan el framework publicado, cada una en el nivel de su audiencia
restricciones_duras:
  - D1 a D9 del README, en particular D2 y D3
  - Ninguna guía redefine lo que un archivo de reglas ya declara: lo cita
  - Toda edición sobre IA.SDD es una intervención: CHANGELOG, _legacy y nota de coherencia
decisiones_cerradas:
  - Conocimiento/ es carpeta anexa, no parte del conjunto normativo
  - El desacoplamiento es que el framework corra con la carpeta vacía
  - Conocimiento/ entra en el snapshot de _legacy/
  - La compuerta de ofuscación es bloqueante: el repositorio es público
fuera_de_alcance:
  - El Bloque II del plan de base de conocimiento (intake, master-prompt, AG-00980)
  - Reescribir guías por estilo donde no haya desfasaje
umbral_de_calidad: S1 y S2 bloquean el cierre
presupuesto: { ciclos_max: 2, hallazgos_max_por_especialista: 7 }
```

### 2. Antes de convocar a nadie, correr los chequeos mecánicos

Sobre las cuatro guías: recuentos en prosa que hayan quedado viejos, rutas que ya no resuelven, versiones citadas que no coinciden con las de cabecera, y menciones de la capa nueva. **Lo que falle entra como S1 con evidencia E1.**

### 3. Aplicar y publicar

Con las obligaciones de siempre: nota de coherencia, entrada en `CHANGELOG.md` y copia del conjunto superado a `_legacy/<version>/` **tomada antes de editar**, según `SDD-Development-Guide.md` §VI.5.

### 4. Verificar el reparto

Al cerrar, comprobar que **ningún hecho quedó contado en dos guías con palabras distintas**. Es el modo de falla propio de una actualización que toca cuatro documentos a la vez.

---

## Procedimiento rápido — relevar capturas de pantalla y extraer características de diseño

El caso: tengo un par de capturas de pantalla y quiero quedarme con sus características de diseño para reusarlas.

**Qué regla citar depende del origen, y son dos caminos distintos.**

| De dónde salen las capturas | Regla a citar | Dónde queda | Cómo se llama el resultado |
|---|---|---|---|
| De una **maqueta que el framework generó** y vos aprobaste en la Fase B2 | `Maqueta-Rules.md` §5, más `Modelos-UX-UI/Rules-Design-Modelo-Template.md` | `SDD/Devs/Modelos-UX-UI/` y su ejemplo en `Templates/` | Un **modelo UX-UI** |
| De **algo externo**: una app existente, un producto ajeno, un sistema legado, un diseño que te pasaron | `Rules-Base-Conocimiento.md` | `Conocimiento/` | Un **documento de conocimiento** |

**El criterio es el origen, no el parecido del resultado.** Los dos producen reglas de diseño reusables y los dos usan nombres agnósticos del dominio —`Panel-Operativo-Denso` sí, `Panel-Cliente-Acme` no—, así que se confunden fácil. Pero un modelo UX-UI es **la capitalización de una salida del propio framework**, con su ejemplo ejecutable y su lugar en la Fase B2; un documento de conocimiento caracteriza **algo que el framework no gobierna**.

**Para el caso de las capturas, que por definición vienen de afuera: el camino es el segundo.**

Pasos, en concreto:

1. Ejecutar `PROMPTs/Features/16-Relevar-Conocimiento/Relevar-Conocimiento.md` con:
   - `que_capturar`: las características de diseño de las pantallas
   - `de_donde`: la ruta de las capturas
   - `framework`: la raíz de `IA.SDD`
2. En el paso de orientación, declarar **`propio`** como naturaleza —un diseño concreto no tiene nombre canónico en la industria— y **03** como consumidor.
3. En el relevamiento, lo que hay que extraer de una captura son **reglas accionables, no descripciones**. El criterio ya está escrito y conviene reusarlo tal cual: una regla entra **si su ausencia haría que un diseño posterior salga distinto de forma perceptible** (`SDD-User-Guide.md`, sección de captura de modelos). Una captura no dice «hay un botón azul»: dice qué jerarquía visual, qué densidad, qué patrón de navegación y qué tratamiento de estados sostiene.
4. **La compuerta de ofuscación es bloqueante**, y en capturas es donde más se filtra: nombres de cliente en encabezados, datos reales en tablas, logos. Se declara término por término, con los falsos positivos léxicos enumerados.
5. Alta en `Conocimiento/` con su fila en `Index-Knowledge.md`, y las obligaciones de intervención sobre el framework.

**Una cosa a mirar y que este prompt no resuelve solo.** Los dos catálogos comparten convención de nombres y territorio —diseño de interfaz—, y hoy nada declara la frontera entre ellos de forma citable. **Es un hallazgo para la mesa**: si la frontera no está escrita, alguien va a poner un documento en el catálogo equivocado, y la evidencia de que pasa es que hubo que escribir esta tabla para contestarlo.

---

## Reglas

- No inventar información.
- Toda afirmación deberá estar respaldada por evidencias verificables, citando archivo y línea.
- Ninguna guía redefine lo que un archivo de reglas ya declara. Lo cita.
- El framework tiene que seguir funcionando con `Conocimiento/` vacía. Cualquier redacción que sugiera lo contrario es un defecto.
- Toda escritura sobre `IA.SDD` es una intervención: nota de coherencia, `CHANGELOG.md` y copia a `_legacy/` tomada **antes** de editar.
