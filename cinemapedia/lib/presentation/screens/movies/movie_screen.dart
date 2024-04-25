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
      // Usamos CustomScrollView porque quiero trabajar con slivers
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(), // Evitamos el rebote de IOs
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) => _MovieDetails(movie: movie),
            childCount: 1
          ))
        ],
      )
    );
  }
}

class _MovieDetails extends StatelessWidget {

  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),

              const SizedBox(width: 10),

              // Descripción
              // Resto 40 porque he metido el SizedBox de 10 y además tenemos un padding.
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyles.titleLarge),
                    Text(movie.overview),
                  ],
                ),
              )
            ],
          ),
        ),

        // Géneros de la película
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(gender),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ))
            ],
          ),
        ),

        // TODO: Mostrar actores ListView

        // Nos aseguramos que la persona tiene el espacio suficiente para que la persona
        // pueda hacer scroll.
        const SizedBox(height: 100)
      ],
    );
  }
}

// AppBar personalizado que va a realizar la modificación personalizada de nuestro Sliver.
class _CustomSliverAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomSliverAppBar({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {

    // Las dimensiones del dispositivo físico.
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
          // centerTitle: false,
          titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          title: Text(
            movie.title,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.start,
          ),
          background: Stack(
            children: [
              SizedBox.expand(
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox.expand(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.7, 1.0],
                      colors: [
                        Colors.transparent,
                        Colors.black87
                      ]
                    )
                  )
                ),
              ),

              const SizedBox.expand(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      stops: [0.0, 0.3],
                      colors: [
                        Colors.black87,
                        Colors.transparent,
                      ]
                    )
                  )
                ),
              )
            ],
          ),
        ),
    );
  }
}
