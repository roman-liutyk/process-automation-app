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

  Future<void> fetchTasks() async {
    try {
      state = const TaskState.loading();

      final tasks = await _taskRepository.fetchTasks();

      state = TaskState.loaded(tasks: tasks);
    } catch (e) {
      state = const TaskState.loaded(tasks: []);
      rethrow;
    }
  }

  Future<void> createTask({
    required String name,
    required String? description,
    required TaskStatusEnum status,
    required TaskPriorityEnum priority,
  }) async {
    try {
      state = const TaskState.loading();

      final TaskModel task = await _taskRepository.createTask(
        name: name,
        description: description,
        status: status,
        priority: priority,
      );

      await fetchTasks();
    } catch (e) {
      state = const TaskState.loaded(tasks: []);
      rethrow;
    }
  }

  Future<void> updateStatus({
    required TaskModel updatedTask,
  }) async {
    final currentState = state.mapOrNull(
      loaded: (value) => value,
    );

    if (currentState != null) {
      state = const TaskState.loading();

      final task = await _taskRepository.updateStatus(
        id: updatedTask.id,
        status: updatedTask.status,
      );

      final List<TaskModel> updatedTasks = currentState.tasks
          .map(
            (e) => e.id == task.id ? task : e,
          )
          .toList();

      state = currentState.copyWith(tasks: updatedTasks);
    }
  }

  Future<void> updatePriority({
    required TaskModel updatedTask,
  }) async {
    final currentState = state.mapOrNull(
      loaded: (value) => value,
    );

    if (currentState != null) {
      state = const TaskState.loading();

      final task = await _taskRepository.updatePriority(
        id: updatedTask.id,
        priority: updatedTask.priority,
      );

      final List<TaskModel> updatedTasks = currentState.tasks
          .map(
            (e) => e.id == task.id ? task : e,
          )
          .toList();

      state = currentState.copyWith(tasks: updatedTasks);
    }
  }

  Future<void> updateAssignee({
    required TaskModel updatedTask,
  }) async {
    final currentState = state.mapOrNull(
      loaded: (value) => value,
    );

    if (currentState != null) {
      state = const TaskState.loading();

      final task = await _taskRepository.updateAssignee(
        id: updatedTask.id,
        assigneeId: updatedTask.assignee!.id,
      );

      final List<TaskModel> updatedTasks = currentState.tasks
          .map(
            (e) => e.id == task.id ? task : e,
          )
          .toList();

      state = currentState.copyWith(tasks: updatedTasks);
    }
  }

  Future<void> updateTask({
    required TaskModel updatedTask,
  }) async {
    final currentState = state.mapOrNull(
      loaded: (value) => value,
    );

    if (currentState != null) {
      state = const TaskState.loading();

      final task = await _taskRepository.updateTask(
        task: updatedTask,
      );

      final List<TaskModel> updatedTasks = currentState.tasks
          .map(
            (e) => e.id == task.id ? task : e,
          )
          .toList();

      state = currentState.copyWith(tasks: updatedTasks);
    }
  }
}

final taskProvider = StateNotifierProvider.autoDispose<TaskNotifier, TaskState>((ref) => TaskNotifier(
      taskRepository: TaskRepositoryImpl(
        dio: Dio(),
        firebaseAuth: FirebaseAuth.instance,
      ),
    )..fetchTasks());
