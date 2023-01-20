class TeacherAttendance {
  int? id;
  final String isPresent;

  TeacherAttendance({this.id, required this.isPresent});

  factory TeacherAttendance.fromMap({required Map data}) {
    return TeacherAttendance(
      id: data["tea_id"],
      isPresent: data["is_present"],
    );
  }
}
