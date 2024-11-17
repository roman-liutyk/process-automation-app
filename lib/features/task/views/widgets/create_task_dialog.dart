import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process_automation_app/common/utils/enums/task_priority_enum.dart';
import 'package:process_automation_app/common/utils/enums/task_status_enum.dart';
import 'package:process_automation_app/features/task/providers/task_provider.dart';
import 'package:process_automation_app/shared/widgets/primary_button.dart';
import 'package:process_automation_app/shared/widgets/primary_text_field.dart';

class CreateTaskDialog extends StatefulWidget {
  const CreateTaskDialog({super.key});

  @override
  State<CreateTaskDialog> createState() => _CreateTaskDialogState();
}

class _CreateTaskDialogState extends State<CreateTaskDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  TaskStatusEnum _status = TaskStatusEnum.values.first;
  TaskPriorityEnum _priority = TaskPriorityEnum.values.first;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        child: SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryTextField(
                controller: _nameController,
                placeholder: 'Task name',
              ),
              const SizedBox(
                height: 16,
              ),
              PrimaryTextField(
                controller: _descriptionController,
                maxLines: 3,
                placeholder: 'Description',
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Choose status:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      DropdownButton(
                        value: _status,
                        items: List.generate(
                          TaskStatusEnum.values.length,
                          (index) {
                            return DropdownMenuItem(
                              value: TaskStatusEnum.values[index],
                              child: Text(
                                TaskStatusEnum.values[index].title,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          },
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (value != null) {
                              _status = value;
                            }
                          });
                        },
                      ),
                      const Text(
                        'Choose priority:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      DropdownButton(
                        value: _priority,
                        items: List.generate(
                          TaskPriorityEnum.values.length,
                          (index) {
                            return DropdownMenuItem(
                              value: TaskPriorityEnum.values[index],
                              child: Text(
                                TaskPriorityEnum.values[index].title,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          },
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (value != null) {
                              _priority = value;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Consumer(builder: (context, ref, _) {
                    return PrimaryButton(
                      title: 'Create',
                      callback: () {
                        ref.read(taskProvider.notifier).createTask(
                            name: _nameController.text.trim(),
                            description:
                                _descriptionController.text.trim().isEmpty
                                    ? null
                                    : _descriptionController.text.trim(),
                            status: _status,
                            priority: _priority);
                        Navigator.pop(context);
                      },
                    );
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
