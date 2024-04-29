import 'package:flutter/material.dart';

class SearchMovieDelegate extends SearchDelegate {

  // Implementar esta función es opcional
  // Sirve para cambiar el texto Search por el deseado
  @override
  String get searchFieldLabel => 'Buscar película';

  // Implementar estas 4 funciones es obligatorio.

  // Para construir las acciones (iconos) en la parte derecha
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      const Text('buildActions')
    ];
  }

  // Para construir un icono o lo que sea en la parte izquierda
  @override
  Widget? buildLeading(BuildContext context) {
    return const Text('buildLeading');
  }

  // Los resultados que van a aparecer cuando la persona pulse Intro
  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  // Mientras la persona va escribiendo, qué queremos hacer
  @override
  Widget buildSuggestions(BuildContext context) {
    return const Text('buildSuggestions');
  }
  
}
