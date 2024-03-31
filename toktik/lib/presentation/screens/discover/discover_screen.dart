// Usamos el snippet stles para crear un StatelessWidget
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/presentation/providers/discover_provider.dart';
import 'package:toktik/presentation/widgets/shared/video_scrollable_view.dart';

// Pantalla bastante sencilla. Toda la lógica va a estar colocada en otro lugar.
class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // Escucha renderizanzdo el Widget si hay cambios.
    final discoverProvider = context.watch<DiscoverProvider>();

    // Otra forma más antigua de hacer lo mismo de arriba es:
    // final otroProvider = Provider.of<DiscoverProvider>(context);
    //
    // Y si solo quisiéramos escuchar
    // final otroProvider = Provider.of<DiscoverProvider>(context, listen: false);

    return Scaffold(
      body: discoverProvider.initialLoading 
        ? const Center(child: CircularProgressIndicator(strokeWidth:  2,))
        : VideoScrollableView(videos: discoverProvider.videos)
    );
  }
}
