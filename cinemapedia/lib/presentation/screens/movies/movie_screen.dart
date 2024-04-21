import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {

  static const name = 'movie-screen';

  // Lo hacemos de esta manera en vez de estar esperando que me manden un objeto de tipo Movie
  // porque vamos a querer hacer un deep linking, es decir, que tocaremos una película y entraremos
  // a la página, donde habrá un botón que diga 'Share' para compartirlo con una persona.
  // Cuando esa persona toque ese enlace lo llevará a la app, específicamente a la página de
  // esa película. Esto se hace enviando el id. En ese momento no tengo algo de tipo Movie, solo el id
  // que aparece en la url (si se hace desde Web)
  final String movieId;

  const MovieScreen({
    super.key,
    required this.movieId
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MovieID: $movieId'),
      ),
    );
  }
}
