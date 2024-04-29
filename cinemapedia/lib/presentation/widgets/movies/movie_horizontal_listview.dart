import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Como vamos a incluir un listener convertimos este Widget a StatefulWidget.
class MovieHorizontalListview extends StatefulWidget {
  // Para hacerlo muy flexible necesitamos estos argumentos.
  final List<Movie> movies;
  final String? title;
  final String? subTitle;

  // Tengo que saber cuando llego al final del SlideShow para cargar
  // (o no, de ahí que sea opcional) las siguientes películas y así conseguir el infinite scroll.
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview(
      {super.key,
      required this.movies,
      this.title,
      this.subTitle,
      this.loadNextPage});

  @override
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      // Puede ser que no tengamos la siguiente página. Entonces nos vamos.
      if (widget.loadNextPage == null) return;

      // Necesitamos saber la posición actual del scroll.
      // Damos 200px de gracia
      if ((scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent) {
        widget.loadNextPage!(); // Sabemos que en este momento NO va a ser null.
      }
    });
  }

  // Cuando añadimos un listener y sabemos que la pantalla se va a destruir en algún punto del tiempo,
  // hay que llamar al dispose()
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Para que no se desborde
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            _Title(title: widget.title, subTitle: widget.subTitle),

          // Porque necesitamos que el ListView tenga un tamaño específico.
          Expanded(
              child: ListView.builder(
            controller: scrollController, // Asociando el controller al ListView
            itemCount: widget.movies.length,
            scrollDirection: Axis.horizontal,
            // Para que se vea igual en Android e IOs
            physics: const BouncingScrollPhysics(),            
            itemBuilder: (context, index) {
              return FadeInRight(child: _Slide(movie: widget.movies[index]));
            },
          ))
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          //* Imagen
          SizedBox(
            width: 150,
            // AspectRatio para que ocupe el máximo del vertical del contenedor.
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  width: 150,
                  // Cuando se construye la imagen ejecutamos el loadingBuilder
                  loadingBuilder: (context, child, loadingProgress) {

                    if (loadingProgress != null) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator(strokeWidth: 2,))
                      );
                    }

                    return GestureDetector(
                      // Recordar que indicamos .push() para que los usuarios puedan volver hacia atrás.
                      onTap:() => context.push('/movie/${movie.id}') ,
                      child: FadeIn(child: child)
                    );
                  },
                )
              ),
            ),
          ),

          const SizedBox(height: 5),

          //* Títle
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyles.titleSmall,
            ),
          ),

          //* Rating
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                const SizedBox(width: 3,),
                Text(HumanFormats.number(movie.voteAverage, 1), style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800),),
                // const SizedBox(width: 10,),
                const Spacer(),
                Text(HumanFormats.number(movie.popularity), style: textStyles.bodySmall)
              ],
            ),
          ),
        ]
      )
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _Title({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: titleStyle,
            ),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {},
                child: Text(subTitle!))
        ],
      ),
    );
  }
}
