import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/domain/entities/movie.dart';

import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

// Transformado a ConsumerWidget porque me hace falta para hacer el Search
class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      // Este atributo se ha puesto para que el SafeArea no ocupe tanto espacio por abajo.
      // Se ha salido que ocupaba ese espacio usando las DevTools (la lupa del debug de VSCode)
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5),
              Text('Cinemapedia', style: titleStyle),
      
              // Sería parecido al diseño Flex, para que tome todo el espacio disponible.
              const Spacer(),
      
              IconButton(
                onPressed: () {
                  final searchedMovies = ref.read(searchedMoviesProvider);
                  final searchQuery = ref.read(searchQueryProvider);

                  showSearch<Movie?>(
                    query: searchQuery,
                    context: context,
                    // El delegate es el encargado de trabajar la búsqueda.
                    // Mandamos la referencia de la función de búsqueda que usaremos en el delegate.
                    delegate: SearchMovieDelegate(
                      initialMovies: searchedMovies,
                      searchMovies: ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery
                    )
                  ).then((movie) {
                    if (movie == null) return;

                    context.push('/home/0/movie/${movie.id}');
                  });

                }, 
                icon: const Icon(Icons.search)
              )
            ],
          ),
        )
      )
    );
  }
}
