void main() {
  // Un mapa son pares de valores: key-value pairs
  final Map<String, dynamic> pokemon = {
    'name': 'Ditto',
    'hp': 100,
    'isAlive': true,
    'abilities': <String>['impostor'],
    'sprites': {1: 'ditto/front.png', 2: 'ditto/back.png'}
  };

  // Las llaves no tienen por qué ser siempre String
  // final pokemons = {1: 'ABC', 2: 'XYZ', 3: '123', 150: 'AGJH'};

  print(pokemon);

  // Hay muchas formas de utilizar los mapas, pero la forma más sencilla
  // es utilizar la notación de llave cuadrada.
  // Recordar: con $ queremos hacer una interpolación de String y con {} queremos indicar una expresión
  print('Name: ${pokemon['name']}');
  print('Name: ${pokemon['sprites']}');

  print('Back: ${pokemon['sprites'][2]}');
  print('Front: ${pokemon['sprites'][1]}');

  // Esto es complejo de utilizar.
  // Lo que se suele hacer es mapear el objeto para poder utilizar la anotación de punto, es decir
  // pokemon.sprites, pokemon.sprites.back...
}
