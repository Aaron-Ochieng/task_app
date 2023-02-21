import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:theme_changer/db/db_helper.dart';
import 'package:theme_changer/screens/home.dart';
import 'package:theme_changer/services/theme_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDB();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent, // Status bar
            statusBarIconBrightness: Brightness.dark,
          ),
          backgroundColor: Color(0xfff1f5f9),
        ),
        scaffoldBackgroundColor: const Color(0xfff1f5f9),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent, // Status bar
            statusBarIconBrightness: Brightness.light,
          ),
          backgroundColor: Color(0xff334155),
        ),
        scaffoldBackgroundColor: const Color(0xff334155),
        brightness: Brightness.dark,
      ),
      themeMode: ThemeService().theme,
      home: const HomeScreen(),
    );
  }
}
