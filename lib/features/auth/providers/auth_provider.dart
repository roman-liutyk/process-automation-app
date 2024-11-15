import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class AuthState {}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);
