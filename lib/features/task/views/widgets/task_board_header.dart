import 'package:flutter/material.dart';
import 'package:process_automation_app/shared/widgets/primary_button.dart';
import 'package:process_automation_app/shared/widgets/primary_text_field.dart';

class TaskBoardHeader extends StatelessWidget {
  const TaskBoardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task board',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Project: name',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            PrimaryButton(
              title: 'Add task',
              callback: () {},
            ),
            const SizedBox(
              height: 16,
            ),
            PrimaryTextField(
              controller: TextEditingController(),
              placeholder: 'Search tasks...',
              prefix: Padding(
                padding: const EdgeInsets.fromLTRB(
                  15,
                  0,
                  10,
                  0,
                ),
                child: Icon(
                  Icons.search_outlined,
                  color: Colors.grey[500],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
