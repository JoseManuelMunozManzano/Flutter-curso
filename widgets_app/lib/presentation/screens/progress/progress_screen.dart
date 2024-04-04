// Usando el snipped impm importamos el paquete de Material
import 'package:flutter/material.dart';

// Usando el snippet stlesw creamos un StatelessWidget
class ProgressScreen extends StatelessWidget {
  static const name = 'progress_screen';

  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Indicators'),
      ),
      body: const _ProgressView(),
    );
  }
}

class _ProgressView extends StatelessWidget {
  const _ProgressView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          SizedBox(height: 30),
          Text('Circular progress indicator'),
          SizedBox(height: 10),
          CircularProgressIndicator(strokeWidth: 2, backgroundColor: Colors.black45),

          SizedBox(height: 20),
          Text('Circular y Linear controlados'),
          SizedBox(height: 10),
          _ControlledProgressIndicator(),
        ],
      ),
    );
  }
}

class _ControlledProgressIndicator extends StatelessWidget {
  const _ControlledProgressIndicator();

  @override
  Widget build(BuildContext context) {
    // El StreamBuilder es un widget que se va a construir en tiempo de ejecución.
    // Está asociado a un stream (un flujo de información)
    // Cuando no usamos el Stream, porque nos vamos de la pantalla, por ejemplo, Flutter
    // automáticamente realiza el dispose, por lo que se deja de consumir memoria.
    return StreamBuilder<double>(
      // Quiero obtener valores que van desde 0.0 hasta 1.0 y que se detenga (takeWhile)
      stream: Stream.periodic(const Duration(milliseconds: 300), (value) {
        return (value * 2) / 100;
      }).takeWhile((value) => value <= 1.0),

      // El context es la información de nuestro árbol de Widgets.
      // snapshot nos dice cual es el valor concreto del stream.
      builder: (context, snapshot) {

        // La primera emisión tendrá un valor null porque no se ha emitido nada.
        final progressValue = snapshot.data ?? 0;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Indicamos un value, que es un double que va desde 0.0 hasta 1.0.
              // 0.0 indica que no hay valor y conforme vamos aumentando value se va rellenando el círculo.
              CircularProgressIndicator(value: progressValue, strokeWidth: 2, backgroundColor: Colors.black12),
              const SizedBox(width: 20),
              // LinearProgressIndicator necesita saber cual es el espacio para poder renderizar la línea.
              // Como estamos dentro de un Row, no hay un límite de ancho.
              // Para que no falle nuestro LinearProgressIndicator, usaremos un Widget Expanded, que toma
              // to-do el espacio que el padre está dando.
              Expanded(
                // Indicamos un value, que es un double que va desde 0.0 hasta 1.0.
              // 0.0 indica que no hay valor y conforme vamos aumentando value se va rellenando la línea.
                child: LinearProgressIndicator(value: progressValue),
              )
            ],
          ),
        );
      },
    );
  }
}
