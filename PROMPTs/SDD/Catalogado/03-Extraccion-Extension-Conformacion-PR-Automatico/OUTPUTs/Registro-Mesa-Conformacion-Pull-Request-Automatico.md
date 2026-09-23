# Registro de la mesa — Conformacion-Pull-Request-Automatico

**Fecha:** 2026-09-19
**Marco:** `IA/PROMPTs/IA.Prompts/Base/Mesa-Evaluadora.md`
**Objeto:** `Knowledge-Conformacion-Pull-Request-Automatico.md` y su fila de índice, en esta misma carpeta

Este archivo **no forma parte de lo que se incorpora a un fork**. Es la constancia de cómo se llegó a
los dos entregables.

---

## 1. Lectura del pedido

| Punto del tool-prompt | Cómo se resolvió |
| --- | --- |
| «Generes dos documentos como dicta la estructura de la base desacoplada» | `Rules-Base-Conocimiento.md` §2.1 y §8 fijan exactamente dos piezas: el `Knowledge-<Tema>.md` y su fila en `Index-Knowledge.md`. Son los dos entregables |
| Párrafo del template con ABM clásico, asistente de 3 o 4 niveles y ventanas modales, y la maqueta HTML/CSS | **Fuera de alcance**, declarado. Es un resto copiado del tool-prompt que originó `Template-HTML-SDD-Default`: no tiene relación con el pull request, ese conocimiento ya está catalogado en el framework, y la misma oración termina con «Catalogalo a este como: `Conformacion-Pull-Request-Automatico`». **Confirmado por el autor del pedido el 2026-09-19**: el párrafo no debía ir; el alcance era sólo la conformación automática del pull request |
| «En base a los proyectos dados en el contexto» | El contexto sólo nombra el framework. La práctica automática se relevó donde existe: las convenciones de un proyecto que reglamentaron la delegación del merge, el registro de corridas del taller y la API de la plataforma (§2) |
| No modificar el `Framework SDD` | Cumplido: nada se escribió en `IA.SDD`. La fila de índice se entrega aparte, con su procedimiento de alta |

## 2. Evidencia relevada

| Qué | Dónde | Qué aporta |
| --- | --- | --- |
| Norma del traspaso | `IA.SDD` `Master-Prompt.md` §12.1 T0–T6 y §8.1 | T1 prohíbe el merge del agente, así que la variante es una desviación |
| Padre | `IA.SDD` `Conocimiento/Knowledge-Conformacion-Pull-Request-Manual.md` | Su §8 anticipa que una variante que cambie quién fusiona es desviación y se declara en su §8 |
| Reglamentación real de la delegación | Convenciones comunes de un proyecto privado del taller, §8.5 «Delegación del merge al agente — sólo por decisión explícita del responsable» | Qué se pierde, con qué se compensa, cómo se asienta; y el informe fuera de bloque cercado (§8.2) |
| Práctica medida | Registro de corridas del agente del taller (2026-08-31 a 2026-09-14) | La API por HTTP con la credencial de `git`, la guarda explícita, `unstable` = controles fallando (seis fusiones encadenadas), la credencial por cuenta, `worktree` por corrida |
| Análisis previo del usuario | `IA.SDD.Documentacion/Analisis/Git-Workflow-Agente/Git-Workflow-Agente.md` | La forma manual de la limpieza local (`pull --ff-only`, `branch -d`, `fetch --prune`) |
| Medición del día | API de la plataforma, 2026-09-19 | Tres pull requests recientes de tres repositorios, con `merged` verdadero y `merged_by` igual a la cuenta dueña de la credencial (la atribución no se distingue). Una rama borrada da 404. `permissions.push` es legible. Las corridas traen `status` y `conclusion`. `curl -H @<(…)` no deja la credencial en los argumentos |
| Historia de merges | `git log --merges` de dos repositorios: 68 y 170 commits «Merge pull request» | El método observado es el commit de merge |

## 3. Composición del panel

| Rol | Por qué | Hallazgos |
| --- | --- | --- |
| Requisitos | Núcleo | 6 |
| Verificación / QA | Núcleo | 7 |
| Implementador ingenuo, que leyó sólo el documento y su padre | Núcleo | 7 |
| Abogado del diablo | Núcleo | 6 |
| Seguridad | Señal: credencial con permiso de merge y publicación en un repositorio público | 2 |
| Operación y entrega | Señal: controles, espera y relectura, merge por API, carrera con la principal | 7 |
| AH-001 Conformidad con la base | Ad hoc. Pregunta: ¿pasa la lista de §6.1 de `Rules-Base-Conocimiento.md`? | 3 |

Trabajaron a ciegas y en paralelo. Hubo un corte por límite de la API y se reanudaron sin pérdida. El
jurado se despachó por separado con sus cinco funciones.

## 4. Veredictos

43 hallazgos, consolidados en 18 ítems. Conteo en el orden PROCEDE / NO_PROCEDE / INSUFICIENTE.

| Ítem | Qué | Conteo | Resultado |
| --- | --- | --- | --- |
| C1 | 301 líneas contra techo 250 de `canonico` | 5/0/0 | PROCEDE, opción A |
| C2 | La fila no está en el índice real | 0/5/0 | NO_PROCEDE: restricción dura, se entrega aparte |
| C3 | El merge no se ataba a la cabeza auditada | 5/0/0 | PROCEDE |
| C4 | «Todas en éxito» sobre cero corridas aprobaba | 5/0/0 | PROCEDE |
| C5 | Se borraba la rama sin leer la respuesta del merge | 5/0/0 | PROCEDE |
| C6 | Techo de espera sin valor ni bucle | 5/0/0 | PROCEDE |
| C7 | En curso, fallida y `mergeable` sin distinguir | 5/0/0 | PROCEDE (paginación y prosa de `unstable`, archivadas por nivel C) |
| C8 | Sin comprobar la ausencia de la rama; alcance del borrado | 4/1/0 | PROCEDE |
| C9 | Sin leer los controles del commit de merge | 5/0/0 | PROCEDE |
| C10 | Familia de API sin declarar | 4/1/0 | PROCEDE, sólo declararla |
| C11 | `$API`, `$T` y permiso sin procedimiento | 5/0/0 | PROCEDE (S2) |
| C12 | Credencial en argumentos de proceso; techo de alcance | 4/1/0 | PROCEDE, sin imponer una credencial distinta |
| C13 | Formatos en `Master-Prompt.md` | 3/2/0 | PROCEDE acotado: se define `Base`, no se copian los formatos |
| C14 | «Se decide a la vista» ante una falla que ya estaba en la principal | 5/0/0 | PROCEDE: es reserva |
| C15 | 4b y G4 duplicados | 0/5/0 | NO_PROCEDE |
| C16 | `Hereda-de` frente a variante hermana | 0/5/0 | NO_PROCEDE: decisión cerrada, con precedente Template-Blazor |
| C17 | La delegación no es verificable desde el índice | 3/2/0 | PROCEDE acotado: el informe la cita; sin encontrarla rige el padre |
| C18 | Espera entre el merge y la alcanzabilidad | 1/4/0 | NO_PROCEDE |

**C1, opción A:** cuerpo bajo 250 líneas sin §5, y §5 declarado en §0 como la excepción de §6.2, con el
precedente de `Knowledge-Bundle-JS`. Se descartó el artefacto ejecutable aparte porque suma un tercer
archivo y un guion que no se probó en un pull request real, y la partición en hermanos porque fragmenta
un delta.

## 5. Aplicación y verificación

| Comprobación | Resultado |
| --- | --- |
| Cuerpo sin §5 (`awk` hasta §5 y desde §6) | **248** líneas. Documento completo: 346 |
| Sintaxis de §5.1 y §5.2, con los marcadores reemplazados (`bash -n`) | Correcta |
| Guarda, merge y borrado contra una API simulada | 9/9: cero corridas → reserva; en curso hasta el techo → reserva; fallida → reserva; `unstable` con controles verdes → reserva; `unknown` hasta el techo → reserva; cabeza cambiada → reserva; merge rechazado → **sin DELETE**; rama viva después del DELETE → se detiene; camino feliz → MERGE y DELETE |
| Preparación de §5.1 contra la plataforma real (sólo lectura) | `REPO` derivado del remoto; credencial obtenida por cuenta con `git credential fill`; `permissions.push` = `true`; la credencial no aparece en argumentos |
| Ofuscación (`grep` de organizaciones, cuentas, repositorios, productos, dominios y números de PR) | Sin coincidencias |
| Cabecera frente a la fila de índice, campo por campo | Coinciden, `Tema` incluido |
| Numeración interna | Contigua: §3.1–§3.5 y §5.1–§5.3 |

**No se ejecutaron** un merge ni un borrado reales por este documento: se probaron simulados. Se
declara en §9 del documento.

## 6. Cierre

```yaml
cierre:
  version_final: Knowledge-Conformacion-Pull-Request-Automatico 1.0
  ciclos_ejecutados: 1
  motivo_de_parada: no quedan hallazgos PROCEDE abiertos por encima de S2; todos aplicados y verificados
  panel:
    convocados: [requisitos: 5, qa: 6, implementador: 6, diablo: 2, seguridad: 2, operacion: 7, AH-001: 1]
    descartados: [rendimiento y costo: sin volumen declarado, datos y dominio: sin entidades]
    ad_hoc: [AH-001: conformidad con la base; detectó el exceso de techo, el único S1 de forma]
  hallazgos: { detectados: 43, items: 18, procedentes: 14, aplicados: 14, revertidos: 0 }
  deuda_declarada:
    - C2: la fila vive fuera del índice real hasta que un fork la pegue (restricción dura)
    - C7: paginación mayor a 100 corridas y controles externos a la familia de API sin cubrir (nivel C)
    - T1 no rotulado como decisión de stack: la variante será siempre desviación
  escaladas_pendientes: []
  capas_a_revalidar: [la fila de índice, si cambia la cabecera]
```
