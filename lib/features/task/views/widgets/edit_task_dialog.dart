import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process_automation_app/common/utils/enums/task_priority_enum.dart';
import 'package:process_automation_app/common/utils/enums/task_status_enum.dart';
import 'package:process_automation_app/features/project/providers/project_details_provider.dart';
import 'package:process_automation_app/features/task/models/task_model.dart';
import 'package:process_automation_app/features/task/providers/task_details_provider.dart';
import 'package:process_automation_app/shared/widgets/primary_button.dart';
import 'package:process_automation_app/shared/widgets/primary_text_field.dart';

class EditTaskDialog extends ConsumerStatefulWidget {
  const EditTaskDialog({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  ConsumerState<EditTaskDialog> createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends ConsumerState<EditTaskDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late TaskStatusEnum _status;
  late TaskPriorityEnum _priority;
  late DateTime? _deadline;
  String? _selectedAssigneeId;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.task.name);
    _descriptionController =
        TextEditingController(text: widget.task.description);
    _status = widget.task.status;
    _priority = widget.task.priority;
    _deadline = widget.task.deadline;
    _selectedAssigneeId = widget.task.assignee?.id;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectDetailsState = ref.watch(projectDetailsProvider);

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
          width: 400,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Edit Task',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                PrimaryTextField(
                  controller: _nameController,
                  placeholder: 'Task name',
                ),
                const SizedBox(height: 16),
                PrimaryTextField(
                  controller: _descriptionController,
                  maxLines: 3,
                  placeholder: 'Description',
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Status:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          DropdownButtonFormField<TaskStatusEnum>(
                            value: _status,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            items: TaskStatusEnum.values.map((status) {
                              return DropdownMenuItem(
                                value: status,
                                child: Text(status.title),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _status = value);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Priority:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          DropdownButtonFormField<TaskPriorityEnum>(
                            value: _priority,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            items: TaskPriorityEnum.values.map((priority) {
                              return DropdownMenuItem(
                                value: priority,
                                child: Text(priority.title),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _priority = value);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Due Date:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          InkWell(
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: _deadline ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 365 * 2),
                                ),
                              );
                              if (date != null) {
                                setState(() => _deadline = date);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _deadline?.toString().split(' ')[0] ??
                                    'Select date',
                                style: TextStyle(
                                  color: _deadline == null
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Assignee:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          projectDetailsState.when(
                            loaded: (project, members, error) => Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButton<String?>(
                                value: _selectedAssigneeId,
                                isExpanded: true,
                                underline: const SizedBox.shrink(),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                items: [
                                  const DropdownMenuItem<String?>(
                                    value: null,
                                    child: Text('Unassigned'),
                                  ),
                                  ...members.map((member) {
                                    return DropdownMenuItem<String?>(
                                      value: member.userId,
                                      child: Text(
                                        '${member.firstName} ${member.lastName}',
                                      ),
                                    );
                                  }).toList(),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedAssigneeId = value;
                                  });
                                },
                              ),
                            ),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PrimaryButton(
                      title: 'Cancel',
                      callback: () => Navigator.pop(context),
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      borderColor: Colors.black.withOpacity(0.2),
                    ),
                    const SizedBox(width: 12),
                    PrimaryButton(
                      title: 'Save',
                      callback: () {
                        final currentState = projectDetailsState.mapOrNull(
                          loaded: (value) => value,
                        );
                        if (currentState != null) {
                          ref.read(taskDetailsProvider.notifier).updateTask(
                                name: _nameController.text.trim(),
                                description: _descriptionController.text.trim(),
                                status: _status,
                                priority: _priority,
                                deadline: _deadline,
                                assignee: _selectedAssigneeId,
                              );
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
