// Instalamos, usando Pubspec Assist, el paquete: flutter_riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repository/movie_repository_impl.dart';

// Una vez creado este provider, no se va a cambiar nunca, va a ser un provider de solo lectura.
// Es quien crea la instancia de movie_repository_impl.dart de manera global para que en cualquier otro provider
// tengamos acceso a esa información.

final movieRepositoryProvider = Provider((ref) {

  // Este datasource es el origen de dato necesario para que funcione este movieRepositoryProvider.
  // Enviamos la implementación específica.
  // Si algún día cambiamos de TMDB a, por ejemplo IMDB, cambiamos este datasource y listo.
  return MovieRepositoryImpl(MoviedbDatasource());
});
