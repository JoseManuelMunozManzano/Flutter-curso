import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
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
    final response = await dio.get('/movie/now_playing');
    final List<Movie> movies = [];

    return movies;
  }
}
