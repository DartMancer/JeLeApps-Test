import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppConfig {
  AppConfig({
    required this.localNotificationsPlugin,
    required this.firebaseMessaging,
  });
  final FlutterLocalNotificationsPlugin localNotificationsPlugin;
  final FirebaseMessaging firebaseMessaging;
}
