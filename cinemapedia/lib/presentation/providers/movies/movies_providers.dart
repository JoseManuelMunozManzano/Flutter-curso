import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Consultaremos este provider para saber que películas están ahora en el cine.
// Los providers deben tratar de mantener la data lo más simple posible.
final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  // ¿De dónde vamos a obtener la función fetchMoreMovies que necesita nuestro MovierNotifier?
  // Esa función la tengo en MovieRepositoryImpl
  // Indicar que en la documentación de Riverpod sugieren usar watch() en vez de read() porque el día
  // de mañana podría cambiar esa implementación por otro provider.
  // Obtenemos el código de la función getNowPlaying, sin los paréntesis porque NO queremos ejecutarlo.
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

//* Películas populares
// Para las películas populares creamos otro StateNotifierProvider en vez de expandir el anterior.
// Como se ha dicho, los providers deben mantener la data lo más simple posible.
// Riverpod permite crear dos instancias de la misma clase.
final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
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
  // Bandera para evitar cargar peticiones simultaneas. Solo cargar la siguiente página.
  bool isLoading = false;
  // Defino el tipo de callback que espero, que tiene que cumplir la firma especificada en el typedef.
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  // El objetivo de este método es hacer alguna modificación al state.
  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;

    // Aquí es donde se podía haber hecho ref.getNowPlaying(), pero queda muy anclado.
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    // Siempre vamos a crear un nuevo estado para que el StateNotifier sepa que hubo un cambio y lo notifique.
    state = [...state, ...movies];

    // Si tarda mucho en cargar, podemos poner un delay. Se indica como se haría porque no haría falta
    // en este ejemplo concreto.
    // Incluso este delay se puede llevar a una función aparte.
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
