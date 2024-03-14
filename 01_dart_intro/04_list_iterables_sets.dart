void main() {
  //? List
  // Datos entre corchetes
  // Las listas tienen sus métodos y propiedades, a las que accedemos con el punto
  final numbers = [1, 2, 3, 4, 5, 5, 5, 6, 7, 8, 9, 9, 10];

  print('List original: $numbers');
  print('Length: ${numbers.length}');
  print('Index 0: ${numbers[0]}');
  print('First: ${numbers.first}');
  print('Last: ${numbers.last}');

  // Reversed nos devuelve los valores entre paréntesis en vez de entre llaves cuadradas.
  // ¿Y eso? Es un Iterable
  print('Reversed: ${numbers.reversed}');

  // El where es un método que tienen los listados y que nos permite aplicar un filtro.
  // En este ejemplo se filtrarán todos los números que no sean mayor que 5.
  // De nuevo, devuelve un Iterable.
  // NOTA: El int no haría falta, pero se indica por temas de legibilidad.
  final numbersGreaterThan5 = numbers.where((int num) {
    return num > 5;
  });
  print('>5 iterable: $numbersGreaterThan5');

  // Pero podemos devolverlo como un Set para eliminar duplicados
  print('>5 set: ${numbersGreaterThan5.toSet()}');

  //? Iterable
  // Datos entre paréntesis
  // Es una colección de elementos que se puede leer de manera secuencial.
  final reversedNumbers = numbers.reversed;
  print('Iterable: $reversedNumbers');

  // ¿Qué podemos hacer con ellos?
  // Podemos recuperar la List
  print('List: ${reversedNumbers.toList()}');
  // Podemos recuperar un Set
  print('List: ${reversedNumbers.toSet()}');

  //? Set
  // Datos entre llaves
  // Un Set se diferencia de una lista en que no contiene datos duplicados.
  print('List: ${reversedNumbers.toSet()}');

  // Cosas que se pueden hacer
  // Obtener una lista sin duplicados de una lista con datos duplicados
  // NOTA: Hay otra forma más fácil de hacer esto.
  print('List original without duplicates: ${numbers.toSet().toList()}');
}
