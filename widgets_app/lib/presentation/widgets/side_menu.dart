// Snippet impm para importar material
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_items.dart';

// Snippet stlesw para crear un StatelessWidget
//
// Como vamos a querer saber cual es la opción seleccionada para activar/desactivar opciones, vamos a
// necesitar un estado.
// Por eso cambiamos a StatefulWidget usando Cmd+.
class SideMenu extends StatefulWidget {
  // Mandamos la lista de menús para que el drawer las construya.
  // Con esto se pueden reutilizar.
  final List<MenuItem> menuItems;

  // Obtenemos el scaffoldKey creado en home_screen.dart para saber su estado
  // y saber si estamos en un drawer, y así poder cerrarlo.
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({
    super.key,
    required this.menuItems,
    required this.scaffoldKey
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  // Para saber cuál de las opciones del menú es la que está seleccionada y poder
  // aplicar un estilo basado en eso.
  // Con un gestor de estado podríamos saber cual fue la última opción usada.
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Nos indica cuánto es el padding de una dirección. En este caso en el top.
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    return NavigationDrawer(
        // To-dos los NavigationDrawerDestination de este children van a saber y poder manejar
        // el index seleccionado.
        selectedIndex: navDrawerIndex,

        // En vez de un onTap tenemos onDestinationSelected para saber que NavigationDrawerDestination
        // se ha seleccionado.
        onDestinationSelected: (value) {
          setState(() {
            navDrawerIndex = value;
          });

          // Para hacer la navegación a los puntos de menú necesitamos saber el enlace.
          // Sabemos el enlace porque lo hemos recibido como parámetro.
          final menuItem = widget.menuItems[value];
          context.push(menuItem.link);

          // Usamos el scaffoldKey para cerrar el drawer si está abierto.
          // Recordar que para poder usar una variable que viene del StatefulWidget (no del State)
          // hay que indicar primero widget.
          widget.scaffoldKey.currentState?.closeDrawer();
        },
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
            child: const Text('Main'),
          ),

          ...widget.menuItems.sublist(0, 3).map((item) =>
              NavigationDrawerDestination(
                  icon: Icon(item.icon), label: Text(item.title))),

          // Línea divisoria
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
            child: Text('More options'),
          ),

          ...widget.menuItems.sublist(3).map((item) =>
              NavigationDrawerDestination(
                  icon: Icon(item.icon), label: Text(item.title))),
        ]);
  }
}
