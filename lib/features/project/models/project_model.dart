import 'package:process_automation_app/features/project/models/milestone_model.dart';

class Project {
  final String name;
  final String description;
  final int tasks;
  final int members;
  final List<Milestone>? milestones;
  final double? progress;

  Project({
    required this.name,
    required this.description,
    required this.tasks,
    required this.members,
    this.milestones,
    this.progress,
  });
}
