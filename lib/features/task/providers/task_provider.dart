import 'dart:html';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:process_automation_app/common/utils/enums/task_priority_enum.dart';
import 'package:process_automation_app/common/utils/enums/task_status_enum.dart';
import 'package:process_automation_app/features/task/models/task_model.dart';

part 'task_provider.freezed.dart';

@freezed
class TaskState with _$TaskState {
  const factory TaskState.loaded({
    required List<TaskModel> tasks,
  }) = _Loaded;
  const factory TaskState.loading() = _Loading;
  const factory TaskState.error({
    required String errorMessage,
  }) = _Error;
}

class TaskNotifier extends StateNotifier<TaskState> {
  TaskNotifier() : super(const TaskState.loading());

  Future<void> fetchTasks({
    required String projectId,
  }) async {
    final placeholderTasks = [
      TaskModel(
        uuid: "1",
        name: "Set up project repository",
        description:
            "Initialize the repository and add basic folder structure.",
        status: TaskStatusEnum.todo,
        priority: TaskPriorityEnum.high,
        deadline: DateTime.now().add(const Duration(days: 3)),
        assigneeUuid: "user_1",
        reporterUuid: "user_2",
        projectUuid: "project_1",
        createdAt: DateTime.now(),
      ),
      TaskModel(
        uuid: "2",
        name: "Create wireframes",
        description: "Design basic wireframes for the dashboard.",
        status: TaskStatusEnum.inProgress,
        priority: TaskPriorityEnum.medium,
        deadline: DateTime.now().add(const Duration(days: 7)),
        assigneeUuid: "user_3",
        reporterUuid: "user_1",
        projectUuid: "project_2",
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      TaskModel(
        uuid: "3",
        name: "Implement login API",
        description: "Build and test the login API using Node.js.",
        status: TaskStatusEnum.todo,
        priority: TaskPriorityEnum.urgent,
        deadline: DateTime.now().add(const Duration(days: 2)),
        assigneeUuid: "user_4",
        reporterUuid: "user_5",
        projectUuid: "project_3",
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      TaskModel(
        uuid: "4",
        name: "Write documentation",
        description: "Prepare initial project documentation.",
        status: TaskStatusEnum.inReview,
        priority: TaskPriorityEnum.low,
        deadline: DateTime.now().add(const Duration(days: 14)),
        assigneeUuid: "user_2",
        reporterUuid: "user_3",
        projectUuid: "project_1",
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
      TaskModel(
        uuid: "5",
        name: "Test payment gateway",
        description:
            "Ensure that the payment gateway is functioning correctly.",
        status: TaskStatusEnum.done,
        priority: TaskPriorityEnum.medium,
        deadline: DateTime.now().subtract(const Duration(days: 1)),
        assigneeUuid: "user_5",
        reporterUuid: "user_1",
        projectUuid: "project_2",
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
      ),
      TaskModel(
        uuid: "6",
        name: "Optimize database queries",
        description: "Reduce load time by optimizing SQL queries.",
        status: TaskStatusEnum.inProgress,
        priority: TaskPriorityEnum.high,
        deadline: DateTime.now().add(const Duration(days: 5)),
        assigneeUuid: "user_4",
        reporterUuid: "user_2",
        projectUuid: "project_3",
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
      TaskModel(
        uuid: "7",
        name: "Create onboarding tutorial",
        description:
            "Develop an interactive onboarding tutorial for new users.",
        status: TaskStatusEnum.todo,
        priority: TaskPriorityEnum.low,
        deadline: DateTime.now().add(const Duration(days: 10)),
        assigneeUuid: "user_3",
        reporterUuid: "user_4",
        projectUuid: "project_1",
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      TaskModel(
        uuid: "8",
        name: "Develop mobile app UI",
        description:
            "Implement the UI for the mobile application using Flutter.",
        status: TaskStatusEnum.inProgress,
        priority: TaskPriorityEnum.high,
        deadline: DateTime.now().add(const Duration(days: 15)),
        assigneeUuid: "user_1",
        reporterUuid: "user_5",
        projectUuid: "project_2",
        createdAt: DateTime.now().subtract(const Duration(days: 6)),
      ),
      TaskModel(
        uuid: "9",
        name: "Deploy staging environment",
        description: "Set up a staging environment for testing.",
        status: TaskStatusEnum.todo,
        priority: TaskPriorityEnum.medium,
        deadline: DateTime.now().add(const Duration(days: 4)),
        assigneeUuid: "user_5",
        reporterUuid: "user_3",
        projectUuid: "project_3",
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      TaskModel(
        uuid: "10",
        name: "Fix login bug",
        description: "Resolve the issue with login failure in certain cases.",
        status: TaskStatusEnum.inReview,
        priority: TaskPriorityEnum.urgent,
        deadline: DateTime.now().add(const Duration(days: 1)),
        assigneeUuid: "user_4",
        reporterUuid: "user_2",
        projectUuid: "project_1",
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
      ),
      TaskModel(
        uuid: "11",
        name: "Update design system",
        description: "Incorporate the new design standards into the system.",
        status: TaskStatusEnum.todo,
        priority: TaskPriorityEnum.low,
        deadline: DateTime.now().add(const Duration(days: 20)),
        assigneeUuid: "user_3",
        reporterUuid: "user_1",
        projectUuid: "project_2",
        createdAt: DateTime.now(),
      ),
      TaskModel(
        uuid: "12",
        name: "Set up CI/CD pipeline",
        description: "Implement a CI/CD pipeline for automated deployments.",
        status: TaskStatusEnum.inProgress,
        priority: TaskPriorityEnum.high,
        deadline: DateTime.now().add(const Duration(days: 8)),
        assigneeUuid: "user_1",
        reporterUuid: "user_5",
        projectUuid: "project_3",
        createdAt: DateTime.now().subtract(const Duration(days: 12)),
      ),
      TaskModel(
        uuid: "13",
        name: "Prepare sprint report",
        description: "Create a detailed report for the current sprint.",
        status: TaskStatusEnum.done,
        priority: TaskPriorityEnum.medium,
        deadline: DateTime.now().subtract(const Duration(days: 2)),
        assigneeUuid: "user_2",
        reporterUuid: "user_4",
        projectUuid: "project_1",
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      TaskModel(
        uuid: "14",
        name: "Integrate analytics",
        description: "Add analytics tracking to monitor user behavior.",
        status: TaskStatusEnum.inReview,
        priority: TaskPriorityEnum.high,
        deadline: DateTime.now().add(const Duration(days: 6)),
        assigneeUuid: "user_3",
        reporterUuid: "user_2",
        projectUuid: "project_2",
        createdAt: DateTime.now().subtract(const Duration(days: 9)),
      ),
      TaskModel(
        uuid: "15",
        name: "Fix responsive layout",
        description: "Ensure the layout is responsive for all devices.",
        status: TaskStatusEnum.todo,
        priority: TaskPriorityEnum.medium,
        deadline: DateTime.now().add(const Duration(days: 12)),
        assigneeUuid: "user_4",
        reporterUuid: "user_3",
        projectUuid: "project_3",
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      TaskModel(
        uuid: "16",
        name: "Add unit tests",
        description: "Write unit tests for the new feature module.",
        status: TaskStatusEnum.inProgress,
        priority: TaskPriorityEnum.low,
        deadline: DateTime.now().add(const Duration(days: 18)),
        assigneeUuid: "user_5",
        reporterUuid: "user_1",
        projectUuid: "project_1",
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
      TaskModel(
        uuid: "17",
        name: "Conduct user interviews",
        description: "Interview users to gather feedback on the new feature.",
        status: TaskStatusEnum.done,
        priority: TaskPriorityEnum.high,
        deadline: DateTime.now().subtract(const Duration(days: 3)),
        assigneeUuid: "user_2",
        reporterUuid: "user_4",
        projectUuid: "project_2",
        createdAt: DateTime.now().subtract(const Duration(days: 25)),
      ),
      TaskModel(
        uuid: "18",
        name: "Set up notifications",
        description: "Implement push notifications for user updates.",
        status: TaskStatusEnum.todo,
        priority: TaskPriorityEnum.urgent,
        deadline: DateTime.now().add(const Duration(days: 3)),
        assigneeUuid: "user_1",
        reporterUuid: "user_5",
        projectUuid: "project_3",
        createdAt: DateTime.now().subtract(const Duration(days: 4)),
      ),
      TaskModel(
        uuid: "19",
        name: "Refactor legacy code",
        description: "Clean up and refactor the older parts of the codebase.",
        status: TaskStatusEnum.inProgress,
        priority: TaskPriorityEnum.medium,
        deadline: DateTime.now().add(const Duration(days: 14)),
        assigneeUuid: "user_3",
        reporterUuid: "user_2",
        projectUuid: "project_1",
        createdAt: DateTime.now().subtract(const Duration(days: 8)),
      ),
    ];

    state = TaskState.loaded(tasks: placeholderTasks);
  }

  Future<void> changeStatus(
    String taskId,
    TaskStatusEnum status,
  ) async {
    final currentState = state.mapOrNull(
      loaded: (value) => value,
    );

    if (currentState != null) {
      state = const TaskState.loading();

      final List<TaskModel> updatedTasks = currentState.tasks
          .map(
            (e) => e.uuid == taskId ? e.copyWith(status: status) : e,
          )
          .toList();

      state = currentState.copyWith(tasks: updatedTasks);
    }
  }
}

final taskProvider = StateNotifierProvider.autoDispose<TaskNotifier, TaskState>(
    (ref) => TaskNotifier()
      ..fetchTasks(projectId: window.sessionStorage['project_id'] as String));
