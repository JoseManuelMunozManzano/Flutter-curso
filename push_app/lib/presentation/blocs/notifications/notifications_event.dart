part of 'notifications_bloc.dart';

// Hemos quitado Equatable porque para los eventos no suele hacer falta.
sealed class NotificationsEvent {
  const NotificationsEvent();
}

class NotificationStatusChanged extends NotificationsEvent {
  final AuthorizationStatus status;

  NotificationStatusChanged(this.status);
}

class NotificationReceived extends NotificationsEvent {
  final PushMessage message;

  NotificationReceived(this.message);
}
