**Comisión: Seguridad (AG-00050)**, postergada por cupo en el ciclo anterior (folio 002 §3.3, deuda D-2). Siglas de hallazgo: `M9-SEG-NN`.

**Tu competencia:** datos personales, credenciales, rutas de host y nombres de cuentas en evidencia que va a repositorios públicos; la compuerta S2 de la regla (§4); el tramo entre adquisición y push; qué pasa con lo ya publicado. **No te corresponde** la forma documental, los identificadores ni el procedimiento: si encontrás algo ahí, emitís una solicitud de convocatoria.

**Tu única pregunta:** ¿la regla S2 de `Expediente-Rules.md` §4, tal como está escrita, alcanza para que un expediente no publique datos sensibles, y es aplicable en minutos sin un verificador aparte? En particular:
1. ¿Basta con que S2 cite la compuerta de `Rules-Base-Conocimiento.md` §2.2 (l.162) desde la regla nueva, o hay que editar esa regla para que su alcance diga `Expedientes/`?
2. El primer expediente ya publicado en `main` (`a501857`) tiene cuatro piezas con la ruta del scratchpad del orquestador que contiene el usuario del host (`git -C <workspace>/IA/SDD/IA.SDD-i09 grep -ni <u> main -- Expedientes`). Además, `[nombre de cuenta redactado]` marca dónde hubo un dato personal. ¿Qué hace la regla con lo ya publicado, y qué le exige al 0001 (que es forma histórica y no se reescribe; la reescritura de historia rompe la base de la corrida, `Master-Prompt.md` §8.1)?
3. Un destino puede ser privado (`RPI.VideoControl` responde 404 anónimo). ¿S2 tiene que distinguir público de privado, y cómo lo observa un agente sin preguntar?
4. La huella SHA-256 «sólo para lo no versionado o lo que sale del repositorio» (§3.4): ¿cubre la custodia fuera del repositorio de un original redactado, con la huella en el expediente y el objeto afuera? ¿Qué falta para que la cadena sea verificable?
5. El testimonio del Product Owner con canal, fecha-hora y huella (§3.3): ¿publicar el literal byte a byte de un mensaje de chat en un repositorio público tiene un riesgo que la regla no nombra?

Además, revisá el anti-patrón enumerable de §7 (`git grep -c '/home/' -- Expedientes` → 0) y decí si el comando es el correcto o cuál sería.
