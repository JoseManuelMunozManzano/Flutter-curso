// Para importar el paquete de Material usamos el snippet: importM
import 'package:flutter/material.dart';

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
          child:  CircleAvatar(
            backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWPsLz31-lZ7-rDiq_tJI-hZblx9S81CQLJg&usqp=CAU'),
          ),
        ),
        // Con la combinación de teclas Cmd + Ctrl + space podemos seleccionar iconos
        title: const Text('Mi amor ❤️'),
        centerTitle: false,
      ),
    );
  }
}
