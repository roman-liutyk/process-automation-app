import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:process_automation_app/features/profile/providers/profile_provider.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final user = ref.watch(profileProvider);
        final String displayName = user?.displayName ?? 'User';

        return InkWell(
          onTap: () {
            context.go('/profile');
          },
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[200],
            child: Builder(
              builder: (context) {
                if (user?.photoURL != null) {
                  return ClipOval(
                    child: Image.network(
                      user!.photoURL!,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildFallbackAvatar(displayName);
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return _buildFallbackAvatar(displayName);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildFallbackAvatar(String displayName) {
    final initials = displayName.split(' ').map((e) => e.isNotEmpty ? e[0].toUpperCase() : '').join('').padRight(1);

    return Text(
      initials,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black54,
      ),
    );
  }
}
