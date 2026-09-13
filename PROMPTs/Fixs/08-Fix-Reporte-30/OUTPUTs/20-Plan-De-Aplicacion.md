# 20 — Plan de aplicación (solicitud 8)

Sobre la decisión de `OUTPUTs/10`. **Framework resultante: SDD 13.16, minor.** Snapshot `_legacy/13.15/`
**entero** antes de editar.

| # | Artefacto | Versión | Severidad | Qué cambia | Qué se preserva | Qué destinos alcanza |
|---|---|---|---|---|---|---|
| 1 | `SDD/Devs/Rules/Intake-Rules.md` §4 | 4.2 → 4.3 | minor | Pertenencia del proyecto de otro ecosistema; dos clases de arista con su marca; único generador; cuatro validaciones bloqueantes | Las validaciones de los dos ejes y del puente; la derivación directa de la columna de dependencias | `Lab-Geometria` (su arista `Visor → Web`) |
| 2 | `SDD/Devs/Rules/Rules-Devops.md` §4.9 punto 4, §4.8 | 6.1 → 6.2 | minor | Único generador; modo de construcción explícito donde falta la cadena, y falla que la nombra; dos anti-patrones | Las dos políticas de coordinación existentes (paquete publicado / build conjunto) | `Lab-Geometria` (arista), `RPI.VideoControl` (cadena dentro de `VideoControl.PinMap`) |
| 3 | `SDD/Devs/Rules/Rules-Examples.md` §3.6, §4.5, §6 | 6.5 → 6.6 | minor | Entrada del sample al agrupador; verificación fuera de la construcción; cobertura por enumeración en el destino; anfitrión mínimo | §0.1 (dos aristas), §2.2/§2.3 (pisos y matriz), §3.4 (compila contra el producto), §4.6 (contrato) | `Lab-Geometria` (once samples) |
| 4 | `SDD/Devs/Rules/Rules-Arquitectura-Tecnica.md` §4.8 | 4.5 → 4.6 | minor, con precedente | Clase de cada arista; punto 2 sin D8 ni `redistribuible` por proyecto; aplicabilidad y omisión alineadas con §2.1 | Las ocho secciones y su orden | `Lab-Geometria` y `RPI.VideoControl` (mapa con D8 por proyecto) |
| 5 | `SDD/Devs/Orchestrator/Master-Prompt.md` §11, §15 | 8.18 → 8.19 | minor | Dos términos del glosario; clase de arista en la vista; README raíz con la tabla de unidades | Todo el despacho y las fases | — |
| 6 | `SDD/Devs/Rules/Catalogo-De-Criterios.md` §1, §3, §4 | 1.17 → 1.18 | minor | Tres situaciones; recuentos 222 → 226 | La política de coincidencia y el resto de las filas | — |
| 7 | `SDD/Devs/Intake/PRODUCT-MANIFEST-template.md` §1.2, §2.B, §3, §4, §7 | 6.0 → 6.1 | minor | Perfil por ecosistema con ejemplo; marca de clase; dos clases y generador; dos validaciones; dos ítems de checklist | Los dos ejes, la matriz, la regla entre soluciones distintas | `Lab-Geometria` |
| 8 | `SDD/Devs/Intake/PRODUCT-INTAKE-template.md` §13.2, perfil, §16.1 | 3.5 → 3.6 | minor, con precedente | §16.1 al D8 de la unidad; pregunta y marca del insumo; capitalización y perfil por ecosistema | Las tres subsecciones de §13 y los campos bloqueantes | `Lab-Geometria` (§16.1 con D8 por proyecto) |
| 9 | `SDD/Devs/Guides/Coherencia-Proyecto-De-Otro-Ecosistema.md` | 1.0 nueva | — | Nota de coherencia (§VI.3, comprobación 11) | — | — |
| 10 | `CHANGELOG.md` | [13.16] | minor | Entrada con impacto medido por destino | Entradas publicadas | — |
| 11 | `_legacy/13.15/` | — | — | Conjunto entero de la 13.15 | Intocable una vez creado | — |

**Por qué minor y no major** (`SDD-Development-Guide.md` §VI.1 y §VI.5). Las piezas nuevas no invalidan
ningún documento que siga el texto de la 13.15: la arista sin marca es referencia de proyecto, el perfil
único sirve con un ecosistema, y §3.6 agrega criterios. Las dos correcciones de residuo (§16.1 y §4.8
punto 2) **sí** dejan en falta a documentos de dos destinos, pero esos documentos contradecían el modelo de
dos ejes desde la 8.0 (`Vocabulario-Rules.md` §2; `Master-Prompt.md` §11, «Sin valor D8»), y la
plantilla del intake ya corrigió **la misma clase de residuo** como minor en su 3.1. Se declara en vez de
esconderlo: si se leyera §VI.1 sin ese precedente, los puntos 4 y 8 serían major.

**Orden de aplicación**: snapshot → los ocho archivos en un solo script con guardas (valida los anclajes de
todos antes de escribir cualquiera) → nota → `CHANGELOG.md` → verificación (`OUTPUTs/30`) → commit del
framework → cierre documental → commit de la documentación.
