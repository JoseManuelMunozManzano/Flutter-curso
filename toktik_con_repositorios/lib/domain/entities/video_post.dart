// Modelo de datos cercano a nuestras reglas de negocio, sin importar que data viene
// de las fuentes externas.
class VideoPost {

  final String caption;
  final String videoUrl;
  final int likes;
  final int views;

  VideoPost({
    required this.caption,
    required this.videoUrl,
    this.likes = 0,
    this.views = 0
  });
}
