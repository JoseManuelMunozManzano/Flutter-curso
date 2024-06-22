// Esta estructura la obtenemos desde Postman, endpoint http://localhost:3001/api/products
// Copiamos el resultado
// Utilizamos la extensión Paste JSON as Code y ponemos como nombre Product
// También se podría haber obtenido desde la web quicktype.io
// No olvidar hacer correcciones después.

import 'package:teslo_shop/features/auth/domain/domain.dart';

class Product {
  String id;
  String title;
  int price;
  String description;
  String slug;
  int stock;
  List<String> sizes;
  String gender;
  List<String> tags;
  List<String> images;
  User? user;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.slug,
    required this.stock,
    required this.sizes,
    required this.gender,
    required this.tags,
    required this.images,
    required this.user,
  });
}
