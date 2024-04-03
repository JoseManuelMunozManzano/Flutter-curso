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

Siempre que instalemos un paquete, deberíamos revisar si hay que tener en cuenta algo para que funcione en iOS, Android, Web...

Envolver archivo `main.dart` con nuestro Provider para crear un provider a nivel global de nuestra aplicación:

- Situarnos sobre MaterialApp y pulsar Cmd+.
- Pulsar sobre Wrap with widget...
- Cambiar el nombre a `MultiProvider`
- Indicar el listado de providers. En nuestra app, como tenemos un provider que se encarga de notificar cuando hay cambios (ChangeNotifier), el provider que indicaremos es `ChangeNotifierProvider`, y este tiene una propiedad `create` que espera que hagamos la creación de la instancia inicial, que es `ChatProvider()`
  - Por defecto, el comportamiento natural de los Change NotifierProvider es que, hasta que no sea necesario, Provider NO creará la instancia. Es decir, por defecto son cargados de manera perezosa. Indicando la propiedad lazy en false, evitamos esa carga perezosa y, por tanto, se crea la intancia: `lazy: false,` Puede ser conveniente cuando sabemos que hay una carga asíncrona de data que el usuario siempre va a necesitar.

```
@override
Widget build(BuildContext context) {
  return MultiProvider(
    providers: [
      // Si queremos que se cree la instancia.
      // lazy: false,
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

    // Otra forma más antigua de hacer lo mismo de arriba es:
    // final otroProvider = Provider.of<DiscoverProvider>(context);
    //
    // Y si solo quisiéramos escuchar
    // final otroProvider = Provider.of<DiscoverProvider>(context, listen: false);

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

## Mappers

En Dart es muy usual crear, para las respuestas de los API, una clase para recibir la respuesta y crear una instancia para poder acceder a sus valores con la notación de punto en vez de con las llaves, como en el ejemplo de arriba. Así evitamos equivocaciones y que el código sea volatil (que cambien el nombre de una propiedad de la respuesta).

El objetivo es, con la respuesta HTTP, crear un Mapper.

Ejemplo de Mapper:

```
// El objetivo de esta clase es tener todas las propiedades que vienen en la response HTTP.
// Es como crearse una adaptación específica de la respuesta.
class YesNoModel {
  String answer;
  bool forced;
  String image;

  YesNoModel({
    required this.answer,
    required this.forced,
    required this.image,
  });

  // Una vez creada esta clase, nos falta recibir un mapa y con ese mapa crear una instancia de esta clase.
  // Aquí tenemos para ello este Factory Constructor.
  factory YesNoModel.fromJsonMap(Map<String, dynamic> json) =>
      YesNoModel(
        // Y luego, de este mapa tendríamos que evaluar que propiedades son las que ocupamos.
        // Con esto ya podemos usar notación de punto para evitar equivocarme al escribir.
        answer: json['answer'],
        forced: json['forced'],
        image: json['image']
    );
}
```

Y ahora la gestión de la respuesta HTTP cambia a:

```
class GetYesNoAnswer {
  final _dio = Dio();

  Future<Message> getAnswer() async {
    final response = await _dio.get('https://yesno.wtf/api');

    final yesNoModel = YesNoModel.fromJsonMap(response.data);

    // Podemos usar notación de punto.
    return Message(
      text: yesNoModel.answer,
      fromWho: FromWho.hers,
      imageUrl: yesNoModel.image,
    );
  }
}
```

Notar que es muy fácil generar este Mapper porque son 3 campos.
Podemos usar la extensión de VSCode `Paste JSON as Code` o ir a la web: `https://quicktype.io/`

En Postman hacer la petición a la API y copiar la respuesta.

En la web, seleccionar las opciones indicadas en la imagen y pegar la respuesta de Postman. Se ha cambiado el nombre del root a YesNoModel.

![alt QuickType](./Images/03_Quicktype.png)

Y como vemos, genera el código automáticamente.

## Assets

En la carpeta raiz del proyecto creamos una carpeta `assets`, es decir, recursos estáticos, donde colocamos las carpetas con dichos recursos. Los recursos estáticos son parte de la app, es decir, irán en el bundle inicial de la aplicación y estarán disponibles directamente en la memoria del dispositivo.

Sin embargo, dichos recursos no van a estar disponibles en nuestra app hasta que lo indiquemos en el fichero `pubspec.yaml`, en la parte donde indica como añadir `assets` a la aplicación, y lo dejamos así.

```
  # To add assets to your application, add an assets section, like this:
  assets:
    - assets/videos/
```

Tal y como lo hemos indicado, con `videos/` se importan todos los videos que se encuentren en esa carpeta, pero NO LOS SUBDIRECTORIOS. Si hubiera subdirectorios, hay que indicarlos.

Cuando se incluyen assets, se recomienda cerrar la app completamente y volverla a ejecutar.

## Operador de cascada

Lo vemos en el proyecto `toktik`.

En la parte `DiscoverProvider()..loadNextPage()`, a `..` se le llama operador de cascada.

```
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DiscoverProvider()..loadNextPage())],
      child: MaterialApp(
        title: 'TokTik',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
        home: const DiscoverScreen()
      ),
    );
  }
```

Ejemplo sin cascada:

```
  myObject.someMethod();
  myObject.someOtherMethod();
```

Ejemplo con cascada:

```
  myObject
    ..someMethod();
    ..someOtherMethod();
```

Puede verse que sirve para evitar tener que estar haciendo referencia constante al objeto.

## PageView

Es un Widget que nos permite hacer scroll a pantalla completa. Similar a un listado.

Toma todo el espacio disponible en la pantalla o el espacio que se le esté asignando.

```
return PageView(
  // Por defecto el movimiento es horizontal.
  // Lo cambiamos para esta app a vertical.
  scrollDirection: Axis.vertical,
  // Para que funcione el scroll horizontal/vertical en Android.
  physics: const BouncingScrollPhysics(),
  // Para ir viendo estos colores, mover el ratón con el botón izquierdo pulsado en el dispositivo simulado, a la derecha
  // y a izquierda (o arriba y abajo en este caso), para que cambie de color.
  children: [
    Container(color: Colors.red),
    Container(color: Colors.blue),
    Container(color: Colors.teal),
    Container(color: Colors.yellow),
    Container(color: Colors.pink),
    Container(color: Colors.deepOrange),
  ],
);
```

Y dinámico, con ejemplo de Stack y Positioned:

```
// Con builder construimos el PageView bajo demanda.
// En vez de tener en children todo lo que queremos renderizar, solo tendremos lo que realmente
// necesitamos (dinámico) en un itemBuilder.
return PageView.builder(
  scrollDirection: Axis.vertical,
  physics: const BouncingScrollPhysics(),
  // Los elementos que tengo.
  itemCount: videos.length,
  itemBuilder: (context, index) {
    final VideoPost videoPost = videos[index];

    // Construimos un stack, que permite colocar sus hijos unos sobre otros. Esto nos permite
    // alinear y posionarlos en relación al espacio que les da el padre.
    // En el ejemplo tenemos tres Widgets: De fondo el video, un gradiente y botones de manejo.
    return Stack(
      children: [
        // Video Player + gradiente

        // Botones
        // Por defecto, todos los Widgets se colocan en la posición 0,0 del dispositivo (arriba a la izquierda)
        // Para colocarlo en la posición que queramos, debemos envolver nuestro Widget en un Widget llamado Positioned.
        // Positioned trabaja junto al Stack y nos permite definir la posición del Widget hijo.
        Positioned(
          bottom: 40,
          right: 20,
          child: VideoButtons(video: videoPost)
        ),
      ],
    );
  } ,
);
```

## Positioned

Por defecto, todos los Widgets se colocan en la posición 0,0 del dispositivo (arriba a la izquierda)

Para colocarlo en la posición que queramos, debemos envolver nuestro Widget en un Widget llamado Positioned.

Positioned trabaja junto al Stack y nos permite definir la posición del Widget hijo.

```
Positioned(
  bottom: 40,
  right: 20,
  child: VideoButtons(video: videoPost)
),
```

## Formateo de números

Instalamos un paquete llamado `intl`.

Ejemplo de uso:

```
class HumanFormats {

  static String humanReadableNumber(double number) {

    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
    ).format(number);

    return formatterNumber;
  }
}
```

## Truco para saber lo que ocupa un Widget en pantalla

Se suele usar `Placerholder()`, cuando veremos una X en el espacio reservado, o `Container(color: Colors.red)` y veremos ese color en el espacio reservado.

## Animaciones en Flutter

Instalamos un paquete llamado `animate_do`.

La web del paquete es: https://pub.dev/packages/animate_do

Y distintos videos de YouTube con la funcionalidad:

https://www.youtube.com/watch?v=48jIUnc1TQo&list=PLCKuOXG0bPi1E-uXVd4j2iLqkbTYaHARX&index=2

https://www.youtube.com/watch?v=oreOdtQ124M

https://www.youtube.com/watch?v=QLUI3Pxw1Z8

https://www.youtube.com/watch?v=w698MRVTB2E

## Video Player

https://docs.flutter.dev/cookbook/plugins/play-video

Para visualizar videos, instalamos el paquete `video_player`.

Siempre que instalemos un paquete, deberíamos revisar si hay que tener en cuenta algo para que funcione en iOS, Android, Web...

Por ejemplo, para cargar videos de Internet en Android, hay que añadir el siguiente permiso en `AndroidManifest.xml`

`<uses-permission android:name="android.permission.INTERNET"/>`

## Acceso a propiedades del StatefulWidget en la clase State.

Dado el StatefulWidget siguiente:

```
class FullScreenPlayer extends StatefulWidget {
  final String videoUrl;
  final String caption;

  const FullScreenPlayer({
    super.key,
    required
    this.videoUrl,
    required this.caption
  });

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}
```

Y su estado, para poder acceder a una propiedad, como por ejemplo caption, usaremos widget.caption.

```
class _FullScreenPlayerState extends State<FullScreenPlayer> {
  @override
  Widget build(BuildContext context) {

    // Usamos widget para acceder a las propiedades del StatefulWidget.
    widget.caption;

    return const Placeholder();
  }
}
```

## Ciclos de Vida

Los StatelessWidgnet NO tienen ciclo de vida. Se crean siempre que haga falta.

Los StatefulWidget SI tienen ciclo de vida.

Pasos del ciclo de vida:

- initState() - Creación del state. Siempre hay que ejecutar lo primero `super.initState();`
- dispose() - Cuando se destruye el Widget. Siempre hay que ejecutar lo último `super.dispose();`

## GestureDetector()

Es un Widget que tiene muchas funciones incorporadas para tratar el tema de gestos sobre la pantalla, como pulsar, pellizcar...

Ejemplo:

```
return GestureDetector(

  // Si pulso en la pantalla entonces se pausa un video. Si vuelvo a pulsar se reproduce el video.
  onTap: () {
    if (controller.value.isPlaying) {
      controller.pause();
      return;
    }

    controller.play();
  },
  ...
);
```

## Gradiente

Ejemplo donde puede verse un BoxDecoration con un LinearGradient y algunas de las propiedades que espera.

```
// fill es parecido a un SizedBox, pero como vamos a estar dentro de un Stack, fill indica
// que se tome todo el espacio posible de ese Stack.
return Positioned.fill(
  child: DecoratedBox(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.transparent,
          Colors.black87  // 87% negro y 13% transparente
        ],
        // Donde queremos que se detenga el gradiente.
        // El comportamiento por defecto del gradiente es [0.0, 1.0]
        //
        // Para este ejemplo [0.5, 1.0]
        // Indicando 0.5 decimos que sea transparente desde 0 hasta la mitad de la pantalla.
        // Podemos definir tantos stops como colores tenemos.
        stops: [0.5, 1.0],
        // Para indicar donde empieza el gradiente (apariencia) y donde acaba
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )
    )
  )
);
```

## Navegación entre pantallas

https://docs.flutter.dev/ui/navigation

La navegación 2.0 de Flutter es bastante compleja.

Se muestra un ejemplo con `onTap()`, pero obviamente puede ser `onPressed: () {}` o cualquier otro gestor de eventos.

Se muestran distintas alternativas para realizar la navegación. Nosotros vamos a usar `go_router`.

El objetivo principal de go_router es que nos haga fácil y explicativo la manera de observar los argumentos por el URL, parametrizarlos, hacer validaciones, sacar al usuario si no está autenticado...

Forma 1:

```
onTap: () {

  // push() hay que entenderlo como que va a crear un Stack de tarjetas.
  // Tengo una tarjeta, y con push() pongo encima otra y con push() pongo encima otra...
  // Y con pop() las voy retirando en sentido LIFO
  // Usando Navigator.of(context).replace() se destruye la ruta anterior, no podiendo regresar a ella.
  // Como ButtonsScreen tiene un AppBar sabe que tenemos un historial y podemos echar para atrás.

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const ButtonsScreen(),
    ),
  );
},
```

Forma 2:

```
// En main.dart definimos las rutas.

return MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: AppTheme(selectedColor: 0).getTheme(),
  home: const HomeScreen(),

  // Para la navegación, se pueden definir rutas, pero no se recomienda por una serie de limitantes.
  // Ver la web para saber las limitantes.
  // Al tener estos nombres de rutas la navegación se hace más fácil.
  routes: {
    '/buttons': (context) => const ButtonsScreen(),
    '/cards': (context) => const CardsScreen(),
  },

);

// En home_screen.dart accedemos a esas rutas.

onTap: () {

  // Y para usar los nombres de rutas:
  Navigator.pushNamed(context, menuItem.link);

  // Esta otra opción es posible:
  // Navigator.of(context).pushNamed(menuItem.link);
},

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
- toktik
- toktik_con_repositorios
  - De aquí en adelante vamos a seguir trabajando usando las bases de la arquitectura limpia (salvo los Casos de Uso)
- widgets_app
