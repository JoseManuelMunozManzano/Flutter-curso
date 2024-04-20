import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {

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
                onPressed: () {}, 
                icon: const Icon(Icons.search)
              )
            ],
          ),
        )
      )
    );
  }
}
