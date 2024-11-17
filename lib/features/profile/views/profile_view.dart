import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:process_automation_app/features/profile/widgets/profile_header.dart';
import 'package:process_automation_app/features/profile/widgets/profile_stats.dart';
import 'package:process_automation_app/shared/widgets/primary_button.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 36,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeader(),
            const SizedBox(height: 24),
            const ProfileStats(),
            const SizedBox(height: 12),
            PrimaryButton(
              icon: Icons.logout,
              horizontalPadding: 8,
              verticalPadding: 4,
              radius: 8,
              backgroundColor: Colors.transparent,
              textColor: Colors.red[400],
              title: 'Logout',
              callback: () async {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) {
                  context.go('/sign_in');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
