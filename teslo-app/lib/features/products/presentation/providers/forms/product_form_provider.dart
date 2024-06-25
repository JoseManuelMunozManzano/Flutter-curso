import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/providers.dart';
import 'package:teslo_shop/features/shared/shared.dart';

// Provider: será un autoDispose Provider porque cuando salga y regrese quiero que el
// estado regrese a su estado por defecto, y un family Provider porque necesito recibir
// el producto (su tipo de dato) para crearlo.
// También necesitaremos el callback para poder hacer el submit de la data.
final productFormProvider = StateNotifierProvider.autoDispose.family<ProductFormNotifier, ProductFormState, Product>
((ref, product) {

  final createUpdateCallback = ref.watch(productsRepositoryProvider).createUpdateProduct;

  return ProductFormNotifier(
    product: product,
    onSubmitCallback: createUpdateCallback,
  );
});


// Notifier: Responsable de mantener el estado y sus cambios. También de emitir la data
// que tiene que ser procesada por otro ente.
class ProductFormNotifier extends StateNotifier<ProductFormState> {

  // Este callback será llamado al pulsar el botón que hace el submit del formulario.
  // Vemos que recibe algo que luce como un producto, pero que NO es un producto.
  // Es el objeto que está esperando el backend.
  final Future<Product> Function(Map<String, dynamic> productLike)? onSubmitCallback;

  // El producto no lo estamos creando como una propiedad. Solo necesitamos recibirlo.
  ProductFormNotifier({
    required Product product,
    this.onSubmitCallback,
  }):super(
    // En el super creamos el estado inicial de nuestro ProductFormState.
    // Tenemos que hacer ciertas transformaciones en el product para que sea como nuestro State.
    ProductFormState(
      id: product.id,
      title: Title.dirty(product.title),
      slug: Slug.dirty(product.slug),
      price: Price.dirty(product.price),
      inStock: Stock.dirty(product.stock),
      sizes: product.sizes,
      gender: product.gender,
      description: product.description,
      tags: product.tags.join(', '),  // Obtenemos el String que espera mi State
      images: product.images
    )
  );

Future<bool> onFormSubmit() async {
  // Cuando vaya a hacer el POST de la data, quiero disparar la validación de Formz para
  // asegurarme de que todos los campos han sido manipulados y que la data es correcta.
  _touchedEverything();
  if (!state.isFormValid) return false;

  // Si no nos mandan la función que tenemos que ejecutar al hacer el submit me voy sin hacer nada
  if (onSubmitCallback == null) return false;

  final productLike = {
    'id': state.id,
    'title': state.title.value,
    'price': state.price.value,
    'description': state.description,
    'slug': state.slug.value,
    'stock': state.inStock.value,
    'sizes': state.sizes,
    'gender': state.gender,
    'tags': state.tags.split(','),
    // Esto sería una imagen
    // http://121.123142.21121.3423/files/product/2381902381290.jpg
    // Pero yo quiero solo el nombre de la imagen, no toda la url.
    // Técnicamente, esta transformación debería estar en el backend, pero lo vamos a hacer aquí.
    'images': state.images.map(
      (image) => image.replaceAll('${Environment.apiUrl}/files/product/', '')
    ).toList()
  };

  try {
    await onSubmitCallback!(productLike);
    return true;
  } catch (e) {
    return false;
  }

}

// Cuando vaya a hacer el POST de la data, quiero disparar la validación de Formz para
// asegurarme de que todos los campos han sido manipulados y que la data es correcta.
void _touchedEverything() {
  state = state.copyWith(
    isFormValid: Formz.validate([
      Title.dirty(state.title.value),
      Slug.dirty(state.slug.value),
      Price.dirty(state.price.value),
      Stock.dirty(state.inStock.value),
    ])
  );
}

  // Cambios al state
  void onTitleChanged(String value) {
    state = state.copyWith(
      title: Title.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(value),   // Lo vuelvo a meter simplemente para que el copy-paste sea más fácil
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ]) // Si la descripción fuera obligatoria se puede hacer AQUI: && description... u otro input
    );
  }

  void onSlugChanged(String value) {
    state = state.copyWith(
        slug: Slug.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(state.title.value), 
          Slug.dirty(value),
          Price.dirty(state.price.value),
          Stock.dirty(state.inStock.value),
        ]));
  }

  void onPriceChanged(double value) {
    state = state.copyWith(
        price: Price.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(state.title.value),
          Slug.dirty(state.slug.value),
          Price.dirty(value),
          Stock.dirty(state.inStock.value),
        ]));
  }

  void onStockChanged(int value) {
    state = state.copyWith(
        inStock: Stock.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(state.title.value),
          Slug.dirty(state.slug.value),
          Price.dirty(state.price.value),
          Stock.dirty(value),
        ]));
  }

  // Otros campos a tratar sus cambios en el state y que no usan Formz
  void onSizeChanged(List<String> sizes) {
    state = state.copyWith(
      sizes: sizes,
    );
  }

  void onGenderChanged(String gender) {
    state = state.copyWith(
      gender: gender,
    );
  }

  void onDescriptionChanged(String description) {
    state = state.copyWith(
      description: description,
    );
  }

  void onTagsChanged(String tags) {
    state = state.copyWith(
      tags: tags,
    );
  }

}

// State
class ProductFormState {

  final bool isFormValid;
  final String? id;
  final Title title;
  final Slug slug;
  final Price price;
  final List<String> sizes;
  final String gender;
  // Aquí haremos algún tipo de conversión porque mi back espera stock, no inStock
  final Stock inStock;
  final String description;
  // Mi back espera un arreglo de Strings, pero aquí lo estoy manejando como un String.
  // Es decir, necesitaremos otro tipo de conversión.
  final String tags;
  final List<String> images;


  ProductFormState({
    this.isFormValid = false,
    this.id,
    this.title = const Title.dirty(''),
    this.slug = const Slug.dirty(''),
    this.price = const Price.dirty(0),
    this.sizes = const [],
    this.gender = 'men',
    this.inStock = const Stock.dirty(0),
    this.description = '',
    this.tags = '',
    this.images = const [],
  });

  ProductFormState copyWith({
    bool? isFormValid,
    String? id,
    Title? title,
    Slug? slug,
    Price? price,
    List<String>? sizes,
    String? gender,
    Stock? inStock,
    String? description,
    String? tags,
    List<String>? images,
  }) {
    return ProductFormState(
      isFormValid: isFormValid ?? this.isFormValid,
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      price: price ?? this.price,
      sizes: sizes ?? this.sizes,
      gender: gender ?? this.gender,
      inStock: inStock ?? this.inStock,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      images: images ?? this.images,
    );
  }
}
