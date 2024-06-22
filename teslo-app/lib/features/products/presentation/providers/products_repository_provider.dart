// El objetivo de este provider es poder establecer, a lo largo de toda la app,
// la instancia de nuestro ProductsRepositoryImpl
// Notar que ese repositorio pide el datasource ProductsDatasourceImpl

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/infrastructure/datasources/products_datasource_impl.dart';
import 'package:teslo_shop/features/products/infrastructure/repositories/products_repository_impl.dart';

// El accessToken lo tengo en otro provider.
// Como aquí me encuentro en un provider, distintos providers de Riverpod pueden hablar muy fácilmente
// entre sí usando la referencia a ref, que son nuestros árboles de providers.

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {

  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final productsRepository = ProductsRepositoryImpl(
    ProductsDatasourceImpl(accessToken: accessToken)
  );

  return productsRepository;
});
