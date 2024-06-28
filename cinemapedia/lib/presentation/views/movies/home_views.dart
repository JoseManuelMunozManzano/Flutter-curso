import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

// Para obtener acceso al ref lo cambiamos a un ConsumerStatefulWidget
class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  // Esto se cambia a HomeViewState ya que abajo hemos cambiado a ConsumerState. Era un State<HomeView>
  HomeViewState createState() => HomeViewState();
}

// Al haber cambiado arriba a un ConsumerStatefulWidget, aquí cambiamos State por ConsumerState
class HomeViewState extends ConsumerState<HomeView> {
  // Con lo comentado en todo este fuente, ya tenemos acceso a ref de manera global en todo este scope.
  @override
  void initState() {
    super.initState();

    // Este es el PUENTE. El read de provider manda a llamar a la siguiente página.
    // Recordar que indicando .notifier no quiero el valor, quiero el notifier.
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    // Vamos a escuchar simultáneamente varios providers.
    // Cuando los cuatro tengan un valor quitamos el FullScreenLoader.
    // Para esto usamos también Riverpod.
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    // Cuando ya tenemos todo cargado eliminamos nuestro SplashScreen.
    FlutterNativeSplash.remove();

    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    // return SingleChildScrollView(
    // child: Column(...
    return CustomScrollView(slivers: [
      // Llevo aquí mi AppBar, que ahora funciona con el scroll.
      // Cuando hago scroll desaparece, pero cuando muevo un poco hacia arriba
      // vuelve a aparecer.
      const SliverAppBar(
        floating: true,
        title: CustomAppBar(),
        // flexibleSpace: FlexibleSpaceBar(
        //   titlePadding: EdgeInsets.all(0),
        //   title: CustomAppBar(),
        // ),
      ),

      // El delegate es la función que me a servir para crear Widgets dentro de este View.
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(children: [
          // Al añadir el CustomScrollView, mi Appbar ya no va a formar parte de ese ListView.
          // Será parte de un nuevo sliver llamado SliverAppbar.
          // const CustomAppBar(),

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

          // Vamos a controlar, usando Riverpod, cuántas películas queremos mandar.
          // Estrictamente hablando, es innecesario porque se puede hacer la lógica en esta llamada.
          // MoviesSlideshow(movies: nowPlayingMovies > 0 ? : [])
          // Pero vamos a explicar un concepto interesante de Riverpod y sus providers.
          MoviesSlideshow(movies: slideShowMovies),

          MovieHorizontalListview(
            movies: nowPlayingMovies,
            title: 'En cines',
            subTitle: 'Lunes 20',
            loadNextPage: () {
              // Recordar que se usa el .read() dentro de funciones o callbacks.
              ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
            },
          ),

          // Los nuevos MovieHorizontalListView generan un error en pantalla por desbordamiento.
          // Para evitar esto, envolvemos nuestro Column en el Widget SingleChildScrollView o
          // con un CustomScrollView y el sliver, que es lo que al final hemos hecho.
          MovieHorizontalListview(
            movies: upcomingMovies,
            title: 'Próximamente',
            subTitle: 'En este mes',
            loadNextPage: () {
              // Recordar que se usa el .read() dentro de funciones o callbacks.
              ref.read(upcomingMoviesProvider.notifier).loadNextPage();
            },
          ),

          MovieHorizontalListview(
            movies: popularMovies,
            title: 'Populares',
            // subTitle: '',
            loadNextPage: () {
              // Recordar que se usa el .read() dentro de funciones o callbacks.
              ref.read(popularMoviesProvider.notifier).loadNextPage();
            },
          ),

          MovieHorizontalListview(
            movies: topRatedMovies,
            title: 'Mejor calificadas',
            subTitle: 'General',
            loadNextPage: () {
              // Recordar que se usa el .read() dentro de funciones o callbacks.
              ref.read(topRatedMoviesProvider.notifier).loadNextPage();
            },
          ),

          // Espacio de gracia para que el usuario pueda hacer algo más de scroll.
          const SizedBox(
            height: 10,
          )
        ]);
      }, childCount: 1))
    ]);
  }
}
