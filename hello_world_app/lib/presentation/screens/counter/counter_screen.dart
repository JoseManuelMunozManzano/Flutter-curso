// Usar atajo importM y Tab para importar material.dart
import 'package:flutter/material.dart';

// Creamos un nuevo StatelessWidget
// Usaremos el atajo stles y Tab
// Luego solo tenemos que indicar, donde aparece MyWidget, el nombre real del Widget.
//
// Como ahora vamos a mantener estado, cambiamos a un StatefulWidget.
// Para ello, nos posicionamos sobre StatelessWidget, pulsamos Cmd + . y seleccionamos Convert to StatefulWidget
class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  // Esta invocación de estado que se crea al transformar a StatefulWidget no es más que la invocación
  // de otra clase.
  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

// Esta clase es la construcción de nuestro Widget, el que teníamos cuando la clase era originalmente un StatelessWidget.
// Ahora va a ser el estado del CounterScreen.
// Podemos definir variables de estado.
class _CounterScreenState extends State<CounterScreen> {
  // Mi variable de estado.
  int clickCounter = 0;

  @override
  Widget build(BuildContext context) {
    // Un PlaceHolder es un Widget que crea una caja con una X para saber que ese es el espacio que se le está asignando
    // y que tenemos para trabajar.
    // Pero lo quitamos para sustituirlo por nuestro Scaffold que estaba en main.dart
    //
    //return const Placeholder();
    //
    // Un Scaffold da la bases de un diseño de material.
    return Scaffold(
      appBar: AppBar(
        // Con estas dos propiedades se deja la Barra de arriba del móvil como lo dejaría Material 2
        // centerTitle: true,
        // backgroundColor: const Color.fromARGB(255, 60, 174, 231),

        title: const Text('Counter Screen'),
      ),
      // El Center Widget se encarga de centrar su hijo en las dimensiones que tenga disponibles el padre.
      body: Center(
        child: Column(
          // La propiedad mainAxisAlignment está esperando un objeto que sea del tipo MainAxisAlignment,
          // que es una enumeración. Esta propiedad es parecida a Flexbox de CSS.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              // Usando el valor de la propiedad con estado clickCounter.
              // También vale clickCounter.toString()
              // Porque se muestra como string
              '$clickCounter',
              style:
                  const TextStyle(fontSize: 160, fontWeight: FontWeight.w100),
            ),
            Text(
              // clickCounter == 1 ? 'Click' : 'Clicks',
              'Click${clickCounter == 1 ? '' : 's'}',
              style: const TextStyle(fontSize: 25),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Cambiando nuestra propiedad de estado.
        onPressed: () {
          clickCounter++;
          // Tenemos que indicarle a Flutter CUANDO QUEREMOS QUE SE RENDERICE DE NUEVO NUESTRO WIDGET.
          // Si no lo hacemos, no veremos el resultado.
          // Usamos una función para esto, setState(() {}) con el callback.
          // Se renderiza TO-DO el Widget, es decir, volverá a renderizar el Scaffold, generará el AppBar,
          //  y, como dentro del AppBar el título es constante lo cogerá sin necesidad de regenerarlo...
          // Pero esto NO ES REALMENTE CIERTO, porque Flutter es muy eficiente. Lo que hace es ver qué se ha
          // afectado por ese cambio de estado y solo eso vuelve a renderizar. Para lo demás coge el estado anterior.
          //
          // Podemos indicar el cambio de estado fuera o dentro del setSatate.
          setState(() {});
        },
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}
