// Uso de snippet impm para importar paquete de Material.
import 'package:colornames/colornames.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

// Uso de snippet stlesw para crear un StatelessWidget.
// Como usamos Riverpod, en concreto un StateProvider, cambiamos StatelessWidget por un ConsumerWidget.
class ThemeChangerScreen extends ConsumerWidget {

  static const name = 'theme_changer_screen';

  const ThemeChangerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // Como vamos a usar un StateNotifierProvider, esto ya no hace falta.
    // final isDarkMode = ref.watch(isDarkModeProvider);

    final isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Changer'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined),
            onPressed: () {
              // ref.read(isDarkModeProvider.notifier).update((state) => !state);
              ref.read(themeNotifierProvider.notifier).toggleDarkmode();
            },
          )
        ],
      ),

      // Lista de colores disponibles.
      body: const _ThemeChangerView(),
    );
  }
}

// Lista de colores disponibles.
// En el fuente app_theme.dart tenemos una constante (nunca va a cambiar) de lista de colores.
// Técnicamente podemos hacer referencia a ella directamente (usando colorList) y ya, tengo los
// colores actuales.
// Pero imaginando una app donde queramos poder referenciar esta lista de colores
// usando el WidgetRef ref, creamos en theme_provider.dart el listado de colores inmutable a partir de
// nuestro colorList.
class _ThemeChangerView extends ConsumerWidget {
  const _ThemeChangerView();

  void copyToClipBoard(BuildContext context, String value) {
    Clipboard.setData(ClipboardData(text: value)).then((_) {
      ScaffoldMessenger.of(context).clearSnackBars();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Color copied to clipboard'),
          duration: Duration(seconds: 1),
        )
      );
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // Inclusive cuando sabemos que colorListProvider NO puede cambiar porque es final,
    // Riverpod recomienda usar watch.
    // En un futuro, si cambiamos a dinámico, no habría que tocar nada, e igualmente
    // Riverpod sabe cuando algo cambia para redibujar o no.
    final List<Color> colors = ref.watch(colorListProvider);

    // Vamos a usar nuestro StateNotifierProvider, por lo que esto ya no hace falta.
    // final int selectedColor = ref.watch(selectedColorProvider);
    final int selectedColor = ref.watch(themeNotifierProvider).selectedColor;

    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (context, index) {
        final Color color = colors[index];
        final String radixString = color.value.toRadixString(16).toUpperCase();

        return ListTile(
          onTap: () {

            // Usamos ahora nuestro StateNotifierProvider
            // if (ref.read(selectedColorProvider) != index) {
            //   ref.read(selectedColorProvider.notifier).state = index;
            //   copyToClipBoard(context, radixString);
            // }

            if (ref.read(themeNotifierProvider).selectedColor != index) {
              ref.read(themeNotifierProvider.notifier).changeColorIndex(index);
              copyToClipBoard(context, radixString);
            }
          },
          leading: CircleAvatar(backgroundColor: colors[index]),
          title: Text(color.colorName), // paquete colornames
          subtitle: Text('#$radixString'),
          trailing: Switch(
            value: index == selectedColor,
            activeColor: color,
            onChanged: (value) {
              // Usamos ahora nuestro StateNotifierProvider
              // if (ref.read(selectedColorProvider) != index) {
              //   ref.read(selectedColorProvider.notifier).state = index;
              //   copyToClipBoard(context, radixString);
              // }

              if (ref.read(themeNotifierProvider).selectedColor != index) {
                ref
                    .read(themeNotifierProvider.notifier)
                    .changeColorIndex(index);
                copyToClipBoard(context, radixString);
              }
            },
          ),
        );
      },
    );
  }
}
