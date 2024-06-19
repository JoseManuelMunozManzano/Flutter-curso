import 'package:flutter_dotenv/flutter_dotenv.dart';

// Indicar que esto es un patrón adaptador para envolver (wrapper) dotenv.
// Solo aquí tenemos referencia al paquete dotenv, es decir, solo lo usamos en un único lugar.
class Environment {

  static initEnvironment() async {
    await dotenv.load(fileName: ".env");
  }

  static String apiUrl = dotenv.env['API_URL'] ?? 'No está configurado el API_URL';
}
