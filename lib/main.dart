import 'package:attendance_management_app/auth/login.dart';
import 'package:attendance_management_app/providers/attendance_controller.dart';
import 'package:attendance_management_app/views/navigation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

void main() {
  Get.put(AttendanceController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Attendance Management App",
      // theme: ThemeData(
      //   primaryColor: Color(0XFFa87efa),
      // ),
      initialRoute: "/",
      getPages: <GetPage>[
        GetPage(
          name: "/navigation",
          page: () => Navigation(),
        ),
        GetPage(
          name: "/",
          page: () => LoginPage(),
        ),
      ],
    );
  }
}
