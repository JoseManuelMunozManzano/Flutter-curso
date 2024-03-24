// Para importar el paquete de Material usamos el snippet: importM
import 'package:flutter/material.dart';
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

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    // Si no se indica el itemCount, los elementos son infinitos.
                    itemCount: 100,
                    itemBuilder: (context, index) {
                      return (index % 2 == 0)
                          ? const HerMessageBubble()
                          : const MyMessageBubble();
                    })),
            
            // Caja de texto de mensajes.
            const MessageFieldBox(),
          ],
        ),
      ),
    );
  }
}
