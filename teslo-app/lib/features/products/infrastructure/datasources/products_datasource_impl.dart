import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';

import '../errors/product_errors.dart';
import '../mappers/product_mapper.dart';

// Aquí es donde hacemos todo el trabajo.
class ProductsDatasourceImpl extends ProductsDatasource {
  
  // Usamos dio para hacer la petición http.
  // Lo vamos a hacer distinto a como lo hicimos en la parte de autenticación.
  late final Dio dio;
  final String accessToken;
  
  ProductsDatasourceImpl({
    required this.accessToken
  }) : dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      headers: {
        'Authorization': 'Bearer $accessToken'
      }
    )
  );

  // Subir una imagen
  Future<String> _uploadFile(String path) async {

    try {
      // nombre del archivo con la extensión
      final fileName = path.split('/').last;
      // El nombre del key, que me pide mi backend, es file
      final FormData data = FormData.fromMap({
        'file': MultipartFile.fromFileSync(path, filename: fileName)
      });

      final response = await dio.post('/files/product', data: data);

      // Es 'image' porque eso es lo que me devuelve mi backend.
      return response.data['image'];

    } catch (e) {
      throw Exception();
    }
  }

  // Carga múltiple de imágenes al backend
  Future<List<String>> _uploadPhotos(List<String> photos) async {

    // Si tienen un / en el nombre significa que vienen de mi filesystem.
    // Voy a disparar un montón de procedimientos de manera simultánea con estas fotografías.
    final photosToUpload = photos.where((element) => element.contains('/')).toList();
    // Las que ignoramos
    final photosToIgnore = photos.where((element) => !element.contains('/')).toList();

    // Creamos una serie de Futures de carga de imágenes y esperamos todas las respuestas.
    // Si uno falla, el procedimiento entero falla.
    final List<Future<String>> uploadJob = photosToUpload.map((e) => _uploadFile(e)).toList();
    final newImages = await Future.wait(uploadJob);

    return [...photosToIgnore, ...newImages];

  }

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) async {
  
    try {
      final String? productId = productLike['id'];
      final String method = (productId == null) ? 'POST' : 'PATCH';
      final String url = (productId == null) ? '/products' : '/products/$productId';

      // Tanto para creación como para actualización, hay que quitar el id.
      // Es una condición del backend.
      productLike.remove('id');

      // Imágenes que tienen el path absoluto a mi filesystem y la que ya venían en el producto.
      productLike['images'] = await _uploadPhotos(productLike['images']);

      // Hacemos el POST o el PATCH
      final response = await dio.request(
        url,
        // Un Map<String, dynamic> como tenemos en productLike, es un JSON. Se puede ver así.
        data: productLike,
        options: Options(
          method: method,
        )
      );

      final product = ProductMapper.jsonToEntity(response.data);
      return product;

    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    try {
      final response = await dio.get('/products/$id');
      final product = ProductMapper.jsonToEntity(response.data);
      return product;

    } on DioException catch (e) {
      if (e.response!.statusCode == 404) throw ProductNotFound();

      // Si no es la excepción de arriba lanzamos esta excepción, que lo que
      // hace es moverla al catch de abajo, en cascada.
      // Técnicamente no deberíamos de caer aquí nunca.
      throw Exception();
      
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0}) async {
    final response = await dio.get<List>('/products?limit=$limit&offset=$offset');
    final List<Product> products = [];
    for (final product in response.data ?? []) {
      products.add(ProductMapper.jsonToEntity(product));
    }

    return products;
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
  }
}
