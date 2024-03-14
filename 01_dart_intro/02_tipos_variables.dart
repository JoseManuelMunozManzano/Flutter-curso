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

// print multilinea con tres comillas dobles
  print("""
  $pokemon
  $hp
  $isAlive
  $abilities
  $sprites
  """);
}
