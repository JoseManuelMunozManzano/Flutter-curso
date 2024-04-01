import 'package:toktik/domain/entities/video_post.dart';

// A las clases que implementen este repository, le entra como parámetro la clase abstracta del DataSource.
// Llamarán a los métodos del DataSource.
abstract class VideoPostsRepository {

  Future<List<VideoPost>> getFavoriteVideosByUser(String userID);

  Future<List<VideoPost>> getTrendingVideosByPage(int page);
}
