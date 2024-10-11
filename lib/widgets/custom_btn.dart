import 'package:flutter/material.dart';
import 'package:othaim/widgets/custom_txt.dart';

class CustomBtn extends StatelessWidget {
  final String label;
  final Function onPressed;
  final Color btnColor;
  final double fontSize;
  const CustomBtn(
      {super.key,
      required this.label,
      required this.onPressed,
      this.btnColor = Colors.red,
      this.fontSize = 14.0});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(btnColor), // Correct usage
        surfaceTintColor: MaterialStateProperty.all(btnColor),
      ),
      onPressed: () => onPressed(),
      child: CustomTxt(
        text: label,
        color: Colors.white,
        fontSize: fontSize,
      ),
    );
  }
}
