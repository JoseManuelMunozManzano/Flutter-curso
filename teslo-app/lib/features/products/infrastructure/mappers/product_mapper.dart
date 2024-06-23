// En vez de usar quicktype.io esta vez lo vamos a hacer manualmente.

import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';

class ProductMapper {

  static jsonToEntity(Map<String, dynamic> json) => Product(
    id: json['id'],
    title: json['title'],
    price: double.parse(json['price'].toString()),    // Si viene el valor 35 Dart cree que es entero.
    description: json['description'],
    slug: json['slug'],
    stock: json['stock'],
    sizes: List<String>.from(json['sizes'].map((size) => size)),
    gender: json['gender'],
    tags: List<String>.from(json['tags'].map((tag) => tag)),
    // Tenemos imágenes parciales (solo el nombre) y completas (URL completa)
    // Convertimos a imagen completa aquí para no tener esta conversión
    // desparramada por el código.
    images: List<String>.from(json['images'].map(
      (image) => image.startsWith('http')
      ? image
      : '${Environment.apiUrl}/files/product/$image',
    )),
    user: UserMapper.userJsonToEntity(json['user'])
  );
}
