import 'dart:math' show Random;
// Usando el snipped impm importamos el paquete de Material
import 'package:flutter/material.dart';

// Usando el snippet stlesw creamos un StatelessWidget
//
// Pero lo transformamos luego en un StatefulWidget (pulsando Cmd+.)
// porque necesitamos que el Widget mantenga un estado (las propiedades que necesito animar)
class AnimatedScreen extends StatefulWidget {

  static const name = 'animated_screen';

  const AnimatedScreen({super.key});

  @override
  State<AnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> {

  // Valores iniciales
  double width = 50;
  double height = 50;
  Color color = Colors.indigo;
  double borderRadius = 10.0;

  void changeShape() {
  
    final random = Random();

    // Como no puede ser 0, si pasase entonces lo dejamos en el valor inicial 120.
    // Esto evita también un error en el curve: Curves.elasticOut, donde los valores
    // pueden ser negativos. Sumando esas cantidades evitamos ese negativo.
    width = random.nextInt(300) + 120;
    height = random.nextInt(300) + 120;
    borderRadius = random.nextInt(100) + 20;
    color = Color.fromRGBO(random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);

    // Para que realice el renderizado con los nuevos valores.
    setState(() {});
  }

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
          curve: Curves.elasticOut,

          // Otra actuación para evitar que los valores sean negativos.
          width: width <= 0 ? 0 : width,
          height: height <= 0 ? 0 : height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius < 0 ? 0 : borderRadius),
          ),
        ),
      ),

      // La idea es que cada vez que se toque el botón anime el contenedor
      // de forma aleatoria.
      floatingActionButton: FloatingActionButton(
        onPressed: changeShape,
        child: const Icon(Icons.play_arrow_rounded)
      ),
    );
  }
}
