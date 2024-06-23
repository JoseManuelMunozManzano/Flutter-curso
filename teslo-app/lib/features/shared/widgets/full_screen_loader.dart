import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: Center(
        // Lo de adaptive significa que se adapta al sistema operativo.
        // Pero como no me gusta como queda en iOS lo modifico a mi gusto.
        //
        // child: CircularProgressIndicator.adaptive(),
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}
