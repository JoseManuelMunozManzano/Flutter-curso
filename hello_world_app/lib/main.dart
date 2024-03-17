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
    return MaterialApp(
      // Esto es para que no aparezca en el emulador el banner indicando que estamos en DEBUG
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Para habilitar Material 3, aunque ya no haga falta porque ya viene por defecto.
        useMaterial3: true,
        // Para crear una paleta de colores.
        // Seleccionando un color, Flutter nos va a hacer una paleta de colores, y un color skin basado en ese color.
        colorSchemeSeed: Colors.blue,
      ),

      // Se acostumbra a que el hijo sea siempre la última propiedad a definir.
      // Indicamos const porque este código NUNCA va a cambiar.
      home: const CounterScreen()
    );
  }
}
