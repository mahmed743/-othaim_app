import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:othaim/Views/homeView.dart';
import 'package:othaim/Views/splashView.dart';
import 'package:othaim/config/app_color.dart';

import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path); // Initialize Hive with a directory
  await Hive.openBox('productCacheBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: kPrimaryColor,
              fontFamily: "Verdana",
              colorScheme: ColorScheme.fromSwatch().copyWith(
                background: Colors.white,
                primary: kPrimaryColor, // Apply primary color globally
                // Set secondary color if needed
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      kPrimaryColor, // Primary color for all buttons
                ),
              ),
              dialogTheme: const DialogTheme(
                surfaceTintColor: Colors.white,
                backgroundColor: Colors.white, // Dialog background color
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: kPrimaryColor, // AppBar background color
                iconTheme: IconThemeData(
                  color: Colors.white, // Set the back icon color to white
                ),
              ),
            ),
            home: const SplashView(),
          );
        });
  }
}
