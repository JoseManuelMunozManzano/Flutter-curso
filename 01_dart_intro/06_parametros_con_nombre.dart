void main() {
  // Al llamar a la función, especificareos el nombre del argumento y su valor.
  // Los parámetros opcionales no son obligatorios informarlos.
  //
  // print(greetPerson(name: 'José Manuel'));
  print(greetPerson(name: 'José Manuel', message: 'Hi, '));
}

// Nombres a los parámetros
// Envolver los parámetros entre llaves los hace opcionales y por nombre.
// Para forzar que siempre tengan un valor se han usado dos funcionalidades distintas:
//    - Con message se ha indicado un valor por defecto para cuando valga null.
//    - Con name se ha usado la palabra reservada required, que obliga a que SIEMPRE nos llamen con un valor.
// Los argumentos por nombre se usan muchísimo en Flutter.
String greetPerson({required String name, String message = 'Hola, '}) {
  return '$message $name';
}
