// Se borra todo el código generado automáticamente.
// Usado snippet mateapp para crear la estructura del proyecto.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/config/theme/app_theme.dart';
import 'package:toktik/presentation/providers/discover_provider.dart';
import 'package:toktik/presentation/screens/discover/discover_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          // Por defecto, el comportamiento natural de los Change NotifierProvider es que,
          // hasta que no sea necesario, Provider NO creará la instancia.
          // Es decir, por defecto son cargados de manera perezosa.
          //
          // Indicando la propiedad lazy en false, evitamos esa carga perezosa y, por tanto,
          // se crea la intancia.
          lazy: false,
          create: (_) => DiscoverProvider()..loadNextPage()
        )
      ],
      child: MaterialApp(
        title: 'TokTik',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
        home: const DiscoverScreen()
      ),
    );
  }
}
