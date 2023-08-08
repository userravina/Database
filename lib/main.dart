import 'package:database/Screen/Home/view/BottomBar.dart';
import 'package:database/Screen/Home/view/FilterScreen.dart';
import 'package:database/Screen/Home/view/Splash.dart';
import 'package:database/Screen/Home/view/addScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'Screen/Home/view/Transaction_page.dart';
import 'chart/widget/all.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType){
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Manager',
        theme: ThemeData(
          scaffoldBackgroundColor: kScaffoldColor,
          appBarTheme: AppBarTheme(
            backgroundColor: kPrimaryColor,
            iconTheme: IconThemeData(
              size: 23.sp,
              color: kSecondaryColor,
            ),
          ),
          iconTheme: IconThemeData(
            size: 23.sp,
            color: kSecondaryColor,
          ),
        ),
      routes: {
          '/':(context) => splashScreen(),
          '/Bottom':(context) => Bottom(),
          '/add':(context) => AddInDataBase(),
          '/Tran':(context) => Transaction_page(),
          '/Tran':(context) => FilterScreen(),
      },
      );
    });
  }
}