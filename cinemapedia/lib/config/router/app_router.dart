import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      // Para poder regresar a la ruta principal cuando se hace deep linking, hay que definir
      // las rutas hijas de esta ruta.
      routes: [
        GoRoute(
          path: 'movie/:id', // El primer / ya no es necesario porque lo da el padre. (no es /movie)
          name: MovieScreen.name,
          builder: (context, state) {
            // Los query parameters siempre son Strings.
            // Siempre deberia venir un id, pero se indica qué pasa si no viene, por si acaso.
            final movieId = state.pathParameters['id'] ?? 'no-id';
            
            return MovieScreen(movieId: movieId);
          },
        ),
      ]
    ),

  ]
);
