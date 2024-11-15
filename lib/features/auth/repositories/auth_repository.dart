abstract class AuthRepository {
  Future<void> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> signIn({required String email, required String password}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(
      {required String username,
      required String email,
      required String password}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
