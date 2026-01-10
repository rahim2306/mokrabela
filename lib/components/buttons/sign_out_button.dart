import 'package:flutter/material.dart';
import 'package:mokrabela/screens/auth/login.dart';
import 'package:mokrabela/services/auth_service.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout_rounded),
      tooltip: 'Sign Out',
      onPressed: () async {
        await AuthService().signOut();
        if (context.mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
          );
        }
      },
      style: IconButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
