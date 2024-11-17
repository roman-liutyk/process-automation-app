import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process_automation_app/common/utils/enums/project_status_enum.dart';
import 'package:process_automation_app/features/project/models/project_model.dart';
import 'package:process_automation_app/features/project/repository/project_repository.dart';

class ProjectProvider extends StateNotifier<List<ProjectModel>?> {
  ProjectProvider({
    required ProjectRepository projectRepository,
  })  : _projectRepository = projectRepository,
        super(null);

  final ProjectRepository _projectRepository;

  Future<void> createProject({
    required String name,
    required String description,
    required ProjectStatusEnum status,
  }) async {
    try {
      final createdProject = await _projectRepository.createProject(
        ProjectModel(
          id: '',
          name: name,
          description: description,
          status: status,
        ),
      );

      await fetchProjects();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchProjects() async {
    try {
      final projects = await _projectRepository.fetchProjects();

      state = projects;
    } catch (e) {
      rethrow;
    }
  }
}

final projectProvider = StateNotifierProvider.autoDispose<ProjectProvider, List<ProjectModel>?>(
  (ref) => ProjectProvider(
    projectRepository: ProjectRepositoryImpl(
      dio: Dio(),
      firebaseAuth: FirebaseAuth.instance,
    ),
  )..fetchProjects(),
);
