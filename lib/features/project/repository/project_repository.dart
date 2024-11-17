import 'dart:html';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:process_automation_app/common/utils/app_constants.dart';
import 'package:process_automation_app/common/utils/enums/user_role_enum.dart';
import 'package:process_automation_app/common/utils/typedefs.dart';
import 'package:process_automation_app/features/auth/models/user_model.dart';
import 'package:process_automation_app/features/project/models/project_member_model.dart';
import 'package:process_automation_app/features/project/models/project_model.dart';

/// An interface, that describes [ProjectRepository] methods.
abstract class ProjectRepository {
  Future<ProjectModel> createProject(ProjectModel project);

  Future<List<ProjectModel>> fetchProjects();

  Future<ProjectModel> fetchProject();

  Future<List<ProjectMemberModel>> fetchProjectMembers();

  Future<void> addProjectMember();
}

/// An implementation of the [ProjectRepository] interface.
class ProjectRepositoryImpl implements ProjectRepository {
  const ProjectRepositoryImpl({
    required Dio dio,
    required FirebaseAuth firebaseAuth,
  })  : _dio = dio,
        _firebaseAuth = firebaseAuth;

  final Dio _dio;
  final FirebaseAuth _firebaseAuth;

  /// Creates project from the [project], that is a [ProjectModel].
  ///
  /// Returns created project as a [ProjectModel] instance, that is parsed from
  /// [Json].
  @override
  Future<ProjectModel> createProject(ProjectModel project) async {
    final Uri url = Uri.parse('${AppConstants.baseUrl}/projects');

    final token = await _firebaseAuth.currentUser?.getIdToken();

    if (token == null) {
      throw Exception('Token cannot be null');
    }

    final response = await _dio.postUri(
      url,
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      ),
      data: project.toJson(),
    );

    return ProjectModel.fromJson(response.data);
  }

  /// Retrieves a list of [ProjectModel] instances.
  ///
  /// Parses a list of [Json] to the list of [ProjectModel] instances.
  @override
  Future<List<ProjectModel>> fetchProjects() async {
    final token = await _firebaseAuth.currentUser?.getIdToken();

    if (token == null) {
      throw Exception('Token cannot be null');
    }

    final response = await _dio.get(
      '${AppConstants.baseUrl}/projects',
      options: Options(
        headers: {
          'ngrok-skip-browser-warning': 'true',
          'Accept': '*/*',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      ),
    );

    return (response.data as List)
        .map((json) => ProjectModel.fromJson(json))
        .toList();
  }

  /// Retrieves a [ProjectModel] instance by the `project_id`.
  ///
  /// Gets `project_id` from local storage and parses [Json] to [ProjectModel].
  @override
  Future<ProjectModel> fetchProject() async {
    final token = await _firebaseAuth.currentUser?.getIdToken();

    if (token == null) {
      throw Exception('Token cannot be null');
    }

    final response = await _dio.get(
      '${AppConstants.baseUrl}/projects/${window.localStorage['project_id']}',
      options: Options(
        headers: {
          'ngrok-skip-browser-warning': 'true',
          'Accept': '*/*',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      ),
    );

    return ProjectModel.fromJson(response.data as Json);
  }

  /// Retrieves a list of [ProjectMemberModel] instances by the `project_id`.
  ///
  /// Gets `project_id` from local storage and maps the responses of users and
  /// roles to the list of [ProjectMemberModel] instances.
  @override
  Future<List<ProjectMemberModel>> fetchProjectMembers() async {
    final token = await _firebaseAuth.currentUser?.getIdToken();

    if (token == null) {
      throw Exception('Token cannot be null');
    }

    final usersResponse = await _dio.get(
      '${AppConstants.baseUrl}/project-connections/${window.localStorage['project_id']}',
      options: Options(
        headers: {
          'ngrok-skip-browser-warning': 'true',
          'Accept': '*/*',
          HttpHeaders.authorizationHeader: 'Bearer $token',
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
            HttpHeaders.authorizationHeader: 'Bearer $token',
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

  @override
  Future<void> addProjectMember() {
    // TODO: implement addProjectMember
    throw UnimplementedError();
  }
}
