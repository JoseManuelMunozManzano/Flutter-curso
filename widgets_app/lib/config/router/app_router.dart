// Código cogido de: https://pub.dev/documentation/go_router/latest/topics/Get%20started-topic.html
// y luego modificado.
// Las rutas se crean con la misma sintaxis que se usa en programación web.
import 'package:go_router/go_router.dart';
import 'package:widgets_app/presentation/screens/screens.dart';

// No puede ser privado porque se va a utilizar en otro fichero.
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: '/buttons',
      builder: (context, state) => const ButtonsScreen(),
    ),

    GoRoute(
      path: '/cards',
      builder: (context, state) => const CardsScreen(),
    ),
  ],
);
