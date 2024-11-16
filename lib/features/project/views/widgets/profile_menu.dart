import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return InkWell(
      onTap: () {
        context.go('/profile');
      },
      borderRadius: const BorderRadius.all(
        Radius.circular(100),
      ),
      child: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(
          user?.photoURL ?? 'https://ui-avatars.com/api/?name=${user?.displayName ?? "User"}',
        ),
      ),
    );
  }
}
