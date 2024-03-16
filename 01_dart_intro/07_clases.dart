void main() {
  // Llamadas correctas para los constructores 2 y 3
  // La palabra reservada new para crear una clase es innecesaria.
  // final wolverine = new Hero('Logan', 'Regeneración');
  //
  // final Hero wolverine = Hero('Logan', 'Regeneración');
  //
  // Llamadas correctas para el constructor 4
  final Hero wolverine = Hero(name: 'Logan', power: 'Regeneración');

  print(wolverine);
  print(wolverine.name);
  print(wolverine.power);

  final Hero pepe = Hero(name: 'Pepe');
  print(pepe);
}

// Clase con dos propiedades.
class Hero {
  // Las propiedades tienen que ser inicializadas sin son Non-nullable, por temas de Null Safety.
  // O se puede indicar que son opcionales con el signo de interrogación: String? name;
  String name;
  String power;

  // Constructor

  // 1. Forma clásica Y ERRONEA de constructor
  // Vemos que ocurre un error porque la inicialización se hace DESPUES de la construcción del objeto
  // por lo que ES NULO!!!
  //
  // Hero(String pName, String pPower) {
  //   name = pName;
  //   power = pPower;
  // }

  // 2. Forma típica en Dart de crear el constructor e inicialización correcta.
  //
  // Hero(String pName, String pPower)
  //     : name = pName,
  //       power = pPower;

  // 3. Otra forma CORRECTA de crear un constructor.
  // Se inicializan las propiedades automáticamente.
  // Muy usada.
  // Hero(this.name, this.power);

  // 4. Otra forma CORRECTA de crear un constructor y la más usada.
  // Los parámetros del constructor son por nombre.
  // Indicamos cuales son los requeridos.
  // NOTA: La llamada a este constructor es diferente. Ver arriba.
  Hero({required this.name, this.power = 'Sin poder'});

  //? Sobreescribiendo un método nativo usando la anotación @override
  // No es obligatorio, pero si es buena práctica usarlo.
  @override
  String toString() {
    return '$name - $power';
  }
}
