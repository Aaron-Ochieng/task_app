import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color primary = Colors.blueAccent;

class Styles {
  static Color primaryClr = primary;
  static Color textColor = const Color(0XFF3B3B3B);
  static Color bgColor = const Color(0XFFeeedf2);
  static Color orangeColor = Colors.orange;
  static Color pinkColor = Colors.pink;
  static Color kakiColor = const Color(0xffd2bdb6);
  static Color iconColor = const Color.fromARGB(255, 108, 108, 104);

  TextStyle get subHeadingStyle => TextStyle(
        fontSize: 20,
        color: Get.isDarkMode ? Colors.grey.shade400 : Colors.grey,
        fontWeight: FontWeight.bold,
      );
  TextStyle get headingStyle => const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      );
  TextStyle get titleStyle => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode ? Colors.white : Colors.black,
      );
  TextStyle get dateTextStyle => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
      );
  TextStyle get dayTextStyle => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
      );
  TextStyle get monthTextStyle => const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
      );
  static TextStyle headingStyle3 = TextStyle(
      fontSize: 15, color: Colors.grey.shade500, fontWeight: FontWeight.w500);
  static TextStyle headingStyle4 = TextStyle(
      fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.w500);
}
