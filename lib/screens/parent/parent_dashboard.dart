import 'package:flutter/material.dart';
import 'package:mokrabela/components/buttons/sign_out_button.dart';
import 'package:sizer/sizer.dart';

class ParentDashboard extends StatelessWidget {
  const ParentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parent Dashboard', style: TextStyle(fontSize: 18.sp)),
        backgroundColor: Colors.green,
        actions: [
          SignOutButton(),
          SizedBox(width: 2.w),
        ],
      ),
      body: const Center(
        child: Text('Parent Dashboard - Multi-Child Supervision'),
      ),
    );
  }
}
