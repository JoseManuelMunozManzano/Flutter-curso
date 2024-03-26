// To parse this JSON data, do
//
//     final yesNoModel = yesNoModelFromJson(jsonString);

// El objetivo de esta clase es tener todas las propiedades que vienen en la response HTTP.
// Es como crearse una adaptación específica de la respuesta.
//
// Si el API llega a cambiar, SOLO TENGO QUE CAMBIARLO AQUÍ!!!
// En todos los otros archivos vamos a trabajar con nuestra entidad local, Message.

// Al haber comentado las dos sentencias de abajo no necesito este import.
//
// import 'dart:convert';

// Esto es por si recibimos la data como un String. No hace falta.
//
// YesNoModel yesNoModelFromJson(String str) => YesNoModel.fromJson(json.decode(str));

// Teniendo una instancia de nuestro modelo, crea un String. No hace falta.
// Es útil para mandar peticiones HTTP, posteos, actualizaciones...
//
// String yesNoModelToJson(YesNoModel data) => json.encode(data.toJson());

import 'package:yes_no_app/domain/entities/message.dart';

class YesNoModel {
  final String answer;
  final bool forced;
  final String image;

  YesNoModel({
    required this.answer,
    required this.forced,
    required this.image,
  });

  // Venia el nombre fromJson y lo hemos cambiado a fromJsonMap.
  //
  // Una vez creada esta clase, nos falta recibir un mapa y con ese mapa crear una instancia de esta clase.
  // Aquí tenemos para ello este Factory Constructor.
  factory YesNoModel.fromJsonMap(Map<String, dynamic> json) => YesNoModel(
        // Y luego, de este mapa tendríamos que evaluar que propiedades son las que ocupamos.
        // Con esto ya podemos usar notación de punto para evitar equivocarme al escribir.
        answer: json["answer"],
        forced: json["forced"],
        image: json["image"],
      );

  // Tampoco necesito esto, pero lo dejo como referencia.
  Map<String, dynamic> toJson() => {
        "answer": answer,
        "forced": forced,
        "image": image,
      };

  // Puedo utilizar este mismo modelo para crear una instancia de mi Mensaje.
  // Esto es nuevo, no lo genera quicktype.io
  //
  // Más adelante, en futuras aplicaciones, este Mapper no va a estar directamente en este modelo.
  // Se crea un archivo independiente que sea un Mapper, porque todo este código lo generamos
  // de manera automática.
  Message toMessageEntity() => Message(
        text: answerToSpanish(answer),
        fromWho: FromWho.hers,
        imageUrl: image,
      );

  String answerToSpanish(String answer) {
    if (answer == 'yes') return 'Si';
    if (answer == 'maybe') return 'Puede';
    return 'No';
  }
}
