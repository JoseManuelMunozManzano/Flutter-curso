// Constructores por nombre
// Es una forma de crear instancias con diferentes tipos de argumentos.
// Podemos tener varios constructores y, dependiendo de sus argumentos, podremos crear instancias
// basadas en esos argumentos.

void main() {
  // Imaginemos que recibimos un objeto con la respuesta de una petición http.
  // Ojo porque algún valor podría venir en null.
  // dynamic si es permitido en objetos que provienen de respuestas http, sobre todo
  // si estos objetos son muy grandes.
  final Map<String, dynamic> rawJson = {
    'name': 'Spiderman',
    'power': 'Trepar paredes',
    'isAlive': true
  };

  // Forma 1 de usar en constructor (fea)
  // NOTA: Hemos indicado isAlive2 en vez de isAlive para dar a entender que esta forma es proclive
  // a errores. Esto daría un error en tiempo de ejecución.
  // Se ha indicado también ?? false para que si el valor es null por defecto indique false.
  //
  // final spiderman = Hero(
  //     isAlive: rawJson['isAlive2'] ?? false,
  //     power: 'Money',
  //     name: 'Tony Stark');

  // Forma 2 de usar en constructor
  // Usando el constructor por nombre creado.
  // Se creará la instancia basada en el json que le mandamos.
  final spiderman = Hero.fromJson(rawJson);

  print(spiderman);

  final ironman = Hero(isAlive: false, power: 'Money', name: 'Tony Stark');

  print(ironman);
}

class Hero {
  String name;
  String power;
  bool isAlive;

  Hero({
    required this.name,
    required this.power,
    required this.isAlive,
  });

  // Constructor por nombre
  // Se indica el nombre del constructor, un punto y el nombre que le queremos dar.
  // En este caso se llama fromJson
  // Indicar que se usa ?? para indicar valor por defecto si no viene alguno de los valores.
  // También nos podemos equivocar indicando isAlive2 en vez de isAlive, pero 
  // solo nos podemos equivocar una vez, aquí en el constructor.
  Hero.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? 'No name found',
        power = json['power'] ?? 'No power found',
        isAlive = json['isAlive'] ?? 'No isAlive found';

  @override
  String toString() {
    return '$name, $power, isAlive: ${isAlive ? 'YES!' : 'Nope'}';
  }
}
