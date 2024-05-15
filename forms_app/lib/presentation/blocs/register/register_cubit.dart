import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forms_app/infrastructure/inputs/inputs.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void onSubmit() {
    print('Cubit Submit: $state');
  }

  // Nos definimos métodos para cuando cambien el username, email y password obtener los valores en el estado.
  void usernameChanged(String value) {
    final username = Username.dirty(value);

    // Cuando el valor cambia, basado en Formz, podemos validar si el formulario es válido.
    // Pasamos un array con todos los inputs que tengamos definidos.
    emit(state.copyWith(username: username, isValid: Formz.validate([username])));
  }

  void emailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value));
  }

}
