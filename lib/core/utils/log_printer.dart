import 'dart:io' as io;

import 'package:logger/logger.dart';

class AppLogPrinter extends LogPrinter {
  final prettyPrinter = PrettyPrinter(
    colors: io.stdout.supportsAnsiEscapes,
    methodCount: 0,
  );

  @override
  List<String> log(LogEvent event) {
    return prettyPrinter.log(event);
  }
}
