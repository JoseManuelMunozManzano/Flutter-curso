import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// En vez de llamar directamente a nuestra implementación del repositorio, vamos a crear, de nuevo,
// un Notifier, porque vamos a crear una clase que me sirva para mantener en caché los actores de
// la película.

// Creación del provider
final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);

  return ActorsByMovieNotifier(getActors: actorsRepository.getActorsByMovie);
});

/* Este va a ser nuestro state, un map con el id de la película y el listado de actores de esa película.
  {
    '505642': <Actor>[],
    '505643': <Actor>[],
    '505651': <Actor>[],
  }
*/

// Como esperamos una función que específicamente regrese algo, nos declaramos un typedef
typedef GeActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GeActorsCallback getActors;

  ActorsByMovieNotifier({
    required this.getActors,
  }) : super({});

  Future<void> loadActors(String movieId) async {
    // Si ya tengo cargada la película en mi state no hago nada (caché).
    if (state[movieId] != null) return;

    // Recordar que si la movie no existe va a lanzar una excepción que podríamos manejar aquí.
    final List<Actor> actors = await getActors(movieId);

    // Generando un nuevo estado
    state = {...state, movieId: actors};
  }
}
