import 'package:flutter/material.dart';

void main() {
  // runApp: Ejecución de Widget inicial.
  runApp(MyApp());
}

// Tenemos dos tipos de Widgets principales y todos los demás Widgets extienden uno de ellos:
// - StatelessWidget
// - StatefulWidget

// To-dos los StatelessWidget necesitan implementar el método build()
// Dejar el cursor sobre MyApp.
// Pulsar Cmd + .
// Seleccionar Create 1 missing override
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Este MaterialApp es nuestra aplicación.
    return MaterialApp(
      // El Center Widget se encarga de centrar su hijo en las dimensiones que tenga disponibles el padre.
      home: Center(child: Text('Hola Mundo')),
    );
  }
}
