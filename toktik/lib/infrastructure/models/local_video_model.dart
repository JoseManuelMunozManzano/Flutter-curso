import 'package:toktik/domain/entities/video_post.dart';

// Esta clase sirve para hacer un match entre las respuestas de los API con mi aplicación.
// Si algún día cambia el API, solo hay dos lugares donde habrá que tocar, el modelo y el mapper.
// Como en este caso todo está en este archivo solo habrá que cambiarlo aquí.
class LocalVideoModel {

  final String name;
  final String videoUrl;
  final int likes;
  final int views;

  LocalVideoModel({
    required this.name,
    required this.videoUrl,
    this.likes = 0,
    this.views = 0,
  });

  // Con este fromJson voy a coger una respuesta HTTP, que será de un tipo Map<String, dynamic>, y voy a 
  // crear instancias de LocalVideoModel.
  factory LocalVideoModel.fromJson(Map<String, dynamic> json) => LocalVideoModel(
    name: json['name'] ?? 'No name',
    videoUrl: json['videoUrl'],
    likes: json['likes'] ?? 0,
    views: json['views'] ?? 0,
  );

  // A la larga, este método mapper debe ir a otro archivo, porque puede ayudarnos a mapear de distintos sources.
  VideoPost toVideoPostEntity() => VideoPost(
    caption: name,
    videoUrl: videoUrl,
    likes: likes,
    views: views,
  );
}
