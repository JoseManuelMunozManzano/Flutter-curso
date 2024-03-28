// Usamos el snippet stles para crear un StatelessWidget
import 'package:flutter/material.dart';

// Pantalla bastante sencilla. Toda la lógica va a estar colocada en otro lugar.
class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('DiscoverScreen'),
      )
    );
  }
}
