// Usamos snippet impm para importar material
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:flutter/material.dart';

// Usamos snippet stlesw para crear un StatelessWidget
class HomeScreen extends StatelessWidget {

  // Nombre de la ruta para llegar aquí por medio del nombre.
  // En esta ocasión usamos guión medio.
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Environment.theMovieDbKey),
      )
    );
  }
}
