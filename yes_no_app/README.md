# yes_no_app

Para la parte del diseño de la aplicación de YesNo, la cual eventualmente responderá nuestras preguntas (siempre y cuando sean de si o no), veremos:

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

La sección está llena de contenido para construir este pequeño chat.

Para la parte de la lógica de negocio de nuestra aplicación, veremos:

- Gestores de estado
- Mappers
- Peticiones HTTP
- Dio
- Paquetes
- Funciones que retornan valores como callbacks
- Scroll
- Provider

Al finalizar la sección tendremos una buena base de como alojar el estado fuera de los widgets y que los widgets se actualicen y tomen la información que necesitan del gestor de estado.

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

## ChatScreen

Para evitar que se nos descontrole la app, apilando Widget tras Widget, nos vamos a llevar el Scaffold a un fichero nuevo en otra carpeta.

En la carpeta `lib` vamos a crear: `lib/presentation/screens/chat`

Dentro de `chat` vamos a colocar todo lo que tiene que ver con pantallas de chat.

Creamos ahí un nuevo archivo llamado `chat_screen.dart`

## ListView - Area de los mensajes

Añadimos un body dentro del Scaffold que se encuentra en el archivo `chat_screen.dart`

El body es lo que vamos a poder colocar en el area opr debajo del appBar. Si no tuviéramos el appBar, sería todo el espacio disponible.

En el body hacemos referencia a un StatelessWidget `_ChatView` que construye un Widget ListView que consta de:

- Un builder
- itemCount
- itemBuilder(context, index)
- Contenido del itemBuilder

## Mis Mensajes - Burbuja de chat

Las burbujas de chat son algo claramente visual.

De nuevo, tener claro que lo más difícil en Flutter es conseguir que el código de los Widgets no se nos descontrole y acaben siendo imposibles de leer.

Vamos a crear una nueva carpeta dentro de la carpeta `presentation` llamada `widgets`.

La idea de esta carpeta es que sean widgets específicos, pequeños, que sean reutilizables.

Como estos widgets en concreto están relacionados con el chat, dentro vamos a crear otra carpeta llamada `chat`.

Y vamos a crear un archivo llamado `my_message_bubble.dart`.

Este widget lo usamos en el archivo `chat_screen_dart`.

## Mensajes de ella - Burbuja de chat

Dentro de la carpeta `widgets` creamos la carpeta `her_message_bubble.dat`.

El contenido es muy similar al del archivo `my_message_bubble.dart`, pero tiene cosas muy diferentes, como una imagen.

Este widget lo usamos, alternándolo con ``my_message_bubble.dart` en `chat_screen.dart`.

## TextFormField

Es una caja de texto, que vamos a situar en la parte de abajo de la app, para poder escribir texto.

No está enteramente relacionada al chat. Podríamos querer esa caja de texto para reutilizarla en otras partes del dispositivo, como arriba para que sirviera de buscados, o flotante...

Dentro de la carpeta `widgets` se crea otra carpeta llamada `shared` y dentro un archivo llamado `message_field_box.dart`.

Este widget lo usamos en el archivo `chat_screen_dart`.
