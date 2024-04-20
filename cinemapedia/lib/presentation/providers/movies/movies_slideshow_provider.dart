import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_providers.dart';

// Este provider es para mostrar de 0 a 6 películas.
// Solo necesito leer las películas, por lo que este provider es de solo lectura.

// En ref tenemos la referencia a todo el árbol que crea Riverpod, es decir, tenemos todos los providers.
final moviesSlideshowProvider = Provider<List<Movie>>((ref) {

  // Buscamos el provider que nos interesa. Este es el que cambia, pero nosotros lo leemos
  // y nuestro provider es de solo lectura.
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if (nowPlayingMovies.isEmpty) return [];

  return nowPlayingMovies.sublist(0, 6);
});
