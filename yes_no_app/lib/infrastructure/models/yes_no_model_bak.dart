// Fuente sustituido por el generado por https://app.quicktype.io/
//
// El objetivo de esta clase es tener todas las propiedades que vienen en la response HTTP.
// Es como crearse una adaptación específica de la respuesta.
class YesNoModel {
  String answer;
  bool forced;
  String image;

  YesNoModel({
    required this.answer,
    required this.forced,
    required this.image,
  });

  // Una vez creada esta clase, nos falta recibir un mapa y con ese mapa crear una instancia de esta clase.
  // Aquí tenemos para ello este Factory Constructor.
  factory YesNoModel.fromJsonMap(Map<String, dynamic> json) => YesNoModel(
      // Y luego, de este mapa tendríamos que evaluar que propiedades son las que ocupamos.
      // Con esto ya podemos usar notación de punto para evitar equivocarme al escribir.
      answer: json['answer'],
      forced: json['forced'],
      image: json['image']
  );
}
