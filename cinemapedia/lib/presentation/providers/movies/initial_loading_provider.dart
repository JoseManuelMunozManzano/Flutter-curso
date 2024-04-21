import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_providers.dart';

// Este provider cambia (true o false) basado en otros providers. Es de solo lectura.
final initialLoadingProvider = Provider<bool>((ref) {

  final movieProviders = [
    ref.watch(nowPlayingMoviesProvider),
    ref.watch(popularMoviesProvider),
    ref.watch(topRatedMoviesProvider),
    ref.watch(upcomingMoviesProvider)
  ];

  // Terminamos de cargar.
  // To-dos deben tener
  return movieProviders.any((movies) => movies.isEmpty);
});
