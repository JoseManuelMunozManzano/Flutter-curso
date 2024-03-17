// Usar atajo importM y Tab para importar material.dart
import 'package:flutter/material.dart';

// Creamos un nuevo StatelessWidget
// Usaremos el atajo stles y Tab
// Luego solo tenemos que indicar, donde aparece MyWidget, el nombre real del Widget.
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Un PlaceHolder es un Widget que crea una caja con una X para saber que ese es el espacio que se le está asignando
    // y que tenemos para trabajar.
    // Pero lo quitamos para sustituirlo por nuestro Scaffold que estaba en main.dart
    //
    //return const Placeholder();
    //
    // Un Scaffold da la bases de un diseño de material
    return const Scaffold(
      // El Center Widget se encarga de centrar su hijo en las dimensiones que tenga disponibles el padre.
      body: Center(child: Text('Counter Screen')),
    );
  }
}
