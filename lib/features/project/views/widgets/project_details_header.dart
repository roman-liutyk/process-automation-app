import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:process_automation_app/common/utils/enums/project_status_enum.dart';
import 'package:process_automation_app/features/project/models/project_model.dart';
import 'package:process_automation_app/features/project/providers/project_details_provider.dart';
import 'package:process_automation_app/features/project/providers/project_provider.dart';

class ProjectDetailsHeader extends StatefulWidget {
  const ProjectDetailsHeader({
    super.key,
    required this.project,
  });

  final ProjectModel project;

  @override
  State<ProjectDetailsHeader> createState() => _ProjectDetailsHeaderState();
}

class _ProjectDetailsHeaderState extends State<ProjectDetailsHeader> {
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
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Projects / ${widget.project.name}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Consumer(
                  builder: (context, ref, _) {
                    return IconButton(
                      onPressed: () {
                        ref.read(projectProvider.notifier).deleteProject();
                        context.pop();
                      },
                      icon: const Icon(
                        Icons.delete_outlined,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              widget.project.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.project.description,
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
                color: widget.project.status.backgroundColor,
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
                  widget.project.status.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: widget.project.status.foregroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Consumer(builder: (context, ref, _) {
              return DropdownButton(
                value: widget.project.status,
                items: List.generate(
                  ProjectStatusEnum.values.length,
                  (index) {
                    return DropdownMenuItem(
                      value: ProjectStatusEnum.values[index],
                      child: Text(
                        ProjectStatusEnum.values[index].title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                ),
                onChanged: (value) {
                  if (value != null) {
                    ref
                        .read(projectDetailsProvider.notifier)
                        .updateProjectStatus(status: value);
                  }
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
