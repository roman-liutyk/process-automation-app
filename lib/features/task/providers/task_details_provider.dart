import 'dart:html' show window;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:process_automation_app/common/utils/enums/task_priority_enum.dart';
import 'package:process_automation_app/common/utils/enums/task_status_enum.dart';
import 'package:process_automation_app/features/task/models/task_model.dart';
import 'package:process_automation_app/features/task/providers/task_provider.dart';

part 'task_details_provider.freezed.dart';

@freezed
class TaskDetailsState with _$TaskDetailsState {
  const factory TaskDetailsState.loaded(TaskModel task) = _Loaded;
  const factory TaskDetailsState.loading() = _Loading;
  const factory TaskDetailsState.error(String message) = _Error;
}

class TaskDetailsNotifier extends StateNotifier<TaskDetailsState> {
  TaskDetailsNotifier(this.ref) : super(const TaskDetailsState.loading()) {
    _initialize();
  }

  final Ref ref;

  void _initialize() {
    final taskState = ref.read(taskProvider);
    final taskId = window.localStorage['task_id'];

    if (taskId == null) {
      state = const TaskDetailsState.error('Task ID not found');
      return;
    }

    taskState.whenOrNull(
      loaded: (tasks) {
        try {
          final task = tasks.firstWhere((task) => task.id == taskId);
          state = TaskDetailsState.loaded(task);
        } catch (e) {
          state = const TaskDetailsState.error('Task not found');
        }
      },
      error: (message) {
        state = TaskDetailsState.error(message);
      },
    );
  }

  Future<void> updateTask({
    required String name,
    required String description,
    required TaskStatusEnum status,
    required TaskPriorityEnum priority,
    required DateTime? deadline,
    required String? assignee,
  }) async {
    try {
      final currentState = state.mapOrNull(
        loaded: (value) => value,
      );

      if (currentState != null) {
        final updatedTask = currentState.task.copyWith(
          name: name,
          description: description,
          status: status,
          priority: priority,
          assignee: currentState.task.assignee?.copyWith(id: assignee),
          deadline: deadline,
        );

        state = const TaskDetailsState.loading();
        final taskRepo = ref.read(taskProvider.notifier);

        await taskRepo.updateStatus(updatedTask: updatedTask);
        await taskRepo.updateAssignee(
            assignee: assignee, taskId: updatedTask.id);
        await taskRepo.updatePriority(updatedTask: updatedTask);
        await taskRepo.updateTask(updatedTask: updatedTask);
        state = TaskDetailsState.loaded(updatedTask);
      }
    } catch (e) {
      state = TaskDetailsState.error(e.toString());
    }
  }
}

final taskDetailsProvider =
    StateNotifierProvider.autoDispose<TaskDetailsNotifier, TaskDetailsState>(
  (ref) => TaskDetailsNotifier(ref),
);
