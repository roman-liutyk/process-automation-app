import 'package:flutter/material.dart';
import 'package:process_automation_app/features/project/models/milestone_model.dart';

class MilestoneItem extends StatelessWidget {
  final Milestone milestone;

  const MilestoneItem({
    super.key,
    required this.milestone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(
            milestone.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: milestone.isCompleted ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              milestone.title,
              style: TextStyle(
                color: milestone.isCompleted ? Colors.grey[800] : Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            milestone.date,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
