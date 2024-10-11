// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othaim/config/app_color.dart';
import 'package:othaim/widgets/custom_txt.dart';

// ignore: must_be_immutable
class DecrementAndIncrement extends StatelessWidget {
  final Function increment;
  final Function decrement;
  final int productQuantity;
  bool canDelete;
  DecrementAndIncrement({
    super.key,
    required this.increment,
    required this.decrement,
    required this.productQuantity,
    this.canDelete = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            onTap: () => decrement(),
            child: Container(
                decoration: const BoxDecoration(
                    color: kPrimaryColor, shape: BoxShape.circle),
                child: const Center(
                    child: Icon(
                  Icons.remove,
                  color: Colors.white,
                )))),
        SizedBox(
          width: 3.w,
        ),
        CustomTxt(
          text: productQuantity.toString(),
        ),
        SizedBox(
          width: 3.w,
        ),
        InkWell(
            onTap: () => increment(),
            child: Container(
                decoration: const BoxDecoration(
                    color: kPrimaryColor, shape: BoxShape.circle),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ))),
      ],
    );
  }
}
