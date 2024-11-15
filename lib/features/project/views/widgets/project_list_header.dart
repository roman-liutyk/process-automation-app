import 'package:flutter/material.dart';
import 'package:process_automation_app/features/project/views/widgets/profile_menu.dart';
import 'package:process_automation_app/shared/widgets/primary_button.dart';
import 'package:process_automation_app/shared/widgets/primary_text_field.dart';

class ProjectListHeader extends StatelessWidget {
  const ProjectListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Projects',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Manage and track your projects',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                const ProfileMenu(),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            PrimaryButton(
              title: 'New project',
              callback: () {},
            ),
            const SizedBox(
              height: 16,
            ),
            PrimaryTextField(
              controller: TextEditingController(),
              placeholder: 'Search projects...',
              prefix: Padding(
                padding: const EdgeInsets.fromLTRB(
                  15,
                  0,
                  10,
                  0,
                ),
                child: Icon(
                  Icons.search_outlined,
                  color: Colors.grey[500],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
