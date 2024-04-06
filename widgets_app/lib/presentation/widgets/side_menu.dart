// Snippet impm para importar material
import 'package:flutter/material.dart';

// Snippet stlesw para crear un StatelessWidget
//
// Como vamos a querer saber cual es la opción seleccionada para activar/desactivar opciones, vamos a
// necesitar un estado.
// Por eso cambiamos a StatefulWidget usando Cmd+.
class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  // Para saber cuál de las opciones del menú es la que está seleccionada y poder
  // aplicar un estilo basado en eso.
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
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
      },

      children: const [
        NavigationDrawerDestination(
          icon: Icon(Icons.add),
          label: Text('Home Screen'),
        ),

        NavigationDrawerDestination(
          icon: Icon(Icons.add_shopping_cart_rounded),
          label: Text('Otra pantalla'),
        ),
      ]
    );
  }
}
