// Usamos snippet impm para importar material
import 'package:cinemapedia/config/router/gorouter_extension.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

// Usamos snippet stlesw para crear un StatelessWidget.
class HomeScreen extends StatelessWidget {

  // Nombre de la ruta para llegar aquí por medio del nombre.
  // En esta ocasión usamos guión medio.
  static const name = 'home-screen';

  // La vista que tenemos que mostrar
  final StatefulNavigationShell currentChild;

  const HomeScreen({
    super.key,
    required this.currentChild
  });

  @override
  Widget build(BuildContext context) {
    
    // Este location() no existe realmente. Se ha añadido. Ver gorouter_extension.dart
    final location = GoRouter.of(context).location();

    return Scaffold(
      body: currentChild,
      // Para que desaparezca el BottomNavigation cuando estoy en /movie
      bottomNavigationBar: location.startsWith('/movie')
      ? null
      : CustomBottomNavigation(currentChild: currentChild)
    );
  }
}
