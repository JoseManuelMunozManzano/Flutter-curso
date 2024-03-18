# yes_no_app

En esta sección haremos el diseño de la aplicación de YesNo, la cual eventualmente responderá nuestras preguntas (siempre y cuando sean de si o no).

En esta sección veremos:

- TextEditingControllers
- Focus Nodes
- ThemeData
- Widgets como:
  - Containers
  - SizeBox
  - ListViews
  - CustomWidgets
  - Expanded
  - Padding
  - Image (desde internet)
  - ClipRRect (bordes redondeados)

La sección está llena de contenido para construir este pequeño chat, pero la funcionalidad la haremos en la siguiente sección.

## Creación de proyecto desde VSCode

- Pulsar Cmd+Shift+P
- Escribir y seleccionar Flutter: New Project
- Seleccionar Application
- Seleccionar el directorio donde guardaremos el proyecto
- Indicar el nombre del proyecto, que deberá ser todo en minúsculas, y, si se separa por palabras, usar el guión bajo.
  - Nuestro proyecto se llama: `yes_no_app`

## Lanzar emulador

- Pulsar Cmd+Shift+P
- Escribir y seleccionar Flutter: Launch Emulator
  - Yo voy a hacer las pruebas con el simulador de iOS
- Estando en el archivo main.dart, volver a pulsar Cmd+Shift+P
- Escribir y seleccionar Flutter: Select Device
- Seleccionar el dispositivo iOS
- Pulsar F5

## Estilo global para la aplicación

El estilo (theme) estará en un archivo independiente para poder manipularlo de manera global.

Cuando hablamos de tema nos referimos a como queremos que luzcan los distintos Widgets.

En la carpeta `lib`, crearemos una carpeta `config`.

Dentro de la carpeta `config` crearemos otra carpeta llamada `theme`.

Dentro de la carpeta `theme` crearemos un archivo llamado `app_theme.dart`.

Creamos la clase `AppTheme` que devolverá algo de tipo `ThemeData`.
