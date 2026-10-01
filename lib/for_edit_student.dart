import 'package:flutter/material.dart';
import 'package:to_do_app/components/custom_buttons.dart';
import 'package:to_do_app/components/custom_text_fields.dart';

import 'to_do_app.dart';

class ForStudentEditScreen extends StatefulWidget {
  final Student student;

  const ForStudentEditScreen({
    super.key,
    required this.student,
  });

  @override
  State<ForStudentEditScreen> createState() =>
      _ForStudentEditScreenState();
}

class _ForStudentEditScreenState
    extends State<ForStudentEditScreen> {
  late TextEditingController nameController;

  late TextEditingController fatherNameController;

  late TextEditingController subjectsController;

  late TextEditingController idController;

  @override
  void initState() {
    super.initState();

    // Existing student data
    nameController = TextEditingController(
      text: widget.student.name,
    );

    fatherNameController = TextEditingController(
      text: widget.student.fatherName,
    );

    subjectsController = TextEditingController(
      text: widget.student.subjects?.join(", ") ?? "",
    );

    idController = TextEditingController(
      text: widget.student.id.toString(),
    );
  }

  void updateStudent() {
    final String name =
        nameController.text.trim();

    final String fatherName =
        fatherNameController.text.trim();

    final String subjectsText =
        subjectsController.text.trim();

    final int? id =
        int.tryParse(idController.text.trim());

    // Validation
    if (name.isEmpty ||
        fatherName.isEmpty ||
        subjectsText.isEmpty ||
        id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please fill all fields correctly",
          ),
        ),
      );

      return;
    }

    // Convert subjects into List<String>
    final List<String> subjects = subjectsText
        .split(",")
        .map(
          (subject) => subject.trim(),
        )
        .where(
          (subject) => subject.isNotEmpty,
        )
        .toList();

    // Create updated Student model
    final Student updatedStudent = Student(
      name: name,
      fatherName: fatherName,
      subjects: subjects,
      id: id,
    );

    // Send updated Student back
    Navigator.pop(
      context,
      updatedStudent,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    fatherNameController.dispose();
    subjectsController.dispose();
    idController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit Student"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            CustomTextFields(componentController: nameController, hintText: 'Enter student name',),

            const SizedBox(height: 15),

            CustomTextFields(componentController: fatherNameController, hintText: 'Enter father name',),

            const SizedBox(height: 15),

            CustomTextFields(componentController: subjectsController, hintText: 'i-e: English',),

            const SizedBox(height: 15),

            CustomTextFields(componentController: idController, hintText: 'i-e: 111',),

            const SizedBox(height: 25),

            CustomButtons(
              label: "Update",
              onButtonTap: updateStudent,
            ),
          ],
        ),
      ),
    );
  }
}