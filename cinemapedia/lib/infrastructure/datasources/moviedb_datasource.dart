import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

// Este datasource está especializado en interaccionar con la API de TMDB.
class MoviedbDatasource extends MoviesDatasource {

  // Como necesitamos hacer peticiones http instalamos el paquete dio
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'language': 'es-ES'
    }
  ));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {

    // Cuando mandemos esta solicitud, tenemos que transformar la respuesta a mi entidad.
    // Creamos un modelo para leer la respuesta que viene de TMDB y un mapper para tomar esa data y crear nuesta entidad.
    // Añadimos el número de página como queryParameter.
    final response = await dio.get('/movie/now_playing',
      queryParameters: {
        'page': page
      }
    );
    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
    // Las películas sin poster se filtran
    .where((moviedb) => moviedb.posterPath != '')
    // El objetivo de este map es crearse la instancia de un Movie.
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();

    return movies;
  }
}
