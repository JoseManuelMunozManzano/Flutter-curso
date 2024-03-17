import 'package:flutter/material.dart';

class CounterFunctionsScreen extends StatefulWidget {
  const CounterFunctionsScreen({super.key});

  @override
  State<CounterFunctionsScreen> createState() => _CounterFunctionsScreenState();
}

class _CounterFunctionsScreenState extends State<CounterFunctionsScreen> {
  int clickCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Counter Functions'),
          // Iconos en la parte izquierda: propiedad leading.
          //    Si necesitamos más de uno, usamos un Widget Row, que permite un array de Widgets.
          // Iconos en la parte derecha: array actions, que ya de por si es un array de Widgets
          actions: [
            IconButton(
                // Icon es un Widget especial para mostrar iconos.
                icon: const Icon(Icons.refresh_rounded),
                onPressed: () {
                  setState(() {
                    clickCounter = 0;
                  });
                }),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$clickCounter',
                style:
                    const TextStyle(fontSize: 160, fontWeight: FontWeight.w100),
              ),
              Text(
                'Click${clickCounter == 1 ? '' : 's'}',
                style: const TextStyle(fontSize: 25),
              )
            ],
          ),
        ),
        // Como Widget indicaremos un Column, ya que necesitamos más de un Widget FloatingActionButton.
        floatingActionButton: Column(
          // Sin mainAxisAlignment, el FloatingActionButton coloca el botón arriba del todo, y lo queremos abajo.
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              // Para que este botón sea circular.
              shape: const StadiumBorder(),
              onPressed: () {
                clickCounter = 0;
                setState(() {});
              },
              child: const Icon(Icons.refresh_outlined),
            ),

            // Para agregar una separación, podemos usar un Widget llamado Sizedbox, que es un contenedor o una
            // caja con un tamaño específico
            const SizedBox(height: 10,),

            // Vemos que todo esto se repite.
            // Vamos a crear nuestros Widgets personalizados.
            FloatingActionButton(
              shape: const StadiumBorder(),
              onPressed: () {
                clickCounter++;
                setState(() {});
              },
              child: const Icon(Icons.plus_one),
            ),

            const SizedBox(height: 10,),

            FloatingActionButton(
              shape: const StadiumBorder(),
              onPressed: () {
                clickCounter--;
                setState(() {});
              },
              child: const Icon(Icons.exposure_minus_1_outlined),
            ),
          ],
        ));
  }
}
