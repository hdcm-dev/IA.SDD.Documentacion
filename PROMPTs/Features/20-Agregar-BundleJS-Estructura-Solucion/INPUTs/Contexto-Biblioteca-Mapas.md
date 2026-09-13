


  ## Proyecto que incluye y estructura en su solución bundle javascript


  Leer `<repo-privado-de-mapas>.Documentacion/ia-db/README.md`, es una solución que incluye una demo PoC de un proyecto libreria de clases de .NET , incluye el proyecto del artifact javascript que consume esos proyectos. Ese artifact se constituye en dos javascript, un bundle que resulta de transpilar un proyecto javascript typescript y otro javascript (main.js) que sirve de interfaz que se antepone ante las llamadas entre los proyectos blazord .net y el bundle javascript. Esta estructura de main.js con funciones para ser invocadas desde blazor .net y una clase para invocar metodos del bundle y registrar los callback de java interoperative (todo en main.js). En adición incorpora tambien una PoC HTML que sirve de prueba de concepto y para apoyo en la fase de diseño del bundle.


  - `<repo-privado-de-mapas>/JS.Bundle`, es un `proyecto en nodejs`, el objetivo es crear un bundle webpack para   incluir luego mediante una clase interfaz y un javascript main.js en el assets de un proyecto .net blazor. Actualmente el desarrollo esta centrado y actualizado en `GoogleMaps`. El proyecto `OpenStreet` quedo totalmente desfasado. El desarrollo `GoogleMaps, contempla un par de páginas html puro con javascript embebido que emula la invocación de los métodos javascript en main.js tal como lo hace dotnet blazor a traves de java interoperative sobre paginas interactive server, esto permite desarrollar y probar sobre esas páginas htmls. 

  - `<repo-privado-de-mapas>/examples/WebBlazor_JS`, es una solución visualstudio para visualstudio, el objetivo es que sirve de `Proyecto PoC .NET Blazor` (PoC, Proof of Concept). Básicamente se toma el main.js y el bundle transpilado y se lo incluye en el assets tal como se haría en un proyecto en desarrollo. Además este `Proyecto PoC .NET Blazor` sirve de ejemplo para futuros desarrolladores que quieran usar el bundle transpilado y el main.js.

  El foco principal de esta solución de software es resolver la dinámica necesaria que solo puede resolver javascript sobre un navegador web y que hoy no ofrece blazor .net. Concretamente la libreria ofrece un bundle tanspilado y un main.js que hace de interfaz entre el javascript interoperative de blazor .net y el bundle transpilado . El bundle trnaspilado para este caso puntual maneja los objetos de google maps, y permite en un futuro cambiar el proveedor de mapas. sin cambiar demasiado desde el lado de blazor .net.