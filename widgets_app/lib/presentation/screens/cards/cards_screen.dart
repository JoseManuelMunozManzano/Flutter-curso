// Importamos paquete de material usando el snippet impm
import 'package:flutter/material.dart';

// Creamos un StatelessWidget usando el snippet stlesw
class CardsScreen extends StatelessWidget {
  
  static const name = 'cards_screen';

  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards Screen'),
      ),
      body: const Placeholder(),
    );
  }
}
