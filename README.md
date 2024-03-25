# FLUTTER - MOVIL: DE CERO A EXPERTO

Del curso de Fernando Herrera:

https://cursos.devtalles.com/courses/take/flutter-movil-cero-a-experto/lessons/42480509-instalaciones-necesarias-menos-flutter

## Instalaciones necesarias del curso

https://gist.github.com/Klerith/2917b2a21ea9c4bfa5d1070c89a89ec7

## Cheat sheets

[Dart Cheat Seet](./Cheat-sheet/dart-cheat-sheet.pdf)

[Flutter Cheat Seet](./Cheat-sheet/flutter-cheat-sheet.pdf)

## Qué es Flutter

SDK portable - Open source framework - UI Widget Library

Sirve para crear hermosas aplicaciones compiladas de forma nativa, multi-plataforma con un único código base.

Está fuertemente inspirado en React, en el sentido es que este reutiliza componentes, llamados Widgets en Flutter.

Un Widget no es más que un objeto o una clase reutilizable que tiene cierta apariencia.

Con Flutter tenemos el control de cada pixel en pantalla.

![alt Flutter en pocas palabras](./Images/02-Flutter_en_pocas_palabras.png)

![alt Flutter en pocas palabras](./Images/02-Flutter_en_pocas_palabras_2.png)

Podemos usar widgets ya creados, pero también podemos crear nuestros propios widgets.

Existe un repositorio llamado `Pub.dev` donde podemos empaquetar nuestros widgets y subirlos.

Con Flutter podemos (independientemente de que se recomiende o no por temas de mantenimiento del software) crear apps para:

- Web
- Windows, Linux y Mac
- IOS, Android
- Sistemas embebidos (Google Nest...)

Todo con una sola base de código.

Hay tres partes en Flutter:

- La construcción de la lógica de negocio
- La conexión de la lógica de negocio y nuestros Widgets
- La creación del diseño de la aplicación

## Borrar y generar dependencias

Usando la terminal y en la raiz del proyecto, ejecutar:

- flutter clean
- flutter pub get

## Trabajar con los colores indicados en el seed

Para no tener que hardcodear colores en cada Widget.

Lo que se hace es indicar en `main.dart` la paleta de colores: `theme: AppTheme(selectedColor: 1).theme(),`

Y luego en cada Widget donde necesitemos acceso a la paleta accedemos al contexto: `final colors = Theme.of(context).colorScheme;`

Y para usarlo en un Widet Decoration, por ejemplo un color primario en función de nuestra paleta de colores:

```
decoration: BoxDecoration(
   color: colors.primary, borderRadius: BorderRadius.circular(20)
)
```

## Obtener dimensiones del dispositivo

El MediaQuery nos va a dar información respecto al dispositivo que lo está ejecutando.

El context hace referencia al árbol de Widgets, donde también tenemos otra información como las dimensiones y características del dispositivo donde se está ejecutando la app.

Usando size obtenemos las dimensiones del dispositivo.

`final size = MediaQuery.of(context).size;`

Y para usarlo en una imagen:

```
child: Image.network(
    'https://yesno.wtf/assets/no/1-c7d128c95c1740ec76e120146c870f0b.gif',
    width: size.width * 0.7,
    // La idea de dejar un height específico, es para evitar que las imágenes
    // varíen unas de otras. Siempre voy a saber su alto.
    height: 150
)
```

## Mostrar mensaje mientras se carga la imagen

Usamos `loadingBuilder` dentro de nuestro Widget `Image`

Recordar que un Builder es algo que se va a construir en tiempo de ejecución.

El child es nuestra misma imagen cuando se carga, ya construida enteramente.

El context es nuestro árbol de Widgets e info del dispositivo.

```
loadingBuilder: (context, child, loadingProgress) {
  // Si se cargo por completo, regresa la imagen
  if (loadingProgress == null) return child;

  // Indicando el mismo size se evitan brincos en el diseño cuando pasamos del loader a la imagen.
  return Container(
    width: size.width * 0.7,
    height: 150,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: const Text('Se está enviando una imagen'),
  );
```

## Recibir lo que la persona escribe

Se puede hacer de las siguientes maneras (puede haber más)

```
// El texto completo, obtenido al pulsar Enter.
onFieldSubmitted: (value) {
  print('Submit value $value');
},

// Cada valor de la tecla pulsada.
onChanged: (value) {
  print('changed: $value');
},
```

## Obtener control de un input

Con este elemento obtenemos el control del input al que se asocia.

`final textController = TextEditingController();`

```
return TextFormField(
  // Para asociarlo
  controller: textController,

  // Y para usarlo, por ejemplo para limpiar un input de texto cuando hemos pulsado enter (en este caso, por ser onFieldSubmitted):
  onFieldSubmitted: (value) {
    textController.clear();
  },
);
```

Y si estamos en otro sitio, pero relacionado, y queremos obtener el texto del input:

```
suffixIcon: IconButton(
  icon: const Icon(Icons.send_outlined),
  onPressed: () {

    // Usamos esto
    final textValue = textController.value.text;

    print('button: $textValue');

    // Y para limpiar el texto
    textController.clear();
  },
);
```

## Mantener el foco

Cuando un elemento necesita un foco, se puede hacer de la siguiente manera:

`final focusNode = FocusNode();`

Y para usarlo:

```
return TextFormField(
  // Al hacer click fuera del input se va a remover el foco
  onTapOutside: (event) {
    focusNode.unfocus();
  },

  // Indicamos que tiene el foco.
  focusNode: focusNode,

  onFieldSubmitted: (value) {
    print('Submit value $value');
    textController.clear();

    // Lo usamos para mantener el foco una vez se ha pulsado Enter.
    focusNode.requestFocus();
  },
);
```

## Instalar y usar Provider

Ir a la ruta: https://pub.dev/packages/provider

Algo que tenemos que tener en cuenta a la hora de instalar un paquete es la plataforma (PLATFORM) Para el paquete provider, vemos que las plataformas posibles son Android, iOS, Linux, MacOs, Web y Windows. Pero no todos los paquetes funcionan para todas las plataformas.

Otra cosa que tenemos que tener en cuenta a la hora de instalar un paquete es la versión de Dart para la que el paquete está disponible. En el caso de Provider, indica `Dart 3 compatible`.

Para instalar:

- Pulsar Installing
  - Ahí nos indica como instalar el paquete

Formas de instalar paquetes:

- Forma 1
  - Ir al terminal, a la raiz del proyecto y ejecutar: `flutter pub add provider`.
  - Podemos ver donde se han instalado todos esos paquetes. Para ello abrir el archivo `pubspec.yaml` y bajar hasta ver `dependencies`
- Forma 2
  - Abrir el fichero `pubspec.yaml`, bajar hasta dependencias y escribir: `provider: ^6.1.2`
  - Grabar el archivo o, en VSCode, pulsar la flecha hacia abajo, donde indica `Get Packages`
- Forma 3
  - Si, en VSCode hemos instalado el plugin `Pubspec Assist`
    - Pulsar Cmd+Shift+P y escribir pubassist
    - Seleccionar `Pubspec Assist: Add/update dependencies`
    - Escribir el nombre del paquete `provider`

Envolver archivo `main.dart` con nuestro Provider para crear un provider a nivel global de nuestra aplicación:

- Situarnos sobre MaterialApp y pulsar Cmd+.
- Pulsar sobre Wrap with widget...
- Cambiar el nombre a `MultiProvider`
- Indicar el listado de providers. En nuestra app, como tenemos un provider que se encarga de notificar cuando hay cambios (ChangeNotifier), el provider que indicaremos es `ChangeNotifierProvider`, y este tiene una propiedad `create` que espera que hagamos la creación de la instancia inicial, que es `ChatProvider()`

```
@override
Widget build(BuildContext context) {
  return MultiProvider(
    providers: [
      // El argumento es el context, pero si no se va a usar se suele indicar _
      ChangeNotifierProvider(create: (_) => ChatProvider())
    ],
    child: MaterialApp(
      ...
    ),
  );
}
```

Al grabar el archivo veremos ahora en la barra de debug de VSCode un icono Flutter de DevTools.

Si lo pulsamos veremos la estructura del BuildContext.

## Leer un valor del Provider

De nuevo, ir a la web: https://pub.dev/packages/provider#reading-a-value y leer la documentación.

La forma más fácil de leer un valor es usar las siguientes extensiones del BuildContext:

- context.watch<T>() : el Widget escucha los cambios sobre T (siendo T el provider especificado) y redibuja
- context.read<T>() : regresa el provider sin escuchar los cambios, es decir, no redibuja
- context.select<T, R>(R cb(T value)) : solo se notifica al Widget cuando alguna propiedad concreta del provider cambia
- Provider.of<T>(context, listen: false) : similar a context.read<T>()

Ejemplo en archivo `chat_screen.dart`

```
class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Hacemos la referencia al provider, indicando la instancia del MultiProvider que necesito, que es ChatProvider.
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      ...
    )
  }
}
```

El código `final chatProvider = context.watch<ChatProvider>();` es muy parecido a este que aparece más arriba para obtener información del context `final colors = Theme.of(context).colorScheme;`

## Truco para que Flutter tarde en hacer una animación

Da la sensación de que se procesa y se hace.

Y también corrige un bug. El provider notifica a los listeners que hubo un cambio pero no le da el tiempo suficiente para que se redibuje la UI y el scrollController se actualize. Con este delay damos ese tiempo.

```
  // Indicamos async y que haga un delayed
  Future<void> moveScrollToBotton() async {
    await Future.delayed(const Duration(milliseconds: 100));

    // Y aquí lo que queramos que haga.
  }
```

## Petición HTTP

Aunque se puede hacer una petición HTTP directamente con Dart, es necesario mucho código.
Al final vamos a acabar usando uno de dos paquetes:

- http: https://pub.dev/packages/http
- dio: https://pub.dev/packages/dio

Para instalar dio:

- Pulsar, en VSCode, `Cmd+Shift+P`
- Seleccionar `Pubspec Assist: Add/update dependencies`
- Escribir el nombre del paquete `dio`

Dio es muy fácil de usar e incluso hace la serialización del mapa por nosotros.

```
class GetYesNoAnswer {
  // Con Dio podemos usar las BaseOptions, que nos permite indicar la url, headers y muchísimas más cosas.
  // final _dio = Dio(BaseOptions(
  //   baseUrl:
  // ));

  final _dio = Dio();

  Future<Message> getAnswer() async {
    final response = await _dio.get('https://yesno.wtf/api');

    // Forma sencilla de devolver lo que queremos, pero sin usar Mappers
    return Message(
      text: response.data['answer'],
      fromWho: FromWho.hers,
      imageUrl: response.data['image'],
    );
  }
}
```

## Temario

- 01_dart_intro
  - Repaso de Dart
- 02_instalación_flutter
  - Instalación de Flutter
  - Configurar emuladores
  - Configurar nuestros dispositivos físicos
- hello_world_app
- yes_no_app
