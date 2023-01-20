import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modals/student.dart';
import '../../providers/attendance_controller.dart';
import 'add_student.dart';

class ShowStudents extends StatelessWidget {
  ShowStudents({Key? key}) : super(key: key);

  AttendanceController attendanceController = Get.find();

  @override
  Widget build(BuildContext context) {
    List<Student> data = attendanceController.studentData;
    log(data.toString(),name: "data");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0XFFa680fa),
        onPressed: (){
          Get.to(AddStudent());
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.builder(
          itemCount: data.length,
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
                            "${data[index].name[0].toUpperCase()}${data[index].name[1].toUpperCase()}",
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
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data[index].name.capitalizeFirst}",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            data[index].email.toLowerCase(),
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        "${data[index].age}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.withOpacity(0.7),
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
    );
  }
}
