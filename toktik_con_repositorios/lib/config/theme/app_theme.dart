import 'package:flutter/material.dart';

class AppTheme {

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,   // Esto realmente no hace falta ya
    brightness: Brightness.dark,
  );
}
