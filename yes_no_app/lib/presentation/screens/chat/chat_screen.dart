// Para importar el paquete de Material usamos el snippet: importM
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';

import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

// Para crear una clase StatelessWidget usamos el snippet: stlesw
// Los screen regresan un Scaffold.
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWPsLz31-lZ7-rDiq_tJI-hZblx9S81CQLJg&usqp=CAU'),
          ),
        ),
        // Con la combinación de teclas Cmd + Ctrl + space podemos seleccionar iconos
        title: const Text('Mi amor ❤️'),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

// Está bien que sea un StatelessWidget, ya que ahora el estado lo maneja Provider.
class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Hacemos la referencia al provider, indicando la instancia del MultiProvider que necesito, que es ChatProvider.
    final chatProvider = context.watch<ChatProvider>();

    // SafeArea evita que nuestros Widgets acaben en zonas que usan los móviles, por ejemplo la parte de abajo, que haga
    // que nuestros widgets no se vean.
    return SafeArea(
      // Por si queremos que el Widget tome toda la parte izquierda
      // left: false,
      // Columna porque necesitamos colocar varios Widgets internos, el ListView y debajo un Widget para mandar mensajes.
      child: Padding(
        // symmetric hace iguales las partes verticales y/o horizontales.
        // En nuestro caso seleccionamos horizontal y una separación, para que el contenido no quede pegado al borde.
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            // Expanded permite expandir el Widget hijo a todo el espacio disponible por el padre.
            Expanded(
                // El builder es un constructor que en tiempo de ejecución Flutter va a ejecutar para construir ese Widget.
                // Permite tener una lista de miles de elementos.
                // El context es el árbol de Widgets y el índice indica que elemento se está renderizando en ese momento.
                child: ListView.builder(
                    // Cualquier elemento que trabaje con scroll tiene un controller que da el control sobre ese scroll.
                    // Ese scroller tiene que ser notificado cuando hay un nuevo mensaje.
                    // En chart_provider tenemos dicho controller y aqúi lo vinculamos a este ListView.
                    controller: chatProvider.chatScrollController,
                    // Si no se indica el itemCount, los elementos son infinitos.
                    itemCount: chatProvider.messages.length,
                    itemBuilder: (context, index) {
                      // Esto regresa una instancia de Message, mi entidad, y sabe si el mensaje es mío o de ella.
                      final message = chatProvider.messages[index];

                      return (message.fromWho == FromWho.hers)
                        ? const HerMessageBubble()
                        : MyMessageBubble(message: message);
                    })),

            // Caja de texto de mensajes.
            // En onValue es el texto que se puso en la caja de texto.
            // Pasamos una función que el hijo llamará, en este caso sendMessage()
            //
            MessageFieldBox(
              // Forma "normal"
              // onValue: (String value) => chatProvider.sendMessage(value),
              //
              // Forma corta cuando la misma cantidad de argumentos se usa para llamar a la función (y en las mismas posiciones)
              onValue: chatProvider.sendMessage
            ),
          ],
        ),
      ),
    );
  }
}
