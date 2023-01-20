class Teacher {
  int? id;
  final String name;
  final int age;
  final String subject;
  final String email;

  Teacher({
    this.id,
    required this.age,
    required this.name,
    required this.email,
    required this.subject,
  });

  factory Teacher.fromMap({required Map data}) {
    return Teacher(
      id: data["tea_id"],
      age: data["age"],
      name: data["name"],
      email: data["email"],
      subject: data["subject"],
    );
  }
}
