// Async-Await son muy útiles para trabajar junto con los Futures.
// La legibilidad del código mejora mucho usando async y await.

void main() async {
  print('Inicio del programa');

  // Promesa cumplida
  // Se espera a tener el valor y la ejecución se para.
  final value = await httpGet('https://neimerc.com/cursos');
  print(value);

  // Promesa fallida
  // Para controlar un error se coloca la petición entre try/catch
  try {
    final value = await httpGetError('https://neimerc.com/cursos');
    print(value);
  } catch (err) {
    print('Tenemos un error: $err');
  }

  print('Fin del programa');
}

// Promesa cumplida con async-await
// Colocamos la palabra reservada async para indicar que un método o función retorna un Future
Future<String> httpGet(String url) async {
  // Podemos usar la palabra reservada await para que espere a que el Future se realice,
  // y entonces devolver el valor o hacer con el lo que queramos.
  // Un await transforma un Future como si fuera un código síncrono y secuencial.
  // Solo se puede usar await cuando el método o función en async.
  await Future.delayed(const Duration(seconds: 1));

  return 'Tenemos un valor de la petición';
}

// Promesa fallida con async-await
Future<String> httpGetError(String url) async {
  await Future.delayed(const Duration(seconds: 1));
  throw 'Error en la petición http';
}
