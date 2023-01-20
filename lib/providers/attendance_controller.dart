import 'dart:developer';
import 'dart:io';
import 'package:attendance_management_app/modals/teacher.dart';
import 'package:attendance_management_app/providers/user_db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import '../modals/student.dart';

Color green = Colors.green;
Color orange = Colors.orangeAccent;
Color red = Colors.red;
enum Status { P, A, L }


class AttendanceController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxList<Student> studentData = <Student>[].obs;
  RxList<Teacher> teacherData = <Teacher>[].obs;
  RxList<dynamic> studentStatus = <dynamic>[].obs;
  RxList<dynamic> teacherStatus = <dynamic>[].obs;
  RxList<String> subjects = <String>[].obs;
  RxList<dynamic> studentAttendance = <dynamic>[].obs;
  RxList<Color> statusColor = <Color>[Colors.green,Colors.red,Colors.orange].obs;





  List<String> alpha = ["A","B","C","D","E","F","G","H","I","J","k","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];

  updateSubjects() {
    subjects.value.clear();
    for(int i=0; i<teacherData.length; i++) {
      subjects.value.add(teacherData[i].subject);
    }
  }

  uploadToExcel() async {
    
    DateTime dateTime = DateTime.now();
    final output = await getExternalStorageDirectory();
    
    final Workbook workbook =  Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName("A1").setText("Name");

    for(int i=0; i<subjects.length; i++) {
      sheet.getRangeByName("${alpha[i+1]}1").setText(subjects[i]);
    }

      // sheet.getRangeByName('A1').setText("Name");
      // sheet.getRangeByName('B1').setText("SE");
      // sheet.getRangeByName('C1').setText("CPP");
      // sheet.getRangeByName('D1').setText("RDBMS");
      // sheet.getRangeByName('E1').setText("WD");
      // sheet.getRangeByName('F1').setText("BS");

// sheet.getRangeByName('A${attendanceCounter.counter}').setText(studentAttendance[attendanceCounter.counter]["name"]);

    for(int i=0; i<studentData.length; i++) {
      sheet.getRangeByName('A${i+2}').setText(studentData[i].name);
    }

    for(int j = 0; j< studentAttendance.length; j++) {
      for(int i = 0; i<subjects.length; i++){
        sheet.getRangeByName('${alpha[i+1]}${j+2}').setText(studentAttendance[j][subjects[i]]);
      }
    }


    // sheet.getRangeByName('C${i+2}').setText(studentAttendance[i]["CPP"]);
    // sheet.getRangeByName('D${i+2}').setText(studentAttendance[i]["RDBMS"]);
    // sheet.getRangeByName('E${i+2}').setText(studentAttendance[i]["WD"]);
    // sheet.getRangeByName('F${i+2}').setText(studentAttendance[i]["BS"]);

    List<int> bytes = workbook.saveAsStream();

    File("${output!.path}/${dateTime.day}${dateTime.hour}${dateTime.minute}${dateTime.second}.xlsx").writeAsBytes(bytes);
    workbook.dispose();
    
    log("File Created..!");
  }

  findAttendance({required String subName}) async {


    List<Map<String, dynamic>> data = await CollageDB.collageDB.fetchSingleColumnFromStudentAttendance(colName: subName);

    log(data.toString());

    studentStatus.clear();

    for (int i = 0; i < data.length; i++) {
      studentStatus.add(data[i][subName]);
    }
  }

  findTeacherAttendance() async {
    List<Map<String, dynamic>> data = await CollageDB.collageDB.fetchSingleColumnFromTeacherAttendance(colName: "is_present");
    log(data.toString());

    teacherStatus.clear();

    for (int i = 0; i < data.length; i++) {
      teacherStatus.add(data[i]["is_present"]);
    }

  }

  Future<int> saveStudentAttendance({required String subName,required List<int> idList}) async {
    List<Map<String,dynamic>> data = [];

    for(int i=0; i< idList.length; i++) {
      data.add(
        {
          "id": idList[i],
          "status" : "${studentStatus[i]}",
        }
      );
    }

    int res = await CollageDB.collageDB.updateSubjectAttendance(subName: subName, data: data);
    return res;

  }

  saveTeacherAttendance({required List<int> idList}) async {

    List<Map<String,dynamic>> data = [];

    for(int i=0; i< idList.length; i++) {
      data.add(
          {
            "id": idList[i],
            "status" : "${teacherStatus[i]}",
          }
      );
    }


    int res = await CollageDB.collageDB.updateTeacherAttendance(data: data);
    return res;
  }

  changeTeacherStatus({required int index}) {
    if (teacherStatus[index] == "P") {
      teacherStatus[index] = Status.L.name;
    } else if (teacherStatus[index] == "A") {
      teacherStatus[index] = Status.P.name;
    } else {
      teacherStatus[index] = Status.A.name;
    }
  }

  changeStatus({required int index}) {
    if (studentStatus[index] == "P") {
      studentStatus[index] = Status.L.name;
    } else if (studentStatus[index] == "A") {
      studentStatus[index] = Status.P.name;
    } else {
      studentStatus[index] = Status.A.name;
    }
  }

  showStudentData() async {
    studentData.value = await CollageDB.collageDB.fetchStudentData();
  }

  showTeacherData() async {
    teacherData.value = await CollageDB.collageDB.fetchTeacherData();
  }

  fetchStudentAttendance() async {
    studentAttendance.value = await CollageDB.collageDB.fetchStudentAttendance();
  }

  Future<int> insertStudentData({required String name, required String email, required int age}) async {
    Student student = Student(age: age, name: name, email: email);

    int res = await CollageDB.collageDB.insertStudent(student: student);

    studentStatus.add(Status.P.name);

    return res;
  }

  Future<int> insertTeacherData({required String name, required String email, required int age,required String subject}) async {
    Teacher teacher = Teacher(age: age, name: name, email: email,subject: subject);

    int res = await CollageDB.collageDB.insertTeacher(teacher: teacher);

    subjects.value.add(subject);

    return res;
  }

}
