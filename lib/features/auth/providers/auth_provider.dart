import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:process_automation_app/features/auth/models/user_model.dart';
import 'package:process_automation_app/features/auth/repositories/auth_repository.dart';

part 'auth_provider.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.authenticated({
    required UserModel user,
  }) = _Authenticated;
  const factory AuthState.unauthenticated({
    String? errorMessage,
  }) = _Unauthenticated;
  const factory AuthState.authenticating() = _Authenticating;
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(
          const AuthState.unauthenticated(),
        );

  final AuthRepository _authRepository;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      state = const AuthState.authenticating();
      await _authRepository.signIn(
        email: email,
        password: password,
      );
      state = const AuthState.authenticated(
        user: UserModel(
          uid: 'uid',
          email: 'email',
          firstName: 'firstName',
          lastName: 'lastName',
        ),
      );
    } catch (e) {
      state = AuthState.unauthenticated(
        errorMessage: e is FirebaseAuthException ? e.message : 'Unknown error',
      );
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      state = const AuthState.authenticating();
      await _authRepository.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
      state = const AuthState.authenticated(
        user: UserModel(
          uid: 'uid',
          email: 'email',
          firstName: 'firstName',
          lastName: 'lastName',
        ),
      );
    } catch (e) {
      state = AuthState.unauthenticated(
        errorMessage: e is FirebaseAuthException ? e.message : 'Unknown error',
      );
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      state = const AuthState.authenticating();
      await _authRepository.signInWithGoogle();
      state = const AuthState.authenticated(
        user: UserModel(
          uid: 'uid',
          email: 'email',
          firstName: 'firstName',
          lastName: 'lastName',
        ),
      );
    } catch (e) {
      state = AuthState.unauthenticated(
        errorMessage: e is FirebaseAuthException ? e.message : 'Unknown error',
      );
    }
  }

  Future<void> signInWithGithub() async {
    try {
      await _authRepository.signInWithGitHub();
    } catch (e) {
      state = AuthState.unauthenticated(
        errorMessage: e is FirebaseAuthException ? e.message : 'Unknown error',
      );
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(
    authRepository: AuthRepositoryImpl(
      firebaseAuth: FirebaseAuth.instance,
    ),
  ),
);
