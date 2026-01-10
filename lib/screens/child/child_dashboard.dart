import 'package:flutter/material.dart';
import 'package:mokrabela/components/buttons/sign_out_button.dart';

class ChildDashboard extends StatelessWidget {
  const ChildDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kids Dashboard'),
        backgroundColor: Colors.blueAccent,
        actions: const [SignOutButton(), SizedBox(width: 8)],
      ),
      body: const Center(child: Text('Child Dashboard - Missing Square Hub')),
    );
  }
}
