import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {

  // Este es nuestro constructor, y en el super inicializa el estado.
  // Luego tenemos el cuerpo del constructor, donde definimos un handler (manejador) de un tipo CounterEvent,
  // ya que solo vamos a poder recibir eventos que extiendan de CounterEvent.
  // En nuestro fichero counter_event.dart tenemos definido el evento CounterIncreased y definimos
  // lo que ocurre cuando este sea incrementado, esto es, emitimos un nuevo estado.
  CounterBloc() : super(const CounterState()) {

    on<CounterIncreased>((event, emit) {
      emit(state.copyWith(
        counter: state.counter + event.valueToIncrease,
        transactionCount: state.transactionCount + 1
      ));
    });
    
  }
}
