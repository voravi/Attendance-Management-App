import 'dart:developer';
import 'package:attendance_management_app/providers/attendance_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  AttendanceController attendanceController = Get.find();

  @override
  Widget build(BuildContext context) {
    String subName = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0XFF9b91f3),
                Color(0XFF8ca6f3),
              ],
            ),
          ),
        ),
        title: Text(
          '$subName Attendance',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.brightness_6_sharp,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.77,
                  child: (subName == "Teacher")
                      ? ListView.builder(
                          itemCount: attendanceController.teacherData.length,
                          itemBuilder: ((context, index) {
                            return Container(
                              margin: EdgeInsets.only(top: 10, bottom: 15, right: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0XFF9b91f3),
                                              Color(0XFF8ca6f3),
                                            ],
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${attendanceController.teacherData[index].name.split(" ")[0][0].toUpperCase()}${attendanceController.teacherData[index].name.split(" ")[1][0].toUpperCase()}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "${attendanceController.teacherData[index].name.split(" ")[0].capitalizeFirst} ${attendanceController.teacherData[index].name.split(" ")[1].capitalizeFirst}",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        borderRadius: BorderRadius.circular(50),
                                        onTap: () {
                                          attendanceController.changeTeacherStatus(index: index);
                                        },
                                        child: Obx(
                                          () => Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: (attendanceController.teacherStatus[index] == "P")
                                                  ? attendanceController.statusColor[0]
                                                  : (attendanceController.teacherStatus[index] == "A")
                                                      ? attendanceController.statusColor[1]
                                                      : attendanceController.statusColor[2],
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                attendanceController.teacherStatus[index],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    indent: 70,
                                    endIndent: 0,
                                    height: 2,
                                    thickness: 1,
                                  ),
                                ],
                              ),
                            );
                          }),
                        )
                      : ListView.builder(
                          itemCount: attendanceController.studentData.length,
                          itemBuilder: ((context, index) {
                            return Container(
                              margin: EdgeInsets.only(top: 10, bottom: 15, right: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0XFF9b91f3),
                                              Color(0XFF8ca6f3),
                                            ],
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${attendanceController.studentData[index].name[0].toUpperCase()}${attendanceController.studentData[index].name[1].toUpperCase()}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "${attendanceController.studentData[index].name.capitalizeFirst}",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        borderRadius: BorderRadius.circular(50),
                                        onTap: () {
                                          attendanceController.changeStatus(index: index);
                                        },
                                        child: Obx(
                                          () => Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: (attendanceController.studentStatus[index] == "P")
                                                  ? attendanceController.statusColor[0]
                                                  : (attendanceController.studentStatus[index] == "A")
                                                      ? attendanceController.statusColor[1]
                                                      : attendanceController.statusColor[2],
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                attendanceController.studentStatus[index],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    indent: 70,
                                    endIndent: 0,
                                    height: 2,
                                    thickness: 1,
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                ),
              ],
            ),
            Spacer(),
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
                      onTap: () {
                        Get.back();
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Cancle",
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

                        if(subName == "Teacher") {
                          List<int> idList = List.generate(attendanceController.teacherData.length, (index) => attendanceController.teacherData[index].id!);

                          int res = await attendanceController.saveTeacherAttendance(idList: idList);

                          log(res.toString(), name: "Updated records");

                          Get.back();

                        } else {
                          List<int> idList = List.generate(attendanceController.studentData.length, (index) => attendanceController.studentData[index].id!);

                          int res = await attendanceController.saveStudentAttendance(subName: subName, idList: idList);

                          log(res.toString(), name: "Updated records");

                          Get.back();
                        }

                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.2,
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
