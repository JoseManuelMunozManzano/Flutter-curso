// Usamos snippet impm
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// Usamos snippet stlesw, pero luego lo transformamos a un StatefulWidget, tal y como indica
// la página de Video Player.
// https://docs.flutter.dev/cookbook/plugins/play-video#3-create-and-initialize-a-videoplayercontroller
class FullScreenPlayer extends StatefulWidget {
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
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {

  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.asset(widget.videoUrl)
      ..setVolume(0)
      ..setLooping(true)
      ..play();
  }

  // Cuando se crea un controlador, al destruir el Widget lo tenemos que limpiar.
  // Evitamos que el video se siga reproduciendo aunque no lo estemos viendo, u otro tipo
  // de fuga de memoria.
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: controller.initialize(),
      // El snapshot es el estado del future de arriba.
      builder: (context, snapshot) {
        return const Center(child: CircularProgressIndicator(strokeWidth: 2));
      },
    );
  }
}
