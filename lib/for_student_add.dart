import 'package:flutter/material.dart';
import 'package:to_do_app/components/custom_buttons.dart';
import 'package:to_do_app/components/custom_text_fields.dart';


import 'to_do_app.dart';

class StudentAdd extends StatefulWidget {
  const StudentAdd({super.key});

  @override
  State<StudentAdd> createState() => _StudentAddState();
}

class _StudentAddState extends State<StudentAdd> {
  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController fatherNameController =
      TextEditingController();

  final TextEditingController subjectsController =
      TextEditingController();

  final TextEditingController idController =
      TextEditingController();

  void addStudent() {
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

    // Create Student object
    final Student newStudent = Student(
      name: name,
      fatherName: fatherName,
      subjects: subjects,
      id: id,
    );

    // Send Student object back
    Navigator.pop(
      context,
      newStudent,
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
        title: const Text("Add Student"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            CustomTextFields(componentController: nameController, hintText: 'Enter student name',),
            // TextField(
            //   controller: nameController,
            //   decoration: InputDecoration(
            //     hintText: "Enter student name",
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //       borderSide: BorderSide(color: Colors.orange),
            //     ),
            //   ),
            // ),

            const SizedBox(height: 15),
            CustomTextFields(componentController: fatherNameController, hintText: 'Enter father name',),
            // TextField(
            //   controller: fatherNameController,
            //   decoration: InputDecoration(
            //     hintText: "Enter father name",
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //       borderSide: BorderSide(color: Colors.orange),
            //     ),
            //   ),
            // ),

            const SizedBox(height: 15),

            CustomTextFields(componentController: subjectsController, hintText: 'i-e: English',),
            const SizedBox(height: 15),

            CustomTextFields(componentController: idController, hintText: 'i-e: 111',),

            const SizedBox(height: 25),

            CustomButtons(
              label: "Add Student",
              buttonIcon: Icons.person_add,
              onButtonTap: addStudent,
            ),
          ],
        ),
      ),
    );
  }
}