// Usamos snippet impm
import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';

// Usamos snippet stlesw
class VideoButtons extends StatelessWidget {
  final VideoPost video;

  const VideoButtons({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CustomIconButton(value: video.likes, iconColor: Colors.red, iconData: Icons.favorite,),
        _CustomIconButton(value: video.likes, iconData: Icons.remove_red_eye_outlined,),
      ],
    );
  }
}

// Personalización del botón
class _CustomIconButton extends StatelessWidget {
  // Cantidad de likes
  final int value;
  final IconData iconData;
  final Color? color;

  // Usualmente, cuando el Widget es private y no pasamos el key, lo podemos quitar.
  const _CustomIconButton({
    required this.value,
    required this.iconData,
    iconColor
  }): color = iconColor ?? Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(onPressed: () {}, icon: Icon(iconData, color: color, size: 30,)),

        Text('$value'),
      ],
    );
  }
}
