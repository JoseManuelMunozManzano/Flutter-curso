import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/domain/repositories/video_posts_repository.dart';

class DiscoverProvider extends ChangeNotifier {

  // Cuando cargamos la aplicación, en principio no tengo ningún video.
  bool initialLoading = true;
  // Vamos a suponer que estos videos vienen de una fuente externa.
  List<VideoPost> videos = [];

  // Tenemos como dependencia la clase abstracta del repositorio.
  final VideoPostsRepository videosRepository;

  DiscoverProvider({
    required this.videosRepository
  });

  Future<void> loadNextPage() async {

    // Llamada al repositorio
    final newVideos = await videosRepository.getTrendingVideosByPage(1);

    videos.addAll(newVideos);
    initialLoading = false;

    notifyListeners();
  }
}
