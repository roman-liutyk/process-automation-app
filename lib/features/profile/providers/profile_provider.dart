import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileNotifier extends StateNotifier<User?> {
  ProfileNotifier() : super(FirebaseAuth.instance.currentUser) {
    FirebaseAuth.instance.userChanges().listen((user) {
      state = user;
      if (user != null && _pendingUpdate != null) {
        _applyPendingUpdate();
      }
    });
  }

  Map<String, String>? _pendingUpdate;

  Map<String, String>? get pendingUpdate => _pendingUpdate;

  void setPendingUpdate(Map<String, String> update) {
    _pendingUpdate = update;
  }

  Future<void> _applyPendingUpdate() async {
    if (_pendingUpdate != null) {
      try {
        final update = _pendingUpdate!;
        await updateProfile(
          firstName: update['firstName']!,
          lastName: update['lastName']!,
          password: update['password'],
        );

        _pendingUpdate = null;
      } catch (e) {
        print('Error applying pending update: $e');
      }
    }
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    String? password,
  }) async {
    final user = state;
    if (user != null) {
      final newDisplayName = '$firstName $lastName'.trim();
      await user.updateDisplayName(newDisplayName);
      if (password != null) await user.updatePassword(password);
      await user.reload();
      state = FirebaseAuth.instance.currentUser;
    }
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, User?>((ref) {
  return ProfileNotifier();
});
