import 'package:dio/dio.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/infrastructure/models/yes_no_model.dart';

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

    final yesNoModel = YesNoModel.fromJsonMap(response.data);

    // Podemos usar notación de punto.
    //
    // Esto ya no hace falta porque usamos la creación de la instancia del archivo yes_no_model.dart
    // return Message(
    //   text: yesNoModel.answer,
    //   fromWho: FromWho.hers,
    //   imageUrl: yesNoModel.image,
    // );

    return yesNoModel.toMessageEntity();
  }
}
