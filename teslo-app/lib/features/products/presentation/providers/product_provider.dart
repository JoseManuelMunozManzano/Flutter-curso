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
  }): super(ProductState(id: productId));

  Future<void> loadProduct() async {

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
