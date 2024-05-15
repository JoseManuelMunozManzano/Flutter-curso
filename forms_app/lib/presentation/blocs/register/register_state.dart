part of 'register_cubit.dart';

// Estados finales posibles del formulario.
// validating es por si estamos esperando a que se resuelva una validación asíncrona.
enum FormStatus { invalid, valid, validating, posting }

// Uso de Formz
// Lo que queremos resolver:
// En lugar de manejar simples Strings en `register_state.dart` lo quiero manejar como un objeto.
//
// Por ejemplo, tenemos un objeto personalizado Username (ver username.dart), que tiene su instrucción de validación,
// su instrucción de errores personalizados... con la idea de que, donde vayamos a utilizar este
// objeto personalizado, pueda utilizar el mismo tipo de dato y todos tendrán las mismas validaciones,
// controles y funcionamiento.
//
// También se añade al formulario el campo isValid
class RegisterFormState extends Equatable {
  final FormStatus formStatus;
  final bool isValid;
  final Username username;
  final String email;
  final String password;

  const RegisterFormState({
    this.formStatus = FormStatus.invalid,
    this.isValid = false,
    this.username = const Username.pure(),
    this.email = '',
    this.password = '',
  });

  // Para poder emitir un nuevo estado
  RegisterFormState copyWith({
    FormStatus? formStatus,
    bool? isValid,
    Username? username,
    String? email,
    String? password,
  }) =>
      RegisterFormState(
        formStatus: formStatus ?? this.formStatus,
        isValid: isValid ?? this.isValid,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  // En qué momento el estado es igual al anterior para no tener que redibujar nada.
  @override
  List<Object> get props => [formStatus, isValid, username, email, password];
}
