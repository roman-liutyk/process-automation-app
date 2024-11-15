import 'package:flutter/material.dart';
import 'package:process_automation_app/features/project/models/project_model.dart';

class ProjectStats extends StatelessWidget {
  final Project project;

  const ProjectStats({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.task_outlined,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Text(
          '${project.tasks} tasks',
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(width: 16),
        Icon(
          Icons.people_outline,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Text(
          '${project.members} members',
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
