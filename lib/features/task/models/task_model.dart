import 'package:process_automation_app/common/utils/enums/task_priority_enum.dart';
import 'package:process_automation_app/common/utils/enums/task_status_enum.dart';
import 'package:process_automation_app/common/utils/typedefs.dart';

class TaskModel {
  final String uuid;
  final String name;
  final String description;
  final TaskStatusEnum status;
  final TaskPriorityEnum priority;
  final DateTime deadline;
  final String assigneeUuid;
  final String reporterUuid;
  final String projectUuid;
  final DateTime createdAt;

  const TaskModel({
    required this.uuid,
    required this.name,
    required this.description,
    required this.status,
    required this.priority,
    required this.deadline,
    required this.assigneeUuid,
    required this.reporterUuid,
    required this.projectUuid,
    required this.createdAt,
  });

  Json toJson() => {
        'task_uuid': uuid,
        'task_name': name,
        'task_description': description,
        'task_status': status.toString(),
        'task_priority': priority.toString,
        'deadline': deadline.millisecondsSinceEpoch,
        'assignation_uuid': assigneeUuid,
        'reporter_uuid': reporterUuid,
        'project_uuid': projectUuid,
        'created_at': createdAt.millisecondsSinceEpoch,
      };

  factory TaskModel.fromJson(Json json) => TaskModel(
        uuid: json['task_uuid'] as String,
        name: json['task_name'] as String,
        description: json['task_description'] as String,
        status: TaskStatusEnum.fromString(
          json['task_status'] as String,
        ),
        priority: TaskPriorityEnum.fromString(
          json['task_priority'] as String,
        ),
        deadline: DateTime.fromMillisecondsSinceEpoch(
          json['deadline'] as int,
        ),
        assigneeUuid: json['assignation_uuid'] as String,
        reporterUuid: json['reporter_uuid'] as String,
        projectUuid: json['project_uuid'] as String,
        createdAt: DateTime.fromMillisecondsSinceEpoch(
          json['created_at'] as int,
        ),
      );

  TaskModel copyWith({
    String? uuid,
    String? name,
    String? description,
    TaskStatusEnum? status,
    TaskPriorityEnum? priority,
    DateTime? deadline,
    String? assigneeUuid,
    String? reporterUuid,
    String? projectUuid,
    DateTime? createdAt,
  }) {
    return TaskModel(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      deadline: deadline ?? this.deadline,
      assigneeUuid: assigneeUuid ?? this.assigneeUuid,
      reporterUuid: reporterUuid ?? this.reporterUuid,
      projectUuid: projectUuid ?? this.projectUuid,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
