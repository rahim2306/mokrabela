import 'package:flutter/material.dart';
import 'package:mokrabela/components/buttons/sign_out_button.dart';
import 'package:sizer/sizer.dart';

class ChildDashboard extends StatelessWidget {
  const ChildDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kids Dashboard', style: TextStyle(fontSize: 18.sp)),
        backgroundColor: Colors.blueAccent,
        actions: [
          SignOutButton(),
          SizedBox(width: 2.w),
        ],
      ),
      body: const Center(child: Text('Child Dashboard - Missing Square Hub')),
    );
  }
}
