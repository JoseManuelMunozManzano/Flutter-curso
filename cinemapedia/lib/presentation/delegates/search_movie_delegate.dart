import 'dart:async';

import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

// Nos definimos el tipo de función específica.
// Cualquier implementación que cumpla esta firma nos vale para buscar películas.
typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

// Vamos a devolver la Movie completa, pero también podríamos devolver solo el id.
class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  List<Movie>
      initialMovies; // Se quita el final para que nos funcione buildResults

  // La idea es que solo cuando mi stream personalizado emita valores, rendericemos el contenido en buildSuggestions.
  // Y el stream emitirá valores solo cuando la persona deja de escribir.
  // Se indica .broadcast() porque puede haber muchos lugares donde se esté escuchando el stream.
  // Sin indicarlo, solo puede tener un listener. Por defecto y solo por si acaso, es mejor indicar broadcast siempre.
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  // Timer es como el setTimeout de JavaScript. Se puede limpiar y cancelar.
  Timer? _debounceTimer; // Opcional porque no lo definimos hasta que no lo estemos utilizando.

  StreamController<bool> isLoadingStream = StreamController.broadcast();

  SearchMovieDelegate({required this.initialMovies, required this.searchMovies})
      : super(
          searchFieldLabel: 'Buscar películas',
          //textInputAction: TextInputAction.done // En el teclado del móvil aparecerá done en vez de search
        );

  // Para limpiar los streams y el timer cuando se cierra el delegate
  void clearStreams() {
    debouncedMovies.close();
    _debounceTimer?.cancel();
    isLoadingStream.close();
  }

  // Función que emite el resultado de las películas
  void _onQueryChanged(String query) {

    isLoadingStream.add(true);

    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // if (query.isEmpty) {
      //   debouncedMovies.add([]);
      //   return;
      // }

      final movies = await searchMovies(query);

      // Para que nos funcione el buildResults
      // Ahora initialMovies siempre va a tener data.
      initialMovies = movies;

      debouncedMovies.add(movies);
      isLoadingStream.add(false);
    });
  }

  // Aplicando DRY
  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
        initialData: initialMovies,
        stream: debouncedMovies.stream,
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];

          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) => _MovieItem(
                  movie: movies[index],
                  onMovieSelected: (context, movie) {
                    clearStreams();
                    close(context, movie);
                  }));
        });
  }

  // Implementar esta función es opcional
  // Sirve para cambiar el texto Search por el deseado
  // También se puede hacer en el constructor
  //
  // @override
  // String get searchFieldLabel => 'Buscar película';

  // Implementar estas 4 funciones es obligatorio.

  // Para construir las acciones (iconos) en la parte derecha
  // Lo vamos a usar para limpiar el texto de búsqueda que ponga el usuario.
  // Además, mientras esté escribiendo, va a ser algo que indique que se están cargando películas.
  // El valor de lo que tiene la caja de texto se obtiene mediante la propiedad query que nos ofrece SearchDelegate.
  // Cada vez que el query cambia se disparan todas las acciones, y es gracias a esto que podemos hacer
  // más cosas mientras vamos escribiendo.
  @override
  List<Widget>? buildActions(BuildContext context) {
    // print('query: $query');

    return [

        StreamBuilder(
          initialData: false,
          stream: isLoadingStream.stream,
          builder: (context, snapshot) {
            if (snapshot.data ?? false) {
              return SpinPerfect(
                duration: const Duration(seconds: 2),
                spins: 10,
                infinite: true,
                child: IconButton(
                  onPressed: () => query = '',
                  icon: const Icon(Icons.refresh_rounded)
                ),
              );
            }

            // Se puede controlar si hay texto en la caja de texto con este if...
            // if (query.isNotEmpty)
            return FadeIn(
              animate: query.isNotEmpty, // ... o en esta propiedad de FadeIn
              // duration: const Duration(milliseconds: 200),
              child: IconButton(
                  onPressed: () => query = '', icon: const Icon(Icons.clear)),
            );
          },
        )
    ];
  }

  // Para construir un icono o lo que sea en la parte izquierda
  // Lo vamos a usar para salir de la búsqueda, pero se puede usar para lo que queramos.
  // El SearchDelegate nos permite llamar a close() para salir de la búsqueda.
  // Usamos el context para saber qué es lo que tenemos que hacer, y el result, que es el valor de retorno.
  // Regresamos null porque vamos a suponer que si la persona quiere salir es porque no quiso buscar nada.
  //
  // Usando close() se limpian los recursos que tengamos abiertos correctamente y además se cierra el delegate de búsqueda.
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  // Los resultados que van a aparecer cuando la persona pulse Intro
  //
  // Como lo hacemos con un stream tenemos un problema, y es que si escribo Batman y espero un par de
  // segundos y pulso Intro, no sale nada. Esto es porque el stream ya se ha leido y se ha limpiado.
  // Si escribo Batman y rápidamente pulso Intro ahí si funciona.
  //
  // Una forma muy sencilla de resolver este problema es volver a ejecutar el _onQueryChanged(),
  // pero esto ejecuta la petición dos veces, una por el buildSuggestion y otra al pulsar Intro.
  //
  // Lo que se ha hecho es que initialMovies ya no sea final y siempre va a tener data, que es
  // la que mostramos en vez de esperar a la emisión del stream.
  // Si se pulsa Intro muy rápido, tendremos la initialData y luego la respuesta del stream.
  //
  // Como al final ha quedado igual que buildSuggestions se ha hecho un método fuera al que llamamos.
  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  // Mientras la persona va escribiendo, qué queremos hacer
  // No queremos estar disparando peticiones HTTP cada vez que una persona toca una tecla.
  // Esto lo vamos a controlar después con un Debounce, pero por ahora vamos a hacer la forma más básica.
  //
  // Técnicamente, siempre que estemos dentro de un build podríamos usar un gestor de estados para construir y disparar
  // la construcción de este Widget de manera automática cuando cambie un estado, pero esto se va a estar disparando
  // por cada tecla.
  //
  // Forma básica.
  // Así que realmente, lo único que necesito es ejecutar una función (arriba) que va a hacer la búsqueda de películas
  // usando nuestro movieRepositoryProvider que devuelve nuestro MovieRepositoryImpl.
  //
  // Ahora si, sustituimos nuestro FutureBuilder por un StreamBuilder para hacer el debounce.
  // Y se añade la función _onQueryChanged()
  //
  // Como al final ha quedado igual que buildResults se ha hecho un método fuera al que llamamos.
  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return buildResultsAndSuggestions();

    // return FutureBuilder(
    //   future: searchMovies(query),
    //   builder: (context, snapshot) {

    //     //! print('Realizando petición');

    //     final movies = snapshot.data ?? [];

    //     return ListView.builder(
    //       itemCount: movies.length,
    //       itemBuilder: (context, index) => _MovieItem(
    //         movie: movies[index],
    //         onMovieSelected: close, // Mandamos la ref. a la función close para poder usarla en nuestro Widget
    //       )
    //     );
    //   }
    // );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({
    required this.movie,
    required this.onMovieSelected,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            // Image
            SizedBox(
                width: size.width * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    movie.posterPath,
                    loadingBuilder: (context, child, loadingProgress) =>
                        FadeIn(child: child),
                  ),
                )),

            const SizedBox(width: 10),

            // Description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium),
                  movie.overview.length > 100
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded,
                          color: Colors.yellow.shade800),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textStyles.bodyMedium!
                            .copyWith(color: Colors.yellow.shade900),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
