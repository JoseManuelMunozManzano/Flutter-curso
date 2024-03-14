void main() {
  //? TIPOS BASICOS

  // Recomendación para trabajar con o sin final.
  // Indicar siempre final. Si más adelante en el código se cambia el valor, Dart indicará que hay que quitar final.
  final String pokemon = 'Ditto';

  //? int -> entero sin decimales.
  final int hp = 100;

  // Declarado de esta manera:
  // bool? isAlive;
  // isAlive puede tener 3 valores: nulo, true, false
  final bool isAlive = true;

  //? List
  // Si no se indica el tipo de dato, como en este caso, Dart lo infiere por nosotros.
  final abilities = ['impostor'];

  // Otras formas de definir un listado de Strings (la segunda es una muy usada)
  //
  // final abilities = <String>['impostor'];
  // final List<String> abilities = ['impostor'];
  // final List<String> abilities = <String>['impostor'];

  final sprites = <String>['ditto/front.png', 'ditto/back.png'];

  //? El tipo de datos dynamic es especial.
  // Significa que puede ser cualquier tipo de dato.
  // dynamic por defecto es null:   dynamic == null   y hay que hacer algún tipo de evaluación de null safety.
  // No tiene sentido indicar dynamic? porque dynamic siempre podría venir nulo.
  // Debemos intentar NO usarlo hasta cuando sea posible.
  // Tenemos que encontrar un balance entre cuándo usar dynamic y cuando no.
  // Es útil usarlo cuando recibimos un map, dada una request a una API, para no tener que mapear todas las
  // posibles respuestas.
  //
  // Cualquier valor es permitido en dynamic.
  dynamic errorMessage = 'Hola';
  errorMessage = true;
  errorMessage = [1, 2, 3, 4, 5, 6];
  errorMessage = {1, 2, 3, 4, 5, 6};
  errorMessage = () => true;
  errorMessage = null;

// print multilinea con tres comillas dobles
  print("""
  $pokemon
  $hp
  $isAlive
  $abilities
  $sprites
  $errorMessage
  """);
}
