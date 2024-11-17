import 'package:process_automation_app/common/utils/enums/project_status_enum.dart';
import 'package:process_automation_app/common/utils/typedefs.dart';

class ProjectModel {
  const ProjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
  });

  factory ProjectModel.fromJson(Json json) => ProjectModel(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        status: ProjectStatusEnum.fromString(json['status'] as String),
      );

  final String id;
  final String name;
  final String description;
  final ProjectStatusEnum status;

  Json toJson() => {
        'name': name,
        'description': description,
        'status': status.toString(),
      };
}
