import 'package:attendance_management_app/providers/attendance_controller.dart';
import 'package:attendance_management_app/views/home_screen/page/home_screen.dart';
import 'package:attendance_management_app/views/linear_container/linear_container.dart';
import 'package:attendance_management_app/views/pdf/pdf_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAttendance extends StatelessWidget {
  AddAttendance({Key? key}) : super(key: key);

  AttendanceController attendanceController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            (attendanceController.emailController.text == "admin" && attendanceController.passwordController.text == "123456")
                ? Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: UnicornOutlineButton(
                            onPressed: () async {
                              await attendanceController.findTeacherAttendance();
                               Get.to(HomePage(),arguments: "Teacher");
                            },
                            strokeWidth: 4,
                            radius: 10,
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0XFFa87efa),
                                Color(0XFF83afed),
                              ],
                            ),
                            child: SizedBox(
                              height: 60,
                              width: 280,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Teacher Attendance",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Icon(Icons.arrow_right_alt_rounded, size: 28, color: Colors.black),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: (attendanceController.emailController.text == "admin" && attendanceController.passwordController.text == "123456")
                  ? MediaQuery.of(context).size.height * 0.58
                  : MediaQuery.of(context).size.height * 0.70,
              child: ListView.builder(
                itemCount: attendanceController.teacherData.length,
                itemBuilder: ((context, index) {
                  return Container(
                    height: 60,
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: UnicornOutlineButton(
                      onPressed: () async {
                        await attendanceController.findAttendance(subName: attendanceController.teacherData[index].subject);
                        Get.to(HomePage(), arguments: attendanceController.teacherData[index].subject);
                      },
                      strokeWidth: 4,
                      radius: 10,
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0XFFa87efa),
                          Color(0XFF83afed),
                        ],
                      ),
                      child: SizedBox(
                        height: 60,
                        width: 280,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              attendanceController.teacherData[index].subject,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            Icon(Icons.arrow_right_alt_rounded, size: 28, color: Colors.black),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Ink(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color(0XFFa87efa),
                        width: 3,
                      ),
                    ),
                    child: InkWell(
                      onTap: () async {
                        await attendanceController.fetchStudentAttendance();
                        Get.to(() => PDFScreen());
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "PDF",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Ink(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0XFFa87efa),
                          Color(0XFF83afed),
                        ],
                      ),
                    ),
                    child: InkWell(
                      onTap: () async {
                        // Excel Upload..........

                        await attendanceController.uploadToExcel();

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Excel Created"),
                          backgroundColor: Colors.green,
                        ));
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Export(excel)",
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
