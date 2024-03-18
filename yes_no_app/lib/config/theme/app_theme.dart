import 'package:flutter/material.dart';

// Flutter no aceptar el código de color en hexadecimal.
// Pero existe este truco: Indicar 0xFF seguido del color en hexadecimal.
// Este es el color personalizado.
// Con _ hacemos la variable privada.
const Color _customColor = Color(0xFF5c11d4);

const List<Color> _colorThemes = [
  _customColor,
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink,
];

class AppTheme {
  final int selectedColor;

  // Aserción para indicar el rango permitido en selectedColor
  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0 && selectedColor < _colorThemes.length,
            'Colors must be between 0 an ${_colorThemes.length}');

  // El tema lo montamos de esta manera porque podemos recibir en tiempo de ejecución alguna variable,
  // y la podemos usar para regresar el tema de manera dinámica.
  ThemeData theme() {
    return ThemeData(
      colorSchemeSeed: _colorThemes[selectedColor],
      // brightness: Brightness.dark,
    );
  }
}
