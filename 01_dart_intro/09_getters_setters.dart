void main() {
  final mySquare = Square(side: 10);

  print('área: ${mySquare.calculateArea()}');

  // Usando el setter
  // Este valor indicado lanza una excepción.
  // mySquare.side = -5;

  mySquare.side = 12;

  // La propiedad area no existe, la hemos creado mediante un getter
  print('área: ${mySquare.area}');
}

class Square {
  // Indicando un guión bajo como prefijo del nombre de la propiedad, hacemos private dicha propiedad.
  double _side;

  Square({required double side}) : _side = side;

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
