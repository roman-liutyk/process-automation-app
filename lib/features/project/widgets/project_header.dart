import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectHeader extends StatelessWidget {
  final String projectName;
  final String description;

  const ProjectHeader({
    super.key,
    required this.projectName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => context.pop(),
      child: Row(
        children: [
          const Icon(Icons.arrow_back),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      projectName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
