import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomTxt extends StatelessWidget {
  final String text;
  Color color;
  int maxLines;
  FontWeight fontWeight;
  final double fontSize;
  TextDecoration textDecoration;
  CustomTxt(
      {super.key,
      required this.text,
      this.color = Colors.black,
      this.maxLines = 2,
      this.fontWeight = FontWeight.normal,
      this.fontSize = 14.0,
      this.textDecoration = TextDecoration.none});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      // textScaleFactor: 1.0,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize.sp,
        decoration: textDecoration,
      ),
    );
  }
}
