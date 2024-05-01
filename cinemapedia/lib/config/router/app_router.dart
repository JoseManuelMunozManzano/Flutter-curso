import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => HomeScreen(currentChild: navigationShell),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomeView(),
              routes: [
                GoRoute(
                  path: 'movie/:id',
                  name: MovieScreen.name,
                  builder: (context, state) {
                    final movieId = state.pathParameters['id'] ?? 'no-id';
                    return MovieScreen(movieId: movieId);
                  },
                )
              ]
            )
          ]
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/categories',
              builder: (context, state) => const FavoritesView(),
            )
          ]
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) => const FavoritesView(),
            )
          ]
        )
      ]
    )


    // USO DEL SHELLROUTE
    //
    // ShellRoute(
    //   // De nuevo, un builder es algo que se va a llamar en tiempo de ejecución para construir algo.
    //   // Nuestra ruta principal es el HomeView, pero va cambiando el Widget hijo.
    //   builder: (context, state, child) {
    //     return HomeScreen(childView: child);
    //   },
    //   // Configuraciones normales de rutas de GoRoute
    //   routes: [
    //     GoRoute(
    //       path: '/',
    //       builder: (context, state) {
    //         return const HomeView();
    //       },
    //       routes: [
    //         GoRoute(
    //           path: 'movie/:id', // El primer / ya no es necesario porque lo da el padre. (no es /movie)
    //           name: MovieScreen.name,
    //           builder: (context, state) {
    //             // Los query parameters siempre son Strings.
    //             // Siempre deberia venir un id, pero se indica qué pasa si no viene, por si acaso.
    //             final movieId = state.pathParameters['id'] ?? 'no-id';

    //             // No va a ser el navegador el que determine si estoy cargando la película, si la tengo
    //             // en memoria...
    //             // El route SOLO SE ENCARGA de la navegación.
    //             // Por tanto, para esa gestión creamos de nuevo un datasource y un repositorio.

    //             return MovieScreen(movieId: movieId);
    //           },
    //         ),
    //       ]
    //     ),

    //     GoRoute(
    //       path: '/favorites',
    //       builder: (context, state) {
    //         return const FavoritesView();
    //       },
    //     )
    //   ]
    // )

    // RUTAS PADRE/HIJO
    // Podría existir también, pero si vamos a una de estas rutas nos salimos del ShellRoute. Todo depende
    // de qué necesitamos.
    //
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name,
    //   builder: (context, state) => const HomeScreen(childView: HomeView()),
    //   // Para poder regresar a la ruta principal cuando se hace deep linking, hay que definir
    //   // las rutas hijas de esta ruta.
    //   routes: [
    //     GoRoute(
    //       path: 'movie/:id', // El primer / ya no es necesario porque lo da el padre. (no es /movie)
    //       name: MovieScreen.name,
    //       builder: (context, state) {
    //         // Los query parameters siempre son Strings.
    //         // Siempre deberia venir un id, pero se indica qué pasa si no viene, por si acaso.
    //         final movieId = state.pathParameters['id'] ?? 'no-id';
            
    //         // No va a ser el navegador el que determine si estoy cargando la película, si la tengo
    //         // en memoria...
    //         // El route SOLO SE ENCARGA de la navegación.
    //         // Por tanto, para esa gestión creamos de nuevo un datasource y un repositorio.

    //         return MovieScreen(movieId: movieId);
    //       },
    //     ),
    //   ]
    // ),

  ]
);
