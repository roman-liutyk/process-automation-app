import 'dart:html';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:process_automation_app/common/utils/app_constants.dart';
import 'package:process_automation_app/features/auth/models/user_model.dart';

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

  Future<void> signInWithGoogle();

  Future<void> signInWithGitHub();
}

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required FirebaseAuth firebaseAuth,
    required Dio dio,
  })  : _firebaseAuth = firebaseAuth,
        _dio = dio;

  final FirebaseAuth _firebaseAuth;
  final Dio _dio;

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
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _firebaseAuth.currentUser?.updateDisplayName('$firstName $lastName');

    _firebaseAuth.currentUser?.reload();

    final String? token = await _firebaseAuth.currentUser?.getIdToken();

    if (token != null) {
      window.localStorage['auth_token'] = token;

      await _createUser(token, _firebaseAuth.currentUser!);
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    GoogleAuthProvider authProvider = GoogleAuthProvider();

    final UserCredential credentials =
        await _firebaseAuth.signInWithPopup(authProvider);

    final String? token = await credentials.user?.getIdToken();

    if (token != null) {
      window.localStorage['auth_token'] = token;

      await _createUser(token, credentials.user!);
    }
  }

  @override
  Future<void> signInWithGitHub() async {
    final OAuthProvider provider = OAuthProvider('github.com');

    final UserCredential credentials =
        await _firebaseAuth.signInWithPopup(provider);

    final String? token = await credentials.user?.getIdToken();

    if (token != null) {
      window.localStorage['auth_token'] = token;

      print(token);

      await _createUser(token, credentials.user!);
    }
  }

  Future<UserModel> _createUser(String token, User user) async {
    final Uri url = Uri.parse('${AppConstants.baseUrl}/users');

    final response = await _dio.postUri(
      url,
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      ),
      data: UserModel(
        id: user.uid,
        email: user.email!,
        firstName: user.displayName!.split(' ')[0],
        lastName: user.displayName!.split(' ')[1],
        imageUrl: user.photoURL,
      ).toJson(),
    );

    return UserModel.fromJson(response.data);
  }
}
