import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theme_changer/themes/styles.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputField({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Styles().titleStyle,
        ),
        Container(
          height: 52,
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.grey),
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: widget == null ? false : true,
                  autofocus: false,
                  autocorrect: true,
                  cursorColor:
                      Get.isDarkMode ? Colors.grey.shade300 : Colors.black,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hint,
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
              widget == null ? Container() : Container(child: widget),
            ],
          ),
        )
      ],
    );
  }
}
