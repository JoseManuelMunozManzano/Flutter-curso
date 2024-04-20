import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatelessWidget {

  // Para hacerlo muy flexible necesitamos estos argumentos.
  final List<Movie> movies;
  final String? title;
  final String? subTitle;

  // Tengo que saber cuando llego al final del SlideShow para cargar 
  // (o no, de ahí que sea opcional) las siguientes películas y así conseguir el infinite scroll.
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.subTitle,
    this.loadNextPage
  });

  @override
  Widget build(BuildContext context) {
    // Para que no se desborde
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (title != null || subTitle != null)
            _Title(title: title, subTitle: subTitle),
        ],
      ),
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
            Text(title!, style: titleStyle,),
          
          const Spacer(),

          if (subTitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(subTitle!)
            )
        ],
      ),
    );
  }
}
