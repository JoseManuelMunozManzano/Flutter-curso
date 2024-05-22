import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
