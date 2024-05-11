part of 'counter_bloc.dart';

// Podemos indicar los tipos de evento que va a recibir mi bloc.
// Aunque el generador nos configuró Equatable, como no nos va a hacer falta comparar eventos, lo quitamos.
sealed class CounterEvent {
  const CounterEvent();
}

// Los nombres de las clases suelen ponerse en pasado, porque queremos indicar que ya sucedió.
class CounterIncreased extends CounterEvent {

  // Si el counter incrementó, queremos saber en cuánto lo hizo.
  final int valueToIncrease;

  CounterIncreased(this.valueToIncrease);
}
