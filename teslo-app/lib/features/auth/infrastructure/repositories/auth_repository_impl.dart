import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';

class AuthRepositoryImpl extends AuthRepository {
  
  final AuthDataSource dataSource;

  // Como estamos seguros de que no va a cambiar el dataSource lo hacemos así.
  // Indicamos que si hay dataSource lo coja.
  // Si no hay la crea.
  AuthRepositoryImpl(
    AuthDataSource? dataSource
  ) : dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return dataSource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    return dataSource.register(email, password, fullName);
  }

}
