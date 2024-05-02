import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0', // El 0 se refiere a Inicio, 1 es Categorias y 2 es Favoritos
  routes: [
    GoRoute(
      path: '/home/:page', // En esta ruta recibimos que screen o view queremos ver
      name: HomeScreen.name,
      builder: (context, state) {
        int pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        
        // Para web, donde el usuario puede indicar la page, tenemos que validar que
        // se indica una page que exista (tenemos ahora mismo de 0 a 2)
        if (pageIndex > 2 || pageIndex < 0) pageIndex = 0;

        return HomeScreen(pageIndex: pageIndex);
      },
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
            
            // No va a ser el navegador el que determine si estoy cargando la película, si la tengo
            // en memoria...
            // El route SOLO SE ENCARGA de la navegación.
            // Por tanto, para esa gestión creamos de nuevo un datasource y un repositorio.

            return MovieScreen(movieId: movieId);
          },
        ),
      ]
    ),


    GoRoute(
      path: '/',
      redirect: (_ , __) => '/home/0',
    )

  ]
);
