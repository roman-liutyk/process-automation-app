import 'package:flutter/material.dart';
import 'package:process_automation_app/features/task/views/widgets/task_board_header.dart';

class TaskBoardView extends StatelessWidget {
  const TaskBoardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: TaskBoardHeader(),
          ),
        ],
      ),
    );
  }
}
