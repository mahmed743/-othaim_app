import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othaim/Views/homeView.dart';

import 'package:othaim/config/app_color.dart';
import 'package:othaim/widgets/custom_txt.dart';
import 'package:othaim/widgets/custom_btn.dart';
import 'package:othaim/widgets/helper.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: CustomTxt(
          text: 'Profile',
          color: Colors.white,
          fontSize: 20.sp,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                confirmationDialog(
                    title: "Log out",
                    textBody: "Are you sure you want log out?",
                    onConfirm: () {
                      Get.offAll(HomeView());
                    });
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0).r,
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 150.w,
                      height: 150.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: kPrimaryColor, width: 2.0)),
                      child: Icon(
                        Icons.person,
                        size: 100.sp,
                        color: kPrimaryColor,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon:
                            const Icon(Icons.camera_alt, color: kPrimaryColor),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTxt(
                    text: 'Name: Mustafa Ahmed Elbashir',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 10.h),
                  CustomTxt(
                    text: 'Email: m.ahmed743@gmail.com',
                    fontSize: 14.sp,
                  ),
                  SizedBox(height: 10.h),
                  CustomTxt(
                    text: 'Phone: 0501903193',
                    fontSize: 14.sp,
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
