// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:theme_changer/themes/styles.dart';

class BottomSheetButton extends StatelessWidget {
  String label;
  Function() onTap;
  Color clr;
  bool close;
  BuildContext context;
  BottomSheetButton({
    super.key,
    required this.label,
    required this.onTap,
    required this.clr,
    this.close = false,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: close == true ? Colors.white : clr,
          border: Border.all(
            width: 2,
            color: close == true ? const Color.fromARGB(255, 100, 93, 93) : clr,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
            child: Text(
          label,
          style: close
              ? Styles().titleStyle.copyWith(color: Colors.black)
              : Styles().titleStyle.copyWith(
                    color: Colors.white,
                  ),
        )),
      ),
    );
  }
}
