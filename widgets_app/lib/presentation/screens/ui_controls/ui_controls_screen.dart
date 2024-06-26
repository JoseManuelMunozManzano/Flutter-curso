// Usando el snipped impm importamos el paquete de Material
import 'package:flutter/material.dart';

// Usando el snippet stlesw creamos un StatelessWidget
class UiControlsScreen extends StatelessWidget {
  static const name = 'ui_controls_screen';

  const UiControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('UI Controls'),
        ),
        body: const _UiControlsView());
  }
}

// Para poder pulsar el Switch y que este cambie, necesitamos estado.
// Puede ser un StatelessWidget pero vamos a necesitar un gestor de estado externo.
// Para este ejemplo, vamos a usar un StatefulWidget.
class _UiControlsView extends StatefulWidget {
  const _UiControlsView();

  @override
  State<_UiControlsView> createState() => _UiControlsViewState();
}

enum Transportation { car, plane, boat, submarine }

class _UiControlsViewState extends State<_UiControlsView> {
  bool isDeveloper = true;
  
  // selectedTransportation contiene el valor seleccionado en los RadioListTile.
  Transportation selectedTransportation = Transportation.car;

  bool wantsBreakfast = false,
       wantsLunch = false,
       wantsDinner = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Evitar el movimiento de rebote
      physics: const ClampingScrollPhysics(),
      // Este ListView no es un builder porque vamos a colocar los hijos dentro del ListView.
      children: [
        // También existe Switch a secas, pero la ventaja de SwitchListTile es que el Switch
        // queda dentro de una lista y tenemos más facilidad a la hora de tocarlo (todo el row)
        SwitchListTile(
          title: const Text('Developer Mode'),
          subtitle: const Text('Controles adicionales'),
          value: isDeveloper,
          onChanged: (value) => setState(() {
            isDeveloper = !isDeveloper;
          }),
        ),

        // La idea es que, tras haber seleccionado una opción de las permitidas
        // en los RadioListTile, que se compacten para ocupar menos espacio.
        // Puede hacerse que esté expandido por defecto.
        ExpansionTile(
          title: const Text('Vehículo de transporte'),
          subtitle: Text('$selectedTransportation'),
          children: [
            // Para seleccionar una opción de entre una lista de opciones.
            // value nos sirve para enlazar el valor seleccionado con el valor actual.
            // groupValue es la variable que vamos a usar para marcar cual es la opción seleccionada.
            // A la función onChanged se le pasa el value, que ya sabe que es de tipo Transportation por
            //   el valor que se asignó a value.

            // Generalizado. También se puede sacar a un Widget aparte.
            //
            ...Transportation.values.map((e) {
              final item = Transportation.values[e.index];
              final title = item.toString().split('.').last;

              return RadioListTile(
                title: Text(title.toUpperCase()),
                subtitle: Text('Travel by $title'),
                value: item,
                groupValue: selectedTransportation,
                onChanged: (value) => setState(() {
                  selectedTransportation = item;
                }),
              );
            }),

            // Opción hardcode
            //
            // RadioListTile(
            //   title: const Text('By Car'),
            //   subtitle: const Text('Viajar en coche'),
            //   value: Transportation.car,
            //   groupValue: selectedTransportation,
            //   onChanged: (value) => setState(() {
            //     selectedTransportation = Transportation.car;
            //   }),
            // ),
            // RadioListTile(
            //   title: const Text('By Boat'),
            //   subtitle: const Text('Viajar en barco'),
            //   value: Transportation.boat,
            //   groupValue: selectedTransportation,
            //   onChanged: (value) => setState(() {
            //     selectedTransportation = Transportation.boat;
            //   }),
            // ),
            // RadioListTile(
            //   title: const Text('By Plane'),
            //   subtitle: const Text('Viajar en avión'),
            //   value: Transportation.plane,
            //   groupValue: selectedTransportation,
            //   onChanged: (value) => setState(() {
            //     selectedTransportation = Transportation.plane;
            //   }),
            // ),
            // RadioListTile(
            //   title: const Text('By Submarine'),
            //   subtitle: const Text('Viajar en submarino'),
            //   value: Transportation.submarine,
            //   groupValue: selectedTransportation,
            //   onChanged: (value) => setState(() {
            //     selectedTransportation = Transportation.submarine;
            //   }),
            // ),
          ],
        ),
      
        // Una opción independiente que está basado en un valor booleano y que es opcional.
        CheckboxListTile(
          title: const Text('¿Desayuno?'),
          value: wantsBreakfast,
          onChanged: (value) => setState(() {
            wantsBreakfast = !wantsBreakfast;
          }),
        ),
        CheckboxListTile(
          title: const Text('¿Almuerzo?'),
          value: wantsLunch,
          onChanged: (value) => setState(() {
            wantsLunch = !wantsLunch;
          }),
        ),
        CheckboxListTile(
          title: const Text('¿Cena?'),
          value: wantsDinner,
          onChanged: (value) => setState(() {
            wantsDinner = !wantsDinner;
          }),
        ),
      ],
    );
  }
}
