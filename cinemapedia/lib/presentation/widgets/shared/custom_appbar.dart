import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                  final movieRepository = ref.read(movieRepositoryProvider);

                  showSearch(
                    context: context,
                    // El delegate es el encargado de trabajar la búsqueda.
                    // Mandamos la referencia de la función de búsqueda que usaremos en el delegate.
                    delegate: SearchMovieDelegate(
                      searchMovies: movieRepository.searchMovies
                    )
                  );
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
