import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push_app/config/router/app_router.dart';


class LocalNotifications {


  static Future<void> requestPermissionLocalNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> initializeLocalNotifications() async {
    
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // El app_icon lo va a buscar en la carpeta android/app/src/main/res/drawable/
    // Ahí no había ningún app_icon.png, lo he cogido de la carpeta mipmap-xhdpi, lo he copiado
    // a drawable y le he cambiado el nombre a app_icon.png
    const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

    // TODO: iOs configuration

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // TODO: iOs configuration settings
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse
    );
  }
  
  static void showLocalNotification({
    // Aquí no hay nada con el id porque el método es estático. Lo hago en notifications_bloc.dart
    required int id,
    String? title,
    String? body,
    String? data,
  }) {

    const androidDetails = AndroidNotificationDetails(
      'channelId',
      'channelName',
      playSound: true,
      // El archivo de audio que me he bajado de la clase, hay que depositarlo en la ruta: 
      // `android/app/src/main/res/` y dentro me creo la carpeta `raw`
      // y dentro colocamos el archivo de audio.
      sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      // TODO: iOs
    );

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails, payload: data);
  }

  // Lo creo static para no tener que crear una instancia y que solo tenga que mandar
  // la referencia de esta función.
  static void onDidReceiveNotificationResponse(NotificationResponse response) {
    // Aquí podemos hacer lo que necesitemos con el payload.

    // Esto también genera una dependencia oculta. También podríamos mandar la función
    // como hemos hecho antes para evitar las dependencias ocultas.
    appRouter.push('/push-details/${response.payload}');
  }
}
