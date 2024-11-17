import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process_automation_app/common/utils/enums/user_role_enum.dart';
import 'package:process_automation_app/common/utils/validators.dart';
import 'package:process_automation_app/features/project/providers/project_details_provider.dart';
import 'package:process_automation_app/shared/widgets/primary_button.dart';
import 'package:process_automation_app/shared/widgets/primary_text_field.dart';

class AddProjectMemberDialog extends StatefulWidget {
  const AddProjectMemberDialog({super.key});

  @override
  State<AddProjectMemberDialog> createState() => _AddProjectMemberDialogState();
}

class _AddProjectMemberDialogState extends State<AddProjectMemberDialog> {
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  UserRoleEnum _role = UserRoleEnum.values
      .where((e) => e.name != UserRoleEnum.owner.name)
      .toList()
      .first;

  @override
  Widget build(BuildContext context) {
    final roles = UserRoleEnum.values
        .where((e) => e.name != UserRoleEnum.owner.name)
        .toList();

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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                PrimaryTextField(
                  controller: _emailController,
                  validator: Validators.email,
                  placeholder: 'Email',
                ),
                const Text(
                  'Choose role:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                DropdownButton(
                  value: _role,
                  items: List.generate(
                    roles.length,
                    (index) {
                      return DropdownMenuItem(
                        value: roles[index],
                        child: Text(
                          roles[index].title,
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
                        _role = value;
                      }
                    });
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Consumer(
                  builder: (context, ref, _) {
                    return PrimaryButton(
                      title: 'Add',
                      callback: () {
                        if (_formKey.currentState!.validate()) {
                          ref
                              .read(projectDetailsProvider.notifier)
                              .addProjectMember(
                                email: _emailController.text.trim(),
                                role: _role,
                              );
                          Navigator.pop(context);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
