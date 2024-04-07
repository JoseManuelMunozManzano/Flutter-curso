// Cuando se trabaja con Riverpod se crean muchos pequeños providers que tienen un estado específico.
// Son más fáciles de mantener y de probar.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Un StateProvider es un proveedor de UN estado de información, como una variable numérica,
// el estado de una clase, tema seleccionado...
final counterProvider = StateProvider((ref) => 5);
