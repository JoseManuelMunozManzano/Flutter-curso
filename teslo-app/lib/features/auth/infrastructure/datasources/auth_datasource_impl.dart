import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';


class AuthDataSourceImpl extends AuthDataSource {

  // No lo vamos a hacer, pero podríamos crear un patrón adaptador para envolver el paquete dio
  // y que solo usemos ese patrón adaptador para no usar dio en todos los elementos.
  // Esto sería para evitar tener que hacer muchos cambios si más adelante queremos cambiarlo por https.
  final dio = Dio(
    BaseOptions(baseUrl: Environment.apiUrl)
  );
    
  @override
  Future<User> checkAuthStatus(String token) async {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  // Usando clean architecture no solo puede regresar un User, también un error personalizado.
  // Nos creamos clases de errores personalizados.
  @override
  Future<User> login(String email, String password) async {
    
    try {
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password
      });
      
      final user = UserMapper.userJsonToEntity(response.data);
      return user;

    // Gestión de errores más procesados
    } on DioException catch(e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(e.response?.data['message'] ?? 'Credenciales incorrectas');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexión a Internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) async {
    // TODO: implement register
    throw UnimplementedError();
  }

}
