import 'package:flutter/material.dart';

class AppTheme {

  ThemeData getTheme() {

    const seedColor = Colors.deepPurple;

    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: seedColor,
      // Vamos a estar usando unas listas y un icono en ellas y no queremos poner que es
      // color morado en cada una de ellas.
      // Lo personalizamos aquí (y de hecho podemos personalizar todos los estados de Flutter)
      listTileTheme: const ListTileThemeData(
        iconColor: seedColor
      )
    );
  }
}
