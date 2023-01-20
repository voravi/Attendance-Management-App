class Student {
  int? id;
  final int age;
  final String name;
  final String email;

  Student({
    this.id,
    required this.age,
    required this.name,
    required this.email,
  });

  factory Student.fromMap({required Map data}) {
    return Student(
      id: data["stu_id"],
      name: data["name"],
      age: data["age"],
      email: data["email"],
    );
  }
}
