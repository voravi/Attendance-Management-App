import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:attendance_management_app/modals/student.dart';
import 'package:attendance_management_app/modals/student_attendance.dart';
import 'package:attendance_management_app/modals/teacher_attendance.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../modals/teacher.dart';


class CollageDB {

  CollageDB._();

  static final CollageDB collageDB = CollageDB._();

  String teacherTable = "teacher";
  String studentTable = "student";
  String studentAttendanceTable = "student_attendance";
  String teacherAttendanceTable = "teacher_attendance";

  Database? db;

  Future<Database> initDatabase() async {
    var db = await openDatabase("myDb.db");

    String dataBasePath = await getDatabasesPath();

    String path = join(dataBasePath, "myDB.db");

    db = await openDatabase(
      path,
      version: 1,
      onConfigure: (Database db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (Database db, int vision) async {
        await db.execute("CREATE TABLE IF NOT EXISTS $teacherTable(tea_id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,age INT,email TEXT,subject TEXT);");
        await db.execute("CREATE TABLE IF NOT EXISTS $studentTable(stu_id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,age INT,email TEXT);");
        await db.execute("CREATE TABLE IF NOT EXISTS $teacherAttendanceTable(tea_id INTEGER PRIMARY KEY ,is_present TEXT CHECK(is_present in ('P','A','L')) DEFAULT 'A',FOREIGN KEY(tea_id) REFERENCES $teacherTable(tea_id));");
        await db.execute(
            "CREATE TABLE IF NOT EXISTS $studentAttendanceTable("
                "stu_id INTEGER PRIMARY KEY,"
                "name TEXT,"
                "FOREIGN KEY(stu_id) REFERENCES $studentTable(stu_id));");

      },
    );
    return db;
  }
  /*"SE TEXT CHECK(SE in ('P','A','L')) DEFAULT 'A',"
  "CPP TEXT CHECK(CPP in ('P','A','L')) DEFAULT 'A',"
  "RDBMS TEXT CHECK(RDBMS in ('P','A','L')) DEFAULT 'A',"
  "WD TEXT CHECK(WD in ('P','A','L')) DEFAULT 'A',"
  "BS TEXT CHECK(BS in ('P','A','L')) DEFAULT 'A',"
  * */

  // Todo: Insert

  Future<int> insertStudent({required Student student}) async {
    db = await initDatabase();

    String query = "INSERT INTO $studentTable(name,age,email) VALUES (?, ?, ?);";
    String query2 = "INSERT INTO $studentAttendanceTable(stu_id,name) VALUES (?, ?);";

    List arg = [student.name,student.age,student.email];
    List arg2 = [student.id,student.name];

    await db!.rawInsert(query,arg);
    return await db!.rawInsert(query2,arg2);

  }

  Future<int> insertTeacher({required Teacher teacher}) async {
    db = await initDatabase();

    String query = "INSERT INTO $teacherTable(name,age,email,subject) VALUES (?, ?, ?, ?);";
    String query2 = "INSERT INTO $teacherAttendanceTable(tea_id) VALUES (?);";

    String query3 = "ALTER TABLE $studentAttendanceTable ADD COLUMN ${teacher.subject.toUpperCase()} TEXT CHECK(${teacher.subject.toUpperCase()} in ('P','A','L')) DEFAULT 'A'";


    List arg = [teacher.name,teacher.age,teacher.email,teacher.subject];
    List arg2 = [teacher.id];


    await db!.rawUpdate(query3);
    await db!.rawInsert(query,arg);
    return await db!.rawInsert(query2,arg2);
  }


  // Todo: Add Attendance

  Future<int> updateSubjectAttendance({required String subName,required List<Map<String,dynamic>> data}) async {
    db = await initDatabase();

    int addedRecords = 0;

    for(int i = 0; i<data.length; i++) {

      String query = "UPDATE $studentAttendanceTable SET '$subName' = ? WHERE stu_id=?;";

      List args = [data[i]["status"],data[i]["id"]];

      addedRecords = addedRecords + await db!.rawUpdate(query,args);
    }
    return addedRecords;
  }



  Future<int> updateTeacherAttendance({required List<Map<String,dynamic>> data}) async {
    db = await initDatabase();

    int addedRecords = 0;

    for(int i = 0; i<data.length; i++) {

      String query = "UPDATE $teacherAttendanceTable SET 'is_present' = ? WHERE tea_id=?;";

      List args = [data[i]["status"],data[i]["id"]];

      addedRecords = addedRecords + await db!.rawUpdate(query,args);
    }
    return addedRecords;
  }


  // Todo: Fetch

  Future<List<Map<String,dynamic>>> fetchSingleColumnFromStudentAttendance({required String colName}) async {

    db = await initDatabase();

    String query = "SELECT $colName FROM $studentAttendanceTable";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    return res;

  }

  Future<List<Map<String,dynamic>>> fetchSingleColumnFromTeacherAttendance({required String colName}) async {

    db = await initDatabase();

    String query = "SELECT $colName FROM $teacherAttendanceTable";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    return res;

  }

  Future<List<Student>> fetchStudentData() async {

    db = await initDatabase();

    String query = "SELECT * FROM $studentTable";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<Student>  studentData = res.map((e) => Student.fromMap(data: e)).toList();

    return studentData;
  }

  Future<List<Teacher>> fetchTeacherData() async {

    db = await initDatabase();

    String query = "SELECT * FROM $teacherTable";
    // String query2 = "ALTER TABLE $studentAttendanceTable DROP COLUMN PS";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    // int r = await db!.rawDelete(query2);

    // log("Column PS Deleted: $r");

    List<Teacher> teacherData = res.map((e) => Teacher.fromMap(data: e)).toList();

    return teacherData;

  }

  Future<List> fetchStudentAttendance() async {

    db = await initDatabase();

    String query = "SELECT * FROM $studentAttendanceTable";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    return res;

  }

  Future<List<TeacherAttendance>> fetchTeacherAttendance() async {

    db = await initDatabase();

    String query = "SELECT * FROM $teacherAttendanceTable";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<TeacherAttendance> teacherAttendance = res.map((e) => TeacherAttendance.fromMap(data: e)).toList();

    return teacherAttendance;

  }


  // Todo: Delete

  Future<int> deleteAllStudentData() async {
    db = await initDatabase();

    String query = "DELETE FROM $studentTable";
    String query2 = "DELETE FROM $studentAttendanceTable";

    await db!.rawDelete(query);
    return await db!.rawDelete(query2);

  }

  Future<int> deleteAllTeacherData() async {
    db = await initDatabase();

    String query = "DELETE FROM $teacherTable";
    String query2 = "DELETE FROM $teacherAttendanceTable";

    await db!.rawDelete(query);
    return await db!.rawDelete(query2);

  }

  //Todo: Empty Data

  Future<int> emptyStudentAttendance() async {

    db = await initDatabase();

    String query = "UPDATE $studentAttendanceTable SET 'SE' = ?, 'CPP' = ?, 'RDBMS' = ?, 'WD' = ?, 'BS' = ?;";

    List args = ["A","A","A","A","A"];

    return await db!.rawUpdate(query,args);

  }

  Future<int> emptyTeacherAttendance() async {

    db = await initDatabase();

    String query = "UPDATE $teacherAttendanceTable SET 'is_present' = ?;";

    List args = ["A"];

    return await db!.rawUpdate(query,args);

  }


}