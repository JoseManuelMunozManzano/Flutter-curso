import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';

// ChangeNotifier indica que, cuando hay cambios, puede notificarlos.
// Y entonces podremos redibujar ciertas cosas.
//
// Provider nos permite tener estos ChangeNotifier de manera global o a un cierto nivel del contexto de nuestra aplicación.
// En este último caso, solo los Widgets hijos podrán ver ese provider.
// Por ejemplo, podemos tener providers solo a nivel de formularios.
// O lo podemos tener en el raiz para que todos los Widgets lo puedan ver.
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
