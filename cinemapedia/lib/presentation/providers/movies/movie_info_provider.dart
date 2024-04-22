import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

// En vez de llamar directamente a nuestra implementación del repositorio, vamos a crear, de nuevo,
// un Notifier, porque vamos a crear una clase que me sirva para mantener en caché las películas
// que hayamos consultado.

// Creación del provider
final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);

  return MovieMapNotifier(getMovie: movieRepository.getMovieById);
});

/* Este va a ser nuestro state, un map con el id de la película y el objeto Movie de esa película.
  {
    '505642': Movie(),
    '505643': Movie(),
    '505651': Movie(),
  }
*/

// Como esperamos una función que específicamente regrese algo, nos declaramos un typedef
typedef GetMovieCallback = Future<Movie>Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {

  final GetMovieCallback getMovie;

  MovieMapNotifier({
    required this.getMovie,
  }): super({});

  Future<void> loadMovie(String movieId) async {

    // Si ya tengo cargada la película en mi state no hago nada.
    if (state[movieId] != null) return;

    // Recordar que si la movie no existe va a lanzar una excepción que podríamos manejar aquí.
    final movie = await getMovie(movieId);

    // Generando un nuevo estado
    state = {...state, movieId: movie};
  }
}
