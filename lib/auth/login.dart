import 'dart:convert';
import 'dart:developer';
import 'package:attendance_management_app/providers/attendance_controller.dart';
import 'package:attendance_management_app/views/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modals/sign_up.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  initData() async {
    await attendanceController.showStudentData();
    await attendanceController.showTeacherData();
    await attendanceController.fetchStudentAttendance();

    log("Donee");
  }


  AttendanceController attendanceController = Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool checkBoxValue = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/vactor1.webp",
                height: 230,
                width: 230,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(
                    color: Color(0XFFa680fa),
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Enter Email"),
                      SizedBox(
                        height: 5,
                      ),
                      Stack(
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: attendanceController.emailController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Enter Email";
                              }
                              return null;
                            },
                            cursorColor: Color(0XFFa680fa),
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.8),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Color(0XFFa680fa),
                                ),
                              ),
                              disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Color(0XFFa680fa),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Color(0XFFa680fa),
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Color(0XFFa680fa),
                                ),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Color(0XFFa680fa),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Enter Password"),
                      SizedBox(
                        height: 5,
                      ),
                      Stack(
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: attendanceController.passwordController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Enter password";
                              }
                              return null;
                            },
                            cursorColor: Color(0XFFa680fa),
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.8),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Color(0XFFa680fa),
                                ),
                              ),
                              disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Color(0XFFa680fa),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Color(0XFFa680fa),
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Color(0XFFa680fa),
                                ),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: Color(0XFFa680fa),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0XFF83afed),
                        Color(0XFFa87efa),
                      ],
                    ),
                  ),
                  child: InkWell(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        if (attendanceController.emailController.text == "admin" && attendanceController.passwordController.text == "123456") {
                          Get.offAll(Navigation(), arguments: "Admin");
                        } else {
                          Get.offAll(Navigation(), arguments: "Teacher");
                        }

                        print(attendanceController.emailController.text);
                        print(attendanceController.passwordController.text);
                      }
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Row(
                children: [
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20,color: Color(0XFFa680fa)),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const SignUpScreen(),
                      //   ),
                      // );
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
