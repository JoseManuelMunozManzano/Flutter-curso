// async* se indica en funciones y métodos e indica que se devuelve un stream

void main() {
  // Escuchamos los valores que se emiten, con intervalos de 1 sg entre cada emisión.
  emitNumber().listen((int value) {
    print('Stream value: $value');
  });
}

// Emitimos valores
Stream<int> emitNumber() async* {
  // Listado de enteros que vamos a emitir de manera secuencial.
  final valuesToEmit = [1, 2, 3, 4, 5];

  for (int i in valuesToEmit) {
    await Future.delayed(const Duration(seconds: 1));
    yield i;
  }
}
