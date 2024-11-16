import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await FirebaseAuth.instance.signOut();
      },
      borderRadius: const BorderRadius.all(
        Radius.circular(100),
      ),
      child: const CircleAvatar(
        radius: 16,
        backgroundImage: NetworkImage(
          'https://ui-avatars.com/api/?name=John+Doe',
        ),
      ),
    );
  }
}
