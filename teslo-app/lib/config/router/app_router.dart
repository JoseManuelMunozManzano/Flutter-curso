import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/config/router/app_router_notifier.dart';
import 'package:teslo_shop/features/auth/auth.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/products.dart';

// Vamos a envolver la instacia de GoRouter con un Provider, para poder acceder a otros providers.
final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',

    // refreshListenable lo que hace es que, cuando cambia, vuelve a evaluar el redirect.
    //
    // Lo que vamos a hacer es que vamos a hacer algo (ChangeNotifier) que esté pendiente
    // de la autenticación y cuando esta cambie, refreshListenable se va a dar cuenta y va
    // a volver a lanzar el redirect.
    refreshListenable: goRouterNotifier,

    routes: [
      //* Primera pantalla
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      ///* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      ///* Product Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductsScreen(),
      ),

      GoRoute(
        // Alta será: /product/new
        path: '/product/:id',
        builder: (context, state) => ProductScreen(
          productId: state.params['id'] ?? 'no-id',
        ),
      ),
    ],

    // redirect es como si se sobreescribiera la ruta
    // Aquí es donde vamos a ver si está autenticado o no.
    redirect: (context, state) {

      final isGoingTo = state.subloc;
      final authStatus = goRouterNotifier.authStatus;

      // print('GoRouter authStatus: $authStatus, isGoingTo: $isGoingTo');

      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) return null;

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') return null;

        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/splash') {
          return '/';
        }
      }

      // Aquí se puede añadir también if por si el user isAdmin...
      // Pero lo dejamos

      return null;
    }
  );
});
