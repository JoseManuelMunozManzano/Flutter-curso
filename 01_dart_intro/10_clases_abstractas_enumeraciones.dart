void main() {
  final windPlant = WindPlant(initialEnergy: 100);

  print('wind: ${chargePhone(windPlant)}');
}

enum PlantType { nuclear, wind, water }

abstract class EnergyPlant {
  double energyLeft;
  PlantType type;

  EnergyPlant({required this.energyLeft, required this.type});

  // Mucha gente implementa el método solo con la línea de excepción para que,
  // si se manda llamar, lance la excepción y sepamos que no se ha implementado.
  // Esto ayuda a la compatibilidad.
  //
  // void consumeEnergy(double amount) {
  //   throw UnimplementedError();
  // }

  // Métodos sin implementar.
  void consumeEnergy(double amount);
}

// extends o implements
// - Con extends indicamos que heredamos de otra clase.
//   En este caso heredamos las propiedades, el constructor y el método, que tendremos que implementar.
//   Como el constructor de la clase abstracta espera dos argumentos, tendremos que llamarlo también.
class WindPlant extends EnergyPlant {
  // Si el constructor del padre fuera con nombre, sería super.nombre
  WindPlant({required double initialEnergy})
      : super(energyLeft: initialEnergy, type: PlantType.wind);

  @override
  void consumeEnergy(double amount) {
    energyLeft -= amount;
  }
}

// ¿Por qué crear una clase abstracta si podría haber creado directamente la clase WindPlant?
// Se hace porque podemos crear métodos, funciones o cualquier otro tipo de estructura en la que no
// esperamos una WindPlant, sino cualquier EnergyPlant que exista.
// 
// La idea es aplicar el principio de inversión de dependencia.
// Si tenemos nuevas plantas de energía no tenemos que tocar este método, se puede usar tal cual por
// esa nueva planta de energía, ya que extiende o implementa EnergyPlant.
double chargePhone(EnergyPlant plant) {
  if (plant.energyLeft < 10) {
    throw Exception('Not enough energy');
  }

  return plant.energyLeft - 10;
}
