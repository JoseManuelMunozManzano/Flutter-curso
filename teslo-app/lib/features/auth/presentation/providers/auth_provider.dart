// Este Provider nos va a permitir mantener el estado de la autenticación de manera global.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/key_value_storage_service.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/key_value_storage_service_impl.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {

  // Aquí tengo los casos de uso.
  // Si el día de mañana cambia el datasource (que para la autenticación es probablemente lo único
  // que podría cambiar) todo lo demás quedaría sin cambios.
  final authRepository = AuthRepositoryImpl();

  final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService
  ); 
});

class AuthNotifier extends StateNotifier<AuthState> {

  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  // No hace falta mandar nada a AuthState porque todos los atributos tienen valores por defecto.
  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService
  }): super(AuthState());

  // Estos tres métodos terminan delegando el llamado al repositorio.
  // Por eso, en authProvider (arriba) lo ponemos como atributo.
  Future<void> loginUser(String email, String password) async {
    // Ralentizamos esto de manera intencional
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);

    // Mejoramos la gestión de los errores
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error no controlado');
    }
  }

  Future<void> registerUser(String email, String password, String fullName) async {
    // Ralentizamos esto de manera intencional
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.register(email, password, fullName);
      _setLoggedUser(user);

      // Mejoramos la gestión de los errores
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error no controlado');
    }
  }

  void checkAuthStatus() async {

  }

  void _setLoggedUser(User user) async {

    // Guardamos el token físicamente
    await keyValueStorageService.setKeyValue('token', user.token);

    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  Future<void> logout([String? errorMessage]) async {
    
    // Limpiar token
    await keyValueStorageService.removeKey('token');

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage
    );
  }
}

enum AuthStatus {checking, authenticated, notAuthenticated}

class AuthState {
  
  final AuthStatus authStatus;  
  final User? user; // Opcional porque cuando creamos el estado no viene
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,    // Si no se indica nada ya es null
    this.errorMessage = ''
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage
  );

}
