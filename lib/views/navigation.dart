import 'dart:developer';

import 'package:attendance_management_app/auth/login.dart';
import 'package:attendance_management_app/views/attendence/add_attendence.dart';
import 'package:attendance_management_app/views/students/show_students.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../providers/attendance_controller.dart';
import 'demo.dart';
import 'teacher/show_teachers.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> with SingleTickerProviderStateMixin {
  late TabController tabController;

  AttendanceController attendanceController = Get.find();

  initData() async {

    // Teacher teacher = Teacher(age: 25, name: "aashish solanki", email: "aashishsolanki23@gmail.com", subject: "SE");
    // Teacher teacher2 = Teacher(age: 26, name: "jay gondaliya", email: "jaygondaliya456@gmail.com", subject: "CPP");
    // Teacher teacher3 = Teacher(age: 27, name: "priyanka chawhan", email: "priyankachawhan98@gmail.com", subject: "RDBMS");
    // Teacher teacher4 = Teacher(age: 24, name: "ankit rabadiya", email: "ankitrabadiya886@gmail.com", subject: "WD");
    // Teacher teacher5 = Teacher(age: 25, name: "tushar kachhadiya", email: "tusharkachhadiya987@gmail.com", subject: "BS");
    //
    // await CollageDB.collageDB.insertTeacher(teacher: teacher);
    // await CollageDB.collageDB.insertTeacher(teacher: teacher2);
    // await CollageDB.collageDB.insertTeacher(teacher: teacher3);
    // await CollageDB.collageDB.insertTeacher(teacher: teacher4);
    // await CollageDB.collageDB.insertTeacher(teacher: teacher5);
    //
    // Student student = Student(age: 20, name: "ravi", email: "voraravi1234@gmail.com");
    // Student student2 = Student(age: 22, name: "nilank", email: "nilnaklakkad99@gmail.com");
    // Student student3 = Student(age: 21, name: "darshan", email: "darshanfindoliya541@gmail.com");
    // Student student4 = Student(age: 21, name: "vasu", email: "vasuvachhani56@gmail.com");
    // Student student5 = Student(age: 20, name: "monil", email: "monillathiya341@gmail.com");
    //
    // await CollageDB.collageDB.insertStudent(student: student);
    // await CollageDB.collageDB.insertStudent(student: student2);
    // await CollageDB.collageDB.insertStudent(student: student3);
    // await CollageDB.collageDB.insertStudent(student: student4);
    // await CollageDB.collageDB.insertStudent(student: student5);

    await attendanceController.showStudentData();
    await attendanceController.showTeacherData();
    await attendanceController.fetchStudentAttendance();
    await attendanceController.updateSubjects();

    log("Data Addad...");

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    initData();
  }

  @override
  Widget build(BuildContext context) {

    String name = ModalRoute.of(context)!.settings.arguments as String;

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
          'Hello $name',
          style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1.2),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Get.offAll(LoginPage());
            },
            icon: Icon(
              Icons.login_outlined,
            ),
          ),
          IconButton(
            onPressed: () async {
              // log(attendanceController.studentAttendance.toString(),name: "Student Attendace");
              // attendanceController.subjects.add("SE");
              // attendanceController.subjects.add("CPP");
              // attendanceController.subjects.add("RDBMS");
              // attendanceController.subjects.add("WD");
              // attendanceController.subjects.add("BS");
              // attendanceController.subjects.add("PS");
              // attendanceController.subjects.add("AN");
              log(attendanceController.subjects.toString(),name: "Subjects");
            },
            icon: Icon(
              Icons.brightness_6_sharp,
            ),
          ),
        ],
        bottom: TabBar(
          indicatorWeight: 3,
          controller: tabController,
          indicatorColor: Color(0XFF7a92ee),
          labelStyle: TextStyle(
            letterSpacing: 1.3,
            fontWeight: FontWeight.bold,
          ),
          tabs: [
            Tab(
              text: "Students",
            ),
            Tab(
              text: "Attendance",
            ),
            Tab(
              text: "Teachers",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          ShowStudents(),
          AddAttendance(),
          ShowTeachers(),
        ],
      ),
    );
  }
}
// Color(0XFFa87efa)