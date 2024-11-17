import 'package:process_automation_app/common/utils/enums/user_role_enum.dart';

class ProjectMemberModel {
  final String userId;
  final String firstName;
  final String lastName;
  final UserRoleEnum role;
  final String imageUrl;

  const ProjectMemberModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.imageUrl,
  });

  ProjectMemberModel copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    UserRoleEnum? role,
    String? imageUrl,
  }) {
    return ProjectMemberModel(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      role: role ?? this.role,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
