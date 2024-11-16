import 'package:process_automation_app/common/utils/enums/project_status_enum.dart';
import 'package:process_automation_app/common/utils/typedefs.dart';

class ProjectModel {
  const ProjectModel({
    required this.uuid,
    required this.name,
    required this.description,
    required this.status,
  });

  factory ProjectModel.fromJson(Json json) => ProjectModel(
        uuid: json['project_uuid'] as String,
        name: json['project_name'] as String,
        description: json['project_description'] as String,
        status: ProjectStatusEnum.fromString(json['project_status'] as String),
      );

  final String uuid;
  final String name;
  final String description;
  final ProjectStatusEnum status;

  Json toJson() => {
        'project_uuid': uuid,
        'project_name': name,
        'project_description': description,
        'project_status': status,
      };
}
