import 'package:flutter/material.dart';
import 'package:mokrabela/components/buttons/sign_out_button.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
        backgroundColor: Colors.orange,
        actions: const [SignOutButton(), SizedBox(width: 8)],
      ),
      body: const Center(child: Text('Teacher Dashboard - Classroom Grid')),
    );
  }
}
