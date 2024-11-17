import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:process_automation_app/features/task/models/task_model.dart';
import 'package:process_automation_app/features/task/views/widgets/edit_task_dialog.dart';
import 'package:process_automation_app/features/task/views/widgets/task_status_badge.dart';
import 'package:process_automation_app/features/task/views/widgets/task_priority_badge.dart';
import 'package:process_automation_app/shared/widgets/primary_button.dart';

class TaskDetailsHeader extends StatelessWidget {
  const TaskDetailsHeader({
    super.key,
    required this.task,
  });

  final TaskModel task;

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
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back_outlined),
                ),
                const SizedBox(width: 4),
                Text(
                  'Tasks / ${task.name}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
                const Spacer(),
                PrimaryButton(
                  horizontalPadding: 12,
                  title: 'Edit',
                  callback: () {
                    showDialog(
                      context: context,
                      builder: (context) => EditTaskDialog(task: task),
                    );
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  borderColor: Colors.black.withOpacity(0.2),
                  icon: Icons.edit_outlined,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              task.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (task.description != null) ...[
              const SizedBox(height: 8),
              Text(
                task.description!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                TaskStatusBadge(status: task.status),
                const SizedBox(width: 8),
                TaskPriorityBadge(priority: task.priority),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
