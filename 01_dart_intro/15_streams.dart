// Los streams son un flujo de información que pueden estar emitiendo valores periódicamente,
// una única vez, o nunca.
// Hay mucha relación entre Futures, streams y programación asíncrona.
// Stream es un genérico.

void main() {
  // Para que los streams emitan valores, alguien tiene que estar escuchándolos.
  emitNumbers().listen((value) {
    print('Stream value: $value');
  });

  // Parará cuando se cierre la escucha, usando .close() o si se ha usado take()...
}

Stream<int> emitNumbers() {
  // Hay varios constructores de streams.
  // Vamos a usar periodic() que emitirá valores empezando en 0, luego el 1, luego el 2... cada vez que pase
  // una duración especificada.
  // El método take() nos sirve para indicar cuántas emisiones queremos emitir, y luego se cierra
  // y hace la limpieza respectiva.
  return Stream.periodic(const Duration(seconds: 1), (value) {
    // print('desde periodic $value');
    return value;
  }).take(5);
}
