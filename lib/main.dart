import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:jele_app/firebase_options.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  _initTalker();

  final config = AppConfig(
    localNotificationsPlugin: FlutterLocalNotificationsPlugin(),
    firebaseMessaging: FirebaseMessaging.instance,
  );

  runApp(JeLeApp(config: config));
}

Talker _initTalker() {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug('Talker started...');
  return talker;
}
