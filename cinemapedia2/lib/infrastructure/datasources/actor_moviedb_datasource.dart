import 'package:cinemapedia2/config/constants/environment.dart';
import 'package:cinemapedia2/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia2/domain/entities/actor.dart';
import 'package:cinemapedia2/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia2/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasource extends ActorsDatasource {

  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'language': 'es-ES'
    }
  ));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async{
    
    final response = await dio.get(
      '/movie/$movieId/credits'
    );

    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast.map(
      (cast) => ActorMapper.castToEntity(cast)
    ).toList();
    
    return actors;
  }

}
