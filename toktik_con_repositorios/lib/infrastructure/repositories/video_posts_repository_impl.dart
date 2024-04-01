import 'package:toktik/domain/datasources/video_posts_datasource.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/domain/repositories/video_posts_repository.dart';

class VideoPostsRepositoryImpl implements VideoPostsRepository {

  // Pasamos la fuente de datos VideoPostDatasource (la clase abstracta)
  // Cualquier implementación es permitida.
  final VideoPostDataSource videosDataSource;

  // Ponemos en el constructor el parámetro por nombre porque así es más fácil de expandir.
  VideoPostsRepositoryImpl({
    required this.videosDataSource
  });

  @override
  Future<List<VideoPost>> getFavoriteVideosByUser(String userID) {
    throw UnimplementedError();
  }

  @override
  Future<List<VideoPost>> getTrendingVideosByPage(int page) {
    return videosDataSource.getTrendingVideosByPage(page);
  }
}
