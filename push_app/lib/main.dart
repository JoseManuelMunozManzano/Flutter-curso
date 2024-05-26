import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/config/router/app_router.dart';

import 'package:push_app/config/theme/app_theme.dart';
import 'package:push_app/presentation/blocs/notifications/notifications_bloc.dart';

// Transformado a función asíncrona al haber añadido la parte de asegurar
// que se ha inicializado nuestro FlutterBindding
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await NotificationsBloc.initializeFCM();

  runApp(
      // Este bloc irá en el nivel más alto de la app, porque en cualquier momento
      // puedo recibir una notificación push, y quiero reaccionar basado en esa notificación,
      // ya sea navegar a una pantalla en particular o leer la notificación, o almacenarla...
      MultiBlocProvider(
          providers: [BlocProvider(create: (_) => NotificationsBloc())],
          child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      // El child es este mismo Widget.
      // Es decir, estamos envolviendo toda la app en este StatefulWidget.
      // Esto es para poder hacer por fuera la parte de la interacción con la notificación.
      builder: (context, child) =>
          HandleNotificationInteractions(child: child!),
    );
  }
}

class HandleNotificationInteractions extends StatefulWidget {
  // Este mismo child es luego retornado.
  final Widget child;

  const HandleNotificationInteractions({super.key, required this.child});

  @override
  State<HandleNotificationInteractions> createState() =>
      _HandleNotificationInteractionsState();
}

class _HandleNotificationInteractionsState extends State<HandleNotificationInteractions> {

  // Ver: https://firebase.flutter.dev/docs/messaging/notifications#handling-interaction
  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {

    // Esto es síncrono.
    context.read<NotificationsBloc>().handleRemoteMessage(message);

    // Esto también se podría haber centralizado en el bloc, ya que es la segunda vez que lo hacemos
    final messageId = message.messageId?.replaceAll(':', '').replaceAll('%', '');

    // Navegamos a la segunda pantalla.
    // Como puede que todo haya ido tan rápido que no esté inicializado el router en el context, usamos
    // directamente nuestra variable appRouter.push en vez de context.push
    appRouter.push('/push-details/$messageId');
  }

  @override
  void initState() {
    super.initState();

    // Run code required to handle interacted messages in an async function
    // as initState() must not be async
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
