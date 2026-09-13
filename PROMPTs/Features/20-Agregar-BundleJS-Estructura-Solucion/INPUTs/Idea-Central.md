# Convención de estructura de repositorio: solución .NET + proyectos Node.js

> **Documento de contexto para agente IA.**
> Define cómo estructurar un repositorio que contiene una solución Visual Studio (.NET/C#)
> junto con uno o más proyectos JavaScript/Node.js cuyos artefactos son consumidos por
> aplicaciones web .NET (Blazor / ASP.NET Core).
>
> **Cómo usar este documento:** es normativo. Las reglas marcadas como **DEBE** son
> obligatorias; las marcadas como **DEBERÍA** admiten desvío justificado. Al proponer o
> modificar la estructura del repositorio, el agente debe respetar estas reglas y, si
> considera que alguna no aplica, explicitar el motivo antes de desviarse.

---

## 1. Problema que resuelve esta convención

Un repositorio poliglota tiene **dos ecosistemas de build independientes** que se
encuentran en un único punto:

| Ecosistema | Herramientas | Salida |
| --- | --- | --- |
| .NET / C# | `dotnet build`, `dotnet test`, MSBuild, NuGet | ensamblados, `wwwroot` publicado |
| Node.js / JS | `npm`/`pnpm`, Webpack/Vite/esbuild, Jest/Vitest | bundles JS/CSS |

El punto de encuentro es el consumo del bundle JavaScript desde una aplicación .NET.

El anti-patrón habitual es aplanar todo bajo `src/`:

```text
src/
├── Proyecto1/
├── Proyecto2/
├── ProyectoNode1/
├── ProyectoNode2/
├── Tests/
└── Blazor/
```

Con esa disposición se pierde la capacidad de responder, mirando el árbol:
**qué es producto, qué es test, qué es herramienta, qué es experimento y qué es generado.**

---

## 2. Principio rector

El repositorio **DEBE** separar en el primer nivel cinco categorías con semántica distinta:

```text
código fuente  →  pruebas  →  experimentos  →  generado  →  automatización
```

De ahí se derivan las reglas del resto del documento.

---

## 3. Referencias de industria

Esta convención no es arbitraria. Se apoya en prácticas establecidas:

- **Layout `src/` + `tests/` en repositorios .NET de referencia.** Es el layout usado por
  los repositorios oficiales de .NET (runtime, ASP.NET Core, EF Core) y el que asume la
  mayoría de la documentación de MSBuild sobre `Directory.Build.props`.
- **`artifacts/` como salida de build unificada.** Desde **.NET 8**, el SDK soporta
  oficialmente `UseArtifactsOutput` / `ArtifactsPath`, que consolida `bin/` y `obj/` de
  todos los proyectos en un único directorio `artifacts/` en la raíz del repositorio.
  La convención deja de ser "un nombre que se suele usar" y pasa a ser una característica
  del SDK.
- **`dist/` como salida de bundlers.** Convención de facto de Webpack, Vite, Rollup y
  esbuild; también es el valor por defecto de `files` en la mayoría de los paquetes npm.
- **Workspaces de npm/pnpm** para agrupar varios paquetes JS bajo una raíz común con un
  único lockfile.
- **Monorepos poliglotas** (Nx, Turborepo, Bazel): el principio compartido es que el
  *build graph* cruza tecnologías, y que la salida de una tecnología es *entrada declarada*
  de otra, nunca una copia manual.
- **Static Web Assets de ASP.NET Core**: el mecanismo soportado para que recursos estáticos
  producidos fuera del proyecto web lleguen a la aplicación sin copias manuales.

---

## 4. Estructura canónica

```text
Solution/
│
├── Solution.slnx
│
├── README.md
├── .editorconfig
├── .gitignore
├── Directory.Build.props
├── Directory.Build.targets
├── Directory.Packages.props
├── package.json                  # workspaces (opcional, ver §7.2)
│
├── src/
│   │
│   ├── dotnet/
│   │   ├── Company.Domain/
│   │   ├── Company.Application/
│   │   ├── Company.Infrastructure/
│   │   ├── Company.Api/
│   │   ├── Company.Web/
│   │   │   └── wwwroot/
│   │   └── Company.Shared/
│   │
│   └── javascript/
│       │
│       ├── company.maps/
│       │   ├── package.json
│       │   ├── webpack.config.js
│       │   ├── src/
│       │   │   └── main.js
│       │   └── dist/
│       │
│       └── company.components/
│           ├── package.json
│           ├── webpack.config.js
│           ├── src/
│           └── dist/
│
├── tests/
│   ├── dotnet/
│   │   ├── Company.Domain.Tests/
│   │   ├── Company.Application.Tests/
│   │   └── Company.Api.Tests/
│   │
│   └── javascript/
│       ├── company.maps.tests/
│       └── company.components.tests/
│
├── poc/
│   └── GoogleMaps/
│       ├── index.html
│       ├── js/
│       ├── shared/
│       │   ├── config.js
│       │   └── fake-blazor.js
│       ├── data/
│       └── imgs/
│
├── examples/
│   └── GoogleMaps/
│       ├── basic/
│       ├── markers/
│       └── polygons/
│
├── build/
│   ├── scripts/
│   └── targets/
│
├── tools/
│
├── docs/
│   ├── architecture/
│   ├── development/
│   └── deployment/
│
└── artifacts/                    # generado — no versionado
```

---

## 5. Semántica de cada carpeta

| Carpeta | Contenido | Versionado |
| --- | --- | --- |
| `src/` | Código fuente del producto, escrito y mantenido por el equipo | Sí |
| `src/dotnet/` | Proyectos .NET/C# | Sí |
| `src/javascript/` | Paquetes Node/JS con build propio | Sí |
| `tests/` | Verificación automatizada del comportamiento | Sí |
| `poc/` | Validación técnica de una idea o integración | Sí |
| `examples/` | Demostración de *cómo se usa* un componente | Sí |
| `build/` | Lógica de construcción, targets MSBuild, scripts de CI | Sí |
| `tools/` | Herramientas auxiliares del repositorio | Sí |
| `docs/` | Documentación | Sí |
| `dist/` | Salida del bundler, local al paquete JS | **No** |
| `artifacts/` | Salida de build consolidada | **No** |
| `wwwroot/` | Recursos públicos de la app .NET | Parcial (ver §8) |

**Regla:** `poc` ≠ `tests`. Una PoC no es necesariamente automatizada y no verifica
regresiones; valida que una arquitectura es viable. `examples` ≠ `poc`: los ejemplos
documentan el uso de un componente ya validado.

---

## 6. El concepto de *artifact*

Un **artifact** es todo archivo **producido por una herramienta**, no escrito por una
persona. La distinción operativa es:

```text
¿alguien lo edita a mano?  → sí → fuente   → versionado
                           → no → artifact → reproducible, no versionado
```

Ejemplos: `maps.bundle.js`, `*.dll`, `*.nupkg`, `obj/`, `dist/`, el `wwwroot` publicado.

### 6.1 Dos niveles de artifact

| Nivel | Ubicación | Alcance |
| --- | --- | --- |
| Local al paquete | `src/javascript/<pkg>/dist/` | salida natural del bundler |
| Consolidado | `artifacts/` en la raíz | salida unificada de todo el repo |

### 6.2 `artifacts/` en .NET 8+

Activarlo en `Directory.Build.props` (**debe** estar ahí, no en cada `.csproj`):

```xml
<Project>
  <PropertyGroup>
    <UseArtifactsOutput>true</UseArtifactsOutput>
    <!-- opcional: <ArtifactsPath>$(MSBuildThisFileDirectory)artifacts</ArtifactsPath> -->
  </PropertyGroup>
</Project>
```

Resultado:

```text
artifacts/
├── bin/<proyecto>/<config>/
├── obj/<proyecto>/<config>/
├── publish/<proyecto>/<config>/
└── package/<config>/
```

Desaparecen los `bin/` y `obj/` dispersos por el árbol.

### 6.3 Convivencia .NET / JavaScript en `artifacts/`

Como el SDK ya reserva `bin`, `obj`, `publish` y `package` dentro de `artifacts/`, la salida
JavaScript **DEBE** usar un subdirectorio propio para evitar colisión:

```text
artifacts/
├── bin/          # .NET SDK
├── obj/          # .NET SDK
├── publish/      # .NET SDK
└── js/           # bundles JavaScript
    ├── company.maps/
    └── company.components/
```

### 6.4 Trade-off: ¿`dist/` local o `artifacts/js/` centralizado?

| Criterio | `dist/` local | `artifacts/js/` centralizado |
| --- | --- | --- |
| Fricción inicial | ninguna | requiere configurar `output.path` en cada bundler |
| Herramientas JS | es lo esperado por defecto | hay que desviarse del default |
| Publicación como paquete npm | natural (`files: ["dist"]`) | incómodo |
| Varios consumidores .NET | funciona, con más rutas relativas | un único origen claro |
| `.gitignore` | una entrada por paquete o glob | una sola entrada |
| Limpieza (`clean`) | dispersa | `rm -rf artifacts/` |

**Recomendación:** empezar con `dist/` local. Migrar a `artifacts/js/` **solo** cuando
exista una necesidad real: varios consumidores .NET del mismo bundle, o pipeline de CI
que deba publicar la salida completa como un único conjunto. Introducir la centralización
antes de esa necesidad agrega configuración sin beneficio.

---

## 7. Proyectos JavaScript

### 7.1 Estructura de cada paquete

```text
src/javascript/company.maps/
├── package.json
├── webpack.config.js
├── src/            ← fuente
│   ├── main.js     ← contrato de integración (ver §9)
│   └── ...
└── dist/           ← generado
    └── maps.min.js
```

**DEBE** mantenerse la distinción entre `src/javascript/<pkg>/src/` (fuente) y
`src/javascript/<pkg>/dist/` (generado). La anidación `src/.../src/` es intencional y es la
que usan los propios paquetes npm.

### 7.2 Múltiples paquetes JS

Con más de dos paquetes, **DEBERÍA** usarse workspaces para un único lockfile y
`node_modules` deduplicado:

```json
{
  "private": true,
  "workspaces": ["src/javascript/*"]
}
```

Trade-off: los workspaces simplifican la instalación y permiten dependencias entre paquetes,
pero acoplan las versiones de dependencias entre ellos. Si un paquete necesita una versión
incompatible de una dependencia compartida, la independencia total (un `package.json` y un
lockfile por paquete) es preferible.

---

## 8. Integración entre los dos builds

### 8.1 Regla central

**Los bundles NO DEBEN copiarse manualmente a `wwwroot`.** La relación entre la salida JS y
la aplicación .NET **DEBE** estar declarada en el build.

```text
JavaScript source
      │ webpack
      ▼
   bundle
      │ build (MSBuild / script)
      ▼
.NET wwwroot
      │
      ▼
Aplicación Blazor
```

### 8.2 Opciones de integración

| Opción | Mecanismo | Cuándo conviene |
| --- | --- | --- |
| **A. Target MSBuild** | `Exec` de `npm ci` + `npm run build`, luego `Copy` a `wwwroot` | un bundle, un consumidor; lo más simple que funciona |
| **B. Razor Class Library** | el bundle vive en una RCL y se sirve vía `_content/<RCL>/` | varios consumidores .NET del mismo bundle |
| **C. Paquete npm privado** | el bundle se publica y se consume versionado | equipos separados, cadencias de release distintas |
| **D. Orquestador de monorepo** | Nx/Turborepo maneja el grafo y el caché | repo grande, muchos paquetes, builds lentos |

Esbozo de la opción A, en `build/targets/JavaScript.targets`:

```xml
<Project>
  <Target Name="BuildJavaScript" BeforeTargets="BeforeBuild"
          Condition="'$(SkipJavaScriptBuild)' != 'true'">
    <Exec Command="npm ci"        WorkingDirectory="$(JsPackageDir)" />
    <Exec Command="npm run build" WorkingDirectory="$(JsPackageDir)" />
  </Target>

  <Target Name="CopyJavaScriptAssets" AfterTargets="BuildJavaScript">
    <ItemGroup>
      <JsBundle Include="$(JsPackageDir)dist/**/*" />
    </ItemGroup>
    <Copy SourceFiles="@(JsBundle)"
          DestinationFolder="$(ProjectDir)wwwroot/js/%(RecursiveDir)"
          SkipUnchangedFiles="true" />
  </Target>
</Project>
```

Consideraciones honestas sobre la opción A:

- `npm ci` en cada build es lento. Conviene condicionarlo (`Inputs`/`Outputs` sobre
  `package-lock.json`, o una propiedad `SkipJavaScriptBuild` para el loop de desarrollo).
- Obliga a tener Node instalado en cualquier máquina que compile, incluido el agente de CI.
- Si `wwwroot/js/` recibe archivos generados, esa ruta **DEBE** entrar en `.gitignore`; de lo
  contrario habrá diffs de bundle en cada commit.

### 8.3 Recomendación por escala

- **1 bundle, 1 consumidor** → opción A.
- **1 bundle, N consumidores .NET** → opción B (RCL). Es el mecanismo que ASP.NET Core
  provee específicamente para esto y evita N copias del mismo archivo.
- **Componente con ciclo de vida propio** → opción C.

---

## 9. `main.js` como contrato de integración

Cuando un bundle va a ser consumido desde Blazor, **DEBE** existir una capa de adaptación
explícita entre el consumidor y el bundle.

```text
Blazor  →  main.js  →  bundle  →  API externa (p. ej. Google Maps)
```

Responsabilidades:

- **El bundle** no conoce Blazor, Razor, `DotNetObjectReference` ni ningún concepto .NET.
- **`main.js`** concentra las funciones que forman el contrato de uso:

```javascript
InitializeMapBlazorAsync(...)
UpdateMarkersAsync(...)
UpdatePolygonsAsync(...)
ShowInfoWindowAsync(...)
DisposeMapAsync(...)
```

**DEBE** vivir en `src/javascript/<pkg>/src/main.js`, no duplicado dentro de cada PoC. La PoC
consume el mismo archivo que consumirá Blazor; si estuviera duplicado, la PoC dejaría de
probar el contrato real.

### 9.1 Versionado del bundle

El nombre físico del archivo **NO DEBE** incluir la versión:

```text
maps.min.js                 ← archivo físico
maps.min.js?v=202607061629  ← referencia del consumidor (cache busting)
```

La versión **DEBERÍA** generarse desde el proceso de build (por ejemplo desde
`package.json` o desde el hash del commit) e inyectarse en la referencia, no escribirse a
mano. Alternativa soportada por ASP.NET Core: `asp-append-version="true"` en el tag helper,
que calcula el hash del contenido automáticamente.

---

## 10. PoC como cliente de referencia

Una PoC de integración JS/Blazor valida, sin levantar la aplicación .NET:

- inicialización del componente,
- forma del contrato de funciones y de sus parámetros,
- eventos y callbacks,
- manejo de errores,
- ciclo de vida y liberación de recursos.

El lado .NET se simula con un adaptador:

```text
PRODUCCIÓN                      POC
Blazor                          fake-blazor.js
  │ JS Interop                    │ simula interop
  ▼                               ▼
main.js                         main.js
  │                               │
  ▼                               ▼
bundle                          bundle
```

Esto evita usar Blazor como banco de pruebas del componente JavaScript: cuando cambia
`main.js` o el bundle, se ejecuta la PoC y se sabe de inmediato si el contrato sigue siendo
compatible.

**Regla de promoción:** una PoC **NO DEBE** convertirse automáticamente en código de
producción. Si demuestra que la solución es válida, la implementación definitiva se escribe
en el proyecto correspondiente dentro de `src/`.

**Trade-off a tener presente:** una PoC sin ejecución automatizada se degrada en silencio.
Si el contrato importa de verdad, lo correcto a mediano plazo es un test en
`tests/javascript/` que ejercite el mismo `main.js`; la PoC queda entonces como entorno de
exploración manual, no como red de seguridad.

---

## 11. Qué entra en la solución `.slnx`

La solución **DEBE** contener los proyectos que forman parte del producto y de su testing.
Las PoC HTML/JS independientes **NO DEBEN** incorporarse a la solución .NET, aunque sí
permanecen en el repositorio.

```text
Repositorio Git
│
├── Solución .NET (.slnx)
│   ├── src/dotnet/...
│   ├── src/javascript/...   (si se modelan como proyectos de la solución)
│   └── tests/...
│
└── poc/                     ← fuera de la solución, dentro del repo
```

Notas:

- `.slnx` es el formato XML de solución que reemplaza al `.sln` clásico; es más legible y
  produce merges más limpios. Verificar la versión de Visual Studio / SDK soportada en el
  equipo antes de adoptarlo como único formato.
- Los paquetes JavaScript **PUEDEN** agregarse a la solución (por ejemplo mediante un
  proyecto de tipo carpeta o un `.esproj`) para tenerlos visibles en el IDE. Es una decisión
  de comodidad, no arquitectónica: agregarlos mejora la navegación, pero introduce un
  proyecto más que mantener en el build de la solución.

---

## 12. `.gitignore`

**NO DEBEN** versionarse:

```gitignore
bin/
obj/
artifacts/
node_modules/
**/dist/
src/dotnet/*/wwwroot/js/*.bundle.js   # si el bundle se copia al wwwroot
```

Excepción justificable: versionar el bundle cuando el entorno de despliegue no puede
ejecutar Node. Es una decisión consciente que **DEBE** documentarse en el README, porque
implica revisar diffs de archivos generados en cada commit.

---

## 13. Resumen normativo

1. **DEBE** separarse `src/`, `tests/`, `poc/`, `build/`, `docs/` en el primer nivel.
2. **DEBE** separarse `src/dotnet/` de `src/javascript/`.
3. **DEBE** distinguirse fuente de generado; lo generado no se versiona.
4. **DEBE** existir una capa `main.js` como contrato entre Blazor y el bundle.
5. **DEBE** declararse en el build la relación bundle → `wwwroot`; nunca copia manual.
6. **NO DEBE** incluirse la versión en el nombre físico del bundle.
7. **NO DEBEN** incorporarse las PoC a la solución `.slnx`.
8. **NO DEBE** promoverse código de PoC a producción sin reimplementación.
9. **DEBERÍA** usarse `UseArtifactsOutput` para consolidar la salida .NET.
10. **DEBERÍA** postergarse `artifacts/js/` centralizado hasta tener más de un consumidor.

---

## 14. Decisiones pendientes para el agente

Antes de generar la estructura concreta, resolver:

1. ¿Cuántos consumidores .NET tiene cada bundle? Determina §8.3 (Target vs RCL).
2. ¿El pipeline de CI/CD puede ejecutar Node? Determina §12.
3. ¿Los paquetes JS comparten dependencias? Determina §7.2 (workspaces sí/no).
4. ¿Qué versión de Visual Studio / SDK usa el equipo? Determina la adopción de `.slnx`.
5. ¿Hay intención de publicar algún componente JS como paquete npm? Determina §6.4.

