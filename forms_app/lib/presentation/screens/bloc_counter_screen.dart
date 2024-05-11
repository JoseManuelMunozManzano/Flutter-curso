import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/counter_bloc/counter_bloc.dart';


class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // No olvidar que tenemos que envolver los Widgets en un BlocProvider
    // para tener acceso a la instancia de CounterBloc.
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: const BlocCounterView()
    );
  }
}

class BlocCounterView extends StatelessWidget {
  const BlocCounterView({
    super.key,
  });

  void increaseCounterBy(BuildContext context, [int value = 1]) {
    // Con add() disparamos un evento.
    // Forma "normal" de llamar
    //
    // context.read<CounterBloc>().add(CounterIncreased(value));

    // Pero, si hemos centralizado la creación de eventos en counter_bloc.dart, entonces llamamos así:
    context.read<CounterBloc>().increaseBy(value);
  }

  void resetCounter(BuildContext context) {
    // Forma "normal" de llamar
    // context.read<CounterBloc>().add(CounterReset());

    // Pero, si hemos centralizado la creación de eventos en counter_bloc.dart, entonces llamamos así:
    context.read<CounterBloc>().resetCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.select((CounterBloc bloc) => Text('Bloc Counter ${bloc.state.transactionCount}')),
        actions: [
          IconButton(
            onPressed: () => resetCounter(context),
            icon: const Icon(Icons.refresh_outlined)
          )
        ],
      ),
      body: Center(
        // Para leer el valor de nuestro BLoC podemos usar el select(), tal y como hicimos con Cubit.
        // Y funcionan las 3 maneras que vimos en Cubit (ver cubit_counter_screen.dart)
        child: context.select((CounterBloc counterBloc) => Text('Counter value: ${counterBloc.state.counter}'))
      ),
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
