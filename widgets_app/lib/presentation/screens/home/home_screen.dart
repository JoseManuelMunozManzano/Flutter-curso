// Usamos el snippet impm para importar el paquete de Material
import 'package:flutter/material.dart';
import 'package:widgets_app/config/menu/menu_items.dart';
import 'package:widgets_app/presentation/screens/buttons/buttons_screen.dart';

// Usamos el snippet stlesw para crear un StatelessWidget.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter + Material 3'),
      ),
      body: const _HomeView()
    );
  }
}

class _HomeView extends StatelessWidget {

  // El key lo he borrado porque, al ser privado, suele tener solo una referencia.
  const _HomeView();

  @override
  Widget build(BuildContext context) {

    // Las opciones de menú nunca van a cambiar. Si fueran dinámicas podrían estar en un gestor de estados.
    // appMenuItems.
    // Text('nombre')
    // ListTile

    // Recordar que builder significa que se va a construir en tiempo de ejecución.
    return ListView.builder(
      itemCount: appMenuItems.length,
      itemBuilder: (context, index) {
        final menuItem = appMenuItems[index];

        return _CustomListTile(menuItem: menuItem);
      },
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    required this.menuItem,
  });

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    // Creado con snippet themeof (Snippet creado manualmente)
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(menuItem.icon, color: colors.primary),
      title: Text(menuItem.title),
      subtitle: Text(menuItem.subTitle),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: colors.primary),
      onTap: () {

        // push() hay que entenderlo como que va a crear un Stack de tarjetas.
        // Tengo una tarjeta, y con push() pongo encima otra y con push() pongo encima otra...
        // Y con pop() las voy retirando en sentido LIFO
        // Usando Navigator.of(context).replace() se destruye la ruta anterior, no podiendo regresar a ella.
        // Como ButtonsScreen tiene un AppBar sabe que tenemos un historial y podemos echar para atrás.
        //
        // Habiendo añadido nombres de rutas en main.dart, esto ya no haría falta
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => const ButtonsScreen(),
        //   ),
        // );
        //
        // Y para usar los nombres de rutas:
        // Navigator.pushNamed(context, menuItem.link);
        // Esta otra opción es posible:
        Navigator.of(context).pushNamed(menuItem.link);

        // Pero ninguna de estas dos técnicas se va a usar. Vamos a usar go_router
      },
    );
  }
}