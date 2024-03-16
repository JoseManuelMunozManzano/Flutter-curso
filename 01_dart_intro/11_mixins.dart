// Con mixins podemos tener clases especializadas que implementen específicamente ciertas funcionalidades.
// Es como una funcionalidad extra para nuestras clases.
// Por ejemplo, tenemos mamíferos como un delfín que puede nadar y un murciélago que puede caminar y volar.
// Tenemos aves como el pato que pueden caminar, nadar y volar.
// Y tenemos peces como el pez volador que puede nadar y volar.

//? Clases abstractas
abstract class Animal {
  // Se indica aquí todo lo que los animales tienen en común
}

abstract class Mamifero extends Animal {
  // Solo características específicas de los mamíferos
}

abstract class Ave extends Animal {
  // Solo características específicas de las aves
}

abstract class Pez extends Animal {
  // Solo características específicas de los peces
}

//? Mixins: especializaciones concretas
// NOTA: No hace falta indicar abstract, pero si mixin
abstract mixin class Volador {
  void volar() => print('estoy volando!');
}

abstract mixin class Caminante {
  void caminar() => print('estoy caminando!');
}

abstract mixin class Nadador {
  void nadar() => print('estoy nadando!');
}

// Animales específicos
//   Extienden de la clase abstracta que necesiten.
//   Para usar mixins (especializaciones) se usa la palabra reservada with seguida del nombre del mixin.
class Delfin extends Mamifero with Nadador {}

class Murcielago extends Mamifero with Volador, Caminante {}

class Gato extends Mamifero with Caminante {}

class Paloma extends Ave with Caminante, Volador {}

class Pato extends Ave with Caminante, Nadador, Volador {}

class Tiburon extends Pez with Nadador {}

class PezVolador extends Pez with Nadador, Volador {}

void main() {
  final flipper = Delfin();
  flipper.nadar();

  final batman = Murcielago();
  batman.caminar();
  batman.volar();

  final namor = Pato();
  namor.caminar();
  namor.volar();
  namor.nadar();
}
