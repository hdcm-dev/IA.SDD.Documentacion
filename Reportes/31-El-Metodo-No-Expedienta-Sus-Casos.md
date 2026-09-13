# Reporte 31 — El método no expedienta sus casos

| Campo | Valor |
|---|---|
| Reporte | 31 |
| Fecha | 2026-09-13 |
| Origen | **El expediente `IA.SDD/Expedientes/0001-Expedientes-Como-Comportamiento-Del-Framework/`**, el primero del repositorio del framework. Está en la rama `expedientes/0001-caso`, sin push. Su presentación es el pedido del Product Owner del 2026-09-13, preservado byte a byte en su `evidencia/ev-07-presentacion-original.txt`: *«Vamos a adoptar como parte del `Framework SDD` que los expedientes y casos que se armen se documenten de forma sistematica […] las pruebas que aporse yo o las que obtuviesen los agentes quedarian como prte de las especificaciones- arregla esa idea y mejorala en base a los etandares de la industria y la academia»*. Este reporte **es el pase** del dictamen de ese expediente (folio 016) a la intervención `09` |
| Versión del framework evaluada | SDD **13.16** (`IA.SDD` `main` `8c55a1e`): `Mesa-Rules.md` 1.3 · `Master-Prompt.md` §7.0, §8.1, §8.2 y §12.1 · `Master-Prompt-Migracion.md` · `Master-Prompt-Reanudacion.md` §2 y §5 · `Root-Rules.md` §9 a §12 · `Deriva-Rules.md` §1 · `SDD-Development-Guide.md` §II.7, §III.8 y §VI.5 · `README.md` (D3, D5, D9 y autosuficiencia). Tiene en cuenta la **13.17**, preparada y no fusionada: rama `conocimiento/mesa-de-expertos-a-pedido`, `cab03ed` |
| Artefactos del framework alcanzados | Una **regla transversal nueva**; `Master-Prompt.md` §3.5, §8.1 y §12.1 T1; `Master-Prompt-Migracion.md` M4; `Master-Prompt-Reanudacion.md` §2 y §5; `Mesa-Rules.md` §0.0, §2.1 y §8; `Migracion-Rules.md` §2.2; `Root-Rules.md` §9.2 y §9.5; `SDD-Development-Guide.md` §VI.5; `README.md` l.152; `SDD-User-Guide.md`; y, de la 13.17, `Conocimiento/Knowledge-Mesa-De-Expertos-A-Pedido.md` §2.3, §3.2, §5.2, §5.3 y §6 |
| Naturaleza | **Una unidad de trabajo que el método practica y no nombra.** El framework tiene contenedores por artefacto: ADR, informe de audit, registro de mesa, informe de estado, ítem diferido, fila de decisión pendiente. No tiene ninguno para **el caso**, que atraviesa artefactos, corridas y repositorios. Los destinos lo inventan, y cada uno con otra forma. **Además, la evidencia que funda una decisión no tiene dónde quedar** con procedencia y custodia |
| Estado | **Abierto** |
| Reportes relacionados | **`18`**, la mesa se convoca por condición: este reporte pide lo mismo para el expediente y **no reabre** esa decisión. **`26`**, origen del hecho: la figura lo reutiliza y no crea otro eje. **`27`**, ciclo de origen: **no se toca** (§6). **`28`**, colisión con comando: toda afirmación de nombre de este reporte lleva su medición. **`12`**, el framework no distribuye código: la evidencia lleva su comando en el texto. **`30`**, precedente del canal: una especificación de destino con mesa alimenta un reporte |

---

## 1. Resumen

**El 2026-09-13, sin que el framework tuviera norma para eso, se abrieron dos expedientes.** Uno en
`IA.SDD`, sobre esta misma adopción, y otro en la migración de `Lab-Geometria` a 13.16
(`SDD/Expedientes/0001-Migracion-Normativa-A-13.16/`, rama `migracion/a-13.16`). **Salieron con dos
formas distintas el mismo día**: cuatro dígitos contra `EXP-0001`, evidencia `ev-NN` con guiones `.sh`
contra `E-NNN` con `.py`, y tabla de artefactos derivada contra tabla declarada. A esas dos se suman la carpeta de mesa
de la 13.17 §2.3 y el precedente `Mesa-2026-09-12-Colision-Lexica/`, que llama «expediente» a cada
pieza. **Son cuatro formas vivas de lo mismo.**

**La mesa del expediente `0001`** trabajó con ocho comisiones a ciegas, una réplica independiente del
panel entero, un refutador y un jurado. Concluye que **la figura hace falta y tiene que ser mínima**:
dieciocho campos en un caso de dos folios, **sin ningún dato derivado escrito a mano**. El plan
compuesto del presidente pedía cuarenta y siete campos y doce pasos, y el refutador lo midió.

**El primer ejemplar vivo cometió en su primer folio el defecto que la figura existe para impedir**:
presentó como literal un pedido del Product Owner que estaba normalizado, reordenado y recortado. Lo
encontró la réplica y no la primera convocatoria.

---

## 2. La evidencia

Todo lo que sigue está en el expediente, con procedencia. Las mediciones se corrieron el 2026-09-13
sobre `IA.SDD` `8c55a1e`, `Lab-Geometria` `main` `b9675d8` y `RPI.VideoControl` `HEAD` `9aabe5c`.

### 2.1 El caso no tiene contenedor, y en un destino hay que reconstruirlo buscando

La comisión «lector sin contexto» (folio 008) reconstruyó la fase `k` de `Lab-Geometria` sólo con
`git ls-tree` y `git show`:

- **seis archivos de `SDD/Docs/Audit/`**, sin índice (`SDD/Docs/README.md` l.100 los describe como «uno por fase»);
- **cinco bases de corrida** que nada encadena;
- el **desenlace fuera de `Audit/`**:

```bash
git -C Lab-Geometria ls-tree -r --name-only main SDD/Docs/Audit | wc -l        → 113
git -C Lab-Geometria grep -E 'v1\.1\.0|v1\.0\.0' main -- SDD/Docs/Audit | wc -l → 0
```

El precedente de la mesa de `IA.SDD.Documentacion` perdió su versión 1.0 de cierre **antes del primer
commit** (folio 009, V3-01):

```bash
git log --oneline -- PROMPTs/Fixs/05-Fix-Reporte-27/OUTPUTs/Mesa-2026-09-12-Colision-Lexica/06-Plan-Y-Cierre.md → 1 commit (eff6729)
```

El control de cambios de ese archivo tiene dos filas, 1.0 y 2.0.

### 2.2 La norma no tiene la figura

```bash
grep -rn -i "expediente" --include=*.md --exclude-dir=_legacy SDD PROMPTS Templates Conocimiento README.md
  → SDD/Devs/Rules/Migracion-Rules.md:669  (una sola, en prosa)
```

**«Punto de continuación» existe sólo en la reanudación** (`Master-Prompt-Reanudacion.md` l.452). Y un
orquestador que tropieza a mitad de M4 **se detiene**, porque así lo manda
`Master-Prompt-Migracion.md` l.291. Además, l.46 prohíbe reconvocar la mesa. La noción «ante un
problema, mesa» sólo se deduce cruzando con `Mesa-Rules.md` §0.0 (folio 008, N3-05).

### 2.3 La premisa de ubicación que traía el caso era falsa

La hipótesis de partida era **«el expediente del framework va en la raíz porque `SDD/` se copia entero a
`_legacy/`»**. Lo que se copia es **toda la raíz menos una lista cerrada**:

```bash
git ls-tree --name-only 8c55a1e                   → .gitignore CHANGELOG.md Conocimiento Examples PROMPTS README.md SDD Templates _legacy vs.bat
git ls-tree --name-only 8c55a1e _legacy/13.15/    → Conocimiento Examples PROMPTS README.md SDD Templates
grep -n "Quedan fuera del snapshot" SDD/Guides/SDD-Development-Guide.md → l.990
```

**Una carpeta `Expedientes/` en la raíz entra al snapshot**, como entraron `Conocimiento/` y `Examples/`.
Lo detectaron por separado V1, N1 y V5 en las dos convocatorias.

### 2.4 La evidencia de la presentación no era lo que decía ser

El folio 001 del expediente declaraba *«Se transcriben sin editar, incluidas las marcas de formato del
original»*. Contra el mensaje original (`ev-07`: 1486 bytes, SHA-256
`cb39bbd64dd919e3bb7ad484779c4215af473892cf02de5b797c76046f63dd1c`):

- la ortografía está normalizada;
- los tres pasajes están en orden inverso;
- falta el párrafo inicial, que daba el OK de la fase `k` y la prioridad de las migraciones.

**La réplica lo encontró con nivel P0. La primera convocatoria no.** La corrección entró como folio
nuevo (012), sin reescribir el 001. El segundo ejemplar, el de la migración, **tiene el mismo defecto**:

```bash
fragmento de ev-07            ev-07  mig/001  mig/002
'me centraria primero'          1      0        0
'tenes el ok'                   1      0        0
```

### 2.5 La evidencia no tiene clase para lo que el Product Owner aporta

`Deriva-Rules.md` l.53 admite `humano` como *«una aprobación explícita registrada con fecha»*, y l.55
excluye *«una captura de una conversación»*. `ev-07` empieza con «tenes el ok de la fase K», y
`Lab-Geometria-mig1316` lo usó para cerrar la fase `k` (commit `7864428`). **Para este caso, las dos
oraciones de D9 chocan.** La 13.17 §3.2 resuelve el hueco llamándolo *«evidencia E4»*, pero E4 es
«regla declarada» en `Mesa-Rules.md` §6.1.

### 2.6 La forma que parece natural se cae al aplicarla

El refutador (folio 014) construyó un caso de dos folios aplicando el plan compuesto al pie de la letra.
Obtuvo **47 campos, 4 archivos, N+1 commits y 12 pasos**, contra el presupuesto de nueve de la guía
(l.630). Encontró además tres defectos:

- el `README.md` copiaba a mano el estado, el índice y el commit del último folio, y **un commit no puede contener su propio hash**;
- el control de inmutabilidad no miraba `evidencia/`;
- «un folio por commit» se pierde con la fusión por squash que `Rules-Devops.md` l.452 recomienda.

El índice del segundo ejemplar ya omitía seis evidencias existentes. **El jurado aprobó la forma
alternativa de dieciocho campos**, con reparto de 4-1.

### 2.7 Evidencia sensible ya sellada en ramas de repositorios públicos

```bash
curl -s -o /dev/null -w '%{http_code}' https://github.com/hdcm-dev/IA.SDD → 200
git -C IA.SDD-exp1 grep -cF '/home/' HEAD -- Expedientes                  → rutas de host en el expediente
```

Un nombre propio salido de una captura de `Lab-Geometria/evidencia/` quedó copiado verbatim en un
informe del expediente. Si es un dato real no está determinado (`C`). **La compuerta de ofuscación
alcanza sólo a `Conocimiento/`** (`Rules-Base-Conocimiento.md` l.162).

---

## 3. Qué dice hoy el framework, y por qué no alcanza

### 3.1 Lo que resuelve bien, y no hay que tocar

- **`SDD/Docs/Audit/`** como lugar de los registros de mesa y de los informes de migración, estado y
  audit. **La figura folia por enlace y no muda nada.**
- **El origen del hecho** (`Master-Prompt.md` §8.1) y **el ciclo de origen** (§8.2). La figura los
  reutiliza. **El ciclo de origen no recibe un campo más** (folio 015, R-10).
- **D9** con sus cuatro condiciones, y **la no retroactividad** (`Deriva-Rules.md` l.59).
- **La condición de convocatoria de la mesa** (§0.0) y **el lote con `SI NO RESPONDÉS`** (§7.0).
- **La neutralidad de stack.** Hablar de commits no la rompe, porque la norma ya lo hace
  (`Migracion-Rules.md` l.678 y l.682; `Master-Prompt.md` l.1131).

### 3.2 Lo que no está

- **a)** Una figura para **el caso**, con condición de apertura y umbral de no apertura.
- **b)** Un **lugar declarado**, tanto en el destino como en el framework, y su exclusión del snapshot.
- **c)** Una **forma mínima** sin datos derivados escritos a mano, y **estados derivados** de sus piezas.
- **d)** **Inmutabilidad observable**, que alcance también a la evidencia y a los renombres.
- **e)** **Custodia del original** de lo que aporta el Product Owner, y **clasificación por contenido** de su testimonio.
- **f)** El **vínculo** entre evidencia y especificación **en los dos sentidos**, sin una segunda declaración.
- **g)** **«Ante un problema, mesa y no detención»** escrito donde el orquestador tropieza, acotado a las familias que preguntan.
- **h)** Un **punto de continuación** fuera de la reanudación.
- **i)** Una **compuerta de datos personales** para la evidencia que no es de `Conocimiento/`.

---

## 4. El hueco, en una frase

**El framework tiene contenedores para cada artefacto y ninguno para el caso que los atraviesa, de modo
que la evidencia que funda una decisión —incluida la palabra del Product Owner— queda sin lugar, sin
custodia y sin vínculo con lo que cambió; los destinos lo inventan con formas distintas el mismo día, y
la forma que parece natural es una ceremonia que nadie completa.**

---

## 5. Qué se propone evaluar

**El punto de partida es el dictamen del expediente** (folio 016), no una redacción. La intervención
**lo verifica y lo aplica, o lo corrige con fundamento**.

### 5.1 El caso de fondo, que se decide primero

**¿El método adopta el caso como figura normada, con la forma mínima del dictamen, que tiene dieciocho
campos, ningún dato derivado a mano y estados derivados?** Si la respuesta es no, hay que decir dónde
queda escrito un caso que atraviesa corridas y cómo se custodia la palabra del Product Owner. **Una
decisión negativa con fundamento es un desenlace válido**, con el precedente del reporte `12`.

### 5.2 Las tres escaladas del lote

Salen al Product Owner con su valor por defecto (folio 015 §5). La intervención **lee primero si fueron
contestadas**:

| Escalada | Qué pregunta | Si no hay respuesta |
|---|---|---|
| **E-1** | ¿`IA.SDD/Expedientes/` con la autosuficiencia reformulada, o `IA.SDD.Documentacion/Expedientes/`? | `IA.SDD/Expedientes/` |
| **E-2** | ¿El nombre propio copiado es un dato personal real? | Se redacta |
| **E-3** | ¿D9 suma una oración para la aprobación por conversación con original y huella? | No se suma, y el salto queda **minor** |

### 5.3 Las doce preguntas

Q1 a Q12 del dictamen, una por una: ubicación, apertura, forma, identificador, estados, inmutabilidad,
evidencia, evidencia → especificación, relación con `Audit/`, retroactividad, mesa en lugar de detención
y punto de continuación.

### 5.4 La deuda que el ciclo dejó

- **D-2** Seguridad, **D-5** Formal y **D-6** Trazabilidad se convocan en la mesa de la intervención.
- **D-7** disposición.
- **D-3** alineación de la 13.17.
- **D-1** es de otra corrida y **no la cierra la intervención**.

---

## 6. Lo que este reporte no afirma

- **No afirma que haya que mudar nada.** Ni los 113 archivos de `Lab-Geometria/SDD/Docs/Audit/`, ni los
  51 de `RPI.VideoControl`, ni los `OUTPUTs/` de las intervenciones.
- **No afirma que el ciclo de origen tenga que citar el expediente.** El jurado lo rechazó (R-10).
- **No afirma que la palabra del Product Owner sea evidencia de estado.** Funda intención, y cuando es
  aprobación es `humano`.
- **No afirma que el dictamen sea la regla.** Es el punto de partida medido, y su propio jurado se
  declaró sospechoso de homogeneidad (81 %, un solo agente).
- **No reabre el reporte `12`**: ningún verificador distribuido, los comandos van en el texto.

---

## 7. Cómo verificar que la corrección funcionó

1. **La forma mínima se llena en minutos y se verifica enumerando.** Hay que abrir un expediente de dos
   folios usando sólo lo que el framework dice, y contar: **no más de dieciocho campos**, ningún dato
   derivado escrito a mano, y **los diez criterios `[enumerable]` del dictamen (A1 a A10) corren con su
   comando dentro de la regla**. Si hace falta un script aparte, no alcanzó.
2. **La exclusión del snapshot funciona.** `_legacy/<vigente-anterior>/` **no contiene `Expedientes/`**,
   y la línea de exclusiones de la guía §VI.5 la nombra.
3. **Un orquestador que tropieza a mitad de M4 sabe que convoca mesa**, y la confirmación de plan y T4
   **siguen deteniéndose**. Se prueba leyendo `Master-Prompt-Migracion.md` M4 y l.46 con los ojos del
   lector sin contexto.
4. **La inmutabilidad es observable y ve la evidencia.** Sobre un clon, borrar un archivo de
   `evidencia/` después del push hace fallar el criterio A7.
5. **No hay cuatro formas vivas sin nombre.** Los dos adelantos y el precedente están declarados como
   forma histórica, y la 13.17 está alineada en §2.3, §3.2, §5.2, §5.3 y §6. Se verifica con `grep` de
   `00-Contrato-De-Entrada` y de «evidencia E4» en `Conocimiento/`.

---

## Control de cambios

| Versión | Fecha | Cambios | Autor |
|---|---|---|---|
| 1.0 | 2026-09-13 | Emisión inicial. Nace del **expediente `0001` del repositorio del framework**, el primero, que es a la vez el caso y su primer ejemplar vivo. **Primer reporte de la serie cuyo origen es un expediente foliado**, con réplica del panel, refutación, jurado y dictamen, y **primero que incluye la corrección de su propia presentación** (folio 012). Declara la evidencia del caso, la forma que se cayó al aplicarla y las tres escaladas en lote. | Orquestador, como presidente de la mesa del expediente `0001` |
