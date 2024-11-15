import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Center(
        child: SingleChildScrollView(
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
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PrimaryTextField(
                        controller: _lastNameController,
                        placeholder: 'Last name',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PrimaryTextField(
                        controller: _emailController,
                        placeholder: 'Email',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PrimaryTextField(
                        controller: _passwordController,
                        obscureText: true,
                        placeholder: 'Password',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PrimaryTextField(
                        controller: _confirmPassword,
                        obscureText: true,
                        placeholder: 'Confirm password',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PrimaryButton(
                        title: 'Sign Up',
                        callback: () {
                          ref.read<AuthNotifier>(authProvider.notifier).signUp(
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                                firstName: _firstNameController.text.trim(),
                                lastName: _lastNameController.text.trim(),
                              );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('You already have an account. '),
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
}
