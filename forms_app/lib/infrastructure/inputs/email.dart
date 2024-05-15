import 'package:formz/formz.dart';

// Define input validation errors
enum EmailError { empty, format }

// Extend FormzInput and provide the input type and error type.
class Email extends FormzInput<String, EmailError> {

  // Para poder reutilizar la expresión regular en otras partes de mi aplicación.
  static final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  // Call super.pure to represent an unmodified form input.
  // Este es el valor inicial.
  const Email.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  // La forma como quiero que cambie el valor cuando es alterado por el usuario.
  // Definimos los parámetros como posicionales y obligatorios.
  const Email.dirty(super.value) : super.dirty();

  // getter para obtener el errorMessage para el formulario.
  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == EmailError.empty) return 'El campo es requerido';
    if (displayError == EmailError.format) return 'No tiene formato de correo electrónico';

    return null;
  }

  // Override validator to handle validating a given input value.
  // Establecemos la forma como vamos a hacer nuestras validaciones.
  // Si devuelve null es porque pasa todas las validaciones. Es mejor dejarlo explícito.
  @override
  EmailError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return EmailError.empty;
    // Usando expresión regular
    if (!emailRegExp.hasMatch(value)) return EmailError.format;

    return null;
  }
}
