import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<void> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future<void> googleSignIn();
}

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    final UserCredential credentials =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final String? token = await credentials.user?.getIdToken();

    if (token != null) {
      window.localStorage['auth_token'] = token;
    }
  }

  @override
  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final UserCredential credentials =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final String? token = await credentials.user?.getIdToken();

    if (token != null) {
      window.localStorage['auth_token'] = token;
    }
  }

  @override
  Future<void> googleSignIn() async {
    GoogleAuthProvider authProvider = GoogleAuthProvider();

    final UserCredential credentials =
        await _firebaseAuth.signInWithPopup(authProvider);

    final String? token = await credentials.user?.getIdToken();

    if (token != null) {
      window.localStorage['auth_token'] = token;
    }
  }
}
