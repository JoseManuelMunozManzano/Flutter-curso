import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

// Dado un objeto que recibamos, devolveremos una entity Movie.
class MovieMapper {
  // Tip: Cuando haya muchos atributos, pulsar Cmd+Shift+P y seleccionar Format Document para que los deje uno en cada línea.
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != '') 
        ? 'https://image.tmdb.org/t/p/w500/${moviedb.backdropPath}'
        : 'https://ih1.redbubble.net/image.3224006290.0121/flat,750x,075,f-pad,750x1000,f8f8f8.jpg',
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
        ? 'https://image.tmdb.org/t/p/w500/${moviedb.posterPath}'
        : 'https://ih1.redbubble.net/image.3224006290.0121/flat,750x,075,f-pad,750x1000,f8f8f8.jpg',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount
  );
}
