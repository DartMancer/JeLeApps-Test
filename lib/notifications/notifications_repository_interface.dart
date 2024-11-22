import 'models/notification.dart';

abstract interface class NotificationsRepositoryI {
  Future<void> init();
  Future<String?> getToken();
  Future<bool> requestPermission();
  Future<void> showLocalNotification(Notification notification);
}
