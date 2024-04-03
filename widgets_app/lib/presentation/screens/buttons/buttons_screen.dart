// Importamos paquete de material usando el snippet impm
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Creamos un StatelessWidget usando el snippet stlesw
class ButtonsScreen extends StatelessWidget {
  
  static const name = 'buttons_screen';

  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buttons Screen'),
      ),
      body: const _ButtonsView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          // Gracias a go_router, podemos usar context.pop() para salirnos de ese screen.
          context.pop();
          // Sin go_router, usando Navigator sería
          // Navigator.of(context).pop();
        },
      ),
    );
  }
}

class _ButtonsView extends StatelessWidget {
  const _ButtonsView();

  @override
  Widget build(BuildContext context) {
    // Usando snipped creado manualmente theme-of
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      // Con double.infinity, llega hasta donde el padre puede llegar.
      // Puede dar lugar a problemas si el Widget no tiene una dimensión específica.
      width: double.infinity,
      // Usado el decoratedBox para ver cuando ocupan los elementos en pantalla,
      // usando un color de fondo.
      // Es un truco.
      // child: DecoratedBox(
      //   decoration: const BoxDecoration(color: Colors.green),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          // Wrap es similar a los Rows, como los inline en CSS.
          child: Wrap(
            spacing: 10,
            alignment: WrapAlignment.center,
            // El children van a ser los botones que necesitamos colocar.
            children: [
              ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
              // Si en onPressed indicamos null, por defecto ese botón está deshabilitado.
              const ElevatedButton(onPressed: null, child: Text('Elevated Disabled')),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.access_alarm_rounded),
                label: const Text('Elevated Icon')
              ),

              FilledButton(onPressed: () {}, child: const Text('Filled')),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.accessibility_new),
                label: const Text('Filled Icon')
              ),

              OutlinedButton(onPressed: () {}, child: const Text('Outline')),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.terminal),
                label: const Text('Outline Icon'),
              ),

              TextButton(onPressed: () {}, child: const Text('Text')),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.account_box_outlined),
                label: const Text('Text Icon')
              ),

              // TODO: custom button

              IconButton(onPressed: () {}, icon: const Icon(Icons.app_registration_rounded)),

              IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: const Icon(Icons.app_registration_rounded),
                style: IconButton.styleFrom(backgroundColor: colors.primary),
              ),

            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.app_registration_rounded),
              style: ButtonStyle(
                // Con MaterialStatePropertyAll se aplica el color a todos.
                backgroundColor: MaterialStatePropertyAll(colors.primary),
                iconColor: const MaterialStatePropertyAll(Colors.white),
              )
            ),
            ],
          ),
        ),
      // ),
    );
  }
}

// NOTA:
// Utilizar MaterialStatePropertyAll([color]) quizá no es la mejor idea siempre,
// ¿por qué?
// Bueno, digamos que tienen un botón que quieren que sea de color rojo, pero que
//  cuando esté disabled (onPressed: null) tenga un color "deshabilitado".
//
// Bueno, si usan MaterialStatePropertyAll, esto pondrá el mismo color para todos los
//  estados. Inclusive cuando el botón esté deshabilitado.
//
// Es por eso que una mejor técnica es usar Foo.styleFrom(), siendo Foo el nombre
//  del widget que quieren estilizar.
// De esta manera, solo están afectando una propiedad en específico y no todas en general.
//
// De nuevo, esto no solo les sirve para IconButtons, sino para TextInputFields,
//  Switchs, etc. Básicamente cualquier widget que tenga un
//  MaterialStateProperty<Color> como tipo de color.
