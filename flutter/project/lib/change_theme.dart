import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;
  final String _themeKey = "isDarkMode";
  late Box _box;

  @override
  void onInit() {
    super.onInit();
    _box = Hive.box('mybox');
    isDarkMode.value = _box.get(_themeKey, defaultValue: false);
  }

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    _box.put(_themeKey, value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
