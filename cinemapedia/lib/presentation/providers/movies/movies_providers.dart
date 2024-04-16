import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Consultaremos este provider para saber que películas están ahora en el cine.
final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  
  // ¿De dónde vamos a obtener la función fetchMoreMovies que necesita nuestro MovierNotifier?
  // Esa función la tengo en MovieRepositoryImpl
  // Indicar que en la documentación de Riverpod sugieren usar watch() en vez de read() porque el día
  // de mañana podría cambiar esa implementación por otro provider.
  // Obtenemos el código de la función getNowPlaying, sin los paréntesis porque NO queremos ejecutarlo.
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

// Para especificar el tipo de función que espero.
// Esto sirve para definir el caso de uso. MoviesNotifier recibe esta función para cargar más películas.
// NOTA: Se podría haber pasado a MoviesNotifier() el ref desde StateNotifierProvider, y usar getNowPlaying(),
// pero entonces queda anclado a esa funcionalidad.
// Haciéndolo de este modo, se hace más genérico.
typedef MovieCallback = Future<List<Movie>> Function({int page});

// Es un Notifier que va a poder controlar el StateNotifierProvider de arriba.
// Su objetivo es que proporcione un listado de Movies. Ese será el state, el listado de Movies.
// Es decir, el StateNotifier sirve para manejar un state, en este caso, el listado de Movies.
// Se hace lo más genérico posible para que sirva para todos los providers (de ahí el atributo fetchMoreMovies).
// Y debe hacerse lo más sencillo posible para que sea fácil de leer y mantener.
class MoviesNotifier extends StateNotifier<List<Movie>> {

  int currentPage = 0;
  // Defino el tipo de callback que espero, que tiene que cumplir la firma especificada en el typedef.
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }): super([]);

  // El objetivo de este método es hacer alguna modificación al state.
  Future<void> loadNextPage() async {
    currentPage++;

    // Aquí es donde se podía haber hecho ref.getNowPlaying(), pero queda muy anclado.
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    // Siempre vamos a crear un nuevo estado para que el StateNotifier sepa que hubo un cambio y lo notifique.
    state = [...state, ...movies];
  }
}
