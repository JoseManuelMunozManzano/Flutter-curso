import 'package:flutter/material.dart';

class HerMessageBubble extends StatelessWidget {
  const HerMessageBubble({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: colors.secondary, borderRadius: BorderRadius.circular(20)),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text('Hola Mundo', style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(height: 5),
        _ImageBubble(),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class _ImageBubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // El MediaQuery nos va a dar información respecto al dispositivo que lo está ejecutando.
    // El context hace referencia al árbol de Widgets, donde también tenemos otra información como
    // las dimensiones y características del dispositivo donde se está ejecutando la app.
    // Usando size obtenemos las dimensiones del dispositivo.
    final size = MediaQuery.of(context).size;

    // ClipRRect permite bordes redondeados
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        'https://yesno.wtf/assets/no/1-c7d128c95c1740ec76e120146c870f0b.gif',
        width: size.width * 0.7,
        // La idea de dejar un height específico, es para evitar que las imágenes
        // varíen unas de otras. Siempre voy a saber su alto.
        height: 150,
        fit: BoxFit.cover,
        // Recordar que un Builder es algo que se va a construir en tiempo de ejecución.
        // El child es nuestra misma imagen cuando se carga, ya construida enteramente.
        // El context es nuestro árbol de Widgets e info del dispositivo.
        loadingBuilder: (context, child, loadingProgress) {
          // Si se cargo por completo, regresa la imagen
          if (loadingProgress == null) return child;

          // Indicando el mismo size se evitan brincos en el diseño cuando pasamos
          // del loader a la imagen.
          return Container(
            width: size.width * 0.7,
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: const Text('Mi amor está enviando una imagen'),
          );
        },
      ),
    );
  }
}
