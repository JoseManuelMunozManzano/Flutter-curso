import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:push_app/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  // Cogemos esta declarción de código de https://firebase.flutter.dev/docs/messaging/permissions
  // Permite escuchar y emitir mensajería a través de este objeto.
  //
  // Usualmente toda la mensajería ocurre en el lado del backend. Nuestras apps le mandan al
  // backend, y este sabe a quien mandarle la notificación.
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(const NotificationsState()) {

    on<NotificationStatusChanged>(_notificationStatusChanged);

    // Llamamos después de crear todos los listeners.
    // Queremos que toda la lógica esté en los blocs, no en main.dart
    _initialStatusCheck();

    // Listener para notificaciones en Foreground.
    _onForegroundMessage();

  }

  // Es estático porque no necesito, ni voy a tener acceso al context en ese momento,
  // para crear la primera instancia.
  // FCM significa Firebase Cloud Messaging, y es muy común ver estas siglas.
  static Future<void> initializeFCM() async {
     await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void _notificationStatusChanged(NotificationStatusChanged event, Emitter<NotificationsState> emit) {
    emit(
      state.copyWith(
        status:  event.status
      )
    );

    // Obtenemos el token
    _getFCMToken();
  }

  void _initialStatusCheck() async {
    // Notar que, a diferencia de en requestPermission, donde se pide el permiso,
    // aquí solo se comprueba cual es el estado de los permisos.
    final settings = await messaging.getNotificationSettings();

    // Disparamos el evento.
    // Esto es síncrono.
    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  // Si lo autorizamos, queremos obtener el token que va a tener esta instalación
  // de la app. Con ese token podemos mandar notificaciones a ese cliente en particular.
  // En BD, en el backend, sería algo así:
  /*
    jmm@gmail.com: [
      token1
      token2
      token3
    ]
  */
  // Porque un usuario puede tener varios dispositivos.
  void _getFCMToken() async {

    // Forma 1
    // final settings = await messaging.getNotificationSettings();
    // if (settings.authorizationStatus != AuthorizationStatus.authorized) return;

    // Forma 2 usando nuestro state
    if (state.status != AuthorizationStatus.authorized) return; 

    final token = await messaging.getToken();
    print(token);
  }

  // Foreground Message, es decir, cuando se está usando la aplicación.
  void _handleRemoteMessage(RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification == null) return;

    print('Message also contained a notification: ${message.notification}');    
  }

  void _onForegroundMessage() {
    // Cuando veamos un .listen es un stream.
    // OJO. Los streams solo hay que inicializarlos una vez.
    // No queremos limpiarlo nunca porque siempre vamos a estar atentos a que vengan notificaciones.
    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);

    // Si quisiéramos limpiarlo:
    // final listener = FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
    // listener.cancel();
  }
 
  // Esto sería algo así como un método del Provider.
  // Lo vamos a mandar a llamar cuando tocamos el engrane de la pantalla.
  void requestPermission() async {
    // Cogemos este código de https://firebase.flutter.dev/docs/messaging/permissions
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    // Disparamos el evento
    add(NotificationStatusChanged(settings.authorizationStatus));
  }
}
