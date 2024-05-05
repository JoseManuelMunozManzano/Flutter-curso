import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia/domain/entities/movie.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';

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

  const MovieScreen({super.key, required this.movieId});

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

    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    // Aquí sabemos cuando la película existe y cuando no. Cuando no existe puedo mostrar un loading.
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    // Si movie es null sabemos que estamos haciendo la petición http.
    if (movie == null) {
      // Envolvemos en un Scaffold porque si no la pantalla se ve negra durante un segundito.
      return const Scaffold(
          body: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }

    // A partir de aquí siempre tenemos una película.
    return Scaffold(
        // Usamos CustomScrollView porque quiero trabajar con slivers
        body: CustomScrollView(
      physics: const ClampingScrollPhysics(), // Evitamos el rebote de IOs
      slivers: [
        _CustomSliverAppBar(movie: movie),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _MovieDetails(movie: movie),
                childCount: 1))
      ],
    ));
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ))
            ],
          ),
        ),

        _ActorByMovie(movieId: movie.id.toString()),

        // Nos aseguramos que la persona tiene el espacio suficiente para que la persona
        // pueda hacer scroll.
        const SizedBox(height: 50)
      ],
    );
  }
}

class _ActorByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    // Tenemos que estar pendientes de cuando tenemos los actores.
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(strokeWidth: 2);
    }

    final actors = actorsByMovie[movieId]!; // Aquí siempre tenemos los actores

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];

          return Container(
              padding: const EdgeInsets.all(8.0),
              width: 135,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Actor Photo
                  FadeInRight(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(actor.profilePath,
                            height: 180, width: 135, fit: BoxFit.cover)),
                  ),

                  const SizedBox(height: 5),

                  // Nombre
                  Text(actor.name, maxLines: 2),
                  Text(actor.character ?? '',
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis)),
                ],
              ));
        },
      ),
    );
  }
}

// Pequeño provider que implementa el modifier .family, recibiendo un entero para saber si
// la película está en la BD y así marcar/desmarcar el corazón de rojo (devuelve un booleano)
// NOTA: Usando el ref.invalidate (más abajo) ya me funcionaba sin necesidad de hacer el .autoDispose
final isFavoriteProvider = FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);  
  return localStorageRepository.isMovieFavorite(movieId);
});

// AppBar personalizado que va a realizar la modificación personalizada de nuestro Sliver.
// Hemos cambiado de StatelessWidget a ConsumerWidget para poder hacer uso de ref
class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    // Las dimensiones del dispositivo físico.
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async {
            // ref.read(localStorageRepositoryProvider).toggleFavorite(movie);
            await ref.read(favoriteMoviesProvider.notifier).toggleFavorite(movie);

            // Esperamos a que resuelva antes de invalidar el estado.
            // Cuando apreto seguidamente el botón de favoritos este se traba y su estado final
            // queda inverso a como deberia quedar, quiero decir, en mi isar inspector me aparece
            // una pelicula marcada en true mientras que en el celular no.
            // Eso soluciona este problema.
            // Lo que hace es invalidar y volver el provider a su estado original (un future que no se ha resuelto)
            // Por ejemplo, si fuera un contador y su valor inicial fuera el 0, regresa a 0.
            ref.invalidate(isFavoriteProvider(movie.id));

          },
          icon: isFavoriteFuture.when(
            loading: () => const CircularProgressIndicator(strokeWidth: 3,),
            data: (isFavorite) {
              return isFavorite
              ? const Icon(Icons.favorite_rounded, color: Colors.red)
              : const Icon(Icons.favorite_border);
            },
            error: (_, __) => throw UnimplementedError(),
          ),
            
          
          // const Icon(Icons.favorite_border),
          // icon: const Icon(Icons.favorite_rounded, color: Colors.red)
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        // centerTitle: false,
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        // Quitamos esta visualización del título porque no me acaba de gustar como queda.
        // title: Text(
        //   movie.title,
        //   style: const TextStyle(fontSize: 20),
        //   textAlign: TextAlign.start,
        // ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                // Por temas estéticos, ya que al cargar la imagen aparece como un punto blanco y luego
                // aparece muy bruscamente.
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const SizedBox(); // Para que no se vea nada (negro)
                  }
                  return FadeIn(
                      child:
                          child); // Regresamos la imagen más suavemente, del negro al color.
                },
              ),
            ),

            const _CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 0.2],
              colors: [Colors.black54, Colors.transparent],
            ),

            const _CustomGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.8, 1.0],
              colors: [Colors.transparent, Colors.black54],
            ),

            const _CustomGradient(
              begin: Alignment.topLeft,
              stops: [0.0, 0.3],
              colors: [Colors.black87, Colors.transparent]
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {

  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient({
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    required this.stops,
    required this.colors
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors
          )
        )
      )
    );
  }
}
