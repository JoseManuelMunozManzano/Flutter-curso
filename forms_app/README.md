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

Vamos a trabajar con nuestra screen `presentation/screens/cubit_counter_screen.dart`.

Empezamos a trabajar con Cubit, un nuevo gestor de estado que viene incluido con Flutter_Bloc, siendo este un conjunto de Widgets específicos para trabajar la implementación de Bloc en Flutter, y siendo Bloc una forma de trabajar el estado de la aplicación separado en eventos, separado en estado y separado en una clase que controla los eventos y los estados.

https://pub.dev/packages/flutter_bloc

Instalamos el paquete `flutter_bloc` usando `Pubspec Assist`.

Recordar que los gestores de estado siempre van en la capa de presentación.

En la carpeta `presentation` creamos la carpeta `blocs`.

Hay un plugin de VSCode que nos permite crear código para Cubit y para Bloc, se llama `bloc`. Sobre nuestra carpeta `blocs` pulsamos botón derecho y seleccionamos, sobre el final, `Cubit: New Cubit`. Como nombre indicamos `counter`. El plugin de VSCode nos crea una carpeta `cubit` y dentro un par de archivos, `counter_cubit.dart` y `counter_state.dart`.

La carpeta `cubit` la renombramos a `counter_cubit`.

### Consumir y utilizar el CounterCubit

Usar nuestra clase `CounterCubit` es literalmente lo mismo que usar el primer gestor de estado que vimos en el curso, `Provider`.

Modificamos nuestro fuente `presentation/screens/cubit_counter_screen.dart` porque queremos tener acceso a ese state solo en la pantalla `CubitCounterScreen`.

### Equatable

Puede ser que el hecho de generar un nuevo estado, cuando ese nuevo estado sea igual al anterior, haga que se redibuje de nuevo el Widget, ya que el `.watch()` detecta un cambio de estado, aunque tenga los mismos valores que los anteriores.

Vamos a instalar el paquete `equatable`. Para ello, usamos `Pubspec Assist`

https://pub.dev/packages/equatable

Equatable resuelve un problema muy común cuando tenemos objetos. No es lo mismo que un objeto tenga los mismos valores que otro a que las posiciones que ocupa en memoria sean las mismas.

Una forma de trabajar con Equatable es extender nuestra clase de Equatable, y tenemos que implementar una lista de propiedades que son usadas para comparar. Ver `counter_state.dart`.

Cuando incorporamos Equatable en nuestros estados, el mecanismo de comparación interno del flutter_bloc determina si un nuevo estado emitido es idéntico al estado anterior en términos de sus propiedades. Si los estados son idénticos, el cubit no emitirá una nueva notificación de cambio, lo que significa que las partes de la aplicación que escuchan ese cubit no serán notificadas del cambio y no se redibujarán. Esto puede llevar a situaciones donde dos cubits con el mismo tipo de estado compartan el mismo estado en un contexto específico, lo que puede requerir un manejo cuidadoso, especialmente cuando necesitamos trabajar con múltiples instancias del mismo cubit.

En cambio, Riverpod puede manejar más fácilmente múltiples instancias de proveedores con diferentes nombres, lo que puede ser beneficioso en ciertos escenarios. Es importante tener en cuenta esta consideración al diseñar y organizar la aplicación con bloc.

NOTA: Equatable se usa mucho, no solamente en conjunción con Bloc, sino para comparar objetos.

## BLoC y Flutter BLoC

Vamos a trabajar ahora con nuestra otra screen `presentation/screens/bloc_counter_screen.dart`.

En la carpeta `presentation`, hacemos click derecho en la carpeta `blocs` y en el desplegable seleccionamos el generador `Bloc: New Bloc` y damos el nombre `counter`.

Veremos que, dentro de la carpeta `blocs` se ha generado la carpeta `bloc` y dentro los archivos `counter_bloc.dart`, `counter_event.dart` y `counter_state.dart`.

Renombramos la carpeta `bloc` a `counter_bloc`.

- counter_bloc.dart es similar a counter_cubit.dart, es decir, maneja el state, pero veremos que este fluye de manera diferente
- counter_state.dart es similar a counter_state.dart, es decir, como luce el estado propiamente del bloc
- counter_event.dart aparece porque para emitir nuevos estados, nos basamos en eventos. Es similar a la idea de Redux

NOTA: Si ya tenemos instalado Equatable, automáticamente, en las clases, el generador de código lo configura para que nuestras clases extiendan de él.

### Utilizar Counter Bloc

Vamos a modificar nuestro screen `presentation/screens/bloc_counter_screen.dart`.

El consumo es muy similar a Cubit, pero cuando queremos hacer un cambio en el state lo que tenemos que hacer es emitir un evento.
