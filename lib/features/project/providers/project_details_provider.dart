import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:process_automation_app/common/utils/enums/project_status_enum.dart';
import 'package:process_automation_app/common/utils/enums/user_role_enum.dart';
import 'package:process_automation_app/features/project/models/project_member_model.dart';
import 'package:process_automation_app/features/project/models/project_model.dart';
import 'package:process_automation_app/features/project/repository/project_repository.dart';

part 'project_details_provider.freezed.dart';

@freezed
class ProjectDetailsState with _$ProjectDetailsState {
  const factory ProjectDetailsState.loaded({
    required ProjectModel project,
    required List<ProjectMemberModel> members,
    String? errorMessage,
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

  Future<void> addProjectMember({
    required String email,
    required UserRoleEnum role,
  }) async {
    final currentState = state.mapOrNull(
      loaded: (value) => value,
    );

    if (currentState != null) {
      try {
        state = const ProjectDetailsState.loading();

        await _projectRepository.addProjectMember(
          email: email,
          role: role,
        );

        final members = await _projectRepository.fetchProjectMembers();

        state = currentState.copyWith(members: members);
      } catch (e) {
        state = currentState.copyWith(errorMessage: 'Cannot add a member');
      }
    }
  }

  Future<void> updateProjectStatus({
    required ProjectStatusEnum status,
  }) async {
    final currentState = state.mapOrNull(
      loaded: (value) => value,
    );

    if (currentState != null) {
      try {
        state = const ProjectDetailsState.loading();

        await _projectRepository.updateProjectStatus(
          status: status,
        );

        final project = await _projectRepository.fetchProject();

        state = currentState.copyWith(project: project);
      } catch (e) {
        state = currentState.copyWith(errorMessage: 'Cannot change the status');
      }
    }
  }
}

final projectDetailsProvider = StateNotifierProvider.autoDispose<
    ProjectDetailsNotifier, ProjectDetailsState>(
  (ref) => ProjectDetailsNotifier(
    projectRepository: ProjectRepositoryImpl(
      dio: Dio(),
      firebaseAuth: FirebaseAuth.instance,
    ),
  )..fetchProject(),
);
