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

## Configurar proyecto de Firebase

Para poder comenzar la configuración, lo primero es tener un proyecto en Firebase: `https://firebase.google.com/?hl=es-419`

Nos interesa de Firebase sobre todo la parte de `Cloud Messaging (FCM)` que no tiene ningún coste.

He creado el proyecto `flutter-projects`: `https://console.firebase.google.com/project/flutter-projects-29ae9/overview?hl=es-419`

Si volvemos a `https://firebase.flutter.dev/docs/overview` veremos que nos pide instalar `firebase_core`. Nosotros lo vamos a configurar mediante el CLI, con el comando `flutterfile configure` que también aparece en esta documentación. Por tanto, lo primero es instalar el CLI. La forma más fácil de hacerlo es ir a `https://firebase.google.com/docs/cli?hl=es` y seguir los pasos, que básicamente consiste en ejecutar, uno después de otro, los siguiente comandos:

- Abrir terminal
- curl -sL https://firebase.tools | bash
- Cerrar la terminal
- Abrir otra terminal
- firebase login

Si necesitamos, podemos hacer `firebase logout` también.

Cuando configuremos Firebase, aunque otras personas accedan a nuestra configuración, no van a poder mandar notificaciones push porque va a estar amarrado a un id de la aplicación.

## Cambiar id de la aplicación

El identifier de la aplicación es lo que hace que dos aplicaciones con el mismo nombre sean distintas. Tenemos que cambiar ese id tanto en la carpeta de ios como en la de android, ya que, si ejecutamos el comando `dart pub global activate flutterfire_cli` que aparece en `https://firebase.flutter.dev/docs/overview/`, va a crear la configuración basada en el identificador que tiene nuestra aplicación, que, dada la forma en la que hemos creado el proyecto, es bastante genérico.

Para Android, será `com.example.push_app`, es decir `com.example.` concatenado con el nombre que le hayamos dado al proyecto.

Para IOs, será `com.example.pushApp`, es decir, `com.example` concatenado con el camel case del nombre del proyecto, sin guiones de ningún tipo.

Si queremos publicar esto en la Apple Store o la Google Play Store, vamos a tener problemas, porque seguro que ese nombre ya existe.

Busco, usando VSCode, todos los sitios donde aparezca ese nombre y lo cambio, para Android, por el nombre `com.jmmunozmanzano.push_app`. Además, ir a la ruta `android/app/src/main/kotlin/com` y sustituir el directorio `example` por `jmmunozmanzano`.

Para IOS, se puede cambiar ejecutando el archivo `Runner.xcworkspace`. Se abrirá el programa `Xcode`, ir a TARGETS Runner, tab Signing & Capabilities, y cambiar, en Signing, el Bundle Identifier a `com.jmmunozmanzano.pushApp`. Si no está asignado, también indicamos el Team. Pero también se puede cambiar al igual que se ha hecho en Android, es decir, buscando en VSCode y cambiando a mano. Es posible que de esta última forma se evite algún problema al configurar Flutter con Firebase.

Ahora ya si podemos hacer la configuración de Firebase. Tener en cuenta que Firebase va a amarrar nuestro bundle id o package identifier para configurarlo y permitir la comunicación de solo ese id con Firebase. Si se hiciera después, tendríamos que volver a configurar Firebase de nuevo.

NOTAS:

- Una mejor forma para crear el proyecto Flutter y así evitar todas las modificaciones de esta clase, es realizarlo con el CLI, en mi opinión es más sencillo. Aquí dejo un ejemplo:

`flutter create --org com.jmmunoz push_app`

Con ese comando, Flutter, al crear el proyecto, ya nos genera el ID correcto en cada uno de los archivos, por lo que no tendríamos que cambiarlo luego manualmente uno por uno.

- Otra opción muy sencilla para evitar tener que renombrar el nombre del dominio es editar el archivo settings.json de la configuración de vscode y añadir la linea:

`"dart.flutterCreateOrganization": "es.nombredeorganizacion",`

Tal y como viene en la documentación de Flutter (https://dartcode.org/docs/settings/#dartfluttercreateorganization).

¿Qué pasa con los que usamos un dispositivo físico?

Si estás usando un dispositivo físico para probar tu aplicación, no hay ninguna interacción directa con el archivo AndroidManifest.xml. El archivo de manifiesto se utiliza principalmente para configurar aspectos como los permisos de la aplicación, las actividades principales, los servicios, etc. Por lo tanto, los cambios en este archivo no afectarán directamente la funcionalidad en un dispositivo físico.

¿También tenemos que hacer el renombre?

Por lo que sí, es necesario realizar los cambios que se indican para poder continuar.

¿Afecta de alguna manera al dispositivo físico como que no lo encuentra?

Realizar cambios en el archivo AndroidManifest.xml no debería afectar la capacidad de tu aplicación para ejecutarse en un dispositivo físico, a menos que realices cambios que impidan que la aplicación se ejecute correctamente debido a configuraciones incorrectas en el manifiesto. Por lo tanto, es importante revisar cuidadosamente los cambios que realices en el archivo de manifiesto para asegurarte de que no haya errores que puedan afectar el funcionamiento de la aplicación en un dispositivo físico.

## Configurar Flutter con proyecto de Firebase

Ahora ya si que podemos hacer la configuración de Firebase con nuestra aplicación de Flutter `https://firebase.flutter.dev/docs/overview/`.

- En VSCode, usando Pubspec Assist, indicamos: `firebase_core`
- Ejecutamos en el terminal, en la carpeta del proyecto: `dart pub global activate flutterfire_cli`

  - Haced caso de este Warning, si sale:
  - ```
      Warning: Pub installs executables into $HOME/.pub-cache/bin, which is not on your path.
      You can fix that by adding this to your shell's config file (.zshrc, .bashrc, .bash_profile, etc.):

      export PATH="$PATH":"$HOME/.pub-cache/bin"
    ```

- Ejecutamos en el terminal, en la carpeta del proyecto: `flutterfire configure`
  - Seleccionamos el proyecto que creamos antes en Firebase, en mi caso, el id del proyecto es `flutter-projects-29ae9`
  - Seleccionamos las configuraciones que vamos a querer para este proyecto, en mi caso solo android e ios (se desmarcan los checks pulsando la barra espaciadora)

Cuando terminemos, veremos que en la carpeta `lib` se ha creado un fuente `firebase_options.dart`. Este archivo se puede usar para hacer cualquier otra configuración, por si queremos más tarde usar storage, mensajería... Este mismo archivo se puede usar.

## Inicializar la aplicación de Firebase en Flutter

Antes de intentar levantar el proyecto, todavía nos hace falta realizar un par de pasos.

Seguimos con los pasos de la web: `https://firebase.flutter.dev/docs/overview/`, aunque lo vamos a hacer un poco distinto para centralizarlo en nuestro Bloc.

`WidgetsFlutterBinding.ensureInitialized();` Esta línea nos la llevamos a `main.dart`.

```
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
```

Y esta parte la centralizamos en nuestro Bloc, en la carpeta `presentation/blocs`, archivo `notifications_bloc.dart`.

Ya podemos levantar la aplicación.

NOTA: Me ha dado un error ` Could not resolve all files for configuration ':app:debugRuntimeClasspath'.` que he solventado de la siguiente forma:
En el archivo `android/app/build.gradle` he modificado la version Java de la 1.8 a la 17:

```
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_17
        targetCompatibility JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = '17'
    }
```

Pero además he borrado el sdk y lo he vuelto a bajar de nuevo. También he bajado una versión NDK en IntelliJ Idea.

![alt NDK Version](../Images/08_NDK_Version.png)

Una vez me ejecuta la aplicación, pulso el engranaje y cuando me pregunta por el permiso pulso `Allow`.
