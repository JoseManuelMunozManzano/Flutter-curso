void main() {
  final mySquare = Square(side: 10);

  print('área: ${mySquare.calculateArea()}');

  // Usando el setter
  // Este valor indicado lanza una excepción.
  // mySquare.side = -5;

  mySquare.side = 12;

  // La propiedad area no existe, la hemos creado mediante un getter
  print('área: ${mySquare.area}');

  //? aserciones
  // Esto sigue siendo permitido, aunque es erroneo.
  // Con setter lo tenemos controlado, pero podemos indicar un valor negativo en el constructor.
  // Las aserciones no son más que indicar unas reglas de negocio y se usa mucho en Flutter.
  final mySquare2 = Square(side: -10);
  print('área: ${mySquare2.area}');
}

class Square {
  // Indicando un guión bajo como prefijo del nombre de la propiedad, hacemos private dicha propiedad.
  double _side;

  //? aserciones
  // Para indicar aserciones, se recomienda que vayan primero las aserciones y luego las asignaciones,
  // porque si una aserción no se cumple no sigue ejecutando las siguientes líneas.
  // Conviene indicar el segundo argumento posicional con el mensaje del error, para saber que aserción
  // ha fallado.
  Square({required double side}) 
  : assert(side >= 0, 'side must be >= 0'),
  _side = side;

  // getter
  // Se indica el tipo de retorno, la palabra reservada get, para indicar que es un getter, y luego
  // el nombre de lo que yo quiero que sea visto como una propiedad.
  double get area {
    return _side * _side;
  }

  // setter
  // Se indica la palabra reservada set seguido del nombre del setter lo que yo quiero que sea visto como
  // una propiedad y, entre paréntesis, el tipo y el nombre de los argumentos que estoy esperando.
  set side(double value) {
    print('setting new value $value');

    if (value < 0) throw 'Value must be >= 0';

    _side = value;
  }

  double calculateArea() {
    return _side * _side;
  }
}
