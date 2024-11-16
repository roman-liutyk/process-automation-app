import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:process_automation_app/features/project/models/project_model.dart';
import 'package:process_automation_app/shared/widgets/primary_container.dart';

class ProjectItem extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback onTap;

  const ProjectItem({
    super.key,
    required this.project,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(
        Radius.circular(12),
      ),
      child: PrimaryContainer(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: project.status.backgroundColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Text(
                        project.status.title,
                        style: TextStyle(
                          color: project.status.foregroundColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                print(project.id);
                context.go('/${project.id}/details');
              },
              icon: const Icon(
                Icons.settings_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
