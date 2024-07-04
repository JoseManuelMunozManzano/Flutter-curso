# hello_world_app

En esta sección crearemos nuestra primera aplicación real de Flutter, la que nos enseñará cosas como:

- Stateful y Stateless Widgets
- Scaffold
- FloatingActionButtons
- Column
- Widgets personalizados
- Constantes
- MaterialApp
- Introducción a Material Design 3
- Color Schemes
- AppBars

## Creación de proyecto desde VSCode

- Pulsar Cmd+Shift+P
- Escribir y seleccionar Flutter: New Project
- Seleccionar Application
- Seleccionar el directorio donde guardaremos el proyecto
- Indicar el nombre del proyecto, que deberá ser todo en minúsculas, y, si se separa por palabras, usar el guión bajo.
  - Nuestro proyecto se llama: `hello_world_app`
- Empieza a generarse la app, y Flutter detecta en qué Sistema Operativo estamos para crear la estructura de directorios.

## Lanzar emulador

- Pulsar Cmd+Shift+P
- Escribir y seleccionar Flutter: Launch Emulator
  - Yo voy a hacer las pruebas con el simulador de iOS
- Estando en el archivo main.dart, volver a pulsar Cmd+Shift+P
- Escribir y seleccionar Flutter: Select Device
- Seleccionar el dispositivo iOS
- Pulsar F5

## Creación de FileSystem de proyecto

En la carpeta lib vamos a tener que crear nuestra propia estructura de filesystem (directorios) para poder acomodar las distintas pantallas, utilidades... de nuestro proyecto.

Se va a aplicar ciertos principios de arquitectura para poder mantener fácilmente nuestras aplicaciones.

El Scaffold es una nueva página que debe estar desacoplado de MaterialApp, porque no sabemos si el día de mañana podemos cambiar esa primera página por otra.

Dentro de la carpeta lib crearemos la carpeta `presentation`.

En esta carpeta pondremos todo lo que visualmente es de Flutter, es decir, Widgets, personalizados o no, o cualquier construcción visual.

Dentro de `presentation` crearemos la carpeta `screens`. Un screen en un Widget que cubre toda la pantalla (en diseño Web lo llamaríamos página) y adicionalmente lleva un Widget Scaffold.

Como podemos tener varios screens, para este proyecto vamos a crear, dentro de la carpeta `screens` otra carpeta llamada `counter`

En esta carpeta `counter` vamos a crear nuestro screen `counter_screen.dart`

## Cambiar estado de la aplicación

Tenemos distintos estados:

- Estado global de la aplicación es un estado al que todos los Widgets, independientemente de su posición en el árbol de Widgets (BuildContext), tienen acceso.
- Estado de un Widget (y sus hijos) es una variable a la que puede acceder el Widget y sus hijos, pero estos no directamente, sino mediante paso de parámetros.

No se puede cambiar un estado en un StatelessWidget. Si necesitamos tener estado en un Widget, este debe ser un StatefulWidget.

Debe haber los menos StatefulWidget posibles en nuestra app. Esto no significa que no deba haber, ya que son necesarios para gestioanr el estado de nuestra app, pero casi todos los Widget deberían ser StatelessWidget.

Indicar también que, para gestionar el estado, existen paquetes especiales.

## AppBar y Acciones

Se ha creado en la carpeta `/lib/presentation/screens/counter` el fuente `counter_functions_screen.dart`.

Dicho fuente es la copia de `counter_screen.dart`.

Y en nuestro fuente `main.dart` cambiamos la referencia home a este nuevo fuente.

Hemos hecho esta copia para poder hacer pruebas con el AppBar.

## Widgets personalizados

Tenemos que tener mucho cuidado con que Flutter no se descontrole, en el sentido de tener una especie de callback Hell con llave, llave, corchete, llave...

Cuando veamos que hay mucho nivel de indentación, lo mejor es extraer ese Widget, para que el proyecto sea más fácil de mantener.
