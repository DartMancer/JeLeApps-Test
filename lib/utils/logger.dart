import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class Logger {
  Talker talker = GetIt.I<Talker>();

  void info(dynamic message) {
    talker.info(message);
  }

  void handle(dynamic e, dynamic st) {
    talker.handle(e, st);
  }

  void debug(dynamic message) {
    talker.debug(message);
  }

  void critical(dynamic message) {
    talker.critical(message);
  }
}
