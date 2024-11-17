import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process_automation_app/features/task/providers/task_details_provider.dart';
import 'package:process_automation_app/features/task/views/widgets/task_details_header.dart';
import 'package:process_automation_app/features/task/views/widgets/task_details_info.dart';

class TaskDetailsView extends ConsumerWidget {
  const TaskDetailsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskDetailsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: state.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (message) => Center(
          child: Text(message),
        ),
        loaded: (task) => SingleChildScrollView(
          child: Column(
            children: [
              TaskDetailsHeader(task: task),
              const SizedBox(height: 24),
              TaskDetailsInfo(task: task),
            ],
          ),
        ),
      ),
    );
  }
}
