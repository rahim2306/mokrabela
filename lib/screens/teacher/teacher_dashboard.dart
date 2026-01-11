import 'package:flutter/material.dart';
import 'package:mokrabela/components/buttons/sign_out_button.dart';
import 'package:sizer/sizer.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Dashboard', style: TextStyle(fontSize: 18.sp)),
        backgroundColor: Colors.orange,
        actions: [
          SignOutButton(),
          SizedBox(width: 2.w),
        ],
      ),
      body: const Center(child: Text('Teacher Dashboard - Classroom Grid')),
    );
  }
}
