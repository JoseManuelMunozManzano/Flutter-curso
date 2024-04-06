// Usando el snipped impm importamos el paquete de Material
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Usando el snippet stlesw creamos un StatelessWidget
// Lo cambiamos por un StatefulWidget.
class InfiniteScrollScreen extends StatefulWidget {
  static const name = 'infinite_screen';

  const InfiniteScrollScreen({super.key});

  @override
  State<InfiniteScrollScreen> createState() => _InfiniteScrollScreenState();
}

class _InfiniteScrollScreenState extends State<InfiniteScrollScreen> {
  List<int> imagesIds = [1, 2, 3, 4, 5];
  final scrollController = ScrollController();
  bool isLoading = false;

  // Recordar que si trabajamos con un controller debemos definir el ciclo de vida (initState y dispose),
  // conectarlo, en este caso con nuestro ListView, y crear el listener.
  @override
  void initState() {
    super.initState();

    // Solo cargar el scroll cuando estoy al final.
    scrollController.addListener(() {
      // Esta es la posición actual.
      //
      // scrollController.position.pixels
      //
      // Es lo más que puede llegar. Si la posición actual = posición máxima es porque
      // hemos llegado al final del listado.
      // Pero se suele dar un "espacio de gracia" llamado threshold.
      //
      // scrollController.position.maxScrollExtent

      if ((scrollController.position.pixels + 500) >=
          scrollController.position.maxScrollExtent) {
        // Cargar siguiente página.
        loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  // Simulamos una petición asíncrona porque si no la carga de las 5 imágenes es instantanea.
  Future loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    setState(() {});

    await Future.delayed(const Duration(seconds: 2));

    addFiveImages();
    isLoading = false;

    // Revisar si está montado el componente / widget
    // Esto es porque si nos salimos, y la carga se dispara, como es de manera asíncrona,
    // se puede acabar llamando al setState de un Widget que ya no existe o que ya no está
    // montado en el contexto. Esto puede dar lugar a que la app termine bruscamente.
    if (mounted) {
      // Para activar el widget que señala que esta cargando imágenes.
      setState(() {});
    }

    // TODO: mover scroll
    // Cuando cargan las imágenes y ya las tenemos en memoria queremos que el scroll se mueva
    // un poquito para indicar que hay más imágenes para ver.
  }

  // Pull Refresh
  // Vamos a borrar todas las imágenes que tengamos y traer 5 nuevas imágenes.
  Future<void> onRefresh() async {
    isLoading = true;
    setState(() {});

    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    isLoading = false;
    final lastId = imagesIds.last;
    imagesIds.clear();
    imagesIds.add(lastId + 1);
    addFiveImages();
    isLoading = false;

    setState(() {});
  }

  void addFiveImages() {
    final lastId = imagesIds.last;

    imagesIds.addAll([1, 2, 3, 4, 5].map((e) => lastId + e));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // Para eliminar el espacio en blanco que se ve en la parte de arriba/abajo del móvil.
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        // Con RefreshIndicator se consigue realizar el pull refresh.
        child: RefreshIndicator(
          onRefresh: onRefresh,
          edgeOffset: 10,
          strokeWidth: 2,
          child: _ScrollPagesView(scrollController: scrollController, imagesIds: imagesIds),          
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pop(),
        
        child: isLoading 
          ? SpinPerfect(
            infinite: true,
            child: const Icon(Icons.refresh_rounded),
            )
          : FadeIn(child: const Icon(Icons.arrow_back_ios_new_outlined)),
      ),
    );
  }
}

class _ScrollPagesView extends StatelessWidget {
  const _ScrollPagesView({
    required this.scrollController,
    required this.imagesIds,
  });

  final ScrollController scrollController;
  final List<int> imagesIds;

  @override
  Widget build(BuildContext context) {
    // Como es una lista infinita, no todos los vamos a querer en memoria.
    // Con el buider se construirán bajo demanda, porque sabe cuando están a punto de entrar en pantalla.
    // Para hacer un infinite scroll tenemos que determinar que estamos al final del scroll, y entonces
    // cargar nuevas imágenes (se añaden a nuestra lista de imagesIds y se muestran)
    return ListView.builder(
      // Conectamos con nuestro controller.
      controller: scrollController,
      itemCount: imagesIds.length,
      itemBuilder: (context, index) {
        // FadeInImage nos permite cargar la imagen y mientras se carga muestra el placeholder Image.
        return FadeInImage(
          fit: BoxFit.cover,
          width: double.infinity,
          height: 300,
          placeholder: const AssetImage('assets/images/jar-loading.gif'),
          image: NetworkImage(
              'https://picsum.photos/id/${imagesIds[index]}/500/300'),
        );
      },
    );
  }
}
