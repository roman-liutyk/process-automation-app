import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process_automation_app/features/profile/providers/profile_provider.dart';
import 'package:process_automation_app/features/profile/widgets/edit_dialog.dart';
import 'package:process_automation_app/shared/widgets/primary_button.dart';

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileProvider);

    if (user == null) return const SizedBox.shrink();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundImage: NetworkImage(
                user.photoURL ?? 'https://ui-avatars.com/api/?name=${user.displayName ?? "User"}',
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.displayName ?? 'User',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (user.email != null)
                  Row(
                    children: [
                      const Icon(
                        Icons.email_outlined,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        user.email!,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
        PrimaryButton(
          backgroundColor: Colors.white,
          textColor: Colors.black,
          borderColor: Colors.black.withOpacity(0.2),
          horizontalPadding: 12,
          verticalPadding: 8,
          radius: 8,
          icon: Icons.edit_outlined,
          title: 'Edit Profile',
          callback: () async {
            await showDialog<bool>(
              context: context,
              builder: (context) => EditProfileDialog(user: user),
            );
          },
        )
      ],
    );
  }
}
