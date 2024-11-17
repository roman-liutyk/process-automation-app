import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:process_automation_app/common/utils/validators.dart';
import 'package:process_automation_app/features/profile/providers/profile_provider.dart';
import 'package:process_automation_app/shared/widgets/primary_button.dart';
import 'package:process_automation_app/shared/widgets/primary_text_field.dart';

class EditProfileDialog extends ConsumerStatefulWidget {
  const EditProfileDialog({
    super.key,
    required this.user,
  });

  final User user;

  @override
  ConsumerState<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends ConsumerState<EditProfileDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final nameParts = widget.user.displayName?.split(' ') ?? ['', ''];
    _firstNameController = TextEditingController(text: nameParts[0]);
    _lastNameController = TextEditingController(text: nameParts.length > 1 ? nameParts[1] : '');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  Future<void> _handleReauthentication(String password) async {
    try {
      final bool? shouldReauth = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Session Expired'),
          content: const Text('Please re-login to continue with password change.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Re-login'),
            ),
          ],
        ),
      );

      if (shouldReauth == true && mounted) {
        Navigator.of(context).pop();

        await FirebaseAuth.instance.signOut();

        if (mounted) {
          context.go('/sign_in');

          final pendingUpdate = {
            'firstName': _firstNameController.text.trim(),
            'lastName': _lastNameController.text.trim(),
            'password': password,
          };

          ref.read(profileProvider.notifier).setPendingUpdate(pendingUpdate);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              e.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      }
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        setState(() => _isLoading = true);

        final bool isPasswordUpdateRequested = _passwordController.text.isNotEmpty && _confirmPassword.text.isNotEmpty;

        await ref.read(profileProvider.notifier).updateProfile(
              firstName: _firstNameController.text.trim(),
              lastName: _lastNameController.text.trim(),
              password: isPasswordUpdateRequested ? _passwordController.text : null,
            );

        if (mounted) {
          Navigator.of(context).pop(true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'Profile updated successfully',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          if (e.toString().contains('[firebase_auth/requires-recent-login]')) {
            await _handleReauthentication(_passwordController.text);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  e.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
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
                const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                PrimaryTextField(
                  controller: _firstNameController,
                  placeholder: 'First name',
                  validator: (value) => Validators.name(value, 'First name'),
                ),
                const SizedBox(height: 16),
                PrimaryTextField(
                  controller: _lastNameController,
                  placeholder: 'Last name',
                  validator: (value) => Validators.name(value, 'Last name'),
                ),
                const SizedBox(height: 16),
                PrimaryTextField(
                  controller: _passwordController,
                  placeholder: 'New Password',
                  validator: (value) {
                    if (value?.isEmpty ?? true) return null;
                    return Validators.password(value);
                  },
                ),
                const SizedBox(height: 16),
                PrimaryTextField(
                  controller: _confirmPassword,
                  placeholder: 'Confirm password',
                  validator: (value) {
                    if (_passwordController.text.isEmpty) return null;
                    return Validators.confirmPassword(
                      value,
                      _passwordController.text,
                    );
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PrimaryButton(
                      title: 'Cancel',
                      callback: () => Navigator.of(context).pop(),
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      borderColor: Colors.black.withOpacity(0.2),
                      horizontalPadding: 16,
                      verticalPadding: 8,
                      radius: 8,
                    ),
                    const SizedBox(width: 12),
                    if (_isLoading)
                      const SizedBox(
                        width: 67,
                        child: Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                      )
                    else
                      PrimaryButton(
                        title: 'Save',
                        callback: _updateProfile,
                        horizontalPadding: 16,
                        verticalPadding: 8,
                        radius: 8,
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
