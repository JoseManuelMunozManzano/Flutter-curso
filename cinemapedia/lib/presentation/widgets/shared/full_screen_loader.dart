import 'package:flutter/material.dart';

// Loading a pantalla completa.
// Cuando terminemos de hacer la carga ocultaremos esta pantalla.
class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Cargando películas',
      'Comprando palomitas de maiz',
      'Cargando populares',
      'Llamando a mi mujer',
      'Ya casi...',
      'Esto está tardando más de lo esperado :(',
    ];

    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere por favor'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 10),

          // Barriendo el arreglo de mensajes.
          // Cuando se destruye el Widget el StreamBuilder hace la limpieza.
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              // Para la primera vez cuando no tenemos todavía emisión
              if (!snapshot.hasData) return const Text('Cargando...');

              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}
