import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/providers.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class ProductScreen extends ConsumerWidget {

  final String productId;

  const ProductScreen({super.key, required this.productId});

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Producto Actualizado'))
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // Riverpod va a mantener en memoria este productProvider cuyo id sea el mismo.
    // Es decir, puedo usar esta misma sintaxis en otros sitios y va a usar la misma
    // referencia a este objeto siempre y cuando sea el mismo id.
    final productState = ref.watch(productProvider(productId));

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Editar Producto'),
          actions: [
            IconButton(onPressed: () async {
                final photoPath = await CameraGalleryServiceImpl().selectPhoto();
                if (photoPath == null) return;

                photoPath;
              },
              icon: const Icon(Icons.photo_library_outlined)
            ),

            IconButton(onPressed: () async {
              final photoPath = await CameraGalleryServiceImpl().takePhoto();
              if (photoPath == null) return;

              photoPath;
              
              },
              icon: const Icon(Icons.camera_alt_outlined)
            )
          ],
        ),
      
        body: productState.isLoading
        ? const FullScreenLoader()
        : _ProductView(product: productState.product!),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (productState.product == null) return;
      
            // Para mostrar un Snackbar necesitamos el context.
            final result = await ref.read(productFormProvider(productState.product!).notifier).onFormSubmit();
            // Pero esto nos va a lanzar un error que dice que no hay que utilizar el BuildContext
            // a través de gaps (espacios asíncronos) porque en un await se da tiempo a que el build context
            // cambie en otro sitio, lo que lo hace potencialmente inseguro.
            // ScaffoldMessenger.of(context);
            //
            // Pero se puede solucionar así:
            if (!result || !context.mounted) return;
            showSnackbar(context);
      
            // Otra forma de solucionarlo era usar Futures normales, con el .then, es decir, sin await.
            // De esta forma, con el .then() toma el valor correcto de BuildContext:
            //
            // ref.read(productFormProvider(productState.product!).notifier).onFormSubmit().then((value) {
            //   if (!value) return;
            //   showSnackbar(context);
            // });
          },
          child: const Icon(Icons.save_as_outlined),
        ),
      ),
    );
  }
}


// No debe ser un StatefulWidget.
// Como solo usamos el provider en el initState() y luego ya no es necesario, automáticamente
// lo destruye (el autoDispose) y luego ya no existe ningún notifier. Ese es el error.


// class ProductScreen extends ConsumerStatefulWidget {

//   final String productId;

//   const ProductScreen({super.key, required this.productId});

//   @override
//   ProductScreenState createState() => ProductScreenState();
// }

// class ProductScreenState extends ConsumerState<ProductScreen> {

//   @override
//   void initState() {
//     super.initState();

//     // Hay que llamarlo con el id del producto porque el provider tiene el modificador
//     // .family, y luego añadir el .notifier
//     ref.read(productProvider(widget.productId).notifier);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Editar Producto'),
//       ),

//       body: Center(
//         child: Text(widget.productId),
//       )
//     );
//   }
// }




class _ProductView extends ConsumerWidget {
  
  final Product product;

  const _ProductView({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // En diferentes puntos de la app, si hago referencia a este provider, tendré
    // este mismo valor.
    final productForm = ref.watch(productFormProvider(product));

    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [
        SizedBox(
          height: 250,
          width: 600,
          child: _ImageGallery(images: productForm.images),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            productForm.title.value,
            style: textStyles.titleSmall,
            textAlign: TextAlign.center,
          )
        ),
        const SizedBox(height: 10),
        _ProductInformation(product: product),
      ],
    );
  }
}

class _ProductInformation extends ConsumerWidget {
  final Product product;
  const _ProductInformation({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // Riverpod sabe que esto ya existe (se creó en _ProductView) y se va a encargar de
    // darnos la instancia exactamente como nosotros la creamos en ese momento.
    final productForm = ref.watch(productFormProvider(product));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Generales'),
          const SizedBox(height: 15),
          CustomProductField(
            isTopField: true,
            label: 'Nombre',
            initialValue: productForm.title.value,
            onChanged: ref.read(productFormProvider(product).notifier).onTitleChanged,
            errorMessage: productForm.title.errorMessage,
          ),
          CustomProductField(
            label: 'Slug',
            initialValue: productForm.slug.value,
            onChanged: ref.read(productFormProvider(product).notifier).onSlugChanged,
            errorMessage: productForm.slug.errorMessage,
          ),
          CustomProductField(
            isBottomField: true,
            label: 'Precio',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: productForm.price.value.toString(),
            onChanged: (value)
              => ref.read(productFormProvider(product).notifier)
              .onPriceChanged(double.tryParse(value) ?? -1.0),
            errorMessage: productForm.price.errorMessage,
          ),
          const SizedBox(height: 15),
          const Text('Extras'),

          _SizeSelector(
            selectedSizes: productForm.sizes,
            onSizesChanged: ref.read(productFormProvider(product).notifier).onSizeChanged,
          ),
          const SizedBox(height: 5),
          _GenderSelector(
            selectedGender: productForm.gender,
            onGenderChanged: ref.read(productFormProvider(product).notifier).onGenderChanged,
          ),

          const SizedBox(height: 15),
          CustomProductField(
            isTopField: true,
            label: 'Existencias',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: productForm.inStock.value.toString(),
            onChanged: (value) 
              => ref.read(productFormProvider(product).notifier)
              .onStockChanged(int.tryParse(value) ?? -1),
            errorMessage: productForm.inStock.errorMessage,
          ),
          CustomProductField(
            maxLines: 6,
            label: 'Descripción',
            keyboardType: TextInputType.multiline,
            initialValue: product.description,
            onChanged: ref.read(productFormProvider(product).notifier).onDescriptionChanged,
          ),
          CustomProductField(
            isBottomField: true,
            maxLines: 2,
            label: 'Tags (Separados por coma)',
            keyboardType: TextInputType.multiline,
            initialValue: product.tags.join(', '),
            onChanged: ref.read(productFormProvider(product).notifier).onTagsChanged,
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _SizeSelector extends StatelessWidget {

  final List<String> selectedSizes;
  // Función que podremos invocar desde fuera
  final void Function(List<String> selectedSizes) onSizesChanged;

  final List<String> sizes = const ['XS', 'S', 'M', 'L', 'XL', 'XXL', 'XXXL'];

  const _SizeSelector({
    required this.selectedSizes,
    required this.onSizesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      // Porque puede ser que no tengamos ninguna talla
      emptySelectionAllowed: true,
      showSelectedIcon: false,
      segments: sizes.map((size) {
        return ButtonSegment(
            value: size,
            label: Text(size, style: const TextStyle(fontSize: 10)));
      }).toList(),
      selected: Set.from(selectedSizes),
      onSelectionChanged: (newSelection) {
        FocusScope.of(context).unfocus();
        // Convertimos el Set a List
        onSizesChanged(List.from(newSelection));
      },
      multiSelectionEnabled: true,
    );
  }
}

class _GenderSelector extends StatelessWidget {
  
  final String selectedGender;
  // Función que podremos invocar desde fuera
  final void Function(String selectedGender) onGenderChanged;

  final List<String> genders = const ['men', 'women', 'kid'];
  final List<IconData> genderIcons = const [
    Icons.man,
    Icons.woman,
    Icons.boy,
  ];

  const _GenderSelector({
    required this.selectedGender,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SegmentedButton(
        multiSelectionEnabled: false,
        showSelectedIcon: false,
        style: const ButtonStyle(visualDensity: VisualDensity.compact),
        segments: genders.map((size) {
          return ButtonSegment(
              icon: Icon(genderIcons[genders.indexOf(size)]),
              value: size,
              label: Text(size, style: const TextStyle(fontSize: 12)));
        }).toList(),
        selected: {selectedGender},
        onSelectionChanged: (newSelection) {
          FocusScope.of(context).unfocus();
          // Convertimos el Set a List
          onGenderChanged(newSelection.first);
        },
      ),
    );
  }
}

class _ImageGallery extends StatelessWidget {
  final List<String> images;
  const _ImageGallery({required this.images});

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: PageController(viewportFraction: 0.7),
      children: images.isEmpty
          ? [
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image.asset('assets/images/no-image.jpg',
                      fit: BoxFit.cover))
            ]
          : images.map((e) {
              return ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Image.network(
                  e,
                  fit: BoxFit.cover,
                ),
              );
            }).toList(),
    );
  }
}
