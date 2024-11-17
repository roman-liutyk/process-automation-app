import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process_automation_app/common/utils/enums/task_status_enum.dart';
import 'package:process_automation_app/features/task/providers/task_provider.dart';
import 'package:process_automation_app/features/task/views/widgets/task_board_header.dart';
import 'package:process_automation_app/features/task/views/widgets/task_list_item.dart';

class TaskBoardView extends ConsumerWidget {
  const TaskBoardView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TaskBoardHeader(),
          state.map(
            loaded: (loaded) {
              return Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 36,
                  ),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final tasks = loaded.tasks
                        .where((e) => e.status == TaskStatusEnum.values[index])
                        .toList();

                    return DragTarget<String>(
                      onAcceptWithDetails: (data) {
                        ref.read(taskProvider.notifier).updateStatus(
                              updatedTask: loaded.tasks
                                  .firstWhere((e) => e.id == data.data)
                                  .copyWith(
                                    status: TaskStatusEnum.values[index],
                                  ),
                            );
                      },
                      builder: (context, candidateData, rejectedData) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: TaskStatusEnum.values[index].backgroundColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.25),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: SizedBox(
                            width: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    TaskStatusEnum.values[index].title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        return TaskListItem(
                                          task: tasks[index],
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        height: 16,
                                      ),
                                      itemCount: tasks.length,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 20,
                    );
                  },
                  itemCount: TaskStatusEnum.values.length,
                ),
              );
            },
            loading: (loading) {
              return const Expanded(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
            },
            error: (error) {
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
