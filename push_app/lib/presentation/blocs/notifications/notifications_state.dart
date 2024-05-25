part of 'notifications_bloc.dart';

// Solo necesitamos una clase para manejar el estado
class NotificationsState extends Equatable {

  // Este tipo viene de firebase_messaging.dart, que se importa en notifications_bloc.dart
  final AuthorizationStatus status;

  // Para poder manejar la data de una manera centralizada.
  final List<PushMessage> notifications;

  const NotificationsState({
    this.status = AuthorizationStatus.notDetermined,
    this.notifications = const[]
  });

  NotificationsState copyWith({
    AuthorizationStatus? status,
    List<PushMessage>? notifications,
  }) => NotificationsState(
    status: status ?? this.status,
    notifications: notifications ?? this.notifications
  );
  
  @override
  List<Object> get props => [status, notifications];
}
