// Importamos el paquete de material usando el snippet importM
import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';

// Creamos un StatelessWidget usando el snippet stlesw
class MyMessageBubble extends StatelessWidget {
  final Message message;

  const MyMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    // Con esto se evita tener que hardcodear los colores en función de nuestro tema, del modo light o dark...
    //
    // Se busca el tema dentro del contexto.
    // El primer tema que encuentre es el que va a usar.
    // Pero esto va a tomar el tema global.
    // Con colorScheme tenemos todos los colores basados en el seed que creamos en main.dart
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
              // En vez de tener que indicar un color (Colors.black por ejemplo), gracias a
              // obtener el colorScheme definido en nuestro contexto, al indicar que queremos
              // el color primario, en función del modo light o dark, este cambia de forma
              // dinámica.
              color: colors.primary,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child:
                Text(message.text, style: const TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
