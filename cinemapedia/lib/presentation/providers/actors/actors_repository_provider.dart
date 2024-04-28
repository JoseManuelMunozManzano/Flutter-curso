import 'package:cinemapedia/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repository/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Una vez creado este provider, no se va a cambiar nunca, va a ser un provider de solo lectura.
// Es quien crea la instancia de actor_repository_impl.dart de manera global para que en cualquier otro provider
// tengamos acceso a esa información.

final actorsRepositoryProvider = Provider((ref) {
  // Este datasource es el origen de dato necesario para que funcione este actorRepositoryProvider.
  // Enviamos la implementación específica.
  // Si algún día cambiamos de TMDB a, por ejemplo IMDB, cambiamos este datasource y listo.
  return ActorRepositoryImpl(ActorMovieDbDatasource());
});
