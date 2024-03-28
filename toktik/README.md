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

## Estructuras y entidades

Tenemos que preparar como queremos que sea nuestra entidad de data.

En la carpeta `lib` creamos una carpeta `domain`, y dentro creamos la carpeta `entities`, donde crearemos nuestras entidades.

En la carpeta `lib` creamos una carpeta `shared` donde va todo lo que es compartido en la aplicación. Dentro creamos la carpeta `data` donde irá un archivo `local_video_posts.dart` que contendrá toda la información de mis video posts. Es información local que puede venir de un API externa.

En la carpeta raiz del proyecto creamos una carpeta `assets`, es decir, recursos estáticos, donde colocamos la carpeta `videos` con los videos. Los recursos estáticos son parte de la app, es decir, irán en el bundle inicial de la aplicación, con lo que los videos estarán disponibles directamente en la memoria del dispositivo. En una app real no sería así, los videos vendrían de una API.

Sin embargo, los videos no van a estar disponibles en nuestra app hasta que lo indiquemos en el fichero pubspec.yaml, en la parte donde indica como añadir assets a la aplicación, y lo dejamos así.

```
  # To add assets to your application, add an assets section, like this:
  assets:
    - assets/videos/
```

Tal y como lo hemos indicado, con `videos/` se importan todos los videos que se encuentren en esa carpeta, pero NO LOS SUBDIRECTORIOS. Si hubiera subdirectorios, hay que indicarlos.

Cuando se incluyen assets, se recomienda cerrar la app completamente y volverla a ejecutar.

NOTA: Los videos están cogidos de la página `https://www.pexels.com/search/videos/vertical/`
