// Usamos snippet impm para importar material
import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Usamos snippet stlesw para crear un StatelessWidget.
class HomeScreen extends StatelessWidget {

  // Nombre de la ruta para llegar aquí por medio del nombre.
  // En esta ocasión usamos guión medio.
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView()
    );
  }
}

// Para obtener acceso al ref lo cambiamos a un ConsumerStatefulWidget
class _HomeView extends ConsumerStatefulWidget {

  const _HomeView();

  @override
  // Esto se cambia a _HomeViewState ya que abajo hemos cambiado a ConsumerState. Era un State<_HomeView>
  _HomeViewState createState() => _HomeViewState();
}

// Al haber cambiado arriba a un ConsumerStatefulWidget, aquí cambiamos State por ConsumerState
class _HomeViewState extends ConsumerState<_HomeView> {

  // Con lo comentado en todo este fuente, ya tenemos acceso a ref de manera global en todo este scope.
  @override
  void initState() {
    super.initState();

    // Este es el PUENTE. El read de provider manda a llamar a la siguiente página.
    // Recordar que indicando .notifier no quiero el valor, quiero el notifier.
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    return Column(
      children: [

        const CustomAppBar(),
        
        // Dado el padre Column, expande todo lo posible, dando un ancho y un alto fijo.
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: nowPlayingMovies.length,
        //     itemBuilder: (context, index) {
        //       final movie = nowPlayingMovies[index];
          
        //       return ListTile(
        //         title: Text(movie.title),
        //       );
        //     }
        //   ),
        // )

        MoviesSlideshow(movies: nowPlayingMovies)
      ]
    );
  }
}
