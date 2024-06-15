import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/shared/shared.dart';

// Indicar que hay desarrolladores que crean archivos independientes para cada uno de los pasos indicados aquí.

//! 1 - State del provider
// Hay gente que extiende de Equatable, porque es posible usarlo en Provider, para no redibujar
// los cambios cuando los datos del objeto no cambian.
class LoginFormState {

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure()
  });

  // Para crear nuevos estados basados en el estado actual
  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password
  }) => LoginFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,
  );

  @override
  String toString() {
    return '''
  LoginFormState:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    isValid: $isValid
    email: $email
    password: $password
''';
  }
}

//! 2 - Como implementamos un notifier
// Vamos a trabajar con ChangeNotifierProvider porque queremos dar la máxima flexibilidad a la manera
// como puede cambiar nuestro estado (eventos cuando cambia el email o el password...)
//
// Se ha instalado en VSCode el plugin: Flutter Riverpod Snippets
// Fuente creado con el snippet: stateNotifier
class LoginFormNotifier extends StateNotifier<LoginFormState> {
  // En el super indicamos la primera instancia del Notifier.
  // Esta creación del estado inicial tiene que ser siempre síncrona.
  LoginFormNotifier(): super(LoginFormState());

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.password])
    );
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword, state.email])
    );
  }

  onFormSubmit() {
    _touchedEveryField();

    if (!state.isValid) return;

    print(state);
  }
  
  // Cuando toquemos el botón Ingresar, queremos que todos los campos se verifiquen
  _touchedEveryField() {

    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      isValid: Formz.validate([email, password])
    );
  }
}

//! 3 - StateNotifierProvider - consume afuera
// Fuente creado con el snippet: stateNotifierProvider
//
// No es obligatorio, pero si recomendable usar `autoDispose`. Esto es porque cuando salgamos
// de la pantalla de Login, por ejemplo al Ingresar y entremos a la app, el usuario trabajará y
// luego puede que cierre sesión. Al volver a la pantalla de Login, si no indicamos autoDispose,
// aparecerán datos informados. Es decir, autoDispose limpia los datos cuando salimos de la pantalla.
final LoginFormProvider = StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  return LoginFormNotifier();
}); 
