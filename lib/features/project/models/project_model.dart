import 'package:process_automation_app/common/utils/enums/project_status_enum.dart';
import 'package:process_automation_app/common/utils/typedefs.dart';

class ProjectModel {
  const ProjectModel({
    required this.uuid,
    required this.name,
    required this.description,
    required this.projectStatus,
  });

  factory ProjectModel.fromJson(Json json) => ProjectModel(
        uuid: json['uuid'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        projectStatus: ProjectStatusEnum.fromString(json['project_status'] as String),
      );

  final String uuid;
  final String name;
  final String description;
  final ProjectStatusEnum projectStatus;

  Json toJson() => {
        'uuid': uuid,
        'name': name,
        'description': description,
        'project_status': projectStatus,
      };
}
