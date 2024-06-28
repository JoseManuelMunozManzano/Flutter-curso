import 'package:cinemapedia/config/scroll/custom_scroll_behavior.dart';
import 'package:flutter/material.dart';

import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future main() async {

  // Para mantener el SplashScreen mientras queramos.
  // Hacemos el remove() en home_views.dart.
  // Con esto el spinnner queda oculto por el Splash Screen.
  // Podríamos implementar el patrón adaptador para no tener aquí esta dependencia.
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  await dotenv.load(fileName: '.env');

  // ProviderScope contiene la referencias a todos nuestros providers de Riverpod.
  runApp(
    const ProviderScope(child: MainApp())
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scrollBehavior: CustomScrollBehavior(),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      // Aquí no mostramos nada porque la configuración del router ya sabe cual es nuestra pantalla inicial (HomeScreen)
    );
  }
}
