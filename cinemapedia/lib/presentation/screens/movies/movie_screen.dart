import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Cambiamos el StatefulWidget y, más abajo, _MovieScreenState y State<MovieScreen>
// por la representación de Riverpod que nos permita tomar la referencia de nuestro provider.
class MovieScreen extends ConsumerStatefulWidget {

  static const name = 'movie-screen';

  // Lo hacemos de esta manera en vez de estar esperando que me manden un objeto de tipo Movie
  // porque vamos a querer hacer un deep linking, es decir, que tocaremos una película y entraremos
  // a la página, donde habrá un botón que diga 'Share' para compartirlo con una persona.
  // Cuando esa persona toque ese enlace lo llevará a la app, específicamente a la página de
  // esa película. Esto se hace enviando el id. En ese momento no tengo algo de tipo Movie, solo el id
  // que aparece en la url (si se hace desde Web)
  final String movieId;

  const MovieScreen({
    super.key,
    required this.movieId
  });

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {

  // Para saber cuando estoy cargando y cuando acabé de cargar.
  // Vamos a manejar una caché local para mostrar un loading y ser más eficientes a la hora de
  // no volver a hacer una petición para cargar películas que ya hemos cargado antes.
  @override
  void initState() {
    super.initState();
    // Recordar que nuestros widgets no llaman a las implementaciones (repositorio)
    // Nuestro widgets llaman providers y estos últimos son los que llaman a las implementaciones.
    //
    // Y como estamos dentro de un ConsumerState, tenemos acceso a ref.
    // Si fuera un StatelessWidget tendríamos acceso a ref solo en el método build()
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {

    // Aquí sabemos cuando la película existe y cuando no. Cuando no existe puedo mostrar un loading.
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    // Si movie es null sabemos que estamos haciendo la petición http.
    if (movie == null) {
      // Envolvemos en un Scaffold porque si no la pantalla se ve negra durante un segundito.
      return const Scaffold(body: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }

    // A partir de aquí siempre tenemos una película.
    return Scaffold(
      appBar: AppBar(
        title: Text('MovieID: ${widget.movieId}'),
      ),
    );
  }
}
