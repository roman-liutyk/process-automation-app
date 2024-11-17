import 'dart:html';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:process_automation_app/common/utils/enums/task_priority_enum.dart';
import 'package:process_automation_app/common/utils/enums/task_status_enum.dart';
import 'package:process_automation_app/features/task/models/task_model.dart';
import 'package:process_automation_app/features/task/repositories/task_repository.dart';

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
  TaskNotifier({
    required TaskRepository taskRepository,
  })  : _taskRepository = taskRepository,
        super(const TaskState.loading());

  final TaskRepository _taskRepository;

  Future<void> fetchTasks({
    required String projectId,
  }) async {
    state = TaskState.loaded(tasks: []);
  }

  Future<void> createTask({
    required String name,
    required String? description,
    required TaskStatusEnum status,
    required TaskPriorityEnum priority,
  }) async {
    state = const TaskState.loading();

    final TaskModel task = await _taskRepository.createTask(
      name: name,
      description: description,
      status: status,
      priority: priority,
    );

    state = TaskState.loaded(tasks: [task]);
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
            (e) => e.id == taskId ? e.copyWith(status: status) : e,
          )
          .toList();

      state = currentState.copyWith(tasks: updatedTasks);
    }
  }
}

final taskProvider = StateNotifierProvider.autoDispose<TaskNotifier, TaskState>(
    (ref) => TaskNotifier(
          taskRepository: TaskRepositoryImpl(
            dio: Dio(),
            firebaseAuth: FirebaseAuth.instance,
          ),
        )..fetchTasks(projectId: window.localStorage['project_id'] as String));
