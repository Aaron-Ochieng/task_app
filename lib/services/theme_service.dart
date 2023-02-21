import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final _store = GetStorage();
  final _key = 'isDarkMode';

  bool _loadTheme() => _store.read(_key) ?? false;

  ThemeMode get theme => _loadTheme() ? ThemeMode.dark : ThemeMode.light;

  _saveTheme(bool isDarkMode) => _store.write(_key, isDarkMode);

  void changeTheme() {
    Get.changeThemeMode(_loadTheme() ? ThemeMode.light : ThemeMode.dark);
    _saveTheme(!_loadTheme());
  }
}
