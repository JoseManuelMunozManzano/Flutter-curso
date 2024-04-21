import 'dart:ui';

import 'package:flutter/material.dart';

// Se crea esta clase personalizada para que el scroll funcione también en web usando el ratón.
class CustomScrollBehavior extends MaterialScrollBehavior {

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
