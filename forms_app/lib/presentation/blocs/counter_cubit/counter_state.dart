part of 'counter_cubit.dart';

// Como queremos que luzca nuestro estado.
// Extendemos de Equatable para hacer que un objeto sea igual a otro por valores y no por direcciones
// de memoria.
class CounterState extends Equatable {
  final int counter;
  // El número de veces que ha cambiado el estado (no se tiene en cuenta el reset).
  final int transactionCount;

  const CounterState({
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
  
  // Si sabemos que las propiedades no pueden ser nulas, indicar List<Object>
  // Si pueden haber propiedades nulas, indicar List<Object?>
  //
  // Si el counter y el transactionCount son iguales a otro objeto, se consideran el mismo,
  // es decir, el estado NO habrá cambiado y no se redibujará nada.
  @override
  List<Object> get props => [counter, transactionCount];

}
