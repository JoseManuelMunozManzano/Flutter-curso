// Usamos el snippet impm para importar el paquete de Material
import 'package:flutter/material.dart';

// Usamos el snippet stlesw para crear un StatelessWidget.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter + Material 3'),
      ),
    );
  }
}
