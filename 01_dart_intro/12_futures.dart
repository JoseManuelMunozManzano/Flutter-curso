// Un future representa el resultado de una operación asíncrona.
// Es una promesa de que pronto tendremos un valor, pero esta promesa puede fallar y hay que manejar
// la excepción.
void main() {
  print('Inicio del programa');

  // Para obtener el valor que emite el Future<String> indicamos el .then(value)
  httpGet('https://neimerc.com/cursos').then((value) {
    print(value);
  });

  // Promesa fallida
  // Para que no sea un error no controlado, tenemos que manejar la excepción con .catchError(error)
  httpGetError('https://neimerc.com/cursos_da_error').then((value) {
    print(value);
  }).catchError((err) {
    print('Error: $err');
  });

  print('Fin del programa');
}

// Vamos a simular una petición get
// Future es un genérico.
Future<String> httpGet(String url) {
  // En la función delayed se indica la duración y un callback de lo que se hará
  // una vez pase esa duración.
  return Future.delayed(const Duration(seconds: 1), () {
    return 'Respuesta de la petición http';
  });
}

// Promesa fallida
Future<String> httpGetError(String url) {
  return Future.delayed(const Duration(seconds: 1), () {
    throw 'Error en la petición http';
  });
}
