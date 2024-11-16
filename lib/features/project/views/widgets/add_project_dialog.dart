import 'package:flutter/material.dart';
import 'package:process_automation_app/common/utils/enums/project_status_enum.dart';
import 'package:process_automation_app/shared/widgets/primary_button.dart';
import 'package:process_automation_app/shared/widgets/primary_text_field.dart';

class AddProjectDialog extends StatefulWidget {
  const AddProjectDialog({super.key});

  @override
  State<AddProjectDialog> createState() => _AddProjectDialogState();
}

class _AddProjectDialogState extends State<AddProjectDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  ProjectStatusEnum _status = ProjectStatusEnum.values.first;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryTextField(
                controller: _nameController,
                placeholder: 'Project name',
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
                          ProjectStatusEnum.values.length,
                          (index) {
                            return DropdownMenuItem(
                              value: ProjectStatusEnum.values[index],
                              child: Text(
                                ProjectStatusEnum.values[index].title,
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
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  PrimaryButton(
                    title: 'Create',
                    callback: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
