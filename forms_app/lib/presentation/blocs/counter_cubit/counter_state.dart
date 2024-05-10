part of 'counter_cubit.dart';

// Como queremos que luzca nuestro estado.
class CounterState {
  final int counter;
  // El número de veces que ha cambiado el estado (no se tiene en cuenta el reset).
  final int transactionCount;

  CounterState({
    this.counter = 0,
    this.transactionCount = 0,
  });

  // Para emitir una copia del estado, ya que un nuevo
  // estado será una copia del estado actual.
  copyWith({
    int? counter,
    int? transactionCount,
  }) => CounterState(
    counter: counter ?? this.counter,
    transactionCount: transactionCount ?? this.transactionCount,
  );

}
