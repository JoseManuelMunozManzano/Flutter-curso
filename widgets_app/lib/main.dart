import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/router/app_router.dart';
import 'package:widgets_app/config/theme/app_theme.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

void main() {
  runApp(
    // Usando ProviderScope, Riverpod va a saber donde buscar cada una de nuestros providers
    // que vayamos creando.
    const ProviderScope(child: MainApp())
  );
}

// Cambiado a ConsumerWidget
class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final int selectedColor = ref.watch(selectedColorProvider);
    final bool isDarkMode = ref.watch(isDarkModeProvider);

    // Se indica el router e indicamos su configuración
    return MaterialApp.router(
      // Este título de la aplicación aparece en el dialog de las licencias usadas.
      title: 'Flutter Widgets',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: selectedColor, isDarkMode: isDarkMode).getTheme(),

      // Ya no hace falta porque viene de appRouter
      // home: const HomeScreen(),

      // No se usa esto. 
      // Para la navegación, se pueden definir rutas, pero no se recomienda por una serie de limitantes.
      // Al tener estos nombres de rutas la navegación se hace más fácil.
      // routes: {
      //   '/buttons': (context) => const ButtonsScreen(),
      //   '/cards': (context) => const CardsScreen(),
      // },
    );
  }
}
