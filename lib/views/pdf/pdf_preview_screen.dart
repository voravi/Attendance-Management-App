import 'dart:developer';
import 'dart:io';
import 'package:attendance_management_app/providers/attendance_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class PDFScreen extends StatelessWidget {
  PDFScreen({Key? key}) : super(key: key);

  DateTime dateTime = DateTime.now();

  AttendanceController attendanceController = Get.find();

  /*
  * Todo: First Alter table Teacher and add teacher_subject column
  * Todo: dynamic PDF Generate
  * Todo: dynamic Excel Sheet Generate
  * Todo: Just Completed...!
  * */
  @override
  Widget build(BuildContext context) {
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
          'PDF Preview',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text("_______________________________________________"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Container(
                            child: Row(
                              children: [
                                Text(
                                  "|",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Name",style: TextStyle(fontSize: 12,),),

                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 20,
                          child: Container(

                            child: Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 210,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: attendanceController.subjects.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 7),
                                            child: Text(attendanceController.subjects[index],style: TextStyle(fontSize: 12,),),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "|",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("____________________________________________"),
                        Text(
                          "|",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(
                      height: 446,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Container(
                              child: ListView.builder(
                                itemCount: attendanceController.studentAttendance.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "|",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(attendanceController.studentAttendance[i]["name"]),
                                        SizedBox(width: 20),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          // 2nd Copy
                          Expanded(
                            flex: 19,
                            child: Container(
                              child: ListView.builder(
                                itemCount: attendanceController.studentAttendance.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 15,
                                          width: 210,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: attendanceController.subjects.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 11),
                                                child: Text(
                                                  attendanceController.studentAttendance[i][attendanceController.subjects[index]],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        // Text(attendanceController.studentAttendance[index].wd),
                                        // SizedBox(
                                        //   width: 35,
                                        // ),
                                        // Text(attendanceController.studentAttendance[index].bs),
                                        // SizedBox(
                                        //   width: 10,
                                        // ),
                                        // Text(
                                        //   "|",
                                        //   style: TextStyle(fontWeight: FontWeight.bold),
                                        // ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Text("_______________________________________________"),
                  ],
                ),
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
                        if (await Permission.storage.request().isGranted) {
                          var pdf = pw.Document();

                          pdf.addPage(
                            pw.Page(
                              pageFormat: PdfPageFormat.a4,
                              build: (pw.Context con) {
                                return pw.Padding(
                                  padding: const pw.EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                  child: pw.Column(
                                    children: [
                                      pw.Container(
                                        margin: const pw.EdgeInsets.only(bottom: 20),
                                        height: MediaQuery.of(context).size.height * 0.75,
                                        child: pw.Padding(
                                          padding: const pw.EdgeInsets.all(15.0),
                                          child: pw.Column(
                                            children: [
                                              pw.Text("_____________________________________________________________"),
                                              pw.Row(
                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Expanded(
                                                    flex: 6,
                                                    child: pw.Container(
                                                      child: pw.Row(
                                                        children: [
                                                          pw.Text(
                                                            "|",
                                                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                                                          ),
                                                          pw.SizedBox(
                                                            width: 10,
                                                          ),
                                                          pw.Text("Name",style: pw.TextStyle(fontSize: 12,),),

                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  pw.Expanded(
                                                    flex: 20,
                                                    child: pw.Container(

                                                      child: pw.Row(
                                                        children: [
                                                          pw.Container(

                                                            height: 30,
                                                            width: 200,
                                                            child: pw.ListView.builder(
                                                              direction: pw.Axis.horizontal,
                                                              itemCount: attendanceController.subjects.length,
                                                              itemBuilder: (context, index) {
                                                                return pw.Column(
                                                                  mainAxisAlignment: pw.MainAxisAlignment.center,
                                                                  children: [
                                                                    pw.Padding(
                                                                      padding: const pw.EdgeInsets.symmetric(horizontal: 7),
                                                                      child: pw.Text(attendanceController.subjects[index],style: const pw.TextStyle(fontSize: 10,),),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          pw.SizedBox(
                                                            width: 10,
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              pw.Row(
                                                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                                mainAxisSize: pw.MainAxisSize.max,
                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                children: [
                                                  pw.Text(
                                                    "|",
                                                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                                                  ),
                                                  pw.Text("______________________________________________________________"),
                                                  pw.Text(
                                                    "|",
                                                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              pw.Container(
                                                height: 446,
                                                child: pw.Row(
                                                  children: [
                                                    pw.Expanded(
                                                      flex: 6,
                                                      child: pw.Container(
                                                        child: pw.ListView.builder(
                                                          itemCount: attendanceController.studentAttendance.length,
                                                          itemBuilder: (context, i) {
                                                            return pw.Padding(
                                                              padding: const pw.EdgeInsets.symmetric(vertical: 6),
                                                              child: pw.Row(
                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                children: [
                                                                  pw.Text(
                                                                    "|",
                                                                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                                                                  ),
                                                                  pw.SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  pw.Text(attendanceController.studentAttendance[i]["name"]),
                                                                  pw.SizedBox(width: 20),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    // 2nd Copy
                                                    pw.Expanded(
                                                      flex: 20,
                                                      child: pw.Container(
                                                        child: pw.ListView.builder(
                                                          itemCount: attendanceController.studentAttendance.length,
                                                          itemBuilder: (context, i) {
                                                            return pw.Padding(
                                                              padding: const pw.EdgeInsets.symmetric(vertical: 6),
                                                              child: pw.Row(
                                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                children: [
                                                                  pw.SizedBox(
                                                                    height: 15,
                                                                    width: 210,
                                                                    child: pw.ListView.builder(
                                                                      direction: pw.Axis.horizontal,
                                                                      itemCount: attendanceController.subjects.length,
                                                                      itemBuilder: (context, index) {
                                                                        return pw.Padding(
                                                                          padding: const pw.EdgeInsets.symmetric(horizontal: 11),
                                                                          child: pw.Text(
                                                                            attendanceController.studentAttendance[i][attendanceController.subjects[index]],
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  // Text(attendanceController.studentAttendance[index].wd),
                                                                  // SizedBox(
                                                                  //   width: 35,
                                                                  // ),
                                                                  // Text(attendanceController.studentAttendance[index].bs),
                                                                  // SizedBox(
                                                                  //   width: 10,
                                                                  // ),
                                                                  // Text(
                                                                  //   "|",
                                                                  //   style: TextStyle(fontWeight: FontWeight.bold),
                                                                  // ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          );

                          final output = await getExternalStorageDirectory();
                          final file = File("${output!.path}/${dateTime.day}${dateTime.hour}${dateTime.minute}${dateTime.second}.pdf");
                          log(output.path, name: "Output : ");
                          await file.writeAsBytes(await pdf.save());
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("PDF Downloaded"),
                            backgroundColor: Colors.green,
                          ));
                          // ${dateTime.day}${dateTime.hour}${dateTime.minute}${dateTime.second}
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.redAccent.withOpacity(0.8),
                              content: Text("Please Allow Storage Permission"),
                            ),
                          );
                        }
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Download",
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
