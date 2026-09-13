

Esos poc serian en realidad samples, 

el tema es que esos samples son proyectos dentro de la solución que sirven para probar los contratos y funcionalidades que ofrecen los proyectos que forman parte de la solución.

La idea se centra en que si una solución trata sobre una api rest, exista otro proyecto que consuma esa api y sirva como ejemplo a los futuros desarrollos.

Si el api Rest objetivo es para ser consumido en una aplicación web debería corresponderle una PoC como sample a incluir que haga las invocaciones. Si fuese una libreria nuget para una aplicación MAUI .net deberia incluir una aplicación maui que sirva de ejemplo de uso esa libreria nuget.

Puede que la api vaya acompañada de librerias nugets para fines especificos - es decir, la solución puede tratar de un api rest que sea servicio pero se especifica otros proyectos complementarios como librerias nugets que sean de integración. Así estos samples deben enfocarse en integrar los proyectos nugets y tambien uno que integre a la respai. En este caso, este último no es de ejmplo de integración, pero es vital para las fases de codeo y revisión para con el usuario que se cumplen los contratos , es decir, durante el ciclo de desarrollo hasta que se codeen y publiquen los proyectos de librerias nuget.

así que el rol de esos proyectos samples , van un poco mas lejos que ser simples proyectos para demostrar al usuario como se usa o consume una api o una libreria nuget, sino que tambien para ser parte de los ajustes y evidencias de cumplimiento de contratos y comportamientos esperados.

Ahora , bajo el concepto de que puede que haya proyectos fuera de lo que es .net, por ejemplo generar un bundle javascript que luego una libreria de clases blazor.net integrar para pintar , como es el caso de los mapas, algo en el navegador .


Aquí para estos proyectos no ordinarios, compo puede ser en nodejs se puede plantear en samples bajo un proyecto simple html que integre pero que se piense en una estructura como propone el `DEVMap` pensado para que sirva de guia para la integración en el proyecto de clases Blazor .NET

