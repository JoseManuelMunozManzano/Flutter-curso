// Importamos el paquete de material usando el snippet importM
import 'package:flutter/material.dart';

// Creamos un StatelessWidget usando el snippet stlesw
class MessageFieldBox extends StatelessWidget {
  const MessageFieldBox({super.key});

  @override
  Widget build(BuildContext context) {
    // Elemento que va a darnos control del input al que lo voy a asociar.
    final textController = TextEditingController();

    // Mantener el foco
    final focusNode = FocusNode();

    // Podemos asignar un Widget a una variable para luego usarla en el return de Widgets.
    final outlineInputBorder = UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    final inputDecoration = InputDecoration(
        // Esto es para lanzar el proceso de respuesta automática que tendrá nuestra app.
        hintText: 'End your message with a "?"',
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        filled: true,
        suffixIcon: IconButton(
          icon: const Icon(Icons.send_outlined),
          onPressed: () {
            final textValue = textController.value.text;
            print('button: $textValue');
            textController.clear();
          },
        ));

    return TextFormField(
      // Al hacer click fuera del input se va a remover el foco.
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      focusNode: focusNode,
      controller: textController,
      decoration: inputDecoration,
      onFieldSubmitted: (value) {
        print('Submit value $value');
        textController.clear();
        focusNode.requestFocus();
      },
    );
  }
}
