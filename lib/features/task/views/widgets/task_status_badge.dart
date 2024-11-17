import 'package:flutter/material.dart';
import 'package:process_automation_app/common/utils/enums/task_status_enum.dart';

class TaskStatusBadge extends StatelessWidget {
  const TaskStatusBadge({
    super.key,
    required this.status,
  });

  final TaskStatusEnum status;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: status.backgroundColor,
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
          status.title,
          style: TextStyle(
            fontSize: 14,
            color: status.foregroundColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
