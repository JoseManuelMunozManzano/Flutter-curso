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

## Temario

- 01_dart_intro
  - Repaso de Dart
- 02_instalación_flutter
  - Instalación de Flutter
  - Configurar emuladores
  - Configurar nuestros dispositivos físicos
- hello_world_app
- yes_no_app
