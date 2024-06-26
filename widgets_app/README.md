# widgets_app

Esta sección es fundamental para cualquier aplicación de Flutter, aprenderemos cosas como:

- Navegación entre pantallas
- Nuevos widgets
  - Botones y sus variantes
  - Botones personalizados
  - Tarjetas
  - Tarjetas personalizadas
  - Align
- Rutas
  - Propias de Flutter
  - Go_Router
  - Paths
  - Configuraciones de router
    - Propio
    - De terceros
- RefreshIndicator
- InfiniteScroll
- ProgresIndicators
  - Lineales
  - Circulares
  - Controlados
- Animaciones
- Snackbars
- Diálogos
- Licencias
- Switches, Checkboxes, Radios
- Tiles
- Listas
- Pageviews
- Aprender sobre "Drawers" menú laterales
- Gestor de estado Riverpod
- Dispositivo posee (o no) notch o un espacio no visible en pantalla y evitar colocar contenido ahí
- Theme Changer

## Creación de proyecto desde VSCode

- Pulsar Cmd+Shift+P
- Escribir y seleccionar Flutter: New Project
- Seleccionar Empty Application
  - Se hace por comprender la diferencia con respecto a seleccionar Application, pero se recomienda seleccionar esta última.
- Seleccionar el directorio donde guardaremos el proyecto
- Indicar el nombre del proyecto, que deberá ser todo en minúsculas, y, si se separa por palabras, usar el guión bajo.
  - Nuestro proyecto se llama: `widgets_app`
- Empieza a generarse la app, y Flutter detecta en qué Sistema Operativo estamos para crear la estructura de directorios.

## Lanzar emulador

- Pulsar Cmd+Shift+P
- Escribir y seleccionar Flutter: Launch Emulator
  - Yo voy a hacer las pruebas con el simulador de iOS
- Estando en el archivo main.dart, volver a pulsar Cmd+Shift+P
- Escribir y seleccionar Flutter: Select Device
- Seleccionar el dispositivo iOS
- Pulsar F5 para probar que funciona

## Tema y estilos de la aplicación

En la carpeta `lib` creamos la carpeta `config` y dentro la carpeta `theme`. En esta última carpeta creamos el archivo `app_theme.dart`.

## Opciones de nuestra aplicación

Las opciones del menú pueden venir de cualquier lugar, como una petición Http, de un archivo JSON...

Para esta app las vamos a tener hardcodeadas.

En la carpeta `config` vamos a crear la carpeta `menu` y dentro el archivo `menu_items.dart`.

¿Dónde vamos a usar nuestro MenuItem? Basado en nuestro list de MenuItem iremos creando nuestra pantalla.

Como no queremos que nuestro main tenga toda la información de la aplicación, en la carpeta `lib` creamos la carpeta `presentation`, dentro la carpeta `screens`, dentro la carpeta `home` y dentro el archivo `home_screen.dart`.

## Navegación entre pantallas

https://docs.flutter.dev/ui/navigation

Antes de hacer la navegación, necesitamos más screens para navegar.

En la carpeta `presentation/screens` creamos la carpeta `buttons` y dentro el archivo `buttons_screen.dart`.

En la carpeta `presentation/screens` creamos la carpeta `cards` y dentro el archivo `cards_screen.dart`.

Recordar que sabemos que son pantallas porque tienen el Widget `Scaffold()`.

Se muestran distintas formas de realizar la navegación.

### go_router

La navegación la vamos a realizar con el paquete `go_router`.

En la carpeta `config` creamos la carpeta `router` y dentro el archivo `app_router.dart`.

Ahí pegamos el código que se encuentra en: https://pub.dev/documentation/go_router/latest/topics/Get%20started-topic.html

## Archivos de barril

En la carpeta `screens` creamos el archivo `screens.dart`.

Este archivo se encarga de exportar todos los screens.

Con esto los archivos quedan separados, pero los cogemos de un único lugar, lo que disminuye las importaciones en otros fuentes.

## Diferentes botones pre-configurados

Flutter ya viene con varios tipos de botones.

En el fuente `buttons_screen.dart`, como no queremos que todo el código quede ahí, donde se indica `Placeholder()` pulsamos `Cmd+.` y seleccionamos `Extract Widget`. Le ponemos el nombre `_ButtonsView`. Todo esto con el objetivo de ser ordenados.

## Botón personalizado

Vamos a hacer un botón desde cero, estilizado con la apariencia que nos convenga y que sea reutilizable en distintas apps.

Lo hacemos en el archivo `buttons_screen.dart`.

Se podría crear también en la carpeta de `widgets`, recibiendo argumentos del onPress, el texto o el icono que queremos mostrar...

## Cards

Las tarjetas no son más que unos agrupadores que ya tienen cierto estilo. Ya vienen preconfiguradas.

https://m3.material.io/develop/flutter

https://m3.material.io/components/cards/overview

Nuestro fuente para esto es `cards_screen.dart`.

## Resto de pantallas faltantes

Dentro de la carpeta `screens` creamos la carpeta `animated` y dentro el archivo `animated_screen.dart`.

Dentro de la carpeta `screens` creamos la carpeta `app_tutorial` y dentro el archivo `app_tutorial_screen.dart`.

Dentro de la carpeta `screens` creamos la carpeta `infinite_scroll` y dentro el archivo `infinite_scroll_screen.dart`.

Dentro de la carpeta `screens` creamos la carpeta `progress` y dentro el archivo `progress_screen.dart`.

Dentro de la carpeta `screens` creamos la carpeta `snackbar` y dentro el archivo `snackbar_screen.dart`.

Dentro de la carpeta `screens` creamos la carpeta `ui_controls` y dentro el archivo `ui_controls_screen.dart`.

## Animated Container

https://api.flutter.dev/flutter/widgets/AnimatedContainer-class.html

Es un contenedor que se puede animar.

Sería como un contenedor normal, salvo que, cuando detecta un cambio en su propiedad (salvo el punto anterior y el final), anima ese cambio.

## Tutorial de nuestra app

Se usa para mostrar los primeros pasos de la app, como funciona...

Necesitamos hacer ciertas configuraciones.

En la pura raiz del proyecto, creamos la carpeta `assets`, dentro creamos la carpeta `images` y copiamos las imágenes.

Lo normal es los tutoriales es saber en que slide estamos para mostrar algún tipo de Widget en el último.

Para animarlo convenientemente, usamos `Pubspec Assist` e instalamos `animate_do`.

## Menús laterales

Dentro de nuestro `Scaffold()` podemos usar dos propiedades más para usar menús laterales:

- drawer: Menú lateral de la izquierda de la pantalla y que se mueve a la derecha
- endDrawer: Menú lateral de la derecha de la pantalla y que se mueve a la izquierda

Para trabajar con los drawers o menús laterales tenemos el Widget `NavigationDrawer` que ya implementa el funcionamiento tradicional.

En la carpeta `presentation` creamos una carpeta `widgets` y dentro el archivo `side_menu.dart`.

## Consideraciones de Notch y Opciones del menú

Hay dispositivos con zonas donde no se puede renderizar, los llamados notch.

Como Flutter nos da control desde el pixed (0, 0), es responsabilidad nuestra saber qué queremos renderizar.

Pero hay ciertos Widgets que ya detectan de forma automática la existencia de un notch y lo evitan.

Y en otras pantallas puede aparecer, por ejemplo el Widget `NavigationDrawerDestination()` de un menú lateral, muy pegado a la parte de arriba. Esto se hace automática y se ve bien tanto en un dispositivo iOS con notch como en un Android sin él.

Por tanto, lo que tenemos que saber es si el dispositivo tiene o no Notch. Esto lo vemos en el fuente `side_menu.dart`.

## Preparación de pantalla para Riverpod

En la carpeta `presentation/screens` creamos la carpeta `counter` y dentro el archivo `counter_screen.dart`.

## Riverpod

En la carpeta `presentation` creamos la carpeta `providers` (no confundir con gestor de estado Provider, esto es para Riverpod) y el archivo `counter_provider.dart`.

En la carpeta `providers` creamos otro archivo `theme_provider.dart`.

## Pantalla para cambiar colores

En la carpeta `screens` creamos la carpeta `theme_changer` y dentro el archivo `theme_changer_screen.dart`.

Se instala la librería `colornames` para obtener el nombre de los colores.

## Riverpod - StateNotifier

La diferencia principal con un StateProvider, es que StateProvider lo usamos para un state "básico", básicamente un Boolean, Integer o String.

Cuando necesitemos trabajar con un state mas complejo, ya sea un objeto, una lista, un map... ahí usaremos StateNotifierProvider.

Tanto en isDarkModeProvider como en selectedColorProvider estamos manejando un boolean y un int, por lo que perfectamente podemos usar un StateProvider.

Ahora, en themeNotifierProvider vamos a manejar un objeto, por lo que ahí tenemos que usar StateNotifierProvider.

https://dhruvnakum.xyz/flutter-riverpod-stateprovider-statenotifier-statenotifierprovider-futureprovider-streamprovider
