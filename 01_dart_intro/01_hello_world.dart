void main() {
  // Tipo de dato inferido.
  //
  // var myName = 'José Manuel';

  // Tipo de dato inferido y que no puede cambiarse.
  // final se asigna en tiempo de ejecución.
  //
  // final myName = 'José Manuel';

  // Asignación tardía.
  // Estamos diciendo que esta variable tendrá un valor al momento de usarse.
  //
  // late final myName;

  // Tipo de dato constante.
  // const se asigna en tiempo de construcción de aplicación.
  //
  // const myName = 'José Manuel';

  // Uso de tipo de dato String
  //
  String myName = 'José Manuel';

  // Uso de interpolación de Strings: $my_variable
  // Si ejecutamos una expresión aparecerá dentro de llaves: ${1 + 1}
  print('Hola $myName');
  print('Hola ${myName.toUpperCase()}');
  print('Hola ${1 + 1}');
}
