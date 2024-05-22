# Push Notifications + Local Notifications

Esta sección está dedicada enteramente al manejo de Push en Android, inclusive si lo que quieren es únicamente IOS, es recomendado y necesario que lo sigamos, ya que el manejo después será el mismo (con otras configuraciones)

Puntualmente veremos:

- Tipos de estado de notificaciones
- Métodos para su manejo
- Entidades
- BLoC
- Leer las notificaciones push
- Interacciones
- Navegación a diferentes rutas basados en la PUSH
- Firebase
- Configuraciones de FCM
- Configuración de proyecto de Firebase
- Tareas y más

Es una sección muy completa sobre el manejo de las notificaciones push.

## Inicio de aplicación

- Pulsamos `Cmd+Shift+P` y seleccionamos `Flutter: New Project`
- Seleccionamos `Empty Application`
- Tras indicar donde queremos alojar el proyecto, le damos el nombre `push_app`
- Pulsamos `Cmd+Shift+P` y seleccionamos `Flutter: Launch Emulator`, seleccionando un emulador de Android
- Pulsamos `Cmd+Shift+P` y seleccionamos `Flutter: Select Device`, seleccionando el emulador de Android
- He cambiado en el fichero `android/gradle/wrapper/gradle-wrapper.properties` la property `distributionUrl` para que tenga la versión de Gradle que yo tengo en mi Mac

Creamos en `lib` el directorio `config` y dentro de este los directorios `router` y `theme`.

Creamos en `lib` el directorio `presentation` y dentro la carpeta `screens`.

Dentro de la carpeta `theme` creo el archivo `app_theme.dart`.

Dentro de la carpeta `screen` creo el archivo `home_screen.dart`.

Dentro de la carpeta `router` definimos nuestras rutas `app_router.dart`.

Vamos a instalar un par de paquetes usando `Pubspec Assist`, separando con comas: equatable, flutter_bloc, go_router
