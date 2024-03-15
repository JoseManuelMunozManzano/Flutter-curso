void main() {
  // La palabra reservada new para crear una clase es innecesaria.
  // final wolverine = new Hero('Logan', 'Regeneración');
  final Hero wolverine = Hero('Logan', 'Regeneración');

  print(wolverine);
  print(wolverine.name);
  print(wolverine.power);
}

// Clase con dos propiedades.
class Hero {
  // Las propiedades tienen que ser inicializadas sin son Non-nullable, por temas de Null Safety.
  // O se puede indicar que son opcionales con el signo de interrogación: String? name;
  String name;
  String power;

  // Constructor

  // Forma clásica Y ERRONEA de constructor
  // Vemos que ocurre un error porque la inicialización se hace DESPUES de la construcción del objeto
  // por lo que ES NULO!!!
  //
  // Hero(String pName, String pPower) {
  //   name = pName;
  //   power = pPower;
  // }

  // Forma típica en Dart de crear el constructor e inicialización correcta.
  //
  // Hero(String pName, String pPower)
  //     : name = pName,
  //       power = pPower;

  // La otra forma CORRECTA de crear un constructor.
  // Se inicializan las propiedades automáticamente.
  // Muy usada.
  Hero(this.name, this.power);
}
