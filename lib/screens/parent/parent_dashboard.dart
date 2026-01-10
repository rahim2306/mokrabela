import 'package:flutter/material.dart';
import 'package:mokrabela/components/buttons/sign_out_button.dart';

class ParentDashboard extends StatelessWidget {
  const ParentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parent Dashboard'),
        backgroundColor: Colors.green,
        actions: const [SignOutButton(), SizedBox(width: 8)],
      ),
      body: const Center(
        child: Text('Parent Dashboard - Multi-Child Supervision'),
      ),
    );
  }
}
