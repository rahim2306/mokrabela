import 'package:flutter/material.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:sizer/sizer.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.logout_rounded, size: 6.w),
      tooltip: 'Sign Out',
      onPressed: () async {
        await AuthService().signOut();
      },
      style: IconButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
