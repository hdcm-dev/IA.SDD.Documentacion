# 30 — Verificación del plan aplicado (solicitudes 9 a 12)

Comandos y salidas completos en `evidencia/ev-04-post-fix.{sh,out}`, corridos sobre el worktree `IA.SDD-i08`
(rama `intervencion/08-reporte-30`) contra la base `main` `47be07d`.

## 1. Lo aplicado es lo planeado

**Commit del framework**: `0f90b851e21c2c1a3b85b74b8a5c59fe73fb2e42`, rama `intervencion/08-reporte-30` del worktree `IA.SDD-i08`.

| Archivo | Base → nueva | En `_legacy/13.15/` |
|---|---|---|
| `Intake-Rules.md` | 4.2 → **4.3** | 4.2 |
| `Rules-Devops.md` | 6.1 → **6.2** | 6.1 |
| `Rules-Examples.md` | 6.5 → **6.6** | 6.5 |
| `Rules-Arquitectura-Tecnica.md` | 4.5 → **4.6** | 4.5 |
| `Master-Prompt.md` | 8.18 → **8.19** | 8.18 |
| `Catalogo-De-Criterios.md` | 1.17 → **1.18** | 1.17 |
| `PRODUCT-MANIFEST-template.md` | 6.0 → **6.1** | 6.0 |
| `PRODUCT-INTAKE-template.md` | 3.5 → **3.6** | 3.5 |

- **Snapshot**: `esperados=130 en_snapshot=130 no_conformes=0`, blob por blob contra `main`; excluidos
  `.gitignore`, `CHANGELOG.md` y `vs.bat`, **los mismos tres que `_legacy/13.14/`**. Adentro, los ocho archivos
  tocados están en su versión de la base, de modo que no se tomó tarde (`SDD-Development-Guide.md` §VI.5).
- **Registro** (comprobación 10): cabecera igual a la última fila y tabla ordenada en los ocho.
- **Ninguna fila de clase estable reescrita**: `git diff main -- SDD | grep -E '^-\| [0-9]+\.[0-9]+ \| 20'`
  devuelve dos filas, la 3.5 del intake y la 4.2 de `Intake-Rules.md`, y las dos reaparecen **idénticas** como
  agregadas: se reordenaron.
- **Catálogo contra tablas**: `Rules-Devops.md 15 8 7`, `Rules-Examples.md 19 10 9`; total 226 / 109 / 117.
- **Colisión posterior**: `insumo de construcción` y `referencia de proyecto` sólo aparecen donde esta
  intervención los escribió.

## 2. Los cinco criterios de §7 del reporte

**1. §16.1 dice D8 de la unidad, medido con el mismo `grep`. CUMPLIDO.**

```text
$ grep -n "tipo D8 de cada proyecto de código" SDD/Devs/Intake/PRODUCT-INTAKE-template.md
782:| 3.6 | 2026-09-13 | **§16.1 pedía los samples «según el tipo D8 de cada proyecto …   ← la fila que declara la corrección
$ grep -n "^Instrucción: Describir cómo se materializan los samples" …
469:Instrucción: Describir cómo se materializan los samples según el tipo D8 de cada unidad de entrega, que es el eje que lo lleva (§13.
```

**2. El grafo admite la arista y `Vista-Producto` puede declararla sin inventar la clase. CUMPLIDO.**
`Intake-Rules.md` §4 (l.142–143, la tabla de las dos clases) y `Rules-Arquitectura-Tecnica.md` §4.8 punto 3 («Cada
arista declara su clase —referencia de proyecto o insumo de construcción—»). El nombre no es el del destino.

**3. Un manifiesto con un proyecto npm dentro de una solución .NET, sólo con el framework. CUMPLIDO.** Ver §3.

**4. Un sample que no se compila tiene forma declarada, y su verificación no se engancha a la construcción.
CUMPLIDO.** `Rules-Examples.md` §3.6 (l.189), fila «No se construye con la solución» (l.197), y en §6 un criterio
`[enumerable]` y otro `[interpretativo]`.

**5. Ningún texto normativo nombra una herramienta. CUMPLIDO.** Salida literal:

```text
### Criterio 5: grep -rn -i 'NoTargets\|csproj\|webpack' SDD/Devs/Rules
  exit=1

### Criterio 5 ampliado: herramientas o ecosistemas en las líneas agregadas a SDD/Devs/Rules y SDD/Devs/Orchestrator
  exit=1 (1 = ninguna)
### dónde se nombra un ecosistema en lo agregado (sólo plantillas)
17:+sufijo—: cambian los parámetros. Ejemplo, un producto con proyectos .NET y un paquete npm cuyo
18:+artefacto un proyecto .NET toma como insumo de construcción:
20:+| Parámetro | Perfil del ecosistema .NET | Perfil del ecosistema npm |
26:+| Extensión del agrupador | `.sln`, que compone `Contoso.Turnos.sln` | Ninguna: el paquete pertenece a la solución
```

Las cuatro líneas que nombran un ecosistema son **el ejemplo del perfil de convención** de
`PRODUCT-MANIFEST-template.md` §1.2, el lugar declarado para eso. Ninguna está en `SDD/Devs/Rules` ni en el
orquestador. El patrón ampliado incluye `npm`, `node`, `.net`, `dotnet`, `.sln`, `msbuild`, `webpack`,
`typescript`, `javascript`, `playwright`, `blazor`, `wwwroot`, `nuget`, `esbuild`, `curl`, `postman` y `docker`.

## 3. La reproducción del criterio 3, sobre la plantilla

**El caso**: el de `Lab-Geometria` —seis proyectos .NET y un paquete npm cuyo bundle consume el front—, completado
**sólo** con el texto de la 13.16. A la izquierda lo que se escribe; a la derecha, de dónde sale.

**§1.2, perfiles** — sale de `PRODUCT-MANIFEST-template.md` §1.2, «Un perfil por ecosistema»:

| Parámetro | .NET | npm |
|---|---|---|
| `Raiz-Codigo` | `GeometriaFactory` | `geometriafactory` |
| Separador | `.` | `-` |
| Capitalización | PascalCase | minúscula |
| Extensión del agrupador | `.sln` → `GeometriaFactory.sln` | Ninguna: pertenece a la solución de su consumidor |

**§2.B, solución `GeometriaFactory.sln`** — sale de §2.B («Un proyecto de código de otro ecosistema va en la tabla
de la solución a la que pertenece») y de `Intake-Rules.md` §4 (pertenencia y marca):

| `Nombre-Proyecto-Codigo` | `Identidad-Codigo` | Solución | Stack | Dependencias de compilación | Path |
|---|---|---|---|---|---|
| `GeometriaFactory-Web` | `GeometriaFactory.Web` | `GeometriaFactory.sln` | Blazor sobre .NET 10 | `GeometriaFactory-Contracts`, `GeometriaFactory-Visor (insumo de construcción)` | `src/GeometriaFactory.Web/` |
| `GeometriaFactory-Visor` | `geometriafactory-visor` | `GeometriaFactory.sln` | TypeScript, empaquetado a un bundle | — | `src/geometriafactory-visor/` |

La `Identidad-Codigo` sale sola del perfil npm: `geometriafactory` + `-` + `visor`, y **coincide con la que el
destino eligió a mano** como «excepción declarada». El path `src/<Identidad-Codigo>/` es el de la plantilla; el
`visor/` en la raíz del destino es **su apartamiento declarado**, anterior y ajeno a este hueco.

**§3, grafo** — sale de §3 («dos clases de arista», «único generador»):

```text
referencias de proyecto (7)
    Domain -> Application, Domain -> Infrastructure, Application -> Infrastructure,
    Application -> Api, Infrastructure -> Api, Contracts -> Api, Contracts -> Web
insumo de construcción (1, generador: GeometriaFactory-Web)
    Visor -> Web
```

**§4, validaciones** — `Intake-Rules.md` §4: el visor es insumo de **un** consumidor, sin `generado por` (pasa);
ninguna referencia de proyecto une el visor con un proyecto .NET (pasa); el grafo es acíclico con las dos clases
(pasa); cada identidad sigue el perfil de su ecosistema (pasa).

**Lo que el texto no dice, y por qué no es invención.** Cómo muestra el agrupador .NET un paquete que no construye
—en el destino, un archivo de proyecto inerte— es **forma del repositorio**, y la regla lo deja al destino por
escrito (`Intake-Rules.md` §4: «es una decisión del destino»; `Rules-Examples.md` §3.6: «la declara el destino»).
El modo de construcción donde falta la cadena se declara por `Rules-Devops.md` §4.9 punto 4, y los samples por
`Rules-Examples.md` §3.6. **No hizo falta inventar ninguna clase, columna, nombre ni validación.**

## 4. Qué le exige a `Lab-Geometria` (solicitud 12)

Medido en su `main` **`b58dec3`**, que **se movió durante esta intervención**: la base de las citas fue
`1ce1b2c`, y entre las dos entró la fusión del agente que estaba trabajando el reporte `12` del destino.

| Qué | Dónde (medido) | Qué le exige |
|---|---|---|
| **La clase de arista tiene nombre del framework, y no es el suyo** | «activo de construcción», **17** ocurrencias: `Handoff-Checkout.md` 2, `Producto/11-Documentacion/README.md` 2, `Vista-Producto.md` 3, `ADR-10008` 2, intake 2, manifiesto 3, `changelog.md` 1, `evidencia/2026-09-12-estructura-solucion/README.md` 1, `visor/geometriafactory-visor.csproj` 1 | Re-expresar a `insumo de construcción` en su próxima migración, como apartamiento **absorbido**. `ADR-10008`, `changelog.md` y la evidencia fechada no se reescriben: son registro |
| **La arista, marcada en el intake** | intake §13.2, fila `GeometriaFactory-Web` (l.417): `GeometriaFactory-Visor` sin marca | `GeometriaFactory-Visor (insumo de construcción)`, y **el manifiesto se re-deriva**, no se edita |
| **La identidad del visor** | intake §13.3 l.490, «Excepción declarada para GeometriaFactory-Visor» | Pasa a ser el perfil del ecosistema npm en §1.2: la identidad resultante es la misma, y la excepción queda absorbida |
| **§16.1 del intake** | l.678: `\| Proyecto de código \| Tipo D8 \| Qué hay en /samples \|` | Re-expresar por unidad de entrega |
| **El mapa de `Vista-Producto.md` §2** | l.85: `\| Nombre-Proyecto-Codigo \| Identidad-Codigo \| Tipo D8 \| … \| redistribuible \|` | Re-expresar sin D8 ni `redistribuible` por proyecto (`Rules-Arquitectura-Tecnica.md` §4.8 punto 2) |
| **Los once samples** | `b58dec3`: once archivos de proyecto `Microsoft.Build.NoTargets` en `samples/{api,contracts,visor,web}/…`, **cero `<Target>` y cero `<Exec>`**; `ci.yml` l.74 corre `scripts/verify-solution-tree.sh` | **Nada: ya cumplen §3.6**, con verificación fuera de la construcción y la cobertura comprobada por un instrumento propio |
| **El único generador y la cadena ausente** | `ADR-10008`; `-p:SkipVisorBuild=true` en `Dockerfile.web` l.94; sin bandera y sin Node, el target falla | **Nada: ya cumple** `Rules-Devops.md` §4.9 punto 4 |

**`RPI.VideoControl`**, que no es el destino del reporte: le alcanza §4.9 punto 4 —`VideoControl.PinMap` corre la
cadena de JavaScript dentro de su construcción, y su target `VerificarNode` ya **falla y la nombra**— y §4.8 punto
2, porque el mapa de su `Vista-Producto.md` (l.33) lleva `Tipo D8` y `Redistribuible` por proyecto.

## 5. Lo no verificado

- **Ninguna corrida del orquestador** ejerció las validaciones nuevas de `Intake-Rules.md` §4 sobre un intake
  real: la reproducción del criterio 3 es de lectura, no de derivación.
- **Nada se construyó** en ningún destino; lo que se afirma de `Lab-Geometria` y `RPI.VideoControl` sale de
  objetos commiteados.
- Si `Pipeline-Producto.md` de `RPI.VideoControl` declara los ambientes sin la cadena: su `grep` por la cadena
  de JavaScript no devuelve nada, y eso **no prueba** que no lo declare con otras palabras.
- Los residuos del barrido del mecanismo de carga de conocimiento y de la guía teórica quedan **vivos y
  declarados** (nota de coherencia §4); no se abrió un reporte para ellos.

## 6. Detenciones

**Ninguna.** La pregunta de fondo tuvo respuesta en el árbol —la frontera de `Vocabulario-Rules.md` §2
contrastada contra el destino— y ninguna decisión requirió intención de producto (§8.1, origen del hecho contra
las bases publicadas en `OUTPUTs/00`).
