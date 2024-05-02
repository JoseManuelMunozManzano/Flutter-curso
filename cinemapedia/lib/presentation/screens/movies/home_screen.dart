// Usamos snippet impm para importar material
import 'package:flutter/material.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:cinemapedia/presentation/views/views.dart';

// Usamos snippet stlesw para crear un StatelessWidget.
class HomeScreen extends StatelessWidget {

  // Nombre de la ruta para llegar aquí por medio del nombre.
  // En esta ocasión usamos guión medio.
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}
