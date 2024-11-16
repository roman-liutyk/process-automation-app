import 'dart:html';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:process_automation_app/common/utils/app_constants.dart';
import 'package:process_automation_app/common/utils/enums/user_role_enum.dart';
import 'package:process_automation_app/common/utils/typedefs.dart';
import 'package:process_automation_app/features/auth/models/user_model.dart';
import 'package:process_automation_app/features/project/models/project_member_model.dart';
import 'package:process_automation_app/features/project/models/project_model.dart';

abstract class ProjectRepository {
  Future<ProjectModel> createProject(ProjectModel project);

  Future<List<ProjectModel>> fetchProjects();

  Future<ProjectModel> fetchProject();

  Future<List<ProjectMemberModel>> fetchProjectMembers();
}

class ProjectRepositoryImpl implements ProjectRepository {
  const ProjectRepositoryImpl({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;

  @override
  Future<ProjectModel> createProject(ProjectModel project) async {
    final Uri url = Uri.parse('${AppConstants.baseUrl}/projects');

    final response = await _dio.postUri(
      url,
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${window.localStorage['auth_token'] as String}',
        },
      ),
      data: project.toJson(),
    );

    return ProjectModel.fromJson(response.data);
  }

  @override
  Future<List<ProjectModel>> fetchProjects() async {
    final response = await _dio.get(
      '${AppConstants.baseUrl}/projects',
      options: Options(
        headers: {
          'ngrok-skip-browser-warning': 'true',
          'Accept': '*/*',
          HttpHeaders.authorizationHeader:
              'Bearer ${window.localStorage['auth_token'] as String}',
        },
      ),
    );

    return (response.data as List)
        .map((json) => ProjectModel.fromJson(json))
        .toList();
  }

  @override
  Future<ProjectModel> fetchProject() async {
    final response = await _dio.get(
      '${AppConstants.baseUrl}/projects/${window.localStorage['project_id']}',
      options: Options(
        headers: {
          'ngrok-skip-browser-warning': 'true',
          'Accept': '*/*',
          HttpHeaders.authorizationHeader:
              'Bearer ${window.localStorage['auth_token'] as String}',
        },
      ),
    );

    return ProjectModel.fromJson(response.data as Json);
  }

  @override
  Future<List<ProjectMemberModel>> fetchProjectMembers() async {
    final usersResponse = await _dio.get(
      '${AppConstants.baseUrl}/project-connections/${window.localStorage['project_id']}',
      options: Options(
        headers: {
          'ngrok-skip-browser-warning': 'true',
          'Accept': '*/*',
          HttpHeaders.authorizationHeader:
              'Bearer ${window.localStorage['auth_token'] as String}',
        },
      ),
    );

    final users = (usersResponse.data as List)
        .map((json) => UserModel.fromJson(json))
        .toList();

    final List<ProjectMemberModel> projectMembers = [];

    for (final user in users) {
      final roleResponse = await _dio.get(
        '${AppConstants.baseUrl}/project-connections/${window.localStorage['project_id']}/${user.id}',
        options: Options(
          headers: {
            'ngrok-skip-browser-warning': 'true',
            'Accept': '*/*',
            HttpHeaders.authorizationHeader:
                'Bearer ${window.localStorage['auth_token'] as String}',
          },
        ),
      );

      projectMembers.add(
        ProjectMemberModel(
          userId: user.id,
          firstName: user.firstName,
          lastName: user.lastName,
          role: UserRoleEnum.fromString(roleResponse.data),
          imageUrl: user.imageUrl ?? '',
        ),
      );
    }
    return projectMembers;
  }
}
