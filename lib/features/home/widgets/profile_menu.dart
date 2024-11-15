import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:process_automation_app/features/home/widgets/profile_menu_item.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: const Offset(0, 50),
      child: const CircleAvatar(
        radius: 16,
        backgroundImage: NetworkImage(
          'https://ui-avatars.com/api/?name=John+Doe',
        ),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () => context.push('/profile'),
          child: const ProfileMenuItem(),
        ),
      ],
    );
  }
}
