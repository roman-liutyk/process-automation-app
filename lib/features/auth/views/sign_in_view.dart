import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:process_automation_app/common/utils/validators.dart';
import 'package:process_automation_app/features/auth/providers/auth_provider.dart';
import 'package:process_automation_app/shared/widgets/primary_button.dart';
import 'package:process_automation_app/shared/widgets/primary_container.dart';
import 'package:process_automation_app/shared/widgets/primary_text_field.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});

  @override
  ConsumerState<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(authProvider.notifier).signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text,
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
                child: Column(
                  children: [
                    PrimaryContainer(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        width: 288,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
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
                              PrimaryButton(
                                title: 'Sign In',
                                callback: _submitForm,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('Don\'t have an account? '),
                                  InkWell(
                                    onTap: () {
                                      context.go('/sign_up');
                                    },
                                    child: const Text(
                                      'Sign up',
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
                    const SizedBox(
                      height: 20,
                    ),
                    PrimaryButton(
                      title: 'Sign in with Google',
                      callback: () {
                        ref.read(authProvider.notifier).signInWithGoogle();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PrimaryButton(
                      title: 'Sign in with GitHub',
                      callback: () {
                        ref.read(authProvider.notifier).signInWithGithub();
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
