import 'package:process_automation_app/common/utils/enums/task_priority_enum.dart';
import 'package:process_automation_app/common/utils/enums/task_status_enum.dart';
import 'package:process_automation_app/common/utils/typedefs.dart';
import 'package:process_automation_app/features/auth/models/user_model.dart';
import 'package:process_automation_app/features/project/models/project_model.dart';

class TaskModel {
  final String id;
  final String name;
  final String? description;
  final TaskStatusEnum status;
  final TaskPriorityEnum priority;
  final DateTime? deadline;
  final UserModel? assignee;
  final UserModel? reporter;
  final ProjectModel project;
  final DateTime createdAt;

  const TaskModel({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.priority,
    required this.deadline,
    required this.assignee,
    required this.reporter,
    required this.project,
    required this.createdAt,
  });

  Json toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'status': status.toString(),
        'priority': priority.toString,
        'deadline': deadline?.millisecondsSinceEpoch,
        'assignee': assignee,
        'reporter': reporter,
        'project': project,
        'createdAt': createdAt.millisecondsSinceEpoch,
      };

  factory TaskModel.fromJson(Json json) => TaskModel(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String?,
        status: TaskStatusEnum.fromString(
          json['status'] as String,
        ),
        priority: TaskPriorityEnum.fromString(
          json['priority'] as String,
        ),
        deadline: json['deadline'] == null
            ? null
            : DateTime.parse(
                json['deadline'] as String,
              ),
        assignee: json['assignee'] != null
            ? UserModel.fromJson(json['assignee'] as Json)
            : null,
        reporter: json['reporter'] != null
            ? UserModel.fromJson(json['reporter'] as Json)
            : null,
        project: ProjectModel.fromJson(json['project'] as Json),
        createdAt: DateTime.parse(
          json['createdAt'] as String,
        ),
      );

  TaskModel copyWith({
    String? id,
    String? name,
    String? description,
    TaskStatusEnum? status,
    TaskPriorityEnum? priority,
    DateTime? deadline,
    UserModel? assignee,
    UserModel? reporter,
    ProjectModel? project,
    DateTime? createdAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      deadline: deadline ?? this.deadline,
      assignee: assignee ?? this.assignee,
      reporter: reporter ?? this.reporter,
      project: project ?? this.project,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
