// Usamos snippet impm
import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';

// Usamos snippet stlesw
class VideoScrollableView extends StatelessWidget {
  final List<VideoPost> videos;

  const VideoScrollableView({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return PageView(
      // Por defecto el movimiento es horizontal.
      // Lo cambiamos para esta app a vertical.
      scrollDirection: Axis.vertical,
      // Para que funcione el scroll horizontal/vertical en Android.
      physics: const BouncingScrollPhysics(),
      // Para ir viendo estos colores, mover el ratón con el botón izquierdo pulsado en el dispositivo simulado, a la derecha
      // y a izquierda (o arriba y abajo en este caso), para que cambie de color.
      children: [
        Container(color: Colors.red),
        Container(color: Colors.blue),
        Container(color: Colors.teal),
        Container(color: Colors.yellow),
        Container(color: Colors.pink),
        Container(color: Colors.deepOrange),
      ],
    );
  }
}
