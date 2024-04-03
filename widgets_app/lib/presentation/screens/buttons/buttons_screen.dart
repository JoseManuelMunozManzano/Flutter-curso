// Importamos paquete de material usando el snippet impm
import 'package:flutter/material.dart';

// Creamos un StatelessWidget usando el snippet stlesw
class ButtonsScreen extends StatelessWidget {
  
  static const name = 'buttons_screen';

  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buttons Screen'),
      ),
      body: const Placeholder(),
    );
  }
}
