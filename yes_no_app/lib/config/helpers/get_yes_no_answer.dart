import 'package:dio/dio.dart';
import 'package:yes_no_app/domain/entities/message.dart';

// Aunque se puede hacer una petición HTTP directamente con Dart, es necesario mucho código.
// Al final vamos a acabar usando uno de dos paquetes:
//  http:  https://pub.dev/packages/http
//  dio:   https://pub.dev/packages/dio
// En este proyecto trabajamos con dio
class GetYesNoAnswer {
  // Con Dio podemos usar las BaseOptions, que nos permite indicar la url, headers y muchísimas más cosas.
  // final _dio = Dio(BaseOptions(
  //   baseUrl:
  // ));

  final _dio = Dio();

  Future<Message> getAnswer() async {
    final response = await _dio.get('https://yesno.wtf/api');

    return Message(
      text: response.data['answer'],
      fromWho: FromWho.hers,
      imageUrl: response.data['image'],
    );
  }
}
