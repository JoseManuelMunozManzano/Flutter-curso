import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

import 'package:teslo_shop/features/products/presentation/providers/providers.dart';
import 'package:teslo_shop/features/products/presentation/widgets/widgets.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu( scaffoldKey: scaffoldKey ),
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon( Icons.search_rounded)
          )
        ],
      ),
      body: const _ProductsView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nuevo producto'),
        icon: const Icon( Icons.add ),
        onPressed: () {},
      ),
    );
  }
}


// Vamos a usar un StatefulWidget porque necesitamos un infiniteScroll y, solo para eso,
// no voy a delegar el controlador a un gestor de estado.
class _ProductsView extends ConsumerStatefulWidget {
  const _ProductsView();

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends ConsumerState<_ProductsView> {

  final ScrollController scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();

    // InfiniteScroll
    scrollController.addListener(() {
      if ((scrollController.position.pixels + 400) >= scrollController.position.maxScrollExtent) {
        // Cargamos la siguiente página.
        ref.read(productsProvider.notifier).loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    // Borramos el controlador si ya no lo usamos
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final productsState = ref.watch(productsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        // Conectamos con nuestro controller para conseguir el InfiniteScroll
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 35,
        itemCount: productsState.products.length,
        itemBuilder: (context, index) {
          final product = productsState.products[index];
          // Cuando se toque la tarjeta entramos en modo edición
          return GestureDetector(
            onTap: () => context.push('/product/${product.id}'),
            child: ProductCard(product: product)
          );
        },
      ),
    );
  }
}
