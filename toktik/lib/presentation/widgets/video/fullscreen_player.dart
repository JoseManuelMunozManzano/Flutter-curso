// Usamos snippet impm
import 'package:flutter/material.dart';

// Usamos snippet stlesw
class FullScreenPlayer extends StatelessWidget {
  // Con la intención de que este Widget se pueda reutilizar en un futuro, solo necesito
  // la URL y el texto de ese video.
  // To-do lo demás, como likes, música de fondo... no forma parte de mi video.
  final String videoUrl;
  final String caption;

  const FullScreenPlayer({
    super.key,
    required
    this.videoUrl,
    required this.caption
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
