# Tool-Prompt — Reestructurar el proyecto

> **Invocación**: Leer y ejecutar `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Features/20-Agregar-BundleJS-Estructura-Solucion/01-Agregar-BundleJS-Estructura-Solucion.md`
>
> **Overview**:  Extracción de comportamientos del template de Lab-Geometria.

---

## Contexto

  Leer `/IA/SDD/IA.SDD/README.md` trata sobre un `Framework SDD` 

  Leer `/PORG2/Geometria/Lab-Geometria.Documentacion/ia-db/README.md` Espcificación de `Geometria`, relativo a  `visor`, que es un proyecto nodejs que luego se transpila en un webpack para incluir en los proyectos blazor .NET.

  Leer `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Features/20-Agregar-BundleJS-Estructura-Solucion/INPUTs/Idea-Central.md`, `Geometria` cuenta de ideas que se pueden considerar a la hora de estructurar una solución .net armonizada, organizadas y estructuradas como una solución .net que toma proyectos otros proyectos. Este incluye un visor para figuras 3d y arbol de un json en javascript.

  Leer `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Features/20-Agregar-BundleJS-Estructura-Solucion/INPUTs/Contexto-Biblioteca-Mapas.md`, describe una estructura mas deseable a incorporar.

  En `Geometria` se plantea una estructura 
  1- Un bundle - o weback transpilado -  desarrollado typescript que encapsula la logica de representación grafica final en el navegador y cuyo interfaz proponga dto que sirvan de intercambio entre fuera y dentro de ese bundle javascript
  2- Este webpack se incluye en blazor .NET y se invoca a traves de un funciones export y una clase para manejar el registro de los callback

```
  // clase para manejar las invocaciones al bundle transpilado y registro de callback hacia javainteroperativo
  class NombreProyectoJavaScriptBlazor{
  //...
  }

  // clase para manejar las invocaciones al bundle transpilado y registro de callback hacia javainteroperativo
  export async function InitializeNombreProyectoJavaScriptAsync(dotnetHelper, options)
  {
      ... invocaciones a NombreProyectoJavaScript...
  }
  //...
```
  Como referencia está: `<repo-privado-de-mapas>/JS.Bundle/Maps/GoogleMaps`

  3- Este visualizador es recomendable trabajarlo a traves de libreria de clases para Blazor .NET. Como referencia esta: `<Mapas>.Core.Blazor.Components` 


  Se busca aun el criterio y homogeinazar la estructura la solución general y armonizar el dicha solución bajo los puntos:

  Acorde a la estructura de solución que se propone en `Framework SDD` , En el caso de `Geometria` se sigue esa estructura de como debe ser la solución de .NET. Seria interesante plantear un plan en el que las PoC se estructure en `/demo` y que todos los proyectos sean parte del arbol de solución, donde las PoC HTML se pueden incluir como proyecto de carpetas web dentro de la solución.
  

---

## Objetivos

  Evaluar la estructura de soluciones que tengan proyectos que no son parte del arbol estructural .NET. y como se integran sus PoC

---

## Solicitudes

  - Evaluar el contexto, y tomando como punto de referencia central la estructura de solución que propone  `Framework SDD`  evaluar el resto de los proyectos que no forman parte de una solución estandar .NET y de los cuales luego se integran como parte funcional de los proyectos .NET  y cuyo desarrollo forma parte de todo el conjunto completo. Iniciar antes de modificar  `Framework SDD` realizar las propuestas .

  
  
  - Ir condensando las propuestas, debates en este documento `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Features/20-Agregar-BundleJS-Estructura-Solucion/OUPUTs/Especificacion-Estructura-Solucion.md` con el fin que otro agente pueda reproducir finalmente de forma clara lo que se llegue a establecer.

---

## Reglas

  - No inventar información. 
  - Toda afirmación debe estar respaldada por evidencia verificable.
  - No modificar el `Framework SDD`

