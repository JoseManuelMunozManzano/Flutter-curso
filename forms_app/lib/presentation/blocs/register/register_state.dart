part of 'register_cubit.dart';

// Estados finales posibles del formulario.
// validating es por si estamos esperando a que se resuelva una validación asíncrona.
enum FormStatus {invalid, valid, validating, posting}

// Vamos a validar el formulario aquí y en register_cubit.dart
// Esto va a tener otros inconvenientes que acabaremos resolviendo, pero luego los veremos.
// Por ahora nos vale.
class RegisterFormState extends Equatable {

  final FormStatus formStatus;
  final String username;
  final String email;
  final String password;

  const RegisterFormState({
    this.formStatus = FormStatus.invalid,
    this.username = '',
    this.email = '',
    this.password = '',
  });

  // Para poder emitir un nuevo estado
  RegisterFormState copyWith({
    FormStatus? formStatus,
    String? username,
    String? email,
    String? password,
  }) => RegisterFormState(
    formStatus: formStatus ?? this.formStatus,
    username: username ?? this.username,
    email: email ?? this.email,
    password: password ?? this.password,
  );

  // En qué momento el estado es igual al anterior para no tener que redibujar nada.
  @override
  List<Object> get props => [formStatus, username, email, password];
}
