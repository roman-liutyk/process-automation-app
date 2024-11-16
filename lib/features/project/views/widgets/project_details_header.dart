import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:process_automation_app/common/utils/enums/project_status_enum.dart';
import 'package:process_automation_app/features/project/models/project_model.dart';

class ProjectDetailsHeader extends StatelessWidget {
  const ProjectDetailsHeader({
    super.key,
    required this.project,
  });

  final ProjectModel project;

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
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_outlined,
                  ),
                ),
                const SizedBox(
                  width: 36,
                ),
                Text(
                  'Projects / ${project.name}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              project.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              project.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: ProjectStatusEnum.values.first.backgroundColor,
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
                  ProjectStatusEnum.values.first.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: ProjectStatusEnum.values.first.foregroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
