# tok_tik_app

Esta sección es muy interesante porque aprenderemos a crear un reproductor de videos vertical estilo TikTok.

Puntualmente veremos:

- Manejo de assets
- Paquetes
- Gesture Detector
- Posicionamiento de Widgets
- Mappers
- Gradientes
- Loops
- Aserciones
- Stacks
- Controladores de video

Queda preparado para aprender dos conceptos nuevos que veremos en la siguiente sección:

- Repositorios
- Datasources

## Creación de proyecto desde VSCode

- Pulsar Cmd+Shift+P
- Escribir y seleccionar Flutter: New Project
- Seleccionar Application
- Seleccionar el directorio donde guardaremos el proyecto
- Indicar el nombre del proyecto, que deberá ser todo en minúsculas, y, si se separa por palabras, usar el guión bajo.
  - Nuestro proyecto se llama: `toktik`
- Empieza a generarse la app, y Flutter detecta en qué Sistema Operativo estamos para crear la estructura de directorios.

## Lanzar emulador

- Pulsar Cmd+Shift+P
- Escribir y seleccionar Flutter: Launch Emulator
  - Yo voy a hacer las pruebas con el simulador de iOS
- Estando en el archivo main.dart, volver a pulsar Cmd+Shift+P
- Escribir y seleccionar Flutter: Select Device
- Seleccionar el dispositivo iOS
- Pulsar F5

NOTA: Se recomienda probar esta aplicación en dispositivo físico porque el emulador puede tener ciertos problemas a la hora de reproducir ciertos videos.

## Estilo global para la aplicación

En la carpeta `lib`, crearemos una carpeta `config`.

Dentro de la carpeta `config` crearemos otra carpeta llamada `theme`.

Dentro de la carpeta `theme` crearemos un archivo llamado `app_theme.dart`.

Creamos la clase `AppTheme` que devolverá algo de tipo `ThemeData`.
