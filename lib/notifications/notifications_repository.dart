import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notifications.dart';

class NotificationsRepositoryImpl implements NotificationsRepositoryI {
  NotificationsRepositoryImpl({
    required FlutterLocalNotificationsPlugin localNotifications,
    required FirebaseMessaging firebaseMessaging,
  })  : _firebaseMessaging = firebaseMessaging,
        _localNotifications = localNotifications;

  final FlutterLocalNotificationsPlugin _localNotifications;
  final FirebaseMessaging _firebaseMessaging;

  static const _defaultChannel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  @override
  Future<void> init() async {
    final androidPlugin =
        _localNotifications.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      androidPlugin.createNotificationChannel(_defaultChannel);
    }

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        final notification = message.notification;
        final android = message.notification?.android;

        if (notification != null && android != null) {
          showLocalNotification(
            Notification(
              title: notification.title!,
              message: notification.body!,
            ),
          );
        }
      },
    );
  }

  @override
  Future<String?> getToken() => _firebaseMessaging.getToken();

  @override
  Future<bool> requestPermission() async {
    final settings = await _firebaseMessaging.requestPermission();
    final isAuthorized =
        settings.authorizationStatus == AuthorizationStatus.authorized;

    if (isAuthorized) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    return isAuthorized;
  }

  @override
  Future<void> showLocalNotification(Notification notification) async {
    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.message,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _defaultChannel.id,
          _defaultChannel.name,
          channelDescription: _defaultChannel.description,
          icon: 'ic_launcher',
        ),
      ),
    );
  }
}
