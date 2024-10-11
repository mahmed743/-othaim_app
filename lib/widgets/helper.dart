import 'package:flutter/material.dart';
import 'package:get/get.dart';

void confirmationDialog(
    {required String title,
    required String textBody,
    required Function onConfirm}) {
  Get.defaultDialog(
    title: title,
    middleText: textBody,
    textConfirm: "Yes",
    textCancel: "No",
    buttonColor: Colors.red,
    cancelTextColor: Colors.red,
    titleStyle: const TextStyle(color: Colors.red),
    confirmTextColor: Colors.white,
    onConfirm: () => onConfirm(),
    onCancel: () {},
  );
}
