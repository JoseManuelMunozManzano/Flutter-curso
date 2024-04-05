// Usando el snipped impm importamos el paquete de Material
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Esto podría estar en una carpeta específica de data, pero como
// solo lo vamos a usar aquí, no me merece la pena.
class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  SlideInfo(this.title, this.caption, this.imageUrl);
}

final slides = <SlideInfo>[
  SlideInfo('Busca la comida', 'Commodo consequat proident ex est amet ex exercitation et eu consequat sit sit.', 'assets/images/1.png'),
  SlideInfo('Entrega rápida', 'Incididunt ut Lorem reprehenderit incididunt laboris non voluptate.', 'assets/images/2.png'),
  SlideInfo('Disfruta la comida', 'Veniam ex commodo duis enim et non veniam tempor veniam commodo dolore adipisicing sit.', 'assets/images/3.png'),
];



// Usando el snippet stlesw creamos un StatelessWidget
//
// Lo cambiamos a un StatefulWidget porque necesitamos estado para crear los listeners de los
// scrolls de los PageView.
class AppTutorialScreen extends StatefulWidget {
  static const name = 'tutorial_screen';

  const AppTutorialScreen({super.key});

  @override
  State<AppTutorialScreen> createState() => _AppTutorialScreenState();
}

class _AppTutorialScreenState extends State<AppTutorialScreen> {

  // Esta propiedad sirve para saber si se está moviendo por los slides, en cual estamos, la totalidad del espacio...
  final pageViewController = PageController();
  bool endReached = false;

  // Ocupamos ciclo de vida del StatefulWidget.
  @override
  void initState() {
    super.initState();

    // Este addListener es de tipo Function.
    // No necesitamos recibir nada porque toda la información la tengo en el pageViewController.
    pageViewController.addListener(() {
      // Indicamos 0 porque puede que el controlador todavía no se haya asignado al
      // Widget (no hay referencia) y no tengamos valor en pageViewController.page.
      final page = pageViewController.page ?? 0;
      // Indicamos 1.5 para que aparezca el botón cuando llevamos la mitad del recorrido
      // hacia la última slide.
      // Tal y como se indica abajo, cuidado con llamar a setState, porque se le llama muchas veces.
      if (!endReached && page >= (slides.length - 1.5)) {
        setState(() {
          endReached = true;
        });
      }

      // Descomentar para ver que se recalcula muchas veces.
      // Esto también indica que hay que tener cuidado con los setState
      // ya que se va a refrescar la pantalla muchas veces.
      //
      // print('${pageViewController.page}');
    });
  }

  @override
  void dispose() {
    // Para limpiar los listeners que no se estén utilizando y no gastar más memoria de la necesaria.
    pageViewController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Solo para esta pantalla cambiamos el fondo.
      backgroundColor: Colors.white,

      // Cada slide generará un PageView que ocupa el tamaño de todo el dispositivo.
      // Para movernos entre ellos en el emulador, pulsando el botón izquierdo del ratón, nos movemos a la izquierda.
      // Envolvemos el PageView en un Stack (Column y Row se comportan como un Stack)
      body: Stack(
        children: [
          PageView(
            // El controller es como la barra de control de videos de YouTube.
            // Lo que queremos es mostrar por qué slide vamos y solo en el último slide dar la opción de Salir.
            // Si queremos tener el control de lo que está sucediendo con ese scroll y crear listeners para saber
            // cuando llego a tal punto, no podemos usar un StatelessWidget (o si con un gestor de estados)
            controller: pageViewController,
            physics: const BouncingScrollPhysics(),
            // map devuelve un Iterable y children espera una lista de Widgets. Por eso acabamos con el .toList()
            children: slides.map(
              (slideData) => _Slide(title: slideData.title, caption: slideData.caption, imageUrl: slideData.imageUrl)
            ).toList(),
          ),

          Positioned(
            right: 20,
            top: 50,
            child: TextButton(
              child: const Text('Salir'),
              // Recordar que podemos usar directamente el pop() en el context gracias a que
              // estamos trabajando con go_router.
              // Si no, sería: Navigator.pop(context)
              onPressed: () => context.pop()
            )
          ),

          // Queremos que este botón solo aparezca cuando lleguemos al último slide.
          // Un truco para mostrar un Widget cuando nos obliga el código, pero no queremos mostrar nada es
          // indicar SizedBox()
          endReached ? 
            Positioned(
              bottom: 30,
              right: 30,
              child: FadeInRight(
                from: 15,
                delay: const Duration(seconds: 1),
                child: FilledButton(
                  child: const Text('Comenzar'),
                  onPressed: () => context.pop(),
                ),
              )
            ) : const SizedBox(),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  // Podemos recibir todo el SlideInfo o cada una de las propiedades que lo componen.
  // Lo hacemos por propiedades individuales porque así es reutilizable, ya que este
  // código no queda amarrado a la clase SlideInfo.
  final String title;
  final String caption;
  final String imageUrl;

  const _Slide({
    required this.title,
    required this.caption,
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {
    // Desestructuración
    final TextTheme(:titleLarge, :bodySmall) = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // El Image provider es un AssetImage. Es lo mismo que hacer: Image.asset()
            Image(image: AssetImage(imageUrl)),
            const SizedBox(height: 20),
            Text(title, style: titleLarge),
            const SizedBox(height: 10),
            Text(caption, style: bodySmall,),
          ],
        ),
      ),
    );
  }
}
