import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/counter_cubit/counter_cubit.dart';

class CubitCounterScreen extends StatelessWidget {
  const CubitCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        // BlocProvider necesita la propiedad create y va a regresar la instancia de
        // nuestro CounterCubit()
        create: (_) => CounterCubit(),
        child: const _CubitCounterView());
  }
}

class _CubitCounterView extends StatelessWidget {
  const _CubitCounterView();

  @override
  Widget build(BuildContext context) {

    // Hay 3 maneras de acceder a los valores del estado (la tercera se ve más adelante).
    // 1. Manera tradicional por la que se escuchan los cambios que tiene el state, parecido a Riverpod.
    // Con watch(), cada vez que se emita un nuevo estado se va a volver a redibujar.
    final counterState = context.watch<CounterCubit>().state;

    void increaseCounterBy(BuildContext context, [int value = 1]) {
      context.read<CounterCubit>().increaseBy(value);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cubit Counter: ${counterState.transactionCount}'),
        actions: [
          IconButton(
            onPressed: () => context.read<CounterCubit>().reset(),
            icon: const Icon(Icons.refresh_outlined)
          )
        ],
      ),
      // 2. Usando un BlocBuilder solo en el sitio que necesitamos.
      //    Se ve como mucho código pero es muy eficiente.
      body: Center(child: BlocBuilder<CounterCubit, CounterState>(
        // Hay una manera de evitar tener que hacer estas condiciones (estas condiciones hacen
        // más eficiente el builder) si el estado no cambia.
        // buildWhen: (previous, current) => current.counter != previous.counter,
        builder: (context, state) {
          print('counter cambió');
          return Text('Counter value: ${state.counter}');
        },
      )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            // Este heroTag es porque, cuando tenemos más de un FloatingActionButton,
            // tenemos que indicarle a Flutter cual es el que se anima por defecto
            // entre Scaffolds.
            heroTag: '1',
            child: const Text('+3'),
            onPressed: () => increaseCounterBy(context, 3)
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            heroTag: '2',
            child: const Text('+2'),
            onPressed: () => increaseCounterBy(context, 2)
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            heroTag: '3',
            child: const Text('+1'),
            onPressed: () => increaseCounterBy(context)
          ),
        ],
      ),
    );
  }
}
