import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process_automation_app/shared/widgets/primary_button.dart';
import 'package:process_automation_app/shared/widgets/primary_text_field.dart';

class AddProjectMemberDialog extends StatefulWidget {
  const AddProjectMemberDialog({super.key});

  @override
  State<AddProjectMemberDialog> createState() => _AddProjectMemberDialogState();
}

class _AddProjectMemberDialogState extends State<AddProjectMemberDialog> {
  final TextEditingController _emailController = TextEditingController();

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
                controller: _emailController,
                placeholder: 'Email',
              ),
              const SizedBox(
                height: 16,
              ),
              Consumer(
                builder: (context, ref, _) {
                  return PrimaryButton(
                    title: 'Add',
                    callback: () {
                      // ref.read(projectProvider.notifier).createProject(
                      //       name: _nameController.text.trim(),
                      //       description: _descriptionController.text.trim(),
                      //       status: _status,
                      //     );
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
