import 'package:flutter/material.dart';
import 'package:process_automation_app/common/utils/enums/task_priority_enum.dart';

class TaskPriorityBadge extends StatelessWidget {
  const TaskPriorityBadge({
    super.key,
    required this.priority,
  });

  final TaskPriorityEnum priority;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        child: Text(
          priority.title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
