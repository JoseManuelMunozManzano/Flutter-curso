import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

// ChangeNotifier indica que, cuando hay cambios, puede notificarlos.
// Y entonces podremos redibujar ciertas cosas.
//
// Provider nos permite tener estos ChangeNotifier de manera global o a un cierto nivel del contexto de nuestra aplicación.
// En este último caso, solo los Widgets hijos podrán ver ese provider.
// Por ejemplo, podemos tener providers solo a nivel de formularios.
// O lo podemos tener en el raiz para que todos los Widgets lo puedan ver.
class ChatProvider extends ChangeNotifier {
  // Para controlar el scroll.
  final chatScrollController = ScrollController();
  final getYesNoAnswer = GetYesNoAnswer();

  List<Message> messages = [
    // 2 mensajes hardcodeados de prueba.
    Message(text: 'Hola amor!', fromWho: FromWho.me),
    Message(text: 'Ya regresaste del trabajo?', fromWho: FromWho.me),
  ];

  // Cuando recibamos el texto lo añadiremos a la lista.
  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.me);
    messages.add(newMessage);

    // Lanzar petición http cuando lo que yo escribo acaba en ?
    if (text.endsWith('?')) {
      herReply();
    }

    // Esto es para indicar a Flutter que algo cambió.
    // Notifica a todos los que estén escuchando este cambio.
    // En nuestra app, sería notificado chat_screen.dart, ya que usa el context.watchz<ChatProvider>()
    notifyListeners();

    // Nos vamos al final del scroll.
    moveScrollToBottom();
  }

  // Obtener respuesta http.
  // Se va a lanzar cuando, lo que yo escriba, acabe en ?
  Future<void> herReply() async {
    final herMessage = await getYesNoAnswer.getAnswer();
    messages.add(herMessage);

    // Notificamos para que redibuje
    notifyListeners();

    moveScrollToBottom();
  }

  Future<void> moveScrollToBottom() async {
    // Para dar la sensación de que se procesa y se hace.
    // Esto también corrige un bug por el que el último mensaje se oculta detrás de la caja de texto.
    // El provider notifica a los listeners que hubo un cambio pero no le da el tiempo suficiente para
    // que se redibuje la UI y el scrollController se actualize. Con este delay damos ese tiempo.
    await Future.delayed(const Duration(milliseconds: 100));

    // El offset es la posición a la cual quiero navegar. Indicamos lo máximo que ese scroll puede dar.
    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }
}
