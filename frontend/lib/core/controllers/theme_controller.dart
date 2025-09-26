import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _storage.write(key: 'isDarkMode', value: isDarkMode.value.toString());
  }

  Future<void> isDarkModeEnabled() async {
    String? isDark = await _storage.read(key: 'isDarkMode');
    if (isDark != null) {
      isDarkMode.value = isDark.toLowerCase() == 'true';
    }
  }
}
