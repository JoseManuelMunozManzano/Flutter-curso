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

  SearchMovieDelegate({
    required this.searchMovies
  });

  // Implementar esta función es opcional
  // Sirve para cambiar el texto Search por el deseado
  @override
  String get searchFieldLabel => 'Buscar película';

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
      // Se puede controlar si hay texto en la caja de texto con este if...
      // if (query.isNotEmpty)
        FadeIn(
          animate: query.isNotEmpty,  // ... o en esta propiedad de FadeIn
          // duration: const Duration(milliseconds: 200),
          child: IconButton(
            onPressed: () => query = '',
            icon: const Icon(Icons.clear)
          ),
        )
    ];
  }

  // Para construir un icono o lo que sea en la parte izquierda
  // Lo vamos a usar para salir de la búsqueda, pero se puede usar para lo que queramos.
  // El SearchDelegate nos permite llamar a close() para salir de la búsqueda.
  // Usamos el context para saber qué es lo que tenemos que hacer, y el result, que es el valor de retorno.
  // Regresamos null porque vamos a suponer que si la persona quiere salir es porque no quiso buscar nada.
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_ios_new_rounded)
    );
  }

  // Los resultados que van a aparecer cuando la persona pulse Intro
  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
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
  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchMovies(query),
      builder: (context, snapshot) {

        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(movie: movies[index])
        );
      }
    );
  }
}

class _MovieItem extends StatelessWidget {

  final Movie movie;

  const _MovieItem({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Padding(
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
                loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
              ),
            )
          ),

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
                  Icon(Icons.star_half_rounded, color: Colors.yellow.shade800),
                  const SizedBox(width: 5),
                  Text(
                    HumanFormats.number(movie.voteAverage, 1),
                    style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade900),
                  )
                ],
              )
              ],
            ),
          )
        ],
      ),
    ); 
  }
}
