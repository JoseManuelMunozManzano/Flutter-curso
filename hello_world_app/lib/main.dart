import 'package:flutter/material.dart';
import 'package:hello_world_app/presentation/screens/counter/counter_screen.dart';

void main() {
  // runApp: Ejecución de Widget inicial.
  runApp(const MyApp());
}

// Tenemos dos tipos de Widgets principales y todos los demás Widgets extienden uno de ellos:
// - StatelessWidget
// - StatefulWidget

// To-dos los StatelessWidget necesitan implementar el método build()
// Dejar el cursor sobre MyApp.
// Pulsar Cmd + .
// Seleccionar Create 1 missing override
//
// El BuildContext, entre otras cosas, crea el árbol de Widgets.
// El key permite nombrar un Widget dentro del arbol de Widgets.
//    Para crear rápidamente el key, nos posicionamos en MyApp, pulsamos Cmd + . y seleccionamos Add 'key' to constructors
class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Este MaterialApp es nuestra aplicación.
    // Indicamos const porque este código NUNCA va a cambiar.
    return const MaterialApp(
      // Esto es para que no aparezca en el emulador el banner indicando que estamos en DEBUG
      debugShowCheckedModeBanner: false,
      home: CounterScreen()
    );
  }
}
