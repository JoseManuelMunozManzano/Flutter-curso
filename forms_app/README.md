# BLoC (Business Logic Component) - Flutter_Bloc y Cubits. Manejo de formularios

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

En esta nueva sección vamos a tratar también el manejo de formularios, aunque hay muchas consideraciones, les mostraré 3 aproximaciones que les pueden servir, recuerden, no hay ninguna mejor, simplemente diferentes formas que pueden ser convenientes para ustedes pero para otros no.

Puntualmente veremos:

- Tradicionales Stateful (Forms, TextFormField + Keys)
- Con gestor de estado
- Con gestor de estado + Data Input fields personalizados

También veremos sus validaciones y obtener la data y estado en todo momento del formulario.

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

### Disparar eventos dentro del BLoC

Nos vamos al fuente `counter_bloc.dart`.

En lugar de que nuestros Widgets disparen, o manden añadir los eventos (con add), vamos a crearnos dos métodos en `counter_bloc.dart` que hagan el `add()` de los eventos. Aunque hay un poco más de código, lo bueno es que centralizamos todo en nuestro BLoC.

Esos métodos son los que llamaremos desde `bloc_counter_screen.dart`.

Son formas similares de trabajar. En vez de hacer el `add()` en nuestro View, lo hacemos en nuestro BLoC.

Lo bueno es que no tenemos que memorizar los eventos que tenemos que disparar.

## Manejo de formularios

Vamos a ver diferentes estrategias para trabajar con formularios, cada una con sus pros y sus contras.

En la carpeta `presentation/screens/` creamos la screen `register_screen.dart`.

En el fichero `config/router/app_router` añadimos la ruta que va a tener.

Con la ruta, vamos a `presentation/screens/home_screen` añadimos el `ListTile` para acceder al formulario.

Como hemos modificado el router, tenemos que hacer un `full restart` de la aplicación para poder entrar a ver la pantalla.

### Consideraciones con inputs y scroll

Manejo de formularios se refiere a poder capturar toda la información, validarla y mostrarle al usuario lo que salió bien y lo que salió mal.

https://api.flutter.dev/flutter/widgets/Form-class.html

https://api.flutter.dev/flutter/widgets/FormField-class.html

No es complicado manejar formularios en Flutter. Necesitamos, como mínimo:

- Un formulario, que conseguimos con el Widget `Form` al que hay que indicarle una `key` que lleva la referencia al estado del formulario. Cualquier Widget hijo del formulario, es parte del formulario
- Un `TextFormField` que debe tener una función validadora. Si esa función regresa null es que todo ha ido bien. si regresa algún string entonces es que ha ocurrido un error
- Para disparar la validación, con el típico botón Submit, tomamos el estado del formulario, de la key, y ejecuta el método `validate()`, que lo que hace es ir a todos los `TextFormField` hijos y ejecuta su función validadora.

Lo vamos a hacer primero de la forma simple y luego lo vamos a escalar para que el resultado sea más robusto.

Vamos a modificar nuestro screen `register_screen.dart`.

```
    // El Widget TextFormField se relaciona con un formulario, mientras que el TextField no.
    // Cuando colocamos este Widget en pantalla, tenemos que tener en cuenta el teclado y la posición del Widget.
    // Si vamos a colocar un input muy abajo, podemos trabajar con el Widget SafeArea, que se va a asegurar
    // de mostrar ese Widget sin estorbos, ya sea el notch, controles de movimiento o lo que sea.
    // Pero esto tiene otro problema serio, porque el Widget Column es inflexible, es decir, que si aparece el teclado
    // y empuja para arriba el input, puede que choque contra otro Widget, y esto va a romper la app.
    // Es por esto que, salvo que el input esté muy arriba, se recomienda envolver todo en un Widget que tenga algún
    // tipo de scroll, ya sea un ListView o un Sliver, CustomChildScrollView...
    // Pero idealmente, vamos a querer envolver el Widget Column en un SingleChildScrollView, lo que cambia la funcionalidad,
    // pero nos permite hacer scroll.

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              const FlutterLogo(size: 100,),

              TextFormField(),
              TextFormField(),
              TextFormField(),
              TextFormField(),

              const SizedBox(height: 20),

              FilledButton.tonalIcon(
                onPressed: () {},
                icon: const Icon(Icons.save),
                label: const Text('Crear usuario'),
              ),

              // Espacio de gracia para que el usuario pueda hacer un poco de scroll.
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
```

### Diseño del campo de texto

Vamos a crear un Widget personalizado para manejar el input en la screen `register_screen.dart`.

Como en TextFormField va a requerir ciertas configuraciones, vamos a crear un nuevo Widget. En la carpeta `presentation` creamos la carpeta `widgets` y dentro creamos un archivo de barril `widgets.dart` y otra carpeta `inputs`, y dentro creamos el widget `custom_text_form_field.dart`.

### Formulario tradicional

Aunque no lo usamos en esta clase, paso información para hacer listas desplegables:

- https://api.flutter.dev/flutter/material/DropdownButton-class.html
- https://datogedon.com/sdks/flutter/flutter-dropdown-como-crear-una-lista-desplegable-dropdownbuttonformfield/

Transformamos en nuestro screen `register_screen`, en concreto el Widget `_RegisterForm` a un StatefulWidget.

Vemos que los validators llevan mucho trabajo.

Vamos a ver como delegar el control del formulario a un gestor de estado.

### Register Form Cubit

Sería bueno que, conforme escribimos en nuestros inputs, se fueran quitando las validaciones que no se cumplen de manera automática, sin tener que tocar el botón `Crear usuario`.

Incluso, por ejemplo, podríamos querer bloquear el botón mientras hubiera errores en las validaciones.

Necesitamos manejar el estado con un gestor de estado, y vamos a usar Cubit, ya que el registro es algo pequeño, aunque se podría hacer perfectamente con Flutter Bloc o incluso una combinación de ambos.

En la carpeta `presentation/blocs` pulsamos botón derecho y seleccionamos `Bloc: New Cubit` y le damos el nombre `register`.

Esto genera una carpeta `cubit` que renombramos a `register`, y dentro crea dos fuentes, `register_cubit.dart` y `register_state.dart`.

Otra forma posible de estructurar nuestras carpetas de Cubit sería, por pantallas, por ejemplo, `presentation/blocs/forms/register`. O, en nuestra estructura Domain Driven Design, también podemos crear por features, por ejemplo, crear las capas de dominio, infraestructura y presentación para la autenticación, dominio, infraestructura y presentación para productos... Hay muchas formas de hacerlo y debemos elegir la que mejor se adapta a nuestras necesidades.

En `register_state.dart` es donde vamos a validar nuestro formulario. `RegisterFormState` es nuestro estado del formulario. Podemos usarlo para saber cuando habilitar/deshabilitar el botón `Crear usuario` y cuando un campo pasa de ser válido a inválido.

Vamos a mandar llamar a los métodos de `register_cubit.dart` desde los inputs para actualizar el estado de mi Cubit, con la idea de tener en el Cubit la última información actualizada de cada campo.

Por ahora no estamos realizando las validaciones.

### Conectar cubit con el formulario

Vamos a conectar nuestro cubit `register_cubit` con nuestro screen `register_screen`.

En lugar de manejar simples Strings en `register_state.dart` lo quiero manejar como un objeto.

Por ejemplo, tendremos un objeto personalizado username que tendrá su instrucción de validación, su instrucción de errores personalizados... con la idea de que, donde vayamos a utilizar este objeto personalizado, pueda utilizar el mismo tipo de dato y todos tendrán las mismas validaciones, controles y funcionamiento.

Esto, a la larga, va a llevarnos a tener que crear unos inputs específicos para cada uno de los campos, que puede verse como más código, pero que a la larga será más reutilizable tanto en esta como otras aplicaciones.

Este es otro camino para hacer lo que ya tenemos, que tampoco es que esté mal. Todo depende de qué necesitamos.

### Formz - Crear inputs individuales

Documentación: https://pub.dev/packages/formz

El paquete Formz es una alternativa interesante que puede ayudarnos a abstraer aún más las validaciones. Algunas de las ventajas de usar Formz son:

- Reutilización de código: Formz nos permite definir modelos de formulario que encapsulan la lógica de validación, lo que facilita su reutilización en diferentes partes de la aplicación
- Manejo de estado: Formz se encarga del manejo del estado del formulario, lo que simplifica la lógica de nuestros widgets
- Validaciones complejas: Formz nos permite definir validaciones complejas de una manera más concisa y legible que si las implementáramos manualmente

La principal desventaja de usar Formz es que agrega una capa de abstracción adicional, lo que puede hacer que el código sea más difícil de entender para desarrolladores que no estén familiarizados con la librería. Sin embargo, si la aplicación tiene formularios complejos y necesitamos una solución robusta para manejar las validaciones, Formz puede ser una opción muy útil.

Lo que se termina creando es un tipo de dato especial, un `input`, que no deja de ser una clase en la que:

- Se establece su valor inicial
- Tiene una forma de establecer un valor
- Un método de validación que regresa un tipo de error personalizado para ese input

Instalación usando Pubspec Assist, del paquete `formz`.

Dentro de `lib` nos creamos la carpeta `infrastructure`, dentro la carpeta `inputs` y dentro el archivo de validación `username.dart` y el archivo de barril `inputs.dart`.

Vamos a la ruta indicada en la documentación y copiamos el ejemplo que aparece en `username.dart`, para no empezar desde cero.

La idea es que vamos a cambiar, en `register_state.dart`, el tipo de dato String del campo `username` a uno de tipo `Username`.
