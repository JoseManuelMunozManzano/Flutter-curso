import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'products_repository_provider.dart';

// State Notifier Provider

// Provider
// Usamos el modificador autoDispose para que se limpie cuando ya no se vaya a utilizar.
// Y usamos también el modificador family para esperar un valor a la hora de utilizar
// este provider.
// Tiene 3 argumentos, que son el notifier, el state y String porque, por el family, estamos esperando
// el valor productId que hemos definido como un String.
final productProvider = StateNotifierProvider.autoDispose.family<ProductNotifier, ProductState, String>(
  (ref, productId) {

    final productsRepository = ref.watch(productsRepositoryProvider);

    return ProductNotifier(
      productsRepository: productsRepository,
      productId: productId
    );
});

// Notifier
class ProductNotifier extends StateNotifier<ProductState> {

  final ProductsRepository productsRepository;

  ProductNotifier({
    required this.productsRepository,
    required String productId,
  }): super(ProductState(id: productId)) {
    // No hace falta pasar el id porque ya lo estamos creando en este momento y 
    // lo tendremos en el state.
    loadProduct();
  }

  // Este es nuestro nuevo producto vacío.
  // Indicamos como id de nuestro nuevo producto 'new' (no confundir este new con el de la ruta)
  Product newEmptyProduct() {
    return Product(
      id: 'new',
      title: '',
      price: 0,
      description: '',
      slug: '',
      stock: 0,
      sizes: [],
      gender: 'men',
      tags: [],
      images: [],
    );
  }

  Future<void> loadProduct() async {
    try {

      // Alta
      if (state.id == 'new') {
        state = state.copyWith(
          isLoading: false,
          product: newEmptyProduct(),
        );
        return;
      }

      final product = await productsRepository.getProductById(state.id);
      
      state = state.copyWith(
        isLoading: false,
        product: product
      );

    } catch (e) {
      // 404 product nof found
      print(e);
    }
  }
}

// State
class ProductState {

  final String id;
  final Product? product;
  final bool isLoading;
  // Para bloquear un botón o evitar que el usuario salga.
  // Pero no debemos de depender de esta funcionalidad, porque en una web
  // el usuario siempre puede pulsar el botón refrescar.
  final bool isSaving;

  ProductState({
    required this.id,
    this.product,
    this.isLoading = true,
    this.isSaving = false,
  });

  ProductState copyWith({
    String? id,
    Product? product,
    bool? isLoading,
    bool? isSaving,
  }) {
    return ProductState(
      id: id ?? this.id,
      product: product ?? this.product,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}
