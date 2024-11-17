import 'package:flutter/material.dart';
import 'package:process_automation_app/features/task/models/task_model.dart';
import 'package:process_automation_app/shared/widgets/primary_container.dart';

class TaskDetailsInfo extends StatelessWidget {
  const TaskDetailsInfo({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: PrimaryContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            if (task.assignee != null) ...[
              _buildDetailRow(
                'Assignee',
                '${task.assignee!.firstName} ${task.assignee!.lastName}',
              ),
              const SizedBox(height: 12),
            ],
            if (task.reporter != null) ...[
              _buildDetailRow(
                'Reporter',
                '${task.reporter!.firstName} ${task.reporter!.lastName}',
              ),
              const SizedBox(height: 12),
            ],
            if (task.deadline != null) ...[
              _buildDetailRow(
                'Due Date',
                task.deadline!.toString().split(' ')[0],
              ),
              const SizedBox(height: 12),
            ],
            _buildDetailRow(
              'Created',
              task.createdAt.toString().split(' ')[0],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
