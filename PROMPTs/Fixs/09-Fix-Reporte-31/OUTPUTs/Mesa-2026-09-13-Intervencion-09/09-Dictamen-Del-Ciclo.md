# Dictamen del ciclo — mesa de la intervención 09

| Campo | Valor |
|---|---|
| Fecha | 2026-09-13 |
| Autor | Presidente de mesa (orquestador de la intervención 09). Redacta lo que el jurado aprobó y **no vota**; lo que agrega por su cuenta va marcado **[presidente]** |
| Base | `IA.SDD` `main` `a501857` (13.17); rama `intervencion/09-reporte-31` en `35212d7` (snapshot `_legacy/13.17/`) |
| Insumos | Contrato de entrada; cartas `00` a `08`; informes `01` a `07`; votos `jurado/Ev.md`, `Im.md`, `CB.md`, `CH.md`, `Ri.md`; constancia `07` (re-despacho del refutador) |

## 1. Veredicto

**Diecisiete ítems, los diecisiete `PROCEDE` con reparto 5-0**, cada juez un agente distinto con una sola función. **Sin veto.**

| Ítem | Decisión | Reparto |
|---|---|---|
| J9-01 | Se adopta el caso como figura normada, regla transversal `Expediente-Rules.md`, minor | 5-0 |
| J9-02 | E-3 opción **C**: D9 intacta; la opción A queda preparada y no se aplica | 5-0 |
| J9-03 | Número local de **cuatro dígitos**, excluido en `Root-Rules.md` §9.2 con forma propia | 5-0 |
| J9-04 | En destino, el panel se folia con una constancia `ruta@commit` del registro de `Audit/`; verbatim como folio sólo en el framework; cartas siempre en `evidencia/` | 5-0 |
| J9-05 | Apertura con precedencia, rama 2 con la letra de Q2, sin «ante la duda, no se abre»; radicación donde corre la corrida que trata el caso | 5-0 |
| J9-06 | Estado derivado sobre la secuencia (un `Corrige` no cambia el estado; reapertura con `Corrige`; qué sigue a `archivo`; alcance de `Suspende hasta:`) | 5-0 |
| J9-07 | S1 después del **primer push**, contra la rama principal; A7 corregido; única excepción: la redacción S2, con constancia | 5-0 |
| J9-08 | S2 autónoma, por clase de dato, con visibilidad verificada o declaración del dueño, antes de **cada** push, criterio A11 | 5-0 |
| J9-09 | Custodia del testimonio en el expediente y en §7.0 y §7.1, no retroactiva | 5-0 |
| J9-10 | Vínculo directo o por dos saltos a través de `Audit/`; cita calificada; alfabeto del título; A10 corregido | 5-0 |
| J9-11 | Q11 como párrafo con fundamento en `Master-Prompt.md` §8.1, cableado en migración y reanudación | 5-0 |
| J9-12 | R0 paso 4 lee sólo expedientes de forma vigente abiertos; `Cierra con:` en el pase | 5-0 |
| J9-13 | La carátula suma `Objeto` (seis campos) | 5-0 |
| J9-14 | Tres momentos de uso con pasos cortos | 5-0 |
| J9-15 | Alcance acotado; la 13.17 por remisión; catálogo incluido; `Deriva-Rules.md` no se toca | 5-0 |
| J9-16 | El 0001 se cierra con folios nuevos y sin editar su README | 5-0 |
| J9-17 | `Examples/` se ofusca en la 13.18; `_legacy/` como deuda declarada | 5-0 |

## 2. Homogeneidad (`Mesa-Rules.md` §6.4)

**100 % de ítems 5-0: el ciclo es sospechoso de homogeneidad** y se declara. A diferencia del ciclo del 0001 (81 %, un solo agente con cinco mandatos), acá votaron **cinco agentes distintos**, a ciegas entre sí, y los fundamentos difieren por función: el juez de evidencia verificó anclas por su cuenta (l.487-488 de `Root-Rules.md`, l.640 de `Master-Prompt.md`, el conteo de `_legacy/`), el de riesgo trajo el problema del snapshot y de la custodia, el de coherencia exigió declarar dos apartamientos. **La salvaguarda de §6.4 manda que el refutador revise los `NO_PROCEDE`: no hubo ninguno**, así que no tiene objeto. **[presidente]** La explicación más probable no es el sesgo del modelo sino que el jurado votó propuestas ya refinadas por siete informes y un refutador que había hecho el trabajo de disentir; lo que el jurado agregó está en las variantes (§3), y ahí sí hay desacuerdo.

## 3. Variantes, y qué se hace con cada una

| Variante | Juez | Decisión del presidente | Motivo |
|---|---|---|---|
| El `ruta@commit` apunta a un commit ancestro de la rama principal; tras un squash se re-folia al commit de squash | Im, Ri (J9-04) | **Se incorpora** a la regla §5 | TRZ-04 (E1): cinco commits del 0001 quedaron inalcanzables |
| La constancia S2 posterior al push declara que la redacción **no retira** lo ya empujado | Im, Ri, Ev (J9-07, J9-16) | **Se incorpora** a S2 y al folio 019 | SEG-01 (E1) |
| Escalar al Product Owner el retiro de los commits del PR #66 | Ri (J9-16) | **No se incorpora** | Decisión del coordinador de la sesión con el Product Owner, 2026-09-13: **evaluado, sin acción**, porque la misma información es pública en su fuente, un repositorio público, desde el 2026-09-02 |
| La sonda de visibilidad se asienta una vez por destino y se repite sólo si cambia el remoto | CB (J9-08) | **Se incorpora** | Costo por push nulo |
| La visibilidad decide sólo **qué se responde**; la compuerta corre siempre | Ri (J9-08) | **Se incorpora** | SEG-07 |
| Si A10 no cabe, diferirlo | CB (J9-10) | **No se incorpora**: A10 se escribe corregido | Cabe |
| La excepción S2 a S1 se declara como apartamiento de 016 Q6 | CH (J9-07) | **Se incorpora** a la nota de coherencia y al `CHANGELOG` | Q6 fue 5-0 |
| D-3 se cierra por remisión y se enumeran las capas de 016 §8 diferidas con su evento | CH (J9-15) | **Se incorpora** (§5) | — |
| La deuda de `_legacy/` con la forma de `Root-Rules.md` §12.2 y con el conteo medido | CH, Ev, Ri (J9-17) | **Se incorpora** (§5) | Medido: `git grep -lE '192\.168\.' main -- _legacy \| wc -l` → `42`, en los snapshots 12.0 a 13.16 |
| Un `Objeto` mal escrito se rectifica con una `constancia` con `Corrige` | Ri (J9-13) | **Se incorpora** a la regla §3 | — |
| Tomar `_legacy/13.17/` después de ofuscar `Examples/` | Ri (J9-15) | **No se incorpora**; rige la segunda rama de la variante: su copia de `Examples/` entra a la deuda | `SDD-Development-Guide.md` §VI.5: el snapshot es el conjunto **antes** de la intervención; tomarlo después es el error silencioso que esa sección nombra |
| Custodia de los originales: lugar durable y custodio humano, o declarar que es de sesión | Ri (J9-16) | **Se incorpora la segunda rama**: la custodia de esta intervención es de sesión, no verificable a futuro, y queda como deuda con el Product Owner como custodio | Esta intervención no escribe fuera de sus dos worktrees |

## 4. Testimonio del Product Owner que la mesa incorpora

La decisión sobre `Lab-Geometria` como destino público de consulta entra con la forma de testimonio de la regla nueva (§3.3):

```testimonio
en el caso especial de `Lab-Geometria` no me importa que quede público, es un ejemplo muy bueno para dejar de consulta ya que es un proyecto público
```

| Campo | Valor |
|---|---|
| Canal | mensaje del Product Owner transmitido por el coordinador de la sesión a esta intervención; el literal es el que el coordinador citó entre comillas |
| Fecha-hora | 2026-09-13, recibido antes de las 16:39:57 -03:00 (hora de la observación) |
| Huella | `0661407860ec217a8278958ad405bfd9cf4b4355c936a8e86b56d1ac96716c04` |

**Clasificación por contenido:** es una **declaración del dueño** sobre la visibilidad de un destino. Funda la excepción fechada de S2 para `Lab-Geometria`: lo que proviene de ese repositorio no se redacta. **No** es aprobación de un entregable ni afirmación de estado.

**Instrucción del coordinador, no literal del Product Owner** (se asienta aparte para no confundir autoridad): los repositorios públicos se nombran; los privados se ofuscan (nombre, organización, dominio, cliente); de un repositorio privado se usan conceptos de diseño y nunca detalles de infraestructura; las rutas del host siempre se redactan; la compuerta distingue público de privado con la visibilidad verificada.

## 5. Deuda declarada (forma de `Root-Rules.md` §12.2)

Ciclo de origen de todas: mesa 2026-09-13 · intervención 09 · `a501857`.

| Id | Qué falta | Por qué no hoy | Quién lo cierra | Evento de cierre |
|---|---|---|---|---|
| **D9-1** | Custodia durable de los originales anteriores a las redacciones S2 de esta intervención (informes de la mesa y folios 005 y V2 del 0001) | Esta intervención sólo escribe en sus dos worktrees; los originales quedaron en el scratchpad de la sesión, que no es durable | El Product Owner, como custodio | Una constancia en el expediente 0001 que nombre el lugar durable y verifique `HUELLAS-ANTES` contra él |
| **D9-2** | IP de red privada, no alcanzable desde Internet, en 42 archivos de `_legacy/12.0` a `_legacy/13.16` y en la copia de `Examples/` de `_legacy/13.17` | Los snapshots son intocables (`SDD-Development-Guide.md` §VI.5); retirarla exige reescribir historia | La organización dueña del repositorio | Decisión registrada en el `CHANGELOG.md` de una versión posterior sobre si se reescribe o se acepta |
| **D9-3** | Capas de 016 §8 diferidas: `SDD-User-Guide.md` (pregunta frecuente sobre expedientes), `Mesa-Rules.md` §0.0 y §2.1 (remisiones) | No participan en la ejecución (M9-REF-08, M9-REQ pregunta 5) | Presidente de mesa de la próxima intervención que toque esos archivos | Fila de control de cambios de cada uno que registre la remisión a `Expediente-Rules.md` |

**Cerradas por este ciclo:** D-2 (Seguridad convocada, informe `01`, J9-08), D-5 (Formal convocada, informe `02`, J9-06), D-6 (Trazabilidad convocada, informe `03`, J9-10), D-3 (por remisión, J9-15), D-7 **[presidente]**: conservación permanente de los expedientes, declarada en la regla §5.1 — no la votó ningún jurado, y se declara como decisión del presidente sobre la propuesta del folio 016 §4. **D-1** es de la corrida de migración de `Lab-Geometria` y no la cierra esta intervención.

## 6. Cierre

```text
CIERRE DE MESA — intervención 09 (reporte 31), 2026-09-13

  PANEL
    Convocados:   Seguridad (AG-00050), Formal, Trazabilidad documental (AG-00110), Requisitos, Verificación,
                  Lector sin contexto, Refutador (re-despachado una vez: constancia 07)
    Hallazgos:    64 (8 × 8) procedentes en su dirección; ninguno fundó un parche con ancla C
  JURADO
    Cinco agentes distintos; 17/17 PROCEDE, 5-0; sin veto; homogeneidad 100 % declarada (§2)
  ENTREGA
    Parches:      la regla corregida y el plan corregido (borrador/ ya reemplazado en la aplicación)
    Deuda:        D9-1 a D9-3
    Escaladas:    ninguna (E-3 resuelta por C con respaldo del jurado; PR #66 evaluado, sin acción)
  CIERRE
    Por decisión, con lo abierto enumerado en §5.
```
