import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/presentation/providers/providers.dart';

class ProductScreen extends ConsumerWidget {

  final String productId;

  const ProductScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // Riverpod va a mantener en memoria este productProvider cuyo id sea el mismo.
    // Es decir, puedo usar esta misma sintaxis en otros sitios y va a usar la misma
    // referencia a este objeto siempre y cuando sea el mismo id.
    final productState = ref.watch(productProvider(productId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Producto'),
        actions: [
          IconButton(onPressed: () {
            
            },
            icon: const Icon(Icons.camera_alt_outlined)
          )
        ],
      ),

      body: Center(
        child: Text(productState.product?.title ?? 'cargando'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.save_as_outlined),
      ),
    );
  }
}


// No debe ser un StatefulWidget.
// Como solo usamos el provider en el initState() y luego ya no es necesario, automáticamente
// lo destruye (el autoDispose) y luego ya no existe ningún notifier. Ese es el error.


// class ProductScreen extends ConsumerStatefulWidget {

//   final String productId;

//   const ProductScreen({super.key, required this.productId});

//   @override
//   ProductScreenState createState() => ProductScreenState();
// }

// class ProductScreenState extends ConsumerState<ProductScreen> {

//   @override
//   void initState() {
//     super.initState();

//     // Hay que llamarlo con el id del producto porque el provider tiene el modificador
//     // .family, y luego añadir el .notifier
//     ref.read(productProvider(widget.productId).notifier);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Editar Producto'),
//       ),

//       body: Center(
//         child: Text(widget.productId),
//       )
//     );
//   }
// }
