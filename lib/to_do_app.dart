import 'package:flutter/material.dart';
import 'package:to_do_app/for_edit_student.dart';


import 'for_student_add.dart';

void main() {
  runApp(const StudentApp());
}

class Student {
  String name;
  String fatherName;
  List<String>? subjects;
  int id;

  Student({
    required this.name,
    required this.fatherName,
    this.subjects,
    required this.id,
  });
}

class StudentApp extends StatefulWidget {
  const StudentApp({super.key});

  @override
  State<StudentApp> createState() => _StudentAppState();
}

Widget myStudentCard({
  required String name,
  required String fatherName,
  required List<String> subjects,
  required VoidCallback onRemove,
  required VoidCallback onEdit,
  required int studentIDForEdit,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.blueGrey,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // STUDENT DATA
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Name: $name",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                "Father: $fatherName",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),

              const SizedBox(height: 5),

              Text(
                "Subjects: ${subjects.join(", ")}",
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),

              const SizedBox(height: 5),

              Text(
                "ID: $studentIDForEdit",
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),

        const SizedBox(width: 10),

        // EDIT + DELETE BUTTONS
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: onEdit,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit),
              ),
            ),

            const SizedBox(width: 10),

            InkWell(
              onTap: onRemove,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.delete, color: Colors.red),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _StudentAppState extends State<StudentApp> {
  final List<Student> studentList = [
    Student(
      name: "Ali Khan",
      fatherName: "Asif Khan",
      subjects: ["Maths"],
      id: 111,
    ),
    Student(
      name: "Ayesha Ahmed",
      fatherName: "Zubair Ahmed",
      subjects: ["Chemistry"],
      id: 112,
    ),
    Student(
      name: "Zain Raza",
      fatherName: "Mansoor Raza",
      subjects: ["Urdu"],
      id: 113,
    ),
  ];

  // ADD STUDENT
  Future<void> addStudent() async {
    final Student? newStudent = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StudentAdd()),
    );

    if (newStudent != null) {
      setState(() {
        studentList.add(newStudent);
      });
    }
  }

  // REMOVE STUDENT
  void removeStudent(int index) {
    setState(() {
      studentList.removeAt(index);
    });
  }

  // EDIT STUDENT
  Future<void> editStudent(int index) async {
    final Student? updatedStudent = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForStudentEditScreen(student: studentList[index]),
      ),
    );

    if (updatedStudent != null) {
      setState(() {
        studentList[index] = updatedStudent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("StudentApp")),

        body: ListView.builder(
          itemCount: studentList.length,

          itemBuilder: (context, index) {
            final Student student = studentList[index];

            return myStudentCard(
              name: student.name,
              fatherName: student.fatherName,
              subjects: student.subjects ?? [],
              studentIDForEdit: student.id,

              onEdit: () {
                editStudent(index);
              },

              onRemove: () {
                removeStudent(index);
              },
            );
          },
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: addStudent,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
