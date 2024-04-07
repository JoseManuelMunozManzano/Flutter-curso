// Estado para manejar tema oscuro
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

final isDarkModeProvider = StateProvider<bool>((ref) => false);

// Listado de colores inmutable.
// En todos los lugares donde se use ref voy a poder acceder a este colorListProvider.
final colorListProvider = Provider((ref) => colorList);
