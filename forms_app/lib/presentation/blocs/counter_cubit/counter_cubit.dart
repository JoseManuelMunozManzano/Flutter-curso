import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';

// CounterCubit es una especie de manejador (o provider) y tiene acceso al state,
// que es la instancia de nuestra clase CounterState
class CounterCubit extends Cubit<CounterState> {
  // Damos un valor inicial para que no sea vea con valor 0.
  CounterCubit() : super(CounterState(counter: 5));

  // Podemos tener propiedades y métodos que no están enlazados al estado.
  // Podríamos, por ejemplo, recibir información de otro Cubit.
  // Emiten nuevos estados.

  void increaseBy(int value) {
    // Emitir un nuevo estado usando nuestro copyWith() de counter_state.dart.
    // Recordar que, al ser opcionales, no tenemos obligatoriedad de mandar alguna
    // de las propiedades.
    emit(state.copyWith(
      counter: state.counter + value,
      transactionCount: state.transactionCount + 1,
    ));
  }

  void reset(int value) {
    emit(state.copyWith(
      counter: 0
    ));
  }
}
