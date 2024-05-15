import 'package:formz/formz.dart';

// Define input validation errors
enum UsernameError { empty, length }

// Extend FormzInput and provide the input type and error type.
class Username extends FormzInput<String, UsernameError> {

  // Call super.pure to represent an unmodified form input.
  // Este es el valor inicial.
  const Username.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  // La forma como quiero que cambie el valor cuando es alterado por el usuario.
  // Definimos los parámetros como posicionales y obligatorios.
  const Username.dirty(super.value) : super.dirty();

  // getter para obtener el errorMessage para el formulario.
  String? get errorMessage {
    if (isValid || isPure) return null;

    // displayError es una propiedad que ya ofrece Formz
    // Por ejemplo: username.displayError.toString() puede valer UsernameError.empty, UsernameError.length y null.
    if (displayError == UsernameError.empty) return 'El campo es requerido';
    if (displayError == UsernameError.length) return 'Mínimo 6 caracteres';

    return null;
  }

  // Override validator to handle validating a given input value.
  // Establecemos la forma como vamos a hacer nuestras validaciones.
  // Si devuelve null es porque pasa todas las validaciones. Es mejor dejarlo explícito.
  @override
  UsernameError? validator(String value) {

    if (value.isEmpty || value.trim().isEmpty) return UsernameError.empty;
    if (value.length < 6) return UsernameError.length;

    return null;
  }
}
