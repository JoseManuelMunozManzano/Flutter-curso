import 'package:cinemapedia/domain/entities/movie.dart';

// Recordar que la idea del repositorio es poder cambiar de datasource fácilmente.

abstract class LocalStorageRepository {

  Future<void> toggleFavorite(Movie movie);

  Future<bool> isMovieFavorite(int movieId);

  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});

}
