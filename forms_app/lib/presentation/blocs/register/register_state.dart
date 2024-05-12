part of 'register_cubit.dart';

// Estados finales posibles del formulario.
// validating es por si estamos esperando a que se resuelva una validación asíncrona.
enum FormStatus { invalid, valid, validating, posting }

// Vamos a validar el formulario aquí y en register_cubit.dart
// Esto va a tener otros inconvenientes que acabaremos resolviendo, pero luego los veremos.
// Por ahora nos vale.
//
// Lo que queremos resolver:
// En lugar de manejar simples Strings en `register_state.dart` lo quiero manejar como un objeto.
//
// Por ejemplo, tendremos un objeto personalizado username que tendrá su instrucción de validación,
// su instrucción de errores personalizados... con la idea de que, donde vayamos a utilizar este
// objeto personalizado, pueda utilizar el mismo tipo de dato y todos tendrán las mismas validaciones,
// controles y funcionamiento.
// Esto, a la larga, va a llevarnos a tener que crear unos inputs específicos para cada uno de los campos,
// que puede verse como más código, pero que a la larga será más reutilizable tanto en esta como otras
// aplicaciones.
// Este es otro camino para hacer lo que ya tenemos, que tampoco es que esté mal.
// To-do depende de qué necesitamos.
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
  }) =>
      RegisterFormState(
        formStatus: formStatus ?? this.formStatus,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  // En qué momento el estado es igual al anterior para no tener que redibujar nada.
  @override
  List<Object> get props => [formStatus, username, email, password];
}
