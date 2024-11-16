import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileNotifier extends StateNotifier<User?> {
  ProfileNotifier() : super(FirebaseAuth.instance.currentUser) {
    FirebaseAuth.instance.userChanges().listen((user) {
      state = user;
    });
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
  }) async {
    final user = state;
    if (user != null) {
      final newDisplayName = '$firstName $lastName'.trim();
      await user.updateDisplayName(newDisplayName);
      await user.reload();
      state = FirebaseAuth.instance.currentUser;
    }
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, User?>((ref) {
  return ProfileNotifier();
});
