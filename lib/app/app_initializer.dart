import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../notifications/notifications.dart';
import 'app_config.dart';

class AppInitializer extends StatelessWidget {
  const AppInitializer({
    super.key,
    required this.config,
    required this.child,
  });

  final AppConfig config;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NotificationsRepositoryI>(
          create: (context) => NotificationsRepositoryImpl(
            localNotifications: config.localNotificationsPlugin,
            firebaseMessaging: config.firebaseMessaging,
          ),
        ),
      ],
      child: child,
    );
  }
}
