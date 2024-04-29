import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

// Vamos a devolver la Movie completa, pero también podríamos devolver solo el id.
class SearchMovieDelegate extends SearchDelegate<Movie?> {

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
  @override
  Widget buildSuggestions(BuildContext context) {
    return const Text('buildSuggestions');
  }
  
}
