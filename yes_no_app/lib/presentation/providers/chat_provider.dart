import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';

// ChangeNotifier indica que, cuando hay cambios, puede notificarlos.
// Y entonces podremos redibujar ciertas cosas.
class ChatProvider extends ChangeNotifier {

  List<Message> messages = [
    // 2 mensajes hardcodeados de prueba.
    Message(text: 'Hola amor!', fromWho: FromWho.me),
    Message(text: 'Ya regresaste del trabajo?', fromWho: FromWho.me),
  ];

  // Cuando recibamos el texto lo añadiremos a la lista.
  Future<void> sendMessage(String text) async {
    // TODO: implementar método
  }
}
