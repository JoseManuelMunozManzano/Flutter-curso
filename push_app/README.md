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

## Bloc y FlutterFire

Vamos a hacer la configuración de nuestro Bloc para saber como va a fluir nuestra información.

Vamos a usar FlutterFire, que es una implementación oficial de Firebase para Flutter.

Documentación: https://firebase.flutter.dev/docs/messaging/notifications/

Tal y como se indica aquí `https://firebase.flutter.dev/docs/messaging/overview`, empezamos las instalaciones.

Por ahora solo vamos a instalar, por ahora, y usando `Pubspec Assist` el paquete `firebase_messaging`. Lo instalamos, sin hacer todavía ninguna configuración, porque en nuestro Bloc vamos a manejar una propiedad igual a un estado que me va a dar ese paquete, y así no hay que crear una enumeración personalizada.

Dentro de la carpeta `presentation` creamos la carpeta `blocs`. En esa carpeta pulsamos click derecho y seleccionamos `Bloc: New Bloc` y le ponemos el nombre `notifications`. Renombramos la carpeta bloc nueva que aparece a notifications.

## Solicitar permisos

Vamos a solicitar los permisos de las notificaciones push. Si el usuario no acepta, no vamos a poder mandarle notificaciones push.

IMPORTANTE: Existe un paquete llamado `permission_handler` que nos permite configurar cualquier permiso que necesite nuestra app, `https://pub.dev/packages/permission_handler`. No lo vamos a usar, pero conviene saberlo.

Si arrancamos el proyecto nos da un error indicando que, para usar las notificaciones push, necesitamos configurar lo siguiente en la ruta `/android/app/build.gradle` del proyecto:

```
  android {
    defaultConfig {
      minSdkVersion 19
    }
  }
```

Pero igualmente nos falla el proyecto y no arranca. Esto es porque tenemos que configurar una instancia de Firebase.
