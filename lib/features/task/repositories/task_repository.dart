import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class TaskRepository {}

class TaskRepositoryImpl implements TaskRepository {
  const TaskRepositoryImpl({
    required Dio dio,
    required FirebaseAuth firebaseAuth,
  })  : _dio = dio,
        _firebaseAuth = firebaseAuth;

  final Dio _dio;
  final FirebaseAuth _firebaseAuth;
}
