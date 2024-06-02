import 'package:flutter_local_notifications/flutter_local_notifications.dart';


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
      // TODO
      // onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse
    );
  }
}
