# cinemapedia

Esta sección dejará las bases de todo lo que empezaremos a construir aquí y en un par de secciones adicionales.

Lo más importante de esta sección es comprender los principios de arquitectura limpia que se siguen (todos menos casos de uso)

La idea es que desde el inicio comencemos a crear código reutilizable, estructurado y con la posibilidad de expandirlo desde el inicio, de esta manera será más simple poder añadir nuevas funcionalidades a futuro.

Puntualmente veremos:

- Datasources
  - Implementaciones
  - Abastracciones
- Repositorios
  - Implementaciones
  - Abstracciones
- Modelos
- Entidades
- Riverpod
  - Provider
  - StateNotifierProvider
  - Notifiers
- Mappers

Todo el objetivo de la sección es poder establecer los cimientos ordenados de nuestra arquitectura para reforzarlos y verlos en la práctica.

## TMDB

https://www.themoviedb.org/

https://developer.themoviedb.org/docs/getting-started

https://developer.themoviedb.org/docs/authentication-application

## Reforzamiento de conceptos de arquitectura

A continuación vamos a ver:

- Entidades
- Datasources
  - Abstractos
  - Implementaciones
- Repositories
  - Abstractos
  - Implementaciones
- Gestor de Estado e interacciones con él

### Entidades

Podemos pensar en las entidades como objetos que son y serán idénticos entre diferentes aplicaciones de nuestra empresa.

Por ejemplo, Tesorerías será el mismo objeto en distintas aplicaciones y se puede reutilizar.

No estamos hablando de Bases de Datos.

### Datasources

Son las fuentes de datos.

No debería importar de donde venga la data.

Si de TheMovieDB, IMDB, Netflix API, etc.

### Repositories

Son quienes llamas a nuestro datasources.

Deben de ser flexibles para poder cambiar los datasources en cualquier momento sin afectar nuestra aplicación.

### Gestor de estado

Sirve de puente entre nuestros casos de uso (en este caso el repositorio) y realizan los cambios visuales en los Widgets.

En caso de una implementación completa de arquitectura limpia, el gestor de estado llama casos de uso, y estos al repositorio.

### Abstractos vs Implementaciones

Hablamos de clases abstractas cuando creamos clases que establecen las reglas de negocio.

Hablamos de implementaciones cuando creamos clases que implementan las reglas de negocio indicadas por las clases abstractas.

### Resumen

- Las Entidades son atómicas (las unidades más pequeñas)
- Los Repositorios (sus implementaciones) llaman a los Datasources (a una abstracción del Datasource)
- Las implementaciones de los Datasources son quienes hacen el trabajo
- El Gestor de estado es el puente que ayuda a realizar los cambios en el UI

## Estructura de carpetas del proyecto

- `config`
  - `constants` con la variables de entorno
  - `router` con el sistema de configuración de rutas
  - `theme` con nuestro tema, que no va a ser tan dinámico, pero queda organizado
- `domain` tenemos nuestras reglas de negocio
  - `datasources` con los origenes de datos. Definimos las reglas que una fuente de información debe de tener para que yo puede traer esa data y usarla en mi app. Aquí solo tenemos la parte abstracta
  - `entities` con la data más apegada a las reglas de negocio. No depende de la BD
  - `repositories` es similar a los datasources, con la diferencia de que nosotros llamamos al repositorio para acceder al datasource. Un repositorio envuelve al datasource, de forma que podemos cambiar el datasource, pero el repositorio debería ser el mismo. Aquí solo tenemos la parte abstracta
- `infrastructure` también llamada data
  - `datasources` es donde están las implementaciones de nuestros datasources. Cada archivo aquí situado debería hacer solo una tarea
  - `mappers` donde, dada la data recibida de una manera, digamos a través de una API, se transforma a la información como la vamos a necesitar en otras entidades. Si cambia la API, solo tendré que cambiar el mapper
  - `models` nos sirve para tipar una respuesta HTTP, evitando tener que usar la notación objeto["campo"], sino objeto.campo, facilitando el trabajo con el mapper
  - `repositories` es donde tenemos la implementación del repositorio
- `presentation`
  - `providers` donde vamos a usar Riverpod y sirven de puente de conexión entre las capas anteriores y la capa de presentación. Todos nuestros Widgets deberían de interactuar de alguna manera con nuestros providers para que sean ellos quienes interactuen allá fuera. Si el día de mañana cambia nuestro gestor de estado (pasar a Bloc por ejemplo) si que va a necesitar trabajo, pero todo lo demás queda igual
  - `screens` donde indicamos nuestras pantallas UI

## Creación de proyecto desde VSCode

- Pulsar Cmd+Shift+P
- Escribir y seleccionar Flutter: New Project
- Seleccionar Application
- Seleccionar el directorio donde guardaremos el proyecto
- Indicar el nombre del proyecto, que deberá ser todo en minúsculas, y, si se separa por palabras, usar el guión bajo.
  - Nuestro proyecto se llama: `yes_no_app`

## Lanzar emulador

- Pulsar Cmd+Shift+P
- Escribir y seleccionar Flutter: Launch Emulator
  - Yo voy a hacer las pruebas con el simulador de iOS
- Estando en el archivo main.dart, volver a pulsar Cmd+Shift+P
- Escribir y seleccionar Flutter: Select Device
- Seleccionar el dispositivo iOS
- Pulsar F5

## Inicio de aplicación - Estilo y Router

Empezamos creando, dentro de la carpeta `lib` la carpeta `config` y dentro las carpetas `theme` y `router`.

En `theme` creamos el archivo `app_theme.dart`.

En `router` creamos el archivo `app_router.dart`. Tenemos que instalar `go_router`.

De nuevo, dentro de la carpeta `lib` creamos la carpeta `presentation`, dentro la carpeta `screens` y dentro la carpeta `movies` donde situaremos todas las pantallas relacionadas con movies.

En `movies` creamos el archivo `home_screen.dart`.

Y como sabemos que vamos a tener más screens, en la carpeta `screens` creamos el archivo de barril `screens.dart`.

## Entidad - Repositorios y Datasources

Empezamos creando, dentro de la carpeta `lib` la carpeta `domain`.

Dentro de `domain` vamos a crear las carpetas `entities`, `datasources` y `repositories`.

En la carpeta `entities` creamos la entidad `movie.dart`.

En la carpeta `datasources` creamos el datasource `movies_datasource.dart` donde NO va la implementación, sino el contrato que deben cumplir los fuentes que lo implementen.

En la carpeta `repositories` creamos el repositorio `movies_repository.dart` donde NO va la implementación, sino el contrato que deben cumplir los fuentes que lo implementen.

Los repositorios van a llamar al datasource, porque el repositorio me va a permitir que se pueda cambiar el datasource sin que afecte al resto de la aplicación.

## Variables de entorno

Creamos en la raiz del proyecto el archivo `.env` y ahí indicamos nuestra clave de TMDB.

Flutter no sabe de la existencia del archivo `.env` y no los maneja por defecto. Tenemos que configurarlo.

Hay muchos paquetes que sirven para manejar los archivos de variables de entorno.

Vamos a usar: https://pub.dev/packages/flutter_dotenv

En esa URL puede verse la documentación para configurarlo en nuestra app de Flutter.

Para no tener que estar acordándonos de los nombres de nuestras variables de entorno, en la carpeta `config` creamos una carpeta `constants` y dentro un archivo llamado `environment.dart`.

El objetivo de esta clase `Environment` es alojar las variables de entorno, definidas estáticamente, para que sean fáciles de utilizar.

## Datasource - Obtener películas en cines

Vamos a implementar el método `getNowPlaying()` de la clase abstracta `MoviesDatasource`.

Para ello, en la carpeta `lib` creamos la carpeta `infrastructure`, que contendrá las implementaciones de los métodos que están en nuestra carpeta `domain`. Dentro creamos la carpeta `datasources` y dentro creamos el fuente `moviedb_datasource.dart`.

## TheMovieDB - Modelos

En la carpeta `infrastructure` creamos la carpeta `models`, dentro creamos la carpeta `moviedb` y dentro creamos dos archivos: `moviedb_response.dart` y `movie_moviedb.dart`.

## MovieMappers - MovieDB hacia MovieEntity

Como el modelo de datos de MovieDB (`infrastructure/models/moviedb/movie_moviedb.dart`) puede cambiar, lo que hacemos es mapear ese modelo al nuestro (`domain/entities/movie.dart`), que será fijo y no cambia. Con nuestra entidad, seguiremos trabajando en nuestra app.

En la carpeta `infrastructure` creamos la carpeta `mappers` y dentro el archivo `movie_mapper.dart`, cuya única misión es leer los diferentes modelos que pueda haber y crear mi entidad.

## MovieRepository - Implementación

En la carpeta `infrastructure` creamos la carpeta `repository`

## Testing

En Postman ejecutar un `GET` con la siguiente ruta: `https://api.themoviedb.org/3/movie/550?api_key=my_key&language=es-ES` donde `my_key` es la clave de la cuenta de TMDB para confirmar que nuestra key funciona correctamente.
