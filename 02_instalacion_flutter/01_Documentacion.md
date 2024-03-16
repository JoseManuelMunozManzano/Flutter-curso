# Instalación de Flutter y Virtuales - Mac y Windows

Esta sección está dedicada a la instalación y preparación de:

- Flutter
  - Windows
  - Mac
- Equipos virtuales
  - Windows
  - Mac
- Correr aplicación en dispositivos físicos
  - Android - Windows y Mac
  - iOS - Mac

https://docs.flutter.dev/get-started/install

En mi proceso de instalación en iOS (un iPhone), se me presentaron inconvenientes que dejé grabados en video para que les sirva a ustedes si alguna vez les llegan a pasar.

## Windows - Mac - Instalación de Android Studio

Tenemos que instalar Android Studio y:

- Android SDK
- Android SDK Command-line Tools
- Android SDK Build-Tools

## Windows - Instalación de Flutter

Flutter no se instala como tal, sino que descargamos Flutter, lo descomprimimos y nos lo llevamos a una carpeta de escritura pública (no Program Files, pero si por ejemplo C:\src\flutter).

Esa carpeta será el path que asignaremos para conectarnos. En concreto, `C:\src\flutter\bin`

Una vez añadido el path a nuestro environment, ejecutar `flutter doctor` para hacer una verificación de la instalación de Flutter en nuestro equipo, va a actualizar ciertas cosas si las ve necesarias y nos va a dar un resumen para que sepamos si nuestro ordenador está listo para ejecutar Flutter.

Probablemente indique que hay que actualizar las licencias. Esto se hace con el comando `flutter doctor --android-licenses`

## Windows - Emuladores

Configuración de máquinas virtuales.

En Android Studio acceder a Virtual Device Manager y pulsar en `Create virtual device`

Seleccionar New Hardware Profile y para RAM indicar la máxima que podamos.

Una vez creado se selecciona y se pulsa Next.

Ahora hay que descargar una versión de Android.

Una vez descargada, en la parte Verify Configuration, en Emulated Performance, si tenemos tarjeta de video independiente, seleccionar Hardware - GLES 2.0. Si no sabemos si tenemos tarjeta de video, seleccionar Automatic.

Pulsar el botón Hide Advanced Settings y, en Boot option seleccionar Quick boot, para evitar que el emulador se apague. Indicar un Multi-Core de 4 y en Memory and Storage, en la parte RAM seleccionar el máximo de GB que podamos. Lo más importante es Internal Storage, donde debemos indicar un mínimo de 4 GB para permitir varios despliegues sin tener que estar borrando despliegues anteriores.

Una vez terminamos la configuración, pulsaremos el botón Play para que se empiece a ejecutar el AVD.

Debería aparecer el emulador de Android.

## Mac - Instalación de Flutter

https://docs.flutter.dev/get-started/install/macos/mobile-ios?tab=download

Ejecutar `sudo softwareupdate --install-rosetta --agree-to-license`

Flutter no se instala como tal, sino que descargamos Flutter, lo descomprimimos y nos lo llevamos a una carpeta sin privilegios de administrador.

Creamos una carpeta Development en el root del usuario y llevamos ahí la carpeta de Flutter descomprimida.

Actualizamos flutter en nuestro path: `export PATH=$HOME/Development/flutter/bin:$PATH`

Para ello editamos el archivo .zshrc y añadimos ese export.

Ejecutamos .zshrc para que tome esos cambios.

Una vez añadido el path, ejecutar `flutter doctor` para hacer una verificación de la instalación de Flutter en nuestro equipo, va a actualizar ciertas cosas si las ve necesarias y nos va a dar un resumen para que sepamos si nuestro ordenador está listo para ejecutar Flutter.

Probablemente indique que hay que actualizar las licencias. Esto se hace con el comando `flutter doctor --android-licenses` Pulsar y cuando pregunte.

Volver a ejecutar `flutter doctor`

Puede que pida instalar las CocoaPods. Para ello ejecutar `brew install cocoapods`

Volver a ejecutar `flutter doctor`

## Mac - iOS Setup

Seguir esta documentación:

https://docs.flutter.dev/get-started/install/macos/mobile-ios?tab=download#configure-ios-development

Para abrir el simulador de iOS ejecutar `open -a Simulator` o en Spotlight ejecutar `simulator`

## Mac - Android Emulator

Seguir este documentación:

https://docs.flutter.dev/get-started/install/macos/mobile-android?tab=download#configure-android-development

Configuración de máquinas virtuales.

En Android Studio acceder a Virtual Device Manager y pulsar en `Create virtual device`

En IntelliJ hay que crear un proyecto de Android y luego ir a Tools/Android/Device Manager y pulsar el botón +

En la ventana que se abre pulsar New Hardware Profile

En Device Name indicar `S23`
En Screen size indicar `6,9`
En Resolution indicar `1440 x 3088`
En Memory indicar `4GB` o más, todo lo que se pueda
Pulsar Finish

Seleccionar el dispositivo `S23` recién creado y pulsar Next
Seleccionar la versión de Android y pulsar Next
En Graphics seleccionar `Hardware - GLES 2.0`
Pulsar el botón `Show Advanced Settings`
En Memory and Storage, RAM seleccionar `4GB`
En Memory and Storage, Internal Storage seleccionar `4GB`
Pulsar el botón Finish

Pulsar el botón Play para iniciar el emulador.

## Mac - Probar simuladores

En VSCode vamos a crear un proyecto simple desde cero.

Para ello pulsar Cmd+Shift+P y escribir Flutter.

Seleccionar Flutter: New Proyect

Seleccionar Application y la ruta donde queremos guardar el proyecto.

Dejar el nombre por defecto.

Se generará el proyecto.

Abrimos los simuladores. Se puede hacer desde VSCode.

Para ejecutar en el simulador pulsar en VSCode, Cmd+Shift+P y seleccionar Fluter: Select Device

Seleccionar el dispositivo y estando en el fuente main.dart, pulsamos F5.

La primera ejecución tarda porque se está creando la aplicación.

Seleccionar ahora el dispositivo de Android. Para ejecutar a la vez en los dos dispositivos, en el proyecto de Flutter buscar la carpeta lib, fuente main.dart, pulsar botón derecho y seleccionar Start Debugging

Si da algún error de Flutter se puede solucionar corrigiendo la versión. Para eso, ir a la carpeta del proyecto /android/gradle/wrapper y en el fuente gradle-wrapper.properties elegir la versión de gradle que tenemos instalada en el Mac.

## Mac - Probar en un iPhone físico

https://docs.flutter.dev/get-started/install/macos/mobile-ios?tab=physical

Importante aquí:

Ejecutar, de la carpeta del proyecto, carpeta ios, el fuente Runner.xcworkspace

Tendremos que firmar y elegir un nombre único.

Luego, en VSCode, pulsar Cmd+Shift+P y seleccionar Fluter: Select Device

Seleccionar el iPhone físico, que tendrá que estar conectado, y pulsar F5
