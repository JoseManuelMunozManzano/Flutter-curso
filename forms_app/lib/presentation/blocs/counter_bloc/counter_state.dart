part of 'counter_bloc.dart';

// Es muy común que tengamos varios states permitidos, por ejemplo:
// - AuthenticatedState
// - UnAuthenticatedState
// - CheckingAuthenticationState
// ...
// Aquí lo vamos a trabajar de forma más sencilla, con un solo state.

class CounterState extends Equatable {

  final int counter;
  final int transactionCount;

  const CounterState({
    this.counter = 10,
    this.transactionCount = 0
  });

  CounterState copyWith({
    int? counter,
    int? transactionCount
    }) => CounterState(
      counter: counter ?? this.counter,
      transactionCount: transactionCount ?? this.transactionCount,
    );
  
  // Para poder comparar este estado con otro estado.
  @override
  List<Object> get props => [counter, transactionCount];
}
