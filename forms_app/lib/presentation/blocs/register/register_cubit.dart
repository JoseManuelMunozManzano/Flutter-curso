import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forms_app/infrastructure/inputs/inputs.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void onSubmit() {
    // Queremos poder saber que un estado ya no es pure, para que, si pulso Submit,
    // me aparezcan los mensajes de error de las validaciones. Cambiamos a un estado nuevo
    // e indicamos que las propiedades ya son dirty y se valida de nuevo.
    emit(
      state.copyWith(
        formStatus: FormStatus.validating,
        username: Username.dirty(state.username.value),
        password: Password.dirty(state.password.value),

        isValid: Formz.validate([
          state.username,
          // TODO: state.email,
          state.password,
        ]),
      )
    );

    print('Cubit Submit: $state');
  }

  // Nos definimos métodos para cuando cambien el username, email y password obtener los valores en el estado.
  void usernameChanged(String value) {
    final username = Username.dirty(value);

    // Cuando el valor cambia, basado en Formz, podemos validar si el formulario es válido.
    // Pasamos un array con todos los inputs que tengamos definidos.
    emit(state.copyWith(username: username, isValid: Formz.validate([username, state.password])));
  }

  void emailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);

    emit(state.copyWith(password: password, isValid: Formz.validate([password, state.username])));
  }

}
