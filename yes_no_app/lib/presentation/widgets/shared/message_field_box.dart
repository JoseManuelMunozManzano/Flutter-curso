// Importamos el paquete de material usando el snippet importM
import 'package:flutter/material.dart';

// Creamos un StatelessWidget usando el snippet stlesw
class MessageFieldBox extends StatelessWidget {
  const MessageFieldBox({super.key});

  @override
  Widget build(BuildContext context) {
    // Podemos asignar un Widget a una variable para luego usarla en el return de Widgets.
    final outlineInputBorder = UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    final inputDecoration = InputDecoration(
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        filled: true,
        suffixIcon: IconButton(
          icon: const Icon(Icons.send_outlined),
          onPressed: () {
            print('Valor de la caja de texto?');
          },
        ));

    return TextFormField(
      decoration: inputDecoration,
      onFieldSubmitted: (value) {
        print('Submit value $value');
      },
      onChanged: (value) {
        print('changed: $value');
      },
    );
  }
}
