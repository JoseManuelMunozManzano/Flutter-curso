// Recordar que el objetivo del mapper es tener la conversión de como luce algún objeto a nuestro
// tipo de objeto personalizado que usamos en la aplicación. Es una barrera protectora muy valiosa.

import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) =>
      Actor(
        id: cast.id,
        name: cast.name,
        profilePath: cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}'
          : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
        character: cast.character
      );
}
