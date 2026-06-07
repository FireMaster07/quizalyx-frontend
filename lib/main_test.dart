import 'package:flutter_driver/driver_extension.dart';
// Import your original main file with the alias 'app'
import 'main.dart' as app;

void main() {
  // 1. First, enable the test extension
  enableFlutterDriverExtension();

  // 2. Then start your original application from main.dart
  app.main();
}
