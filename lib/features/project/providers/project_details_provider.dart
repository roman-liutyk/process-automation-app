import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:process_automation_app/features/project/models/project_member_model.dart';
import 'package:process_automation_app/features/project/models/project_model.dart';
import 'package:process_automation_app/features/project/repository/project_repository.dart';

part 'project_details_provider.freezed.dart';

@freezed
class ProjectDetailsState with _$ProjectDetailsState {
  const factory ProjectDetailsState.loaded({
    required ProjectModel project,
    required List<ProjectMemberModel> members,
  }) = _Loaded;
  const factory ProjectDetailsState.loading() = _Loading;
}

class ProjectDetailsNotifier extends StateNotifier<ProjectDetailsState> {
  ProjectDetailsNotifier({
    required ProjectRepository projectRepository,
  })  : _projectRepository = projectRepository,
        super(const ProjectDetailsState.loading());

  final ProjectRepository _projectRepository;

  Future<void> fetchProject() async {
    state = const ProjectDetailsState.loading();

    final project = await _projectRepository.fetchProject();

    final members = await _projectRepository.fetchProjectMembers();

    state = ProjectDetailsState.loaded(project: project, members: members);
  }
}

final projectDetailsProvider = StateNotifierProvider.autoDispose<
    ProjectDetailsNotifier, ProjectDetailsState>(
  (ref) => ProjectDetailsNotifier(
    projectRepository: ProjectRepositoryImpl(
      dio: Dio(),
    ),
  )..fetchProject(),
);