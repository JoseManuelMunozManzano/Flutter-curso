import 'package:cinemapedia/domain/entities/movie.dart';

// Isar. Si el día de mañana cambiamos de BD local, solo tenemos
// que crear otra implementación de este datasource.

abstract class LocalStorageDatasource {

  Future<void> toggleFavorite(Movie movie);

  Future<bool> isMovieFavorite(int movieId);

  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});

}
