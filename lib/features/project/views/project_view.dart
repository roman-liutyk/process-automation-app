import 'package:flutter/material.dart';
import 'package:process_automation_app/features/project/models/milestone_model.dart';
import 'package:process_automation_app/features/project/models/team_member.dart';
import 'package:process_automation_app/features/project/widgets/milestone_item.dart';
import 'package:process_automation_app/features/project/widgets/progress_section.dart';
import 'package:process_automation_app/features/project/widgets/project_details_section.dart';
import 'package:process_automation_app/features/project/widgets/project_header.dart';
import 'package:process_automation_app/features/project/widgets/stat_card.dart';

class ProjectView extends StatelessWidget {
  final String projectName;
  final String description;
  final int totalTasks;
  final int completedTasks;
  final int inProgressTasks;
  final int blockedTasks;
  final double progress;
  final List<Milestone> milestones;

  const ProjectView({
    super.key,
    this.projectName = 'TaskMaster Pro Development',
    this.description = 'Розробка системи управління проектами з підтримкою командної роботи, трекінгу завдань та аналітикою прогресу.',
    this.totalTasks = 145,
    this.completedTasks = 89,
    this.inProgressTasks = 42,
    this.blockedTasks = 14,
    this.progress = 0.75,
    List<Milestone>? milestones,
  }) : milestones = milestones ??
            const [
              Milestone(
                title: 'MVP Release',
                date: '2024-03-15',
                isCompleted: true,
              ),
              Milestone(
                title: 'Beta Testing',
                date: '2024-06-30',
                isCompleted: true,
              ),
              Milestone(
                title: 'Public Launch',
                date: '2024-09-15',
                isCompleted: false,
              ),
              Milestone(
                title: 'Version 2.0',
                date: '2024-12-15',
                isCompleted: false,
              ),
            ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 36,
              vertical: 24,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                ProjectHeader(
                  projectName: projectName,
                  description: description,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        label: 'Total Tasks',
                        value: totalTasks.toString(),
                        icon: Icons.task_outlined,
                        bgColor: Colors.blue.shade50,
                        iconColor: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: StatCard(
                        label: 'Completed',
                        value: completedTasks.toString(),
                        icon: Icons.check_circle_outline,
                        bgColor: Colors.green.shade50,
                        iconColor: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        label: 'In Progress',
                        value: inProgressTasks.toString(),
                        icon: Icons.trending_up,
                        bgColor: Colors.amber.shade50,
                        iconColor: Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: StatCard(
                        label: 'Blocked',
                        value: blockedTasks.toString(),
                        icon: Icons.error_outline,
                        bgColor: Colors.red.shade50,
                        iconColor: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ProgressSection(progress: progress),
                const SizedBox(height: 24),
                const Text(
                  'Milestones',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                ...milestones.map((milestone) => MilestoneItem(
                      milestone: milestone,
                    )),
                const SizedBox(height: 24),
                const ProjectDetailsSection(
                  status: 'Active',
                  startDate: '2024-01-15',
                  endDate: '2024-12-15',
                  members: [
                    TeamMember(
                      name: 'John Doe',
                      role: 'Project Manager',
                      avatarUrl: 'https://ui-avatars.com/api/?name=John+Doe',
                    ),
                    TeamMember(
                      name: 'Jane Smith',
                      role: 'Lead Developer',
                      avatarUrl: 'https://ui-avatars.com/api/?name=Jane+Smith',
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
