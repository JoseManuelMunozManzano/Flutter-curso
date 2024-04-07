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
import 'package:widgets_app/presentation/providers/theme_provider.dart';

class CounterScreen extends ConsumerWidget {

  static const name = 'counter_screen';

  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // Cada vez que counterProvider cambia, vamos a tener el nuevo valor y Flutter
    // va a redibujar ese Widget donde sea necesario.
    final int clickCounter = ref.watch(counterProvider);

    final bool isDarkMode = ref.watch(isDarkModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Screen'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
            onPressed: () {
              ref.read(isDarkModeProvider.notifier).update((state) => !state);
            },
          )
        ],
      ),

      // ignore: prefer_const_constructors
      body: Center(
        child: Text('Valor: $clickCounter', style: Theme.of(context).textTheme.titleLarge,),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // IMPORTANTE: No se debe usar el watch() en métodos ya que NO se va a redibujar nada.
          // Se usa read()
          // Hay varias maneras de hacer un cambio en un StateProvider:
          
          // Forma 1: se indica notifier, para notificar ese cambio, y ya tenemos acceso
          // al state, que se puede transformar. En este caso sumamos 1.
          // Si no se indica el notifier (ni estate), estamos accediendo al valor del provider en ese momento.
          ref.read(counterProvider.notifier).state++;
          
          // Forma 2: puede ser conveniente cuando necesitamos el estado.
          // Tenemos el valor actual del estado y se le regresa el nuevo estado.
          //
          // ref.read(counterProvider.notifier).update((state) => state + 1);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
