// Usamos snippet impm
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/presentation/widgets/shared/video_buttons.dart';
import 'package:toktik/presentation/widgets/video/fullscreen_player.dart';

// Usamos snippet stlesw
class VideoScrollableView extends StatelessWidget {
  final List<VideoPost> videos;

  const VideoScrollableView({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    // Con builder construimos el PageView bajo demanda.
    // En vez de tener en children todo lo que queremos renderizar, solo tendremos lo que realmente
    // necesitamos (dinámico) en un itemBuilder.
    return PageView.builder(
      // Por defecto el movimiento es horizontal.
      // Lo cambiamos para esta app a vertical.
      scrollDirection: Axis.vertical,
      // Para que funcione el scroll horizontal/vertical en Android.
      physics: const BouncingScrollPhysics(),
      // Los elementos que tengo.
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final VideoPost videoPost = videos[index];

        // Construimos un stack, que permite colocar sus hijos unos sobre otros. Esto nos permite
        // alinear y posionarlos en relación al espacio que les da el padre.
        // En el ejemplo tenemos tres Widgets: De fondo el video, un gradiente y botones de manejo.
        return Stack(
          children: [
            // Video Player + gradiente
            // Tamaño específico de la pantalla de video. Usamos expand para que expanda a toda la pantalla.
            // Sin el, puede que el tamaño no sea el esperado por nosotros.
            SizedBox.expand(
              child: FullScreenPlayer(
                caption: videoPost.caption,
                videoUrl: videoPost.videoUrl,
              ),
            ),

            // Botones
            // Por defecto, todos los Widgets se colocan en la posición 0,0 del dispositivo (arriba a la izquierda)
            // Para colocarlo en la posición que queramos, debemos envolver nuestro Widget en un Widget llamado Positioned.
            // Positioned trabaja junto al Stack y nos permite definir la posición del Widget hijo.
            Positioned(
              bottom: 40,
              right: 20,
              child: VideoButtons(video: videoPost)
            ),
          ],
        );
      } ,
    );
  }
}
