# Despligues a Play Store y Apple App Store

Esta sección está dedicada a la preparación y subida de nuestras aplicaciones a las tiendas (PlayStore y AppStore)

Puntualmente veremos:

- Renombrar app fácilmente y automáticamente
- Splash Screens
- Icono de la aplicación
- Android Developer Console
- Apple Developer Portal
- Alphas y Betas - Android
- TestFlight - Apple
- AAB - Application Bundle Android
- IPA - IOS
- Entre otras generalidades

El objetivo es poder subir la aplicación e iniciar el proceso de revisión y pruebas de múltiples usuarios sin necesidad de que ellos tengan cuentas de developer en las respectivas plataformas.

## Preparación del proyecto a subir

Para poder desplegar en la AppStore tenemos que hacer una app con cierto nivel de programación, es decir, si es una app muy facilona o para aprender sencillota, la AppStore lo va a saber y no nos va a dejar desplegarla.

Vamos a desplegar la app de `cinemapedia`.

Cargamos la app en VSCode y la probamos en el simulador de Android. Lo probamos primero aquí porque vamos a hacer la parte del despliegue primero en la PlayStore. Una vez esté ahí podemos hacer pruebas abiertas, pruebas cerradas, pasarlo o promover el proyecto a un release, ya de producción, y el procedimiento es muy transparente.

También hay un punto donde se pide que personalicemos el icono y el splash screen, porque si lo dejamos por defecto con el de Flutter va a ser rechazada en la AppStore (a lo mejor no en la PlayStore)

Otra cosa que vamos a tener que cambiar también, es, en la ruta `android/app/main/kotlin`, el budle de nuestra app, que ahora mismo es `com.example.cinemapedia`. Ese bundle id tenemos que cambiarlo porque probablemente ya esté tomado, aunque igualmente ese nombre de bundle id no vale. Durante la realización de las notificaciones push aprendimos a cambiar ese nombre manualmente, pero aquí lo vamos a hacer de una manera automática.
