import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process_automation_app/features/task/models/task_model.dart';
import 'package:process_automation_app/features/task/repositories/task_repository.dart';

class TaskDetailsNotifier extends StateNotifier<TaskModel?> {
  TaskDetailsNotifier({
    required TaskRepository taskRepository,
  })  : _taskRepository = taskRepository,
        super(null);

  final TaskRepository _taskRepository;

  Future<void> fetchTask() async {
    try {
      state = null;

      final task = await _taskRepository.fetchTask();

      state = task;
    } catch (e) {
      rethrow;
    }
  }
}
