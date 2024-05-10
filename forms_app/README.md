# BLoC (Business Logic Component) - Flutter_Bloc y Cubits

En esta sección vamos a hablar de dos gestores de estado nuevos: Flutter_Bloc y Cubits.

Vamos a implementar algunos temas de formularios y el típico contador, usando ambos gestores de estado.

Los Cubits se usan cuando tenemos un estado muy pequeño y no queremos crear tanto código para mantener un estado simple. Pero eso no significa que no se pueda usar en toda una app grande. Por cierto, los Cubits ya vienen con Bloc, no hay que instalar nada más.

Cuando trabajemos los formularios lo vamos a hacer basado en Flutter_Bloc. De nuevo, el objetivo es separar ese state de nuestros Widgets. Hay muchas similitudes con Riverpod en cuanto a la forma en la que podemos leer el estado, como podemos obtener la instancia del Bloc.

Un Bloc sería como un provider y es muy estructurado. Es muy fácil saber como fluye la información y en qué momento se hace el cambio de la información, porque todo es basado en eventos.

También vamos a incluir el paquete de `Equatable`, que es muy utilizado y sirve para comparar dos objetos.

Esta sección tiene por objetivo aprender lo siguiente:

- BLoC
- Flutter_Bloc
- Cubits
- Equatable
- Eventos
- Estado

La idea de aprender un nuevo gestor de estado, es para que puedan tener experiencia con diferentes gestores para que logren determinar cuál es el que mejor se adapta a su estilo de programación, Flutter_Bloc es bien robusto y a la vez puede verse como con mucho archivo adicional, pero a la larga, lo hace fácil de probar, revertir y mantener.

## Documentación

https://pub.dev/packages/flutter_bloc

https://bloclibrary.dev/getting-started/

## Diferencia entre BLoC y Flutter_Bloc

El patrón BLoC y flutter_bloc son dos conceptos relacionados pero distintos.

El patrón BLoC es un patrón de diseño que se basa en el concepto de programación reactiva. Este ayuda a separar la lógica de negocio de la interfaz de usuario. En otras palabras, los componentes de la interfaz de usuario solo deben preocuparse por la interfaz de usuario y no por la lógica.

En cambio, flutter_bloc es un paquete en Flutter que proporciona herramientas para implementar el patrón BLoC. El paquete bloc contiene cosas que usarás en tu capa BLoC, como la clase Bloc. Esto no depende necesariamente de Flutter, es solo la arquitectura lógica de tu aplicación. El paquete flutter_bloc contiene elementos que usarás en tu capa de interfaz de usuario. Incluye widgets como BlocProvider y BlocBuilder, que son widgets y, por lo tanto, dependen de Flutter.

Puedes encontrar más detalles en estos artículos:

- https://medium.flutterdevs.com/bloc-pattern-in-flutter-part-1-flutterdevs-128f90059f5c
- https://dev.to/wednesdaysol/guide-to-implementing-bloc-architecture-in-flutter-3j79

## Creación de proyecto desde VSCode

- Pulsar Cmd+Shift+P
- Escribir y seleccionar Flutter: New Project
- Seleccionar Application Empty
- Seleccionar el directorio donde guardaremos el proyecto
- Indicar el nombre del proyecto, que deberá ser todo en minúsculas, y, si se separa por palabras, usar el guión bajo.
  - Nuestro proyecto se llama: `forms_app`
- Empieza a generarse la app, y Flutter detecta en qué Sistema Operativo estamos para crear la estructura de directorios.

## Lanzar emulador

- Pulsar Cmd+Shift+P
- Escribir y seleccionar Flutter: Launch Emulator
  - Yo voy a hacer las pruebas con el simulador de iOS
- Estando en el archivo main.dart, volver a pulsar Cmd+Shift+P
- Escribir y seleccionar Flutter: Select Device
- Seleccionar el dispositivo iOS
- Pulsar F5

## Estructura inicial de la aplicación

Creamos, dentro de la carpeta `lib` la carpeta `config` y dentro dos carpetas, `router` y `theme`.

Dentro de la carpeta `theme` creamos el archivo `app_theme.dart`.

Creamos, dentro de la carpeta `lib` la carpeta `presentation`, dentro la carpeta `screens` y dentro el screen `home_screen.dart` y el archivo de barril `screens.dart`.

También, dentro de `screens` creamos el screen `cubit_counter_screen.dart`.

Y de este último screen, cuando ya lo hemos codificado, creamos una copia y lo renombramos a `bloc_counter_screen.dart`.

Dentro de la carpeta `router` creamos el archivo `app_router.dart` e instalamos, usando Pubspec Assist, el paquete `go_router`.

También actualizamos nuestro fichero `main.dart` para añadir el theme y el router y eliminar nuestro body, porque ahora todo se basa en nuestro router.

## Counter Cubit - Gestor de Estado

Empezamos a trabajar con Cubit, un nuevo gestor de estado que viene incluido con Flutter_Bloc, siendo este un conjunto de Widgets específicos para trabajar la implementación de Bloc en Flutter, y siendo Bloc una forma de trabajar el estado de la aplicación separado en eventos, separado en estado y separado en una clase que controla los eventos y los estados.

https://pub.dev/packages/flutter_bloc

Instalamos el paquete `flutter_bloc` usando `Pubspec Assist`.

Recordar que los gestores de estado siempre van en la capa de presentación.

En la carpeta `presentation` creamos la carpeta `blocs`.

Hay un plugin de VSCode que nos permite crear código para Cubit y para Bloc, se llama `bloc`. Sobre nuestra carpeta `blocs` pulsamos botón derecho y seleccionamos, sobre el final, `Cubit: New Cubit`. Como nombre indicamos `counter`. El plugin de VSCode nos crea una carpeta `cubit` y dentro un par de archivos, `counter_cubit.dart` y `counter_state.dart`.

La carpeta `cubit` la renombramos a `counter_cubit`.
