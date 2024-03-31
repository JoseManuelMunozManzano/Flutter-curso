import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/infrastructure/models/local_video_model.dart';
import 'package:toktik/shared/data/local_video_posts.dart';

class DiscoverProvider extends ChangeNotifier {

  // TODO: Repository, DataSource

  // Cuando cargamos la aplicación, en principio no tengo ningún video.
  bool initialLoading = true;

  // Vamos a suponer que estos videos vienen de una fuente externa.
  List<VideoPost> videos = [];

  // Cargar los videos.
  // El problema que empezamos a tener aquí es que si implementamos aquí toda la función de carga de videos,
  // esto amarra a mi provider a la dependencia del origen de datos (es local, la data que tenemos en la carpeta shared)
  // Si el día de mañana no ocupamos ese fichero de la carpeta shared/data, vamos a tener que venir aquí y hacer
  // las modificaciones necesarias para cargar de una fuente de datos (data source) diferente.
  // Viola el principio Open/Close.
  // A este provider no le debería importar de donde vienen los videos.
  // Esto lo acabaremos resolviendo.
  Future<void> loadNextPage() async {

    // Simular comunicación asíncrona de 2 sg.
    // Cuando pasen suponemos que tenemos los videos, los cargamos y los añade a la lista de videos. 
    await Future.delayed(const Duration(seconds: 2));

    final List<VideoPost> newVideos = videoPosts.map(
      (video) => LocalVideoModel.fromJson(video).toVideoPostEntity()
    ).toList();

    videos.addAll(newVideos);
    initialLoading = false;

    notifyListeners();
  }
}
