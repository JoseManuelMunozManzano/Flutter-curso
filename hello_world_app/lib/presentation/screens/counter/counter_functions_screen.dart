import 'package:flutter/material.dart';

class CounterFunctionsScreen extends StatefulWidget {
  const CounterFunctionsScreen({super.key});

  @override
  State<CounterFunctionsScreen> createState() => _CounterFunctionsScreenState();
}

class _CounterFunctionsScreenState extends State<CounterFunctionsScreen> {
  int clickCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Counter Functions'),
          centerTitle: true,
          // Iconos en la parte izquierda: propiedad leading.
          //    Si necesitamos más de uno, usamos un Widget Row, que permite un array de Widgets.
          // Iconos en la parte derecha: array actions, que ya de por si es un array de Widgets
          leading: const Align(
              alignment: Alignment.center,
              child: FlutterLogo(),
            ),
          actions: [
            IconButton(
                // Icon es un Widget especial para mostrar iconos.
                icon: const Icon(Icons.refresh_rounded),
                onPressed: () {
                  setState(() {
                    clickCounter = 0;
                  });
                }),
          ],
        ),
        body:
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$clickCounter',
                style:
                    const TextStyle(fontSize: 160, fontWeight: FontWeight.w100),
              ),
              Text(
                'Click${clickCounter == 1 ? '' : 's'}',
                style: const TextStyle(fontSize: 25),
              )
            ],
          ),
        ),
        // Como Widget indicaremos un Column, ya que necesitamos más de un Widget FloatingActionButton.
        floatingActionButton: Column(
          // Sin mainAxisAlignment, el FloatingActionButton coloca el botón arriba del todo, y lo queremos abajo.
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Vemos que todo esto se repite, salvo la función onPressed y el icono que mostramos.
            // Vamos a crear nuestros Widgets personalizados.
            // Para extraer un Widget, la forma más sencilla es situar el ratón en el nombre del Widget a extraer,
            // presionar Cmd + . y pulsar en:
            //  - Extract Method: permite extraer un Widget y crear un método en la clase que lo construye.
            //  - Extract Local Variable: crea una variable que apunta al valor del Widget.
            //  - Extract Widget: extrae el Widget y crea uno nuevo. Este es el que queremos hacer, pero no siempre
            //      funciona, ya que, si tiene dependencias, como en este caso con el setState y la variable clickCounter,
            //      no va a permitir hacer esta extracción.
            //      Lo más fácil es eliminar estas dependencias y extraer el Widget.
            //      Le daremos un nombre, en este caso CustomButton, que es un StatelessWidget.
            //      Luego optimizaremos el código para que reciba la función y el icono.
            //      Y por último se llevará a un nuevo archivo.
            //
            // Este es el código que se repetía.
            //
            // FloatingActionButton(
            //   shape: const StadiumBorder(),
            //   onPressed: () {
            //     clickCounter++;
            //     setState(() {});
            //   },
            //   child: const Icon(Icons.plus_one),
            // ),

            CustomButton(
              icon: Icons.refresh_rounded,
              onPressed: () {
                // Recordar que esta sentencia puede estar fuera o dentro del setState()
                clickCounter = 0;
                setState(() {});
              },
            ),
            // Para agregar una separación, podemos usar un Widget llamado Sizedbox, que es un contenedor o una
            // caja con un tamaño específico
            const SizedBox(height: 10),
            CustomButton(
              icon: Icons.exposure_minus_1_outlined,
              onPressed: () {
                if (clickCounter == 0) return;
                clickCounter--;
                setState(() {});
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              icon: Icons.plus_one,
              onPressed: () {
                clickCounter++;
                setState(() {});
              },
            ),
          ],
        ));
  }
}

// Botón personalizado
class CustomButton extends StatelessWidget {
  // No esperamos un Widget, sino la data.
  final IconData icon;

  // Función como argumento.
  // Para saber el tipo de onPressed nos vamos a un Widget que lo use, como FloatingActionButton
  // más abajo. Situamos el ratón en esa palabra y pulsamos Cmd + click para que me lleve a la definición
  // de ese Widget. Ahora solo me toca buscar onPressed hasta que vea el tipo de dato.
  // Veremos que el tipo es VoidCallback?, con interrogación, es decir opcional, porque puede que no lo envíen.
  final VoidCallback? onPressed;

  // Para añadir las propiedades al constructor, situar el ratón en el nombre
  // del constructorpulsar Cmd + . y seleccionar Add final field formal parameters.
  const CustomButton({
    super.key,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const StadiumBorder(),
      // Para hacer sonido cuando se toca el botón.
      enableFeedback: true,
      // Para pronunciar la sombra.
      // Si la pongo en 0 parece que los botones están pegados ahí.
      elevation: 5,
      // Si en onPressed indicamos null
      // onPressed: null
      // veremos que no podemos hacer click en los botones. Están disabled.
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}
