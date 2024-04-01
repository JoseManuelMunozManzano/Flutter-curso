// Usamos snippet impm
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:toktik/config/helpers/human_formats.dart';
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
        const SizedBox(height: 20,),
        _CustomIconButton(value: video.views, iconData: Icons.remove_red_eye_outlined,),

        const SizedBox(height: 20,),
        SpinPerfect(
          infinite: true,
          duration: const Duration(seconds: 5),
          child: const _CustomIconButton(value: 0, iconData: Icons.play_circle_outline,)
        ),
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
        IconButton(
          onPressed: () {},
          icon: Icon(iconData, color: color, size: 30,)
        ),

        if (value > 0)
        Text(HumanFormats.humanReadableNumber(value.toDouble())),
      ],
    );
  }
}
