// Importamos paquete de material usando el snippet impm
import 'package:flutter/material.dart';

// Creamos un listado de varias tarjetas
const cards = <Map<String, dynamic>>[
  {'elevation': 0.0, 'label': 'Elevation 0'},
  {'elevation': 1.0, 'label': 'Elevation 1'},
  {'elevation': 2.0, 'label': 'Elevation 2'},
  {'elevation': 3.0, 'label': 'Elevation 3'},
  {'elevation': 4.0, 'label': 'Elevation 4'},
  {'elevation': 5.0, 'label': 'Elevation 5'},
];

// Creamos un StatelessWidget usando el snippet stlesw
class CardsScreen extends StatelessWidget {
  static const name = 'cards_screen';

  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards Screen'),
      ),
      body: const _CardsView(),
    );
  }
}

class _CardsView extends StatelessWidget {
  const _CardsView();

  @override
  Widget build(BuildContext context) {
    // El Column se va a desbordar, es decir, vamos a tener más Widgets de los que caben en pantalla.
    // Cuando esto suceda aparecerá un error, que se puede resolver si se envuelve el Widget Column en
    // el Widget SingleChildScrollView.
    return SingleChildScrollView(
      child: Column(
        children: [
          // Operador spread
          // Esto devuelve un Iterable. Se puede añadir al final un .toList(), pero no hace falta
          // porque Dart puede trabajar con los iterables.
          ...cards.map(
            (card) =>
                _CardType1(elevation: card['elevation'], label: card['label']),
          ),

          // Si comentamos el Widget SingleChildScrollView, sucede
          // el error que se ha indicado, es decir, los Cards no caben en pantalla.
          ...cards.map((card) => _CardType2(elevation: card['elevation'], label: card['label']),),

          ...cards.map((card) => _CardType3(elevation: card['elevation'], label: card['label']),),

          ...cards.map((card) => _CardType4(elevation: card['elevation'], label: card['label']),),

          // Una forma fácil de evitar que los cards de abajo no se vean, porque chocan con los márgenes
          // del dispositivo, es añadir un SizedBox.
          // Otra forma de corregir este problema es usando SafeArea.
          const SizedBox(height: 50,)
        ],
      ),
    );
  }
}

// Creado con el snippet stlesw
class _CardType1 extends StatelessWidget {
  final String label;
  final double elevation;

  const _CardType1({
    required this.label,
    required this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert_outlined),
                  )),
              Align(alignment: Alignment.bottomLeft, child: Text(label))
            ],
          )),
    );
  }
}

// Cards con borde.
class _CardType2 extends StatelessWidget {
  final String label;
  final double elevation;

  const _CardType2({
    required this.label,
    required this.elevation,
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Card(
      // Este tipo de Card va a tener un borde.
      shape: RoundedRectangleBorder(
      // Por defecto, RoundedRectangleBorder es cuadrado. Se indica borderRadius.
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        side: BorderSide(
          color: colors.outline,
        )
      ),
      elevation: elevation,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert_outlined),
                  )),
              Align(alignment: Alignment.bottomLeft, child: Text('$label - outline'))
            ],
          )),
    );
  }
}

// Cards con fondo relleno
class _CardType3 extends StatelessWidget {
  final String label;
  final double elevation;

  const _CardType3({
    required this.label,
    required this.elevation,
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Card(
      color: colors.surfaceVariant,
      elevation: elevation,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert_outlined),
                  )),
              Align(alignment: Alignment.bottomLeft, child: Text('$label - Filled'))
            ],
          )),
    );
  }
}

// Cards con imágenes
class _CardType4 extends StatelessWidget {
  final String label;
  final double elevation;

  const _CardType4({
    required this.label,
    required this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Otra forma de obtener bordes redondeados usando el Card.
      // hardEdge evita que los hijos se salgan del contenido de su padre.
      clipBehavior: Clip.hardEdge,
      elevation: elevation,
      child: Stack(
        children: [
          Image.network(
            // String de donde se toma la imagen.
            // El 600 es el width y el 350 el height.
            'https://picsum.photos/id/${elevation.toInt()}/600/350',
            // Pero ahora indico un tamaño en específico.
            height: 350,
            // Y como quiero que se adapte al espacio.
            fit: BoxFit.cover,
          ),
      
          Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert_outlined),
                ),
              )),
        ],
      ),
    );
  }
}
