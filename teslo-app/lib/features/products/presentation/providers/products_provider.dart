// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'products_repository_provider.dart';

// Tengo que crearme el State, el Notifier y el Provider

// Provider
// Es la parte que amarra la pieza del State y la del Notifier.
// Provee ese estado, junto con el notifier, de manera global.
final productsProvider = StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {

  final productsRepository = ref.watch(productsRepositoryProvider);

  return ProductsNotifier(productsRepository: productsRepository);
});

// Notifier
class ProductsNotifier extends StateNotifier<ProductsState> {

  // Necesito el repositorio para poder hacer la petición
  final ProductsRepository productsRepository;

  ProductsNotifier({
    required this.productsRepository
  }): super(ProductsState()) {
    // Al crear la primera instancia va a ejecutar loadNextPage()
    // En el constructor NO puede ser asíncrono
    loadNextPage();
  }

  Future<bool> createOrUpdateProduct(Map<String, dynamic> productLike) async {

    try {
      final product = await productsRepository.createUpdateProduct(productLike);
      final isProductInList = state.products.any((element) => element.id == product.id);

      if (!isProductInList) {
        state = state.copyWith(
          products: [...state.products, product]
        );
        return true;
      }

      state = state.copyWith(
        // Recordar poner el .toList() al final, porque se regresa un Iterable y queremos una lista.
        products: state.products.map(
          (element) => (element.id == product.id) ? product : element,
        ).toList()
      );
      return true;

    } catch (e) {
      return false;
    }
  }

  // Actualiza el estado de los productos.
  Future loadNextPage() async {
    // Para que no bombardee a peticiones (pasa mucho con el infiniteScroll)
    // Faltaría el pullToRefresh, que establecería isLastPage en false para que se puedan
    // volver a hacer las peticiones.
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final products = await productsRepository.getProductsByPage(
      limit: state.limit,
      offset: state.offset
    );

    if (products.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        isLastPage: true
      );
      return;
    }

    state = state.copyWith(
      isLoading: false,
      isLastPage: false,
      offset: state.offset + 1,
      products: [...state.products, ...products],
    );
  }
}

// State
class ProductsState {

  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Product> products;

  ProductsState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.products = const[],
  });

  // Creado automáticamente con la extensión de VSCode Dart Data Class Generator
  ProductsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Product>? products,
  }) {
    return ProductsState(
      isLastPage: isLastPage ?? this.isLastPage,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
    );
  }
}
