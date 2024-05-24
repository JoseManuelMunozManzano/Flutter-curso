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

    // on<NotificationsEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

  }

  // Es estático porque no necesito, ni voy a tener acceso al context en ese momento,
  // para crear la primera instancia.
  // FCM significa Firebase Cloud Messaging, y es muy común ver estas siglas.
  static Future<void> initializeFCM() async {
     await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
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

    settings.authorizationStatus;
  }
}
