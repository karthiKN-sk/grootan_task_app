// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

///AppTheme Dark or Light Storage
class ThemeService {
  final getStorage = GetStorage();
  final IS_DARK_MODE = 'isDarkMode';

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  bool isSavedDarkMode() {
    return  getStorage.read(IS_DARK_MODE) ?? false;
  }

  void saveThemeMode(bool isDarkMode) {
    getStorage.write(IS_DARK_MODE, isDarkMode);
  }

  void changeThemeData() {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeMode(!isSavedDarkMode());
  }
}
