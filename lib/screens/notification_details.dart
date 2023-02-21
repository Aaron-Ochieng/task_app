import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationDetailPage extends StatelessWidget {
  final String? label;
  const NotificationDetailPage({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        title: Text(label.toString().split('|')[0]),
      ),
    );
  }
}
