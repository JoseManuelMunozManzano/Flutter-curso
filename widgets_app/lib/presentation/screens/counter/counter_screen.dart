// Para usar Riverpod se puede envolver el Widget que va a cambiar con un Widget llamado Consumer,
// que es básicamente un builder, por lo que vamos a tener acceso al builder para construir
// lo que necesitemos.
//
// Pero es muy común convertir el StatelessWidget o StatefulWidget en un Widget especial de
// Riverpod llamado ConsumerWidget, que funciona literalmente igual al StatelessWidget.
// Este Widget nos ofrece acceso a la referencia (WidgetRef) en el método buil() y el provider en
// concreto se especifica, por ejemplo, en ref.watch()

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/counter_provider.dart';

class CounterScreen extends ConsumerWidget {

  static const name = 'counter_screen';

  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // Cada vez que counterProvider cambia, vamos a tener el nuevo valor y Flutter
    // va a redibujar ese Widget donde sea necesario.
    final int clickCounter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Screen'),
      ),

      // ignore: prefer_const_constructors
      body: Center(
        child: Text('Valor: $clickCounter', style: Theme.of(context).textTheme.titleLarge,),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
