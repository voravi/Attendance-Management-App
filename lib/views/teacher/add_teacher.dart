import 'dart:developer';

import 'package:attendance_management_app/providers/attendance_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../navigation.dart';


class AddTeacher extends StatelessWidget {
  AddTeacher({Key? key}) : super(key: key);

  AttendanceController attendanceController = Get.find();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController subjectController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  String name = "";

  String email = "";

  String subject = "";

  int? age;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "New Teacher",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Enter Teacher Name"),
                      SizedBox(
                        height: 5,
                      ),
                      Stack(
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: nameController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Enter name";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              name = val!;
                            },
                            cursorColor: Color(0XFFa680fa),
                            decoration: InputDecoration(
                              hintText: "Name",
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
                          Positioned(
                            bottom: -1,
                            child: Container(
                              height: 5,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0XFF83afed),
                                    Color(0XFFa87efa),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Enter Teacher Email"),
                      SizedBox(
                        height: 5,
                      ),
                      Stack(
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: emailController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Enter email";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              email = val!;
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
                          Positioned(
                            bottom: -1,
                            child: Container(
                              height: 5,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0XFF83afed),
                                    Color(0XFFa87efa),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Enter Teacher Age"),
                      SizedBox(
                        height: 5,
                      ),
                      Stack(
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: ageController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Enter Age";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              age = int.parse(val!);
                            },
                            cursorColor: Color(0XFFa680fa),
                            decoration: InputDecoration(
                              hintText: "Age",
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
                          Positioned(
                            bottom: -1,
                            child: Container(
                              height: 5,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0XFF83afed),
                                    Color(0XFFa87efa),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Enter Teacher Subject"),
                      SizedBox(
                        height: 5,
                      ),
                      Stack(
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: subjectController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Enter Subject";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              subject = val!;
                            },
                            cursorColor: Color(0XFFa680fa),
                            decoration: InputDecoration(
                              hintText: "Subject",
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
                          Positioned(
                            bottom: -1,
                            child: Container(
                              height: 5,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0XFF83afed),
                                    Color(0XFFa87efa),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 100,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
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
                        formKey.currentState!.save();

                        int res = await attendanceController.insertTeacherData(name: name, email: email, age: age!,subject: subject.toUpperCase());
                        await attendanceController.showTeacherData();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text("Teacher Added"),
                          ),
                        );
                        Get.offAll(Navigation(),arguments: (attendanceController.emailController.text == "admin") ? "Admin" : "Teacher");

                        log(res.toString(),name: "Teacher Inserted Success");
                      }
                    },

                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          "Add teacher",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
