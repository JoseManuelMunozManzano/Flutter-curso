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

## Temario

- 01_dart_intro
  - Repaso de Dart
- 02_instalación_flutter
  - Instalación de Flutter
  - Configurar emuladores
  - Configurar nuestros dispositivos físicos
- hello_world_app
- yes_no_app
