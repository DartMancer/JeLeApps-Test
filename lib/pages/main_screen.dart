import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jele_app/utils/logger.dart';
import '../notifications/notifications.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

const backgroundColor = Color(0xFF202020);
const primaryColor = Color(0xFFBDFF00);
final textColor = Colors.grey.shade300;

class _MainScreenState extends State<MainScreen> {
  String _token = 'Загрузка...';

  @override
  void initState() {
    _initNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Push Notifications',
          style: TextStyle(
            color: textColor,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Токен устройства',
            style: TextStyle(
              fontSize: 40,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: primaryColor,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: SelectableText(
              _token,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {
              _copyToClipboard(_token);
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                width: 2,
                color: primaryColor,
              ),
              backgroundColor: backgroundColor,
            ),
            child: Text(
              'Скопировать',
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _initNotifications() async {
    final repository = context.read<NotificationsRepositoryI>();
    final result = await repository.requestPermission();
    if (result) {
      String? token = await repository.getToken();
      Logger().info(token);
      setState(() {
        _token = token ?? 'Токен не получен';
      });
      repository.init();
    }
  }

  void _copyToClipboard(String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text)).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Текст скопирован в буфер обмена!')),
        );
      });
    } catch (e, st) {
      Logger().handle(e, st);
    }
  }
}
