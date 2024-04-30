import 'package:flutter_riverpod/flutter_riverpod.dart';

// Por ahora solo manejamos el string
final searchQueryProvider = StateProvider<String>((ref) => '');
