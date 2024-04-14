import 'package:flutter_dotenv/flutter_dotenv.dart';

// El objetivo de esta clase es alojar las variables de entorno, definidas estáticamente, para que sean fáciles de utilizar.
class Environment {

  static String theMovieDbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? 'No hay api key';
}
