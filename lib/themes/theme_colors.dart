import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeUI {
  static final darkThemeUi = ThemeData(
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Status bar
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    scaffoldBackgroundColor: const Color(0xfff1f5f9),
    brightness: Brightness.light,
  );

  static final lightThemeUI = ThemeData(
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Status bar
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    scaffoldBackgroundColor: const Color(0xff334159),
    brightness: Brightness.dark,
  );
}
