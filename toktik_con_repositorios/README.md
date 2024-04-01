# toktik_con_repositorios

Tal y como se dijo en la app toktik, quedaba preparada para usar repositorios y datasource.

Actualmente nuestra app lee los videos de forma interna, ya que están localizados en una carpeta del proyecto.

Pero sabemos que el día de mañana esos videos no van a venir de esa fuente de datos, sino que posiblemente vengan de algún servicio Http.

Cuando eso ocurra, vamos a tener que ir al Provider y hacer modificaciones. Esto violenta varios principios SOLID, DRY y de Clean Code.

Nosotros tenemos que priorizar que nuestra app no sufra muchos cambios cuando casos como este sucedan en la vida real.

¿Cómo lo conseguimos?

Vamos a usar dos conceptos fundamentales que son parte de una arquitectura limpia:

- Data Sources: Lugar de donde vamos a obtener los datos. Puede ser que tengamos datos locales, o que vengan desde una conexión Http, Https, o de distintos URLs...
- Repository: Nosotros no vamos a tratar directamente con los Data Sources. Vamos a tener una capa de repositorio que es el que va a hablar con esa fuente de datos. Cuando creamos el repositorio le mandamos un Data Source y el se encarga de llamar a los métodos que tenga nuestro Data Source. Con esto conseguimos una capa de protección y, si cambia el Data Source, no vamos a tener que cambiar nuestra app.

## Uso de arquitectura limpia

![alt Arquitectura Limpia](../Images/04_Clean_Architecture.png)

El objetivo de usar una arquitectura limpia no es hacer que nuestra app sea infalible.

A costo de crear más clases, más archivos y más código, vamos a crear diferentes capas que van a impedir que nuestra app sufra cambios, que sea más fácil de modificar y de mantener.

## Creación de proyecto desde VSCode

Se ha copiado el proyecto `toktik` y se le ha dado el nombre `toktik_con_repositorios`.

## Lanzar emulador

- Pulsar Cmd+Shift+P
- Escribir y seleccionar Flutter: Launch Emulator
  - Yo voy a hacer las pruebas con el simulador de iOS
- Estando en el archivo main.dart, volver a pulsar Cmd+Shift+P
- Escribir y seleccionar Flutter: Select Device
- Seleccionar el dispositivo iOS
- Pulsar F5

NOTA: Se recomienda probar esta aplicación en dispositivo físico porque el emulador puede tener ciertos problemas a la hora de reproducir ciertos videos.
