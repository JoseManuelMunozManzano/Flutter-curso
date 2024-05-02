// Usamos snippet impm para importar material
import 'package:flutter/material.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:cinemapedia/presentation/views/views.dart';

// Usamos snippet stlesw para crear un StatelessWidget.
class HomeScreen extends StatelessWidget {

  // Nombre de la ruta para llegar aquí por medio del nombre.
  // En esta ocasión usamos guión medio.
  static const name = 'home-screen';

  // Indica que opción del tab (CustomBottomNavigation) y que view queremos mostrar.
  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex});

  final viewRoutes = const <Widget>[
    HomeView(),
    SizedBox(), // <-- Categorias View
    FavoritesView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
