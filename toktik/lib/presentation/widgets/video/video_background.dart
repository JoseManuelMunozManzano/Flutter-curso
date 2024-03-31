// Usamos snippet impm
import 'package:flutter/material.dart';

// Usamos snippet stlesw
class VideoBackground extends StatelessWidget {

  final List<Color> colors;
  final List<double> stops;

  // Indicamos un assert para que los compañeros programadores sepan como mandar los parámetros.
  const VideoBackground({
    super.key,
    this.colors = const[
      Colors.transparent,
      Colors.black87  // 87% negro y 13% transparente
    ],
    this.stops = const[0.0, 1.0]
  }): assert(colors.length == stops.length, 'Stops and colors must be same length');

  @override
  Widget build(BuildContext context) {
    // fill es parecido a un SizedBox, pero como vamos a estar dentro de un Stack, fill indica
    // que se tome todo el espacio posible de ese Stack.
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            // Donde queremos que se detenga el gradiente.
            // El comportamiento por defecto del gradiente es [0.0, 1.0]
            //
            // Para este ejemplo [0.5, 1.0]
            // Indicando 0.5 decimos que sea transparente desde 0 hasta la mitad de la pantalla.
            // Podemos definir tantos stops como colores tenemos.
            stops: stops,
            // Para indicar donde empieza el gradiente (apariencia) y donde acaba
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        )
      )
    );
  }
}
