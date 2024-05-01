// Usamos snippet impm para importar material
import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

// Usamos snippet stlesw para crear un StatelessWidget.
class HomeScreen extends StatelessWidget {

  // Nombre de la ruta para llegar aquí por medio del nombre.
  // En esta ocasión usamos guión medio.
  static const name = 'home-screen';

  // La vista que tenemos que mostrar
  final Widget childView;

  const HomeScreen({
    super.key,
    required this.childView
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childView,
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
