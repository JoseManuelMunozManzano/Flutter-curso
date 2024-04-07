// Estado para manejar tema oscuro
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

// Listado de colores inmutable.
// En todos los lugares donde se use ref voy a poder acceder a este colorListProvider.
//
// Provider es para valores inmutables.
final colorListProvider = Provider((ref) => colorList);

// StateProvider es para mantener una sola pieza de estado, para un tipo básico, como String, bool...
// Un simple boolean
final isDarkModeProvider = StateProvider<bool>((ref) => false);

// Un simple int
final selectedColorProvider = StateProvider<int>((ref) => 0);

// Se podría haber hecho un provider compuesto que esté pendiente de las tres propiedades anteriores.
// Pero no lo vamos a necesitar.

// StateNotifierProvider es para mantener un estado de un objeto, un map... de algo complejo.
// Vamos a estar pendientes de la clase AppTheme, en concreto de un objeto personalizado del tipo AppTheme.
// En los genéricos se indica el nombre de la clase que queremos que controle este estado, el Notifier o Controller,
// y el segundo genérico es literalmente el estado interno (instancia) que vamos a tener en ese Notifier o Controller.
// Es decir, indicamos <Notifier, tipo_state>
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  // Tenemos que regresar una instancia. Indicamos la que por defecto inicializa AppTheme.
  // Podríamos mandar información al constructor.
  //
  // El ref que aparece se podría mandar como argumento a ThemeNotifier(ref) y así tener acceso
  // a todos los providers de Riverpod. En este caso no nos hace falta y por tanto no lo mandamos.
  (ref) => ThemeNotifier()
);

// Esto es un Controller o Notifier (algunos programadores lo llamarían ThemeController)
// Este StateNotifier se va a encargar de mantener un estado en particular, en concreto una instancia de AppTheme.
class ThemeNotifier extends StateNotifier<AppTheme> {

  // Necesitamos que cree la primera instancia de mi AppTheme, con sus valores por defecto.
  // Tiene que ser síncrono.
  // Este es mi state.
  ThemeNotifier(): super(AppTheme());

  // Tenemos acceso, usando la variable state, de tipo AppTheme, a todo lo que haya en AppTheme
  // Por ejemplo:
  // void algo() {
  //   state.getTheme();
  // }

  void toggleDarkmode() {
    // Para cambiar variables de AppTheme finales, hemos creado en AppTheme el método copyWith().
    // Riverpod sabe que estamos cambiando el state y va a realizar la notificación a todos los
    // widgets donde sea necesario.
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void changeColorIndex(int colorIndex) {

  }

}
