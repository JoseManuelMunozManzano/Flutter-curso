import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/shared/shared.dart';

// Indicar que hay desarrolladores que crean archivos independientes para cada uno de los pasos indicados aquí.

//! 3 - StateNotifierProvider - consume afuera
// Fuente creado con el snippet: stateNotifierProvider
//
// No es obligatorio, pero si recomendable usar `autoDispose`. Esto es porque cuando salgamos
// de la pantalla de Login, por ejemplo al Ingresar y entremos a la app, el usuario trabajará y
// luego puede que cierre sesión. Al volver a la pantalla de Login, si no indicamos autoDispose,
// aparecerán datos informados. Es decir, autoDispose limpia los datos cuando salimos de la pantalla.
//
// Indicar que este paso se mueve arriba porque es al final lo que más se va a usar.
final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>((ref) {
  return RegisterFormNotifier();
}); 

//! 2 - Como implementamos un notifier
// Vamos a trabajar con ChangeNotifierProvider porque queremos dar la máxima flexibilidad a la manera
// como puede cambiar nuestro estado (eventos cuando cambia el email o el password...)
//
// Se ha instalado en VSCode el plugin: Flutter Riverpod Snippets
// Fuente creado con el snippet: stateNotifier
class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  // En el super indicamos la primera instancia del Notifier.
  // Esta creación del estado inicial tiene que ser siempre síncrona.
  RegisterFormNotifier(): super(RegisterFormState());

  onUsernameChange(String value) {
    final newUsername = Username.dirty(value);
    state = state.copyWith(
      username: newUsername,
      isValid: Formz.validate([newUsername, state.email, state.password, state.repeatPassword])
    );
  }

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.username, state.password, state.repeatPassword])
    );
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword, state.username, state.email, state.repeatPassword])
    );
  }

  onRepeatPasswordChange(String value) {
    final newRepeatPassword = RepeatPassword.dirty(password: state.password.value, value: value);
    state = state.copyWith(
      repeatPassword: newRepeatPassword,
      isValid: Formz.validate([newRepeatPassword, state.username, state.email, state.password])
    );
  }

  onFormSubmit() {
    _touchedEveryField();

    if (!state.isValid) return;

    print(state);
  }
  
  // Cuando toquemos el botón Ingresar, queremos que todos los campos se verifiquen
  _touchedEveryField() {

    final username = Username.dirty(state.username.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final repeatPassword = RepeatPassword.dirty(password: state.password.value, value: state.repeatPassword.value);

    state = state.copyWith(
      isFormPosted: true,
      username: username,
      email: email,
      password: password,
      repeatPassword: repeatPassword,
      isValid: Formz.validate([username, email, password, repeatPassword])
    );
  }
}

//! 1 - State del provider
// Hay gente que extiende de Equatable, porque es posible usarlo en Provider, para no redibujar
// los cambios cuando los datos del objeto no cambian.
//
// Indicar que este paso se mueve al final porque es lo que menos voy a usar.
class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Username username;
  final Email email;
  final Password password;
  final RepeatPassword repeatPassword;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.repeatPassword = const RepeatPassword.pure(),
  });

  // Para crear nuevos estados basados en el estado actual
  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Username? username,
    Email? email,
    Password? password,
    RepeatPassword? repeatPassword,
  }) => RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    username: username ?? this.username,
    email: email ?? this.email,
    password: password ?? this.password,
    repeatPassword: repeatPassword ?? this.repeatPassword
  );

  @override
  String toString() {
    return '''
  RegisterFormState:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    isValid: $isValid
    username: $username
    email: $email
    password: $password
    repeatPassword: $repeatPassword
''';
  }
}
