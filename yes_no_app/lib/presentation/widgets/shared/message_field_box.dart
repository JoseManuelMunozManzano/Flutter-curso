// Importamos el paquete de material usando el snippet importM
import 'package:flutter/material.dart';

// Creamos un StatelessWidget usando el snippet stlesw
//
// NOTA: Había un bug pero YA está solucionado.
//  Al momento de presionar el icono para enviar el mensaje ya no funciona la propiedad de
//  onTapOutside para minimizar el keyboard, al parecer ya no detecta el widget.
//  investigando encontre este ejemplo: https://docs.flutter.dev/cookbook/forms/focus
//  Basicamente, cuando se utiliza un TexFormFiled la pantalla continuamente se esta redibujando.
//  Por eso deberia usarse con un StatefulWidget y sobreescribir dos funciones initState() y dispose()
//  Agregando esto ya se soluciona.
class MessageFieldBox extends StatefulWidget {
  // Esto lo hacemos para que este Widget sea reutilizable en otras aplicaciones.
  // Si indicáramos context.read<ChatProvider> quedaría fuertemente acoplado a esta implementación.
  // ValueChange es un Callback que regresa un valor.
  final ValueChanged<String> onValue;

  const MessageFieldBox({super.key, required this.onValue});

  @override
  State<MessageFieldBox> createState() => _MessageFieldBoxState();
}

class _MessageFieldBoxState extends State<MessageFieldBox> {
  // Mantener el foco
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Elemento que va a darnos control del input al que lo voy a asociar.
    final textController = TextEditingController();

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
            textController.clear();

            // Con esto llamamos al método que tenemos en nuestro padre.
            // Es decir, el padre (chat_screen.dart) me manda una función y aquí la ejecutamos.
            widget.onValue(textValue);
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
        textController.clear();
        focusNode.requestFocus();
        // Con esto llamamos al método que tenemos en nuestro padre.
        // Es decir, el padre (chat_screen.dart) me manda una función y aquí la ejecutamos.
        widget.onValue(value);
      },
    );
  }
}
