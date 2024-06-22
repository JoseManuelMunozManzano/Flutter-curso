// Solo definimos las reglas, no implementamos nada

import 'package:teslo_shop/features/products/domain/entities/product.dart';

abstract class ProductsDatasource {

  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0});

  Future<Product> getProductById(String id);

  Future<List<Product>> searchProductByTerm(String term);

  // productLike es algo que se asemeja a un producto
  Future<List<Product>> createUpdateProduct(Map<String, dynamic> productLike);
}
