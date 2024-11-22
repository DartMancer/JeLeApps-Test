import 'package:flutter/material.dart';

import '../pages/main_screen.dart';
import 'app.dart';

class JeLeApp extends StatelessWidget {
  const JeLeApp({
    super.key,
    required this.config,
  });

  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    return AppInitializer(
      config: config,
      child: MaterialApp(
        title: 'JeLe Push Notifications',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
