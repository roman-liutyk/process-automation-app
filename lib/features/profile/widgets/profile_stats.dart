import 'package:flutter/material.dart';
import 'package:process_automation_app/features/profile/widgets/stat_card.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: StatCard(
            title: 'Tasks Completed',
            value: '0',
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: StatCard(
            title: 'Projects Delivered',
            value: '0',
          ),
        ),
      ],
    );
  }
}
