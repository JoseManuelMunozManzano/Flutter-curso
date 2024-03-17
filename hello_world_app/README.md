# hello_world_app

Esta sección crearemos nuestra primera aplicación real de Flutter, la que nos enseñará cosas como:

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
