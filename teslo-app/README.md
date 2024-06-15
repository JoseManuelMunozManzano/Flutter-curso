# teslo-app

Este es un proyecto para trabajar con:

- Cámara
- Tokens de acceso
- CRUD (Create Read Update Delete) Rest API Endpoints
- Riverpod
- GoRouter

**1**
Vamos a hacer un login que se puede usar en la vida real.

Esta sección principalmente se enfoca en:

- Realizar el POST HTTP
- Obtener las credenciales del usuario
- Manejo de errores personalizados
- Manejo del estado del formulario con Riverpod
- Comunicación entre providers
- Entre otras cosas

Esta sección empieza a dejar las bases de la autenticación mediante JWT (Json Web Tokens) el cual es un estándar hoy en día y probablemente lo terminarán utilizando en la vida real.

De nuevo, mi objetivo es tratar de enseñarles lo más apegado a la realidad posible, para que la experiencia les sirva tanto como para aprender Flutter, como para mejorar sus habilidades como desarrolladores en general.

## Inicio de la aplicación

En este caso, en vez de partir de puro cero, descargamos un proyecto inicializado de la ruta: `https://github.com/Klerith/flutter-authenticated-crud/tree/01-basic-ui`

Al llevarnos este directorio a VSCode nos indicará si queremos instalar las dependencias (Run `pub get`). Indicamos que
Si.

Por ahora, vamos a hacer el desarrollo para Android, porque vamos a ver algunos problemas que vamos a tener con ciertas direcciones.

Indicar que tenemos ciertos `assets` y una carpeta `google-fonts` que, en principio debería estar dentro de assets, pero que se recomienda que esté fuera.

Dentro de la carpeta `lib` vemos una segunda forma de trabajar. Tenemos la carpeta `config` con configuraciones globales, y una carpeta de `features` con carpetas que agrupan características por funcionalidad. Tenemos todo lo de la autenticación en la carpeta `auth` y todo lo de productos en la carpeta `products` y lo que no depende por entero de ninguno lo tenemos en la carpeta `shared`.

Para el uso de Custom Painter ver: `https://www.youtube.com/watch?v=GpxkQegspCk`

## Levantar el backend

Seguir los pasos de ejecución de la parte backend: `teslo-shop-backend`.

Si vemos ese proyecto, vemos que falta el `restart: always` en la parte de `nest-app`. Está hecho a conciencia para ir a Docker de vez en cuando a levantarlo.

Probar con Postman (los scripts están en el proyecto `teslo-shop-backend`) que se puede hacer login.

## Riverpod - Inputs y LoginState

Vamos a dejar los inputs de una manera bien general para poder reutilizarlos. Por eso, en la carpeta `features/shared` creamos la carpeta `infrastructure` y dentro otro directorio llamado `inputs`. Dentro crearemos el archivo de barril `input.dart` y los archivos `email.dart` y `password.dart`.

Hemos instalado, usando `Pubspec Assist` los paquetes: `formz, flutter_riverpod`.

Ahora vamos a la parte de autenticación. En la carpeta `features/auth/presentation` creamos la carpeta `providers` ya que vamos a trabajar con Riverpod, que trabaja en base a providers. Vamos a hacer los pasos iniciales de como quiero trabajar el estado de login. Creamos el archivo provider `login_form_provider.dart` y el archivo de barril `providers.dart`.

Ver: `https://pub.dev/packages/riverpod` y `https://riverpod.dev/docs/introduction/getting_started`

## LoginForm Provider y Notifier

Nos hemos instalado en VSCode, siguiendo la documentación `https://riverpod.dev/docs/introduction/getting_started#going-further-installing-code-snippets`, el plugin de VSCode `Flutter Riverpod Snippets`.

Con esto, en el fuente `login_form_provider.dart`, solo escribiendo `stateNotifier` se genera automáticamente un StateNotifier. Y, solo escribiendo `stateNotifierProvider` se genera el código del Notifier Provider automáticamente.

## Testing

Seguir los pasos de ejecución de la parte backend: `teslo-shop-backend`.
