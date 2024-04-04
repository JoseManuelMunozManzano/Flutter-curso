// Usando el snipped impm importamos el paquete de Material
import 'package:flutter/material.dart';

// Usando el snippet stlesw creamos un StatelessWidget
class AnimatedScreen extends StatelessWidget {

  static const name = 'animated_screen';

  const AnimatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Container'),
      ),

      body: Center(
        // Se va a cambiar el color, el nivel del borde redondeado y el tamaño.
        child: AnimatedContainer(
          // El tiempo que tarda en hacer la animación.
          duration: const Duration(milliseconds: 400),
          // El tipo de animación que se quiere aplicar.
          curve: Curves.easeOutCubic,

          width: 200,
          height: 130,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),

      // La idea es que cada vez que se toque el botón anime el contenedor
      // de forma aleatoria.
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.play_arrow_rounded)
      ),
    );
  }
}
