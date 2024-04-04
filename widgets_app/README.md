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

El objetivo es dejar las bases necesarias para empezar a trabajar en las próximas secciones con una serie de widgets y así comprender mejor como construir nuestras aplicaciones.

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
