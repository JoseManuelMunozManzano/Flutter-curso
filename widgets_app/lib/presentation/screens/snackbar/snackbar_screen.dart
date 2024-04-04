// Usando el snipped impm importamos el paquete de Material
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Usando el snippet stlesw creamos un StatelessWidget
class SnackbarScreen extends StatelessWidget {
  static const name = 'snackbar_screen';

  const SnackbarScreen({super.key});

  void showCustomSnackbar(BuildContext context) {
    // Cada vez que pulsamos para mostrar el snackbar queremos ocultar el anterior.
    ScaffoldMessenger.of(context).clearSnackBars();

    // Cuando se muestra el Snackbar, desplaza hacia arriba el FloatingActionButton, sin embargo,
    // si tuvieras más objetos en la pantalla, el Snackbar solo desplazaría aquellos objetos que
    // estén en la misma área o espacio que ocupa el Snackbar.
    // Los objetos ubicados en diferentes partes de la pantalla no se verían afectados por el Snackbar.
    // Además, el Snackbar no está restringido a ser llamado solo desde un FloatingActionButton, como
    // se muestra en este ejemplo. Puede ser llamado desde otros widgets, como botones regulares o
    // incluso al entrar en la pantalla, según las necesidades de diseño y flujo de la aplicación.
    // Esto te proporciona flexibilidad para mostrar mensajes temporales y notificaciones en
    // respuesta a diversas interacciones del usuario.
    final snackbar = SnackBar(
      content: const Text('Hola Mundo'),
      // SnackBarAction es como un botón.
      // Cualquier acción del SnackBarAction va a hacer que se cierre.
      action: SnackBarAction(label: 'Ok!', onPressed: () {}),
      // Para que se oculte máximo en 2sg.
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void openDialog(BuildContext context) {
    showDialog(
      context: context,
      // Esto es para evitar que, si se pulsa fuera del Dialog, este se cierre.
      // Útil si queremos que el usuario tenga que validar algo, obligándole a 
      // pulsar en alguna de nuestras opciones.
      barrierDismissible: false,
      // Recordar que un builder se construye en tiempo de ejecución.
      builder: (context) => AlertDialog(
        title: const Text('¿Estás seguro?'),
        content: const Text('Ullamco ipsum nulla velit eiusmod esse qui. Ea nisi laborum ullamco duis enim elit veniam. Sit quis voluptate aute nulla eu velit velit nostrud id. Duis id cupidatat voluptate id ad amet voluptate adipisicing irure voluptate voluptate cillum labore officia.'),
        actions: [
          // Gracias a go_router podemos usar context.pop()
          // También se puede usar Navigator.pop(context)
          TextButton(onPressed: () => context.pop(), child: const Text('Cancelar')),
          FilledButton(onPressed: () => context.pop(), child: const Text('Aceptar')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbars y Diálogos'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: () {
                // Para mostrar las licencias del software que estamos utilizando.
                showAboutDialog(
                  context: context,
                  children: [
                    const Text('Nisi et est esse laborum aliquip dolore ad ad excepteur deserunt nisi voluptate aliqua pariatur. Aliqua aliquip ad non ullamco nisi nostrud dolor Lorem. Culpa ad nisi ipsum non Lorem et cillum fugiat est et nisi dolore. Quis sit deserunt sunt quis occaecat. Pariatur sit culpa magna mollit eiusmod do anim.'),
                  ]
                );
              },
              child: const Text('Licencias usadas')
            ),

            FilledButton.tonal(
              onPressed: () => openDialog(context),
              child: const Text('Mostrar diálogo')
            ), 
          ],
        ),
      ) ,

      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Mostrar Snackbar'),
        icon: const Icon(Icons.remove_red_eye_outlined),
        onPressed: () {
          // Hay muchas formas de crear el Snackbar, pero necesitamos la información del Scaffold.
          // Podemos:
          // 1. Indicar la property key en el Scaffold, para identificar donde está,
          // 2. O podemos decirle a Flutter que trate de encontrar el Scaffold más
          //      cercano y ahí construye el Snackbar.
          // La implementación de la segunda opción es esta:
          showCustomSnackbar(context);
        },
      ),
    );
  }
}
