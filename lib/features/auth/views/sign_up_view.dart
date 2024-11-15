import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:process_automation_app/common/utils/validators.dart';
import 'package:process_automation_app/features/auth/providers/auth_provider.dart';
import 'package:process_automation_app/shared/widgets/primary_button.dart';
import 'package:process_automation_app/shared/widgets/primary_text_field.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(authProvider.notifier).signUp(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthState state = ref.watch(authProvider);

    ref.listen<AuthState>(
      authProvider,
      (previousState, currentState) {
        currentState.whenOrNull(
          unauthenticated: (errorMessage) {
            if (errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: const Color.fromRGBO(244, 67, 54, 1),
                  content: Text(
                    errorMessage,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Center(
        child: state == const AuthState.authenticating()
            ? const CircularProgressIndicator(
                color: Color(0xFF3B82F6),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(
                      color: const Color(0xFFE8EAED),
                    ),
                  ),
                  child: SizedBox(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PrimaryTextField(
                              controller: _firstNameController,
                              placeholder: 'First name',
                              validator: (value) => Validators.name(value, 'First name'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PrimaryTextField(
                              controller: _lastNameController,
                              placeholder: 'Last name',
                              validator: (value) => Validators.name(value, 'Last name'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PrimaryTextField(
                              controller: _emailController,
                              placeholder: 'Email',
                              validator: Validators.email,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PrimaryTextField(
                              controller: _passwordController,
                              obscureText: true,
                              placeholder: 'Password',
                              validator: Validators.password,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PrimaryTextField(
                              controller: _confirmPassword,
                              obscureText: true,
                              placeholder: 'Confirm password',
                              validator: (value) => Validators.confirmPassword(
                                value,
                                _passwordController.text,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PrimaryButton(
                              title: 'Sign Up',
                              callback: _submitForm,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('You already have an account? '),
                                InkWell(
                                  onTap: () {
                                    context.go('/sign_in');
                                  },
                                  child: const Text(
                                    'Sign in',
                                    style: TextStyle(
                                      color: Color(0xFF3B82F6),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }
}
