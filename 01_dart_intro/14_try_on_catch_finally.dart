void main() async {
  print('Inicio del programa');

  // Promesa fallida
  //  La palabra reservada finally se ejecuta siempre, haya o no excepción.
  //  La palabra reservada on, que se usa antes del catch, nos permite reaccionar en función
  //   del tipo de excepción/error que recibamos.
  //   Notar que si entramos por el on, no llegamos al catch.
  // Por el catch entraría entonces cuando tenemos un error que no estamos manejando en el on,
  // en el ejemplo, que no sea una Exception.
  try {
    final value = await httpGetError('https://neimerc.com/cursos');
    print('Éxito!!! $value');
  } on Exception catch(err) {
    print('Tenemos una Exception: $err');
  } catch (err) {
    print('Oops! algo terrible pasó: $err');
  } finally {
    print('Fin del try y catch');
  }

  print('Fin del programa');
}

// Promesa fallida con async-await
Future<String> httpGetError(String url) async {
  await Future.delayed(const Duration(seconds: 1));

  // Excepción concreta usando new Exception (el new se omite porque no hace falta indicarlo)
  // Entra por el on
  throw Exception('No hay parámetros en el URL');

  // Entra por el catch porque es un error no controlado.
  // throw 'Error en la petición';
}
