import 'package:teslo_shop/features/products/domain/domain.dart';

class ProductsRepositoryImpl extends ProductsRepository {

  // El único objetivo del ProductsRepositoryImpl es usar el datasource.
  final ProductsDatasource datasource;

  // Aquí veremos que falta recibir el token de acceso para implementar la autenticación.

  ProductsRepositoryImpl(this.datasource);

  @override
  Future<List<Product>> createUpdateProduct(Map<String, dynamic> productLike) {
    return datasource.createUpdateProduct(productLike);
  }

  @override
  Future<Product> getProductById(String id) {
    return datasource.getProductById(id);
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0}) {
    return datasource.getProductsByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    return datasource.searchProductByTerm(term);
  }
}
