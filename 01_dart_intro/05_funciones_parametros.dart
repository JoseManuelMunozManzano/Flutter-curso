void main() {
  print(greetEveryone());

  print('Suma: ${addTwoNumbers(10, 20)}');

  print('Suma Lambda: ${addTwoNumbersLambda(1, 28)}');
}

// Si la función retorna un valor, pero el tipo de dato devuelto no se indica en la firma de
// la función, entonces el tipo retornado es dynamic. Esto hay que evitarlo para no perder
// el type safety.
String greetEveryone() {
  return 'Hello everyone!';
}

// Funciones de flecha o lambda functions
// Tras la flecha tenemos que indicar lo que se devuelve, es decir, no se puede crear
// un cuerpo de una función con llaves.
// En ese caso, deberemos usar la función tradicional.
String greetEveryoneLambda() => 'Hello everyone!';

// De nuevo, si en los argumentos no se indica tipo de dato, estos serán dynamic.
// Aunque se indica que se devuelve un int, si los parámetros enviados son un entero
// y un String, esta función fallará.
// De nuevo, esto será difícil de depurar porque sin tipado estricto, perdemos el type safety.
// Es por esto que debemos indicar el tipado estricto de los argumentos.
int addTwoNumbers(int a, int b) {
  return a + b;
}

int addTwoNumbersLambda(int a, int b) => a + b;

// Haciendo opcional un argumento
//
// Forma 1
// Se hace poniendo el argumento entre corchetes e indicando el signo de interrogación al tipo de dato.
int addTwoNumbersOptional1(int a, [int? b]) {
  // Si b es opcional, la suma de a + b es potencialmente insegura, porque b puede ser null.
  // Posibilidades para corregir esto:

  // Operadores de valores nulos.
  // Indicar un valor por defecto si b es nulo.
  // b = b ?? 0;
  // O su forma corta:
  b ??= 0;

  return a + b;
}

// Haciendo opcional un argumento
//
// Forma 2
// Se hace poniendo el argumento entre corchetes e indicando el valor por defecto para cuando el valor de b es null.
// Es una forma más limpia y fácil de utilizar.
int addTwoNumbersOptional2(int a, [int b = 0]) {
  return a + b;
}
