# Bundle JavaScript en una solución .NET con Blazor — la costura, sus dos artefactos y sus dos anfitriones

**Alias:** Bundle-JS
**Naturaleza:** propio
**Tema:** Proyecto de código JavaScript/TypeScript que emite un bundle agnóstico y una capa de interop (`main.js`), consumido por una biblioteca de clases Razor dentro de una solución .NET: contrato entre los dos lenguajes, cadena de construcción, anfitrión HTML sin .NET y anfitrión Blazor mínimo como instrumentos de diagnóstico
**Consumidor:** 05, 08, 09, 10
**Condicion-de-carga:** proyecto de código de ecosistema JavaScript cuyo artefacto carga un proyecto .NET con interfaz Blazor, por insumo de construcción o dentro del mismo proyecto de código
**Hereda-de:** —
**Sustituye:** —
**Compatible-con:** Rules-Base-Conocimiento.md 2.2
**Versión:** 1.0
**Estado:** Vigente
**Fecha:** 2026-09-13

---

## 0. Propósito y alcance

**Qué caracteriza.** La **costura** entre un proyecto de código JavaScript/TypeScript y la biblioteca de clases Razor (RCL) que lo carga, con los dos anfitriones que la verifican desde lados opuestos: una página HTML sin .NET y una app Blazor mínima. Es un solo artefacto: el contrato se declara de los dos lados, el nombre del callback vive en los dos y el mismo fixture recorre los tres instrumentos de verificación.

**Para qué sirve.** Para que un agente —de este framework o de otro con distinta estructura— pueda crear las cuatro piezas (proyecto del bundle, anfitrión HTML, RCL, anfitrión Blazor) y **diagnosticar una falla de contrato** leyendo sólo este documento.

**Método y artefacto.** Lo que se suele pedir como «metodología» de diseño, integración y diagnóstico entra acá de dos formas: el **procedimiento de cambio coordinado del contrato** (§3.4) y la **matriz de diagnóstico** (§6.3). El método del framework —qué documentos se generan, cómo se aceptan, cómo se numeran— **no** vive acá (§8).

### 0.1 Frontera con la estructura de la solución

| Adentro de este documento | Afuera: lo decide el framework que lo adopta |
|---|---|
| Layout interno del proyecto del bundle, de la RCL y de cada anfitrión | Carpetas de la solución (`/src`, `/samples`, `/demos`, `/tests`) |
| El contrato entre los dos lenguajes y su procedimiento de cambio | Nombre y agrupador de la solución; nombres de proyecto |
| Qué instrumento prueba qué y con qué aserción | Cantidad, nombre y numeración de los samples; su contrato de verificación y sus identificadores |
| Cadena de construcción como propiedades y síntomas | Dónde se archiva la documentación del contrato |

**Toda ruta de este documento es ilustrativa, salvo las internas de cada pieza.** Las piezas se nombran por rol y por arista, nunca por ubicación. Un framework que pone sus pruebas de concepto en `/demos` las pone en `/demos`.

### 0.2 Equivalencias de vocabulario

Para un lector de otro framework. El término de la izquierda aparece sólo en la cabecera y en §8.

| Término de este framework | Qué designa, en palabras neutras |
|---|---|
| Proyecto de código | Unidad que se compila con sus propias dependencias (un `.csproj`, un `package.json`) |
| Unidad de entrega · tipo D8 | Lo que se despliega o publica, y su forma (`web-monolith`, `library`, …) |
| Solución de código | Lo que un único comando de construcción toma como entrada |
| Insumo de construcción | Un proyecto toma como entrada de su construcción el artefacto que genera otro, sin referenciarlo |
| Único generador | El proyecto cuya construcción ejecuta la del productor; los demás consumen su salida |
| Sample · categoría 10 · anfitrión mínimo | Código ejecutable que demuestra el uso y verifica un contrato; acá: los dos anfitriones |
| Maqueta de la Fase B2 | Prototipo HTML sin build para validar experiencia; **no** es el anfitrión HTML |

### 0.3 Qué queda afuera

| Qué | Dónde vive |
|---|---|
| Estructura de la solución y ubicación de los anfitriones | Framework que adopta el documento |
| Publicar la RCL como paquete NuGet, o el bundle como paquete npm con versión propia (solución propia, consumo de artefacto publicado) | Documento hermano futuro; este caso no se publica aparte |
| Un bundle que integra una API de terceros con clave y carga remota | Documento hermano futuro, con especialista de seguridad |
| El dominio que el bundle dibuja | El producto |
| La maqueta de validación visual | Reglas de maqueta del framework |
| Investigación con caja temporal (*spike*) | Backlog técnico del producto |

**§5 supera el techo por sí sola**: son once esqueletos de dos lenguajes que no se pueden partir sin separar los dos lados del contrato. El resto del documento está bajo 600 líneas. Es la excepción que `Rules-Base-Conocimiento.md` §6.2 admite.

**Verificación de ofuscación.** El relevamiento salió de dos productos reales de un mismo taller. Se buscaron y **no aparecen** en el documento: los nombres de los dos productos y de sus proyectos, los nombres de sus componentes y de sus archivos de bundle, el prefijo de clases CSS, la familia de códigos de error, los nombres de sus métodos invocables, sus identificadores de casos de uso, reglas, tareas y decisiones, y sus nombres de dominio. Falsos positivos léxicos declarados: «mapa» (sustantivo genérico del ejemplo), «Contoso» (organización ficticia de las plantillas del framework), «Aplicada» (prefijo de organización por defecto del framework).

## 1. Identidad del artefacto

| | |
|---|---|
| **Qué es** | Un proyecto de código del ecosistema npm, fuente TypeScript, **sin dependencias de ejecución**, que emite dos artefactos; y una RCL que los sirve y los envuelve en un componente |
| **Stack verificado** | .NET con Blazor en render mode **Interactive Server**; Node 22; TypeScript 5.9; esbuild 0.25. WebAssembly y Auto **no están verificados**: la interoperabilidad es sincrónica disponible, no hay circuito que se caiga, y parte de §3.3 no aplica |
| **Supuestos** | Node es requisito de **construcción**, no de ejecución; el navegador soporta módulos ES; el registro de estáticos de §3.5 se midió con el SDK .NET que declara §5.7 |

### 1.1 Vocabulario que fija el documento

| Término | Qué es | Lo produce | Lo carga |
|---|---|---|---|
| **Bundle** | Artefacto que dibuja y opera sobre el DOM. **Agnóstico del anfitrión**: no conoce Blazor ni .NET; recibe callbacks planos | El proyecto del bundle, empaquetado | `main.js`, y el guion anfitrión de la PoC HTML si prueba el bundle solo |
| **`main.js`** o **capa de interop** | Segundo artefacto de la **misma construcción**. Importa el bundle, recibe la referencia .NET y es **el único archivo que conoce `invokeMethodAsync`** | El proyecto del bundle, transpilado sin empaquetar | La RCL por `import`; la PoC HTML con un doble de la referencia |
| **Punto de entrada** | Archivo fuente raíz de cada artefacto. Uno por artefacto | — | — |
| **Guion anfitrión** | Script de cada PoC que hace de consumidor. **No es artefacto** del proyecto del bundle | Cada PoC | Su página |
| **PoC HTML** | Página sin .NET que invoca `main.js` exactamente como lo hace la RCL, con un doble de la referencia .NET | — | — |
| **PoC Blazor** | App mínima que referencia la RCL, muestra el componente y **captura el viaje de ida y vuelta** | — | — |

## 2. Estructura

### 2.1 Piezas por rol y arista

| Pieza | Rol | Arista hacia |
|---|---|---|
| Proyecto del bundle | Productor de los dos artefactos | — (no referencia nada) |
| RCL | Generador único: su construcción ejecuta la del bundle y emite los artefactos a sus estáticos | Proyecto del bundle, por **insumo de construcción** |
| App del producto | Consumidor | RCL, por referencia de proyecto |
| PoC Blazor | Consumidor mínimo | RCL, por referencia de proyecto. **No** vuelve a construir el bundle |
| PoC HTML | Anfitrión sin .NET | Salida de construcción del productor. **No** se construye con la solución |

### 2.2 Dos formas de componer, dentro de una solución

| | **F2 — proyecto hermano** (se presenta primero) | **F1 — cadena dentro de la RCL** (variante) |
|---|---|---|
| Dónde vive el TypeScript | Proyecto propio con su `package.json` | Carpeta de fuentes dentro del proyecto Razor |
| Proyectos de código | Dos: bundle y RCL | Uno |
| Arista | Insumo de construcción, generador RCL | Ninguna nueva |
| Quién copia la salida a `wwwroot/` de la RCL | El target de la RCL, en el mismo comando | El empaquetador escribe directo ahí |
| Pruebas del bundle | Del proyecto del bundle | Del proyecto Razor |
| Delta en el esqueleto de §5.7 | — | `BundleDir` apunta a la propia carpeta; sin copia; mismo registro de estáticos |

El criterio de elección está en §4.

### 2.3 Layout interno del proyecto del bundle

| Archivo | Rol | Se versiona |
|---|---|---|
| `src/contrato.ts` | Tipos del contrato del lado JS. No importa nada | Sí |
| `src/mapa.ts` | Punto de entrada del bundle: registro por contenedor y superficie plana | Sí |
| `src/main.ts` | Punto de entrada de la capa de interop | Sí |
| `src/*.test.ts` | Batería sin anfitrión, junto a la fuente | Sí |
| `package.json`, `package-lock.json` | Scripts `build`/`test`; herramientas con versión exacta | Sí |
| `tsconfig.json` | Tipado estricto, `noEmit` | Sí |
| `tsconfig.pruebas.json` | Emite las pruebas a `build/` para el runner del runtime | Sí |
| `dist/mapa.js`, `dist/main.js` | Salida de construcción | **No** |
| `build/`, `node_modules/` | Salida de pruebas, dependencias | **No** |

### 2.4 Layout interno de la RCL

| Archivo | Rol | Se versiona |
|---|---|---|
| `Contrato.cs` | Tipos del contrato del lado .NET, hermanos de `contrato.ts`. No importa nada | Sí |
| `<Componente>.razor` | Envoltorio: sostiene el ciclo de vida de los dos lados. **No dibuja nada** | Sí |
| `<Proyecto>.csproj` | SDK Razor; targets de la cadena de §3.5 | Sí |
| `wwwroot/js/mapa.js`, `wwwroot/js/main.js` | Salida del generador. Se sirven bajo `_content/<PackageId>/js/` | **No** |
| Hoja de estilos del componente | Variables con valor por defecto que el anfitrión remapea | Fuente sí; copia en `wwwroot/` no |

### 2.5 Layout interno de cada anfitrión

| PoC HTML | PoC Blazor |
|---|---|
| `index.html` que carga `main.js` desde la **salida del productor**, servida | Proyecto de app con referencia a la RCL |
| `anfitrion.js`: guion anfitrión con el **doble** de la referencia .NET | Una página con el componente, render mode declarado |
| `fixture/` con los JSON capturados por la PoC Blazor | Captura del viaje: el DTO que salió y el acuse que volvió |
| README: cómo se sirve, qué se espera ver | README: cómo se corre, dónde queda la captura |

## 3. Contrato de uso

### 3.1 El contrato entre los dos lenguajes

| Regla | Cómo | Qué se rompe si se ignora |
|---|---|---|
| **Una declaración de cada lado** | `contrato.ts` y `Contrato.cs`, mismos nombres y formas; ninguno importa al otro | Un lado generado del otro ata los dos toolchains; un tercer archivo «de referencia» deriva |
| **Nombres** | PascalCase en C#, camelCase en TS. La correspondencia la da la serialización de la interoperabilidad de Blazor, que emite camelCase y lee sin distinguir mayúsculas por omisión | Un `JsonPropertyName` de un solo lado, o una política propia, deja campos en `null` sin error |
| **Conjuntos cerrados** | Uniones de literales en TS; constantes de cadena en C# | Ver §4: un `enum` numérico cruza como entero |
| **Ausencia** | **Una sola regla**: todo campo que .NET puede emitir nulo se declara `T \| null` en TS. Nunca `?:` para un campo que llega `null` | Dos anfitriones con formas distintas del mismo campo pasan los dos |
| **Versión** | Campo `version` en el DTO raíz, mismo literal de los dos lados, **comparado** por §6. Mientras bundle y RCL se construyen juntos, la versión va con el producto. El comportamiento ante versión desconocida se declara recién cuando se publique alguna de las dos piezas por separado | Un campo decorativo que no se compara |
| **Superficie exportada = contrato** | Cada punto de entrada exporta sólo las operaciones del contrato. Nada de `export *` de módulos internos | El anfitrión empieza a invocar internos que el contrato no declara |
| **Callback con nombre literal de los dos lados** | `[JSInvokable("AlActivar")]` en C# y `metodo = "AlActivar"` como valor por omisión en `main.js` | **Ninguna compilación lo verifica**: si difiere, el acuse deja de llegar sin error |

**La costura se verifica sólo en ejecución.** C# y TypeScript no compilan uno contra el otro; que el tipado de cada lado pase no dice nada del otro lado. Es por eso que existen el fixture de §3.6 y la PoC Blazor.

### 3.2 Superficie de cada artefacto

| Artefacto | Exporta | Recibe | Emite |
|---|---|---|---|
| Bundle | `montar(contenedor, opciones)`, `render(contenedor, vista)`, `destruir(contenedor)` | Contenedor del DOM; vista completa | Callback plano `alActivar(acuse)` |
| `main.js` | `montar(contenedor, referenciaDotNet, metodo?)`, `render`, `destruir` | La referencia .NET tipada **estructuralmente** (`{ invokeMethodAsync(...) }`), sin importar nada de Blazor | `referencia.invokeMethodAsync(metodo, acuse)`, con el rechazo capturado |

- **Instancias por contenedor.** El bundle guarda cada instancia en un `WeakMap` indexado por el elemento. Toda función recibe el contenedor. .NET trabaja siempre contra la referencia al elemento.
- **`montar` es idempotente.** Sobre un contenedor ya montado, destruye la instancia anterior.
- **Render completo.** Cada cambio es una vista entera; no hay mutadores parciales.
- **`destruir`** desregistra cada escucha, vacía el contenedor y borra la entrada del registro.
- **Documento del contenedor.** El bundle toma `contenedor.ownerDocument` y nunca el `document` global: es lo que permite probarlo sin navegador.
- **Frontera hacia adentro.** El bundle no hace peticiones, no accede a almacenamiento y no importa nada fuera de su proyecto.

### 3.3 Ciclo de vida del envoltorio Razor

| Paso | Dónde | Qué |
|---|---|---|
| 1 | `OnAfterRenderAsync(firstRender)` | `import` de `./_content/<PackageId>/js/main.js`. **Nunca** en `OnInitialized*` ni `OnParametersSet*`: durante el prerenderizado no hay navegador y la llamada lanza `InvalidOperationException` |
| 2 | Mismo método, después del import | `DotNetObjectReference.Create(this)` y `montar(elemento, referencia)` |
| 3 | Cada render con vista | `render(elemento, vista)` |
| 4 | `[JSInvokable("AlActivar")]` | Recibe el acuse y lo pasa a un `EventCallback` |
| 5 | `DisposeAsync` | En orden: `destruir(elemento)`; `IJSObjectReference.DisposeAsync()`; `DotNetObjectReference.Dispose()`. Los dos primeros dentro de `try/catch (JSDisconnectedException)`; el tercero **siempre**, fuera del `try` |

**Del lado JS**, `invokeMethodAsync` devuelve una promesa que se rechaza cuando el circuito no está: `main.js` la captura.

**Obligaciones del anfitrión** que la RCL no puede asumir:

| Obligación | Síntoma si falta |
|---|---|
| Declarar el render mode interactivo en la página o el componente | El componente se pinta y nunca llama al JS |
| Enlazar la hoja del componente en el `<head>` del documento raíz (`_content/<PackageId>/…`) | Primer dibujo sin estilos |
| Referenciar la RCL | 404 en `_content/<PackageId>/…` |
| Si la página es estática, pasar al componente interactivo **sólo parámetros serializables**; el `EventCallback` se consume adentro de la isla interactiva | Error en ejecución al pasar un delegado |

La higiene general del circuito (`IAsyncDisposable`, `EventCallback` hijo → padre) vive en el documento hermano de §9 y no se repite.

### 3.4 Procedimiento de cambio coordinado del contrato

Es lo que un agente sigue cuando cambia o **autoajusta** el contrato, o cuando diagnostica que se rompió.

| # | Paso | Instrumento que lo cierra |
|---|---|---|
| 1 | Editar `contrato.ts` y `Contrato.cs` en el **mismo cambio**; si cambia un nombre de callback, los dos literales | `tsc --noEmit` y `dotnet build`: sólo prueban cada lado |
| 2 | Ajustar bundle y `main.js` | Batería sin anfitrión (§6.1) |
| 3 | Correr la PoC Blazor y **regenerar el fixture** con la captura del viaje | Aserción del viaje (§6.2) |
| 4 | Correr la batería contra el fixture nuevo | Batería con fixture (§3.6) |
| 5 | Abrir la PoC HTML con el fixture nuevo | Doble de la referencia registra lo recibido |
| 6 | Si algún paso falla, leer la matriz de §6.3 **antes** de tocar código | — |

Un cambio que salta el paso 3 deja un fixture viejo, y la PoC HTML y la batería siguen verdes contra un contrato que ya no es el que corre.

### 3.5 Cadena de construcción

| Propiedad | Por qué | Síntoma si falta |
|---|---|---|
| **Un comando** construye el producto entero, bundle incluido | Un paso previo que alguien tiene que recordar se olvida | Clon limpio: consumidor sin bundle, build verde |
| Versión de Node declarada **en un solo lugar** y **comparada**, no sólo su presencia | Otra versión puede no arrancar el empaquetador o emitir otro bundle | Mensaje del empaquetador que no nombra la versión |
| `npm ci` contra archivo de bloqueo; herramientas con versión exacta | Instalación reproducible | Dos máquinas, dos bundles del mismo commit |
| `Inputs`/`Outputs` con **todas** las fuentes: `.ts`, bloqueo y configuración del compilador y del empaquetador | Incrementalidad | Bundle viejo con build verde |
| **El artefacto generado entra al manifiesto de estáticos en el primer build desde limpio** | Los ítems se evalúan antes de que corra cualquier target: escribir un archivo en `wwwroot/` durante el build no alcanza | **404 en `_content/…/main.js` con build verde, que desaparece en el segundo build.** Salida medida en §5.7 |
| Modo de construcción **nombrado** donde falta la cadena JS, que recibe los artefactos de otra etapa; o falla que nombra la cadena | Un ambiente sin Node no puede entregar el consumidor sin su insumo | Publicación sin bundle |
| Higiene del proyecto mixto: `node_modules/**` fuera de los ítems; `package*.json` y `tsconfig*` fuera de `Content` | Miles de ítems; configuración publicada | Build lento; artefacto con insumos de construcción |
| Nada de salida versionado | La salida se reconstruye | Artefacto desincronizado de su fuente |
| Caché: sello del contenido o huella de estáticos del marco en la URL del `import` | El nombre no cambia entre construcciones | «El cambio no se ve» con build verde |

La auditoría de dependencias de la cadena JS es de la regla de supply chain del framework (§8), no de este documento.

### 3.6 El fixture: un instrumento, tres consumidores

| Quién | Qué hace con el fixture |
|---|---|
| **PoC Blazor** | Lo **produce**: su página vuelca el DTO que pasó por el serializador de la interoperabilidad y el acuse que volvió |
| **Batería sin anfitrión** | Lo **consume**: lo pasa a `render` y a `activar` sobre un contenedor de prueba y afirma el acuse. Valida con el código del propio bundle, sin una tercera declaración de tipos y sin navegador |
| **PoC HTML** | Lo **consume**: lo carga como vista y el doble registra lo que `main.js` invoca |

**Por qué no se valida importando el JSON contra el tipo TS.** Un módulo JSON importado se tipa con cadenas ensanchadas a `string`, que no se asignan a uniones de literales: la compuerta de tipos rechazaría un fixture válido.

## 4. Decisiones ya tomadas

| Bifurcación | Resuelta | Criterio | Alternativa |
|---|---|---|---|
| Composición | **F2 primero**, F1 variante | F2 es la forma que describe la pertenencia por insumo de construcción y separa pruebas y cadena por proyecto | F1: un solo proyecto, contrato y envoltorio juntos, al costo de cargar la cadena JS en el proyecto Razor. Elegila si el bundle nunca se prueba ni se mueve fuera de la RCL |
| Artefactos | **Dos de la misma construcción**: bundle agnóstico y `main.js` | El bundle se prueba y se reutiliza sin .NET; la PoC HTML invoca literalmente lo que invoca Blazor | Un solo módulo con dos funciones de montaje (`montar` y `montarConInterop`): un esqueleto menos, el bundle conoce la referencia .NET |
| Apertura de la PoC HTML | **Servida** por un servidor estático, módulo ES | Carga **el mismo archivo** que importa la RCL | Sin servidor: un módulo ES no carga desde `file://`, y hace falta una salida global de la misma construcción (`esbuild src/main.ts --bundle --format=iife --global-name=<Nombre>`). Un producto de origen eligió esto para su maqueta, sin llegar a emitirla |
| Lenguaje | **TypeScript** con `tsc --noEmit` antes de empaquetar | El tipado de cada lado es la mitad de la guardia | JavaScript plano: cero dependencias de desarrollo; sin tipo del lado JS, **el fixture es la única guardia**; no hay `.d.ts` porque no hay de dónde generarlo |
| Conjuntos cerrados | **Cadenas** | Cruzan a JSON sin conversión; el conjunto lo fija el contrato | `enum` con el serializador configurado para emitir nombres: correcto, pero hay que configurarlo de los dos lados de cada proyecto |
| Instancias | **Por contenedor** en el módulo | Una sola API sirve a la PoC HTML y a Blazor | Devolver la instancia como `IJSObjectReference` y sostenerla en .NET: posible, pero la PoC HTML necesita otra superficie |
| Salidas del bundle | **Callback plano** | Es el canal que `main.js` adapta y que las dos PoC ejercitan | `CustomEvent` burbujeante: salida adicional para anfitriones sin interop; **ninguna PoC lo toma como aserción** |
| Empaquetador | **Minimalista** | Sin dependencias de ejecución, sin cargadores que configurar | Uno de propósito general: justificado cuando el bundle tiene dependencias de ejecución |
| Pruebas del bundle | **Junto a la fuente**, runner del runtime | Sin biblioteca de pruebas ni DOM simulado | Carpeta aparte: si el framework adoptante lo fija, rige el framework |

## 5. Esqueletos de referencia

Nombres neutros: organización `Contoso`, producto `Reservas`, componente `Mapa`. Probados en la forma que indica cada título.

### 5.1 `package.json` y `tsconfig.json` del proyecto del bundle

```json
{
  "name": "contoso-reservas-mapa",
  "version": "0.0.0",
  "private": true,
  "type": "module",
  "scripts": {
    "build": "tsc --noEmit && esbuild src/mapa.ts --bundle --format=esm --outfile=dist/mapa.js && esbuild src/main.ts --format=esm --outfile=dist/main.js",
    "test": "tsc -p tsconfig.pruebas.json && node --test build/*.test.js"
  },
  "devDependencies": {
    "@types/node": "22.20.1",
    "esbuild": "0.25.12",
    "typescript": "5.9.3"
  }
}
```

`main.js` se transpila **sin** `--bundle`: conserva `import … from "./mapa.js"` y no duplica el bundle. En el navegador, `./mapa.js` se resuelve relativo a `_content/<PackageId>/js/main.js`.

```json
{
  "compilerOptions": {
    "target": "ES2022", "module": "ESNext", "moduleResolution": "bundler",
    "strict": true, "noUncheckedIndexedAccess": true, "exactOptionalPropertyTypes": true,
    "noEmit": true
  },
  "include": ["src"],
  "exclude": ["src/**/*.test.ts"]
}
```

`tsconfig.pruebas.json` emite fuente y pruebas a `build/`, que no se versiona ni se empaqueta:

```json
{
  "extends": "./tsconfig.json",
  "compilerOptions": { "noEmit": false, "rootDir": "src", "outDir": "build" },
  "include": ["src"],
  "exclude": []
}
```

### 5.2 Contrato, de los dos lados

```ts
// src/contrato.ts — hermano de Contrato.cs. No se importan: si uno cambia, cambian los dos (§3.4).
export type EstadoCelda = "libre" | "ocupada";

export interface CeldaDto { id: number; fila: number; columna: number; estado: EstadoCelda; etiqueta: string | null }
export interface VistaDto { version: 1; celdas: CeldaDto[] }

export interface AcuseDeActivacion {
  tipo: "celda-activada";
  id: number;
  estado: EstadoCelda | null;      // null: la vista no traía esa celda
  momento: string;                  // ISO 8601, hora del cliente
}

export interface OpcionesDeMontaje { alActivar?: (acuse: AcuseDeActivacion) => void }
```

```csharp
// Contrato.cs — hermano de contrato.ts. PascalCase acá, camelCase allá: lo resuelve la serialización de la interop.
namespace Contoso.Reservas.Mapa;

public static class EstadoCelda
{
    public const string Libre = "libre";
    public const string Ocupada = "ocupada";
}

public sealed record CeldaDto(int Id, int Fila, int Columna, string Estado, string? Etiqueta);

public sealed record VistaDto(IReadOnlyList<CeldaDto> Celdas)
{
    public int Version { get; init; } = 1;
}

public sealed record AcuseDeActivacion(string Tipo, int Id, string? Estado, string Momento);
```

### 5.3 Bundle: `src/mapa.ts`

```ts
import type { AcuseDeActivacion, OpcionesDeMontaje, VistaDto } from "./contrato.js";

interface Instancia { opciones: OpcionesDeMontaje; vista: VistaDto | null; alClic: (e: Event) => void }

// Indexadas por contenedor: el anfitrión nunca sostiene la instancia.
const instancias = new WeakMap<HTMLElement, Instancia>();

export function montar(contenedor: HTMLElement, opciones: OpcionesDeMontaje = {}): void {
  destruir(contenedor);                                   // idempotente
  const alClic = (e: Event) => {
    const id = Number((e.target as HTMLElement).closest("[data-celda]")?.getAttribute("data-celda"));
    if (Number.isFinite(id)) activar(contenedor, id);
  };
  contenedor.addEventListener("click", alClic);
  instancias.set(contenedor, { opciones, vista: null, alClic });
}

export function render(contenedor: HTMLElement, vista: VistaDto): void {
  const i = instancias.get(contenedor);
  if (!i) return;
  i.vista = vista;                                        // render completo, sin mutadores parciales
  const doc = contenedor.ownerDocument;                  // nunca el document global
  contenedor.replaceChildren(...vista.celdas.map((c) => {
    const el = doc.createElement("button");
    el.setAttribute("data-celda", String(c.id));
    el.setAttribute("data-estado", c.estado);
    el.textContent = c.etiqueta ?? String(c.id);
    return el;
  }));
}

export function activar(contenedor: HTMLElement, id: number): void {
  const i = instancias.get(contenedor);
  if (!i) return;
  const celda = i.vista?.celdas.find((c) => c.id === id);
  const acuse: AcuseDeActivacion = { tipo: "celda-activada", id, estado: celda?.estado ?? null, momento: new Date().toISOString() };
  i.opciones.alActivar?.(acuse);
}

export function destruir(contenedor: HTMLElement): void {
  const i = instancias.get(contenedor);
  if (!i) return;
  contenedor.removeEventListener("click", i.alClic);
  contenedor.replaceChildren();
  instancias.delete(contenedor);
}
```

### 5.4 Capa de interop: `src/main.ts`

```ts
import { montar as montarBundle, render, destruir, activar } from "./mapa.js";

// Tipada por forma: no importa nada de Blazor, y la PoC HTML le pasa un doble.
export interface ReferenciaDotNet { invokeMethodAsync(metodo: string, ...args: unknown[]): Promise<unknown> }

// "AlActivar" es el mismo literal que [JSInvokable("AlActivar")] en el envoltorio. Ninguna compilación lo verifica.
export function montar(contenedor: HTMLElement, referencia: ReferenciaDotNet, metodo = "AlActivar"): void {
  montarBundle(contenedor, {
    alActivar: (acuse) => {
      referencia.invokeMethodAsync(metodo, acuse).catch(() => { /* circuito caído: el anfitrión ya no escucha */ });
    },
  });
}

export { render, destruir, activar };
```

### 5.5 Envoltorio Razor

```razor
@using Microsoft.JSInterop
@implements IAsyncDisposable
@inject IJSRuntime Js

<div @ref="_contenedor" class="mapa"></div>

@code {
    private ElementReference _contenedor;
    private IJSObjectReference? _modulo;
    private DotNetObjectReference<Mapa>? _referencia;

    [Parameter] public VistaDto? Vista { get; set; }
    [Parameter] public EventCallback<AcuseDeActivacion> AlActivarCelda { get; set; }

    protected override async Task OnAfterRenderAsync(bool primeraVez)
    {
        if (primeraVez)
        {
            // La ruta es un literal del contrato: cambia si cambia el PackageId.
            _modulo = await Js.InvokeAsync<IJSObjectReference>("import", "./_content/Contoso.Reservas.Mapa/js/main.js");
            _referencia = DotNetObjectReference.Create(this);
            await _modulo.InvokeVoidAsync("montar", _contenedor, _referencia);
        }

        if (_modulo is not null && Vista is not null)
        {
            await _modulo.InvokeVoidAsync("render", _contenedor, Vista);
        }
    }

    // Mismo literal que el valor por omisión de main.js.
    [JSInvokable("AlActivar")]
    public Task RecibirAcuse(AcuseDeActivacion acuse) => AlActivarCelda.InvokeAsync(acuse);

    public async ValueTask DisposeAsync()
    {
        if (_modulo is not null)
        {
            try
            {
                await _modulo.InvokeVoidAsync("destruir", _contenedor);
                await _modulo.DisposeAsync();
            }
            catch (JSDisconnectedException)
            {
                // Sin circuito no hay navegador al que pedirle nada.
            }
        }

        _referencia?.Dispose();
    }
}
```

### 5.6 Batería sin anfitrión que consume el fixture

```ts
// src/fixture.test.ts — corre con node --test, sin DOM ni navegador.
import { test } from "node:test";
import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import { montar, render, activar, destruir } from "./mapa.js";

// Doble mínimo de contenedor: sólo lo que el bundle usa.
function contenedor() {
  const escuchas = new Set<unknown>();
  const doc = { createElement: () => ({ setAttribute() {}, textContent: "" }) };
  return {
    ownerDocument: doc, replaceChildren() {},
    addEventListener: (_: string, f: unknown) => escuchas.add(f),
    removeEventListener: (_: string, f: unknown) => escuchas.delete(f),
    escuchas,
  } as unknown as HTMLElement & { escuchas: Set<unknown> };
}

test("el fixture capturado por la PoC Blazor produce el acuse esperado", () => {
  const { vista, acuse } = JSON.parse(readFileSync("fixture/viaje.json", "utf8"));
  const c = contenedor();
  let recibido: unknown = null;
  montar(c, { alActivar: (a) => { recibido = a; } });
  render(c, vista);
  activar(c, acuse.id);
  assert.deepEqual({ ...(recibido as object), momento: undefined }, { ...acuse, momento: undefined });
  destruir(c);
  assert.equal(c.escuchas.size, 0);
});
```

### 5.7 Proyecto Razor generador (F2)

Medido en SDK .NET 10.0.400 sobre un producto F1: sin el target de declaración, el primer build desde limpio genera el archivo y no lo registra en `staticwebassets.build.json`; el segundo sí. Con el target, lo registra en el primero y el segundo no duplica el ítem. Con otro SDK, repetir la medición (§6.1 criterio 10) antes de confiar en la receta.

```xml
<Project Sdk="Microsoft.NET.Sdk.Razor">

  <PropertyGroup>
    <TargetFramework>net10.0</TargetFramework>
    <ImplicitUsings>enable</ImplicitUsings>
    <Nullable>enable</Nullable>
    <PackageId>Contoso.Reservas.Mapa</PackageId>
    <BundleDir>$(MSBuildThisFileDirectory)../contoso-reservas-mapa/</BundleDir>
    <NodeMayorRequerida>22</NodeMayorRequerida>
    <SinCadenaJs Condition="'$(SinCadenaJs)' == ''">false</SinCadenaJs>
  </PropertyGroup>

  <ItemGroup>
    <FuenteBundle Include="$(BundleDir)src/**/*.ts;$(BundleDir)package-lock.json;$(BundleDir)tsconfig.json" />
    <ArtefactoBundle Include="wwwroot/js/mapa.js;wwwroot/js/main.js" />
    <PackageReference Include="Microsoft.AspNetCore.Components.Web" Version="10.0.0" />
  </ItemGroup>

  <!-- Compara la versión, no sólo la presencia. -->
  <Target Name="VerificarNode" BeforeTargets="ConstruirBundle" Condition="'$(SinCadenaJs)' != 'true'">
    <Exec Command="node -p &quot;process.versions.node.split('.')[0]&quot;" ConsoleToMsBuild="true" ContinueOnError="true">
      <Output TaskParameter="ConsoleOutput" PropertyName="NodeMayor" />
      <Output TaskParameter="ExitCode" PropertyName="NodeSalida" />
    </Exec>
    <Error Condition="'$(NodeSalida)' != '0' Or '$(NodeMayor)' != '$(NodeMayorRequerida)'"
           Text="La construcción necesita Node $(NodeMayorRequerida) (encontrado: '$(NodeMayor)'). Donde no hay cadena JS, construir con -p:SinCadenaJs=true y los artefactos de otra etapa en wwwroot/js/." />
  </Target>

  <!-- Único generador: restaura, empaqueta y copia a sus estáticos en el mismo comando. -->
  <Target Name="ConstruirBundle" BeforeTargets="BeforeBuild"
          Inputs="@(FuenteBundle)" Outputs="@(ArtefactoBundle)" Condition="'$(SinCadenaJs)' != 'true'">
    <Exec Command="npm ci --no-fund" WorkingDirectory="$(BundleDir)" />
    <Exec Command="npm run build" WorkingDirectory="$(BundleDir)" />
    <Copy SourceFiles="$(BundleDir)dist/mapa.js;$(BundleDir)dist/main.js" DestinationFolder="wwwroot/js/" />
  </Target>

  <!-- Declarar el generado DENTRO de un target: estáticamente, no entra al manifiesto en el primer build.
       Exclude="@(Content)": si ya existía al evaluar, el glob de wwwroot/** lo trajo y agregarlo dos veces es error. -->
  <Target Name="DeclararArtefactos" AfterTargets="ConstruirBundle" BeforeTargets="ResolveStaticWebAssetsInputs">
    <Error Condition="!Exists('wwwroot/js/main.js') Or !Exists('wwwroot/js/mapa.js')"
           Text="Faltan los artefactos en wwwroot/js/: la RCL no se entrega sin su insumo de construcción." />
    <ItemGroup>
      <Content Include="@(ArtefactoBundle)" Exclude="@(Content)" />
    </ItemGroup>
  </Target>

</Project>
```

**Delta F1.** `BundleDir` es la carpeta del propio proyecto, el `build` del `package.json` escribe directo a `wwwroot/js/` y se quita el `Copy`. Se agregan `<DefaultItemExcludes>$(DefaultItemExcludes);node_modules/**</DefaultItemExcludes>` y `<Content Remove="package.json;package-lock.json;tsconfig*.json" />`.

### 5.8 PoC HTML

```html
<!-- index.html — se sirve desde la carpeta que contiene esta PoC y el proyecto del bundle
     (npx http-server .. -p 8080, y se abre /<carpeta-de-la-poc>/): servida desde su propia carpeta, ../ da 404. -->
<!doctype html>
<html lang="es">
<head><meta charset="utf-8"><title>PoC HTML — Mapa</title></head>
<body>
  <div id="mapa"></div>
  <pre id="recibido" aria-live="polite"></pre>
  <script type="module" src="./anfitrion.js"></script>
</body>
</html>
```

```js
// anfitrion.js — guion anfitrión. Invoca main.js igual que el envoltorio Razor.
// La ruta apunta a la SALIDA del productor, nunca a una copia en esta carpeta.
import { montar, render } from "../contoso-reservas-mapa/dist/main.js";

const recibido = document.getElementById("recibido");

// Doble de la referencia .NET. Sus nombres invocables salen de una sola fuente: el literal de [JSInvokable].
const referenciaDoble = {
  async invokeMethodAsync(metodo, acuse) {
    recibido.textContent += `${metodo} ${JSON.stringify(acuse)}\n`;
  },
};

const { vista } = await (await fetch("./fixture/viaje.json")).json();
const contenedor = document.getElementById("mapa");
montar(contenedor, referenciaDoble);
render(contenedor, vista);
```

### 5.9 PoC Blazor, reducida a lo que captura el viaje

```razor
@page "/"
@rendermode InteractiveServer
@using System.Text.Json

<Mapa Vista="_vista" AlActivarCelda="Registrar" />

@* Lo que vuelca esta página es el fixture de §3.6. *@
<pre id="viaje">@_viaje</pre>

@code {
    private readonly VistaDto _vista = new([new CeldaDto(1, 0, 0, EstadoCelda.Libre, null),
                                            new CeldaDto(2, 0, 1, EstadoCelda.Ocupada, "B")]);
    private string _viaje = "";

    // Mismas opciones que la interop: camelCase.
    private static readonly JsonSerializerOptions Web = new(JsonSerializerDefaults.Web);

    private void Registrar(AcuseDeActivacion acuse) =>
        _viaje = JsonSerializer.Serialize(new { vista = _vista, acuse }, Web);
}
```

La app anfitriona enlaza la hoja del componente en el `<head>` de su documento raíz (§3.3).

## 6. Criterios de aceptación

Formulados **sobre la costura**. La forma con que el framework adoptante verifica sus samples —comando, criterio, identificador— es suya (§8).

### 6.1 Enumerables

| # | Criterio | Comprobación |
|---|---|---|
| 1 | Toda función que el envoltorio invoca está exportada por `main.js` | Literales de las llamadas **sobre la referencia al módulo** (`_modulo.InvokeVoidAsync("…")`) del `.razor` ⊂ `export` de `src/main.ts`. El `"import"` de `Js.InvokeAsync<IJSObjectReference>` no cuenta |
| 2 | El literal del callback es igual de los dos lados | `grep -o 'JSInvokable("[^"]*")' *.razor` y `grep -o 'metodo = "[^"]*"' src/main.ts` → mismo nombre |
| 3 | La ruta del `import` usa el `PackageId` del proyecto | Segmento de `_content/<X>/` en el `.razor` = `<PackageId>` del `.csproj` |
| 4 | `version` es igual de los dos lados | Literal de `contrato.ts` = valor inicial de `Contrato.cs` |
| 5 | Ningún artefacto de salida está versionado | `git ls-files -- '*/dist/*' '*/wwwroot/js/*.js'` → vacío |
| 6 | La PoC HTML carga la salida del productor | La ruta de `import` de `anfitrion.js` apunta a `dist/` del proyecto del bundle; ninguna copia de `main.js` en la carpeta de la PoC |
| 7 | El bundle no habla con la red ni con el almacenamiento | `grep -c -e 'fetch(' -e XMLHttpRequest -e WebSocket -e localStorage -e sessionStorage src/mapa.ts` → 0 |
| 8 | `main.js` no duplica el bundle | `grep -c 'from "./mapa.js"' dist/main.js` → 1 |
| 9 | La batería corre sin navegador ni .NET | `npm test` → código de salida 0 |
| 10 | El primer build desde limpio registra los artefactos como estáticos | Borrar `bin/`, `obj/` y `wwwroot/js/`; `dotnet build`; `grep -c 'main.js' obj/*/*/staticwebassets.build.json` → mayor que 0 |
| 11 | Un comando construye todo desde limpio | `dotnet build <solución>` → éxito sin paso previo |
| 12 | Montar y destruir N veces no deja escuchas | Prueba de retención de la batería: registrados = desregistrados |

### 6.2 Viaje de ida y vuelta (aserción mínima de la PoC Blazor)

Con la PoC Blazor corriendo: activar una celda. **Criterio:** el acuse llega al `EventCallback` **con todos los campos** y la captura se guarda como `fixture/viaje.json`. El caso de la celda **ausente** (`estado: null`) no se alcanza por la interfaz —el bundle sólo dibuja las celdas de la vista— y lo cubre la batería llamando `activar` con un id que la vista no trae. Se ejecuta con el automatizador de navegador que el framework adoptante tenga; sin automatizador, la ejecución es manual y la captura es la evidencia.

### 6.3 Matriz de diagnóstico

| Batería | PoC HTML | PoC Blazor | Dónde está la falla |
|---|---|---|---|
| Falla | — | — | Bundle |
| Pasa | Falla | — | `main.js`, forma de carga de la PoC, o fixture desactualizado |
| Pasa | Pasa | Falla | Costura .NET: literal del callback, ruta `_content/`, registro de estáticos, ciclo de vida, nombres o ausencia en la serialización |
| Pasa | Pasa | Pasa | Anfitrión real: render mode, hoja de estilos, parámetros no serializables |

| Síntoma | Causa probable | Dónde mirar |
|---|---|---|
| «JavaScript interop calls cannot be issued at this time» | Interop antes de `OnAfterRenderAsync` | §3.3 paso 1 |
| 404 en `_content/…/main.js` con build verde, sólo en el primer build | Artefacto no declarado dentro de un target | §3.5, §5.7 |
| 404 en `_content/…` siempre | RCL sin referenciar o `PackageId` distinto del `import` | §3.3; §6.1 criterio 3 |
| El callback nunca llega, sin error | Literal distinto de un lado, o referencia .NET ya liberada | §6.1 criterio 2 |
| Acuse con campos en `null` | Política de nombres o nombre distinto de un lado | §3.1 |
| `JSDisconnectedException` al cerrar | Falta el `catch` en `DisposeAsync` | §3.3 paso 5 |
| Promesas rechazadas en consola al reconectar | `main.js` no captura el rechazo | §5.4 |
| El cambio no se ve con build verde | Caché del navegador o `Inputs` incompletos | §3.5 |
| Error al pasar un delegado desde una página estática | `EventCallback` fuera de la isla interactiva | §3.3 |

### 6.4 Interpretativos

- [ ] El bundle no conoce Blazor ni .NET; `main.js` es el único que conoce la referencia.
- [ ] El guion anfitrión de la PoC HTML invoca lo mismo que el envoltorio, y nada más.
- [ ] El documento no fija foco ni teclado del DOM que genera el bundle: eso es del método de accesibilidad del destino (§8).

## 7. Anti-patrones

| Anti-patrón | Síntoma | Corrección |
|---|---|---|
| **Copia del bundle mantenida a mano o versionada** en la PoC, en la maqueta o en la app | La PoC valida un componente que ya no es el que corre, y nadie se entera | Cargar la salida del productor (§5.8) |
| *(no es anti-patrón)* **El generador copia la salida a su `wwwroot/`** en el mismo comando, ignorada por el control de versiones | — | Forma válida: es la del único generador (§5.7) |
| Dar la costura por verificada porque «compila» | La falla aparece en ejecución, sin error de build | Fixture y viaje de ida y vuelta (§3.6, §6.2) |
| Tres declaraciones del contrato (dos en código y un `.d.ts` a mano) | Las tres divergen y ninguna prueba lo detecta | Sólo dos, en código |
| `export *` de módulos internos | Superficie mayor que el contrato; anfitriones invocando internos | Exportar sólo el contrato |
| Generar el bundle y declararlo estáticamente como contenido | 404 sólo en el primer build desde limpio | Declararlo dentro de un target (§5.7) |
| Dos generadores del mismo artefacto (RCL y app, o RCL y PoC) | Dos bundles que nadie garantiza iguales | Un generador; los demás consumen su salida |
| Interop en `OnInitializedAsync` | Excepción durante el prerenderizado | `OnAfterRenderAsync(firstRender)` |
| `catch (Exception)` en `DisposeAsync` | Esconde fallos reales del descarte | Sólo `JSDisconnectedException` |
| Prueba del envoltorio que invoca el `EventCallback` directamente y se presenta como prueba de la costura | Verde con el literal del callback roto | Es prueba del componente, no de la costura |
| Prueba del bundle que lee archivos del proyecto .NET | La batería falla al mover el bundle | La batería sólo alcanza su proyecto |
| Otros, sin síntoma propio: `npm install` en la construcción; versión de Node no comparada; `document` global; validar en JS lo que .NET ya validó; enganchar la verificación de una PoC a la construcción de la solución | — | §3.2, §3.5 |

## 8. Frontera con las reglas

**Qué es normativo en el Framework SDD y este documento cita sin redefinir:**

| Tema | Regla |
|---|---|
| A qué solución pertenece el proyecto del bundle; clases de arista; único generador | `Intake-Rules.md` §4 |
| Modo de construcción donde falta la cadena de un ecosistema; coordinación por arista | `Rules-Devops.md` §4.9 punto 4 |
| Forma del sample de un artefacto que otro proyecto carga (anfitrión mínimo); cómo entra al agrupador; verificación nunca enganchada a la construcción | `Rules-Examples.md` §3.6 |
| Contrato de verificación de un sample | `Rules-Examples.md` §4.6 |
| Clases de contrato entre unidades y entre proyectos | `PRODUCT-INTAKE-template.md` §14 |
| Supply chain de la cadena JS | `Rules-Devops.md` §4.2 y §4.6 |
| Accesibilidad del DOM que el bundle genera | Método de la categoría 03 del destino. **El bundle no lo esquiva por estar en otro lenguaje** |

**Huecos que el documento llena sin normar:**

- **Clase de la costura.** Es un contrato **de compilación** por su lugar en el grafo, pero **se verifica en ejecución** por su mecánica. El framework no tiene clase para esa cara.
- **Documentación del contrato en `web-monolith`.** La categoría 05 no obliga a documentarlo, porque no expone API externa. El documento lo describe en §3; dónde se archiva lo decide el destino.
- **Interoperabilidad .NET ↔ JavaScript.** Ciclo de vida, `_content/` y prerenderizado no están normados por el framework.

**Si el framework incorpora cualquiera de estos temas como regla, manda el framework.**

## 9. Trazabilidad

| | |
|---|---|
| **Índice** | El `Index-Knowledge.md` de la base que lo aloje. No se cataloga en este repositorio |
| **Hermano** | `Template-Blazor-Interactive-Server-SDD-Default`: higiene del circuito, `EventCallback`, `IAsyncDisposable`. Este documento no los repite |
| **Consumidor** | 05 (contrato, §3.1-§3.2, §4) · 08 (batería, fixture y matriz, §3.6, §6) · 09 (cadena de construcción, §3.5, §5.7) · 10 (los dos anfitriones, §2.5, §5.8-§5.9) |
| **Origen del relevamiento** | Dos productos de un mismo taller, **ofuscados**: uno con el TypeScript dentro de la RCL (F1) y otro con el proyecto npm hermano y la app como generador (F2). Mesa evaluadora de ocho comisiones, refutador y jurado |
| **Evidencia de §5** | Dos artefactos desde la misma construcción, sin duplicar el bundle, y acuse íntegro por un doble de la referencia: corrida con Node 22, esbuild 0.25.12 y TypeScript 5.9.3. Registro de estáticos en el primer build: medido en SDK .NET 10 |
| **Artefacto de referencia** | Ninguno depositado |

**Fila de índice propuesta:**

| Documento | Alias | Naturaleza | Tema | Consumidor | Condicion-de-carga | Hereda-de | Sustituye | Compatible-con | Estado |
|---|---|---|---|---|---|---|---|---|---|
| `Knowledge-Bundle-JS.md` | `Bundle-JS` | propio | Proyecto de código JavaScript/TypeScript que emite un bundle agnóstico y una capa de interop (`main.js`), consumido por una biblioteca de clases Razor dentro de una solución .NET: contrato entre los dos lenguajes, cadena de construcción, anfitrión HTML sin .NET y anfitrión Blazor mínimo como instrumentos de diagnóstico | 05, 08, 09, 10 | proyecto de código de ecosistema JavaScript cuyo artefacto carga un proyecto .NET con interfaz Blazor, por insumo de construcción o dentro del mismo proyecto de código | — | — | 2.2 | Vigente |

**Adopción en tres pasos:**

1. Copiar este archivo a `Conocimiento/` del fork.
2. Agregar la fila a su `Index-Knowledge.md`, sin editarla.
3. Correr la lista de `Rules-Base-Conocimiento.md` §6.1.

## 10. Control de cambios

| Versión | Fecha | Cambios |
|---|---|---|
| 1.0 | 2026-09-13 | Emisión inicial, con las correcciones de la construcción de punta a punta de los esqueletos: `ImplicitUsings` y `Nullable` en el proyecto Razor, `tsconfig.pruebas.json`, carpeta desde la que se sirve la PoC HTML, comprobaciones de los criterios 1 y 7, y alcance del viaje de §6.2. Dos artefactos de la misma construcción, PoC HTML servida y API de terceros afuera son decisiones de la mesa con su alternativa en §4, revertibles si el Product Owner decide otra cosa. |
