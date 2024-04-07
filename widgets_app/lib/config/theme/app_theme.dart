// Importamos paquete de material usando el snippet impm
import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent,
];

class AppTheme {

  final int selectedColor;
  final bool isDarkMode;

  // Nos aseguramos, usando assert, de que ningún programador de mi equipo llame
  // intentando asignar un color que no esté en la lista de colores.
  // En assert indicamos lo que se tiene que cumplir, y que pasa si no se cumple.
  AppTheme({
    this.selectedColor = 0,
    this.isDarkMode = false,
  }): assert(selectedColor >= 0, 'Selected color must be greater than 0'),
      assert(selectedColor < colorList.length, 
        'Selected color must be less or equal than ${colorList.length - 1}');

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,   // esto ya no haría falta
    // Modo oscuro o brillante
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
    colorSchemeSeed: colorList[selectedColor],
    // Si tengo muchos appBar y quiero que todos tengan el mismo alineado
    appBarTheme: const AppBarTheme(
      centerTitle: false,
    )
  );

  // FORMA DE CAMBIAR VARIABLES FINALES DE UNA CLASE.
  // 
  // La idea de este método es regresar una nueva instancia de AppTheme.  
  // La idea es hacer una copia del tema actual (instacia) que fluirá por toda la aplicación.
  // To-do lo que se pida será opcional.
  // Forma de uso, por ejemplo en main.dart
  //   ThemeData.dark().copyWith( incluir aquí las opciones que quiero cambiar);
  AppTheme copyWith({
    int? selectedColor,
    bool? isDarkMode,
  }) => AppTheme(
    // Si no me mandan nada, utilizo el valor de la instancia anterior.
    selectedColor: selectedColor ?? this.selectedColor,
    isDarkMode: isDarkMode ?? this.isDarkMode,
  );
}
