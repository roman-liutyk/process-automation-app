import 'dart:html';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:process_automation_app/common/utils/app_constants.dart';
import 'package:process_automation_app/common/utils/enums/task_priority_enum.dart';
import 'package:process_automation_app/common/utils/enums/task_status_enum.dart';
import 'package:process_automation_app/features/task/models/task_model.dart';

abstract class TaskRepository {
  Future<TaskModel> createTask({
    required String name,
    required String? description,
    required TaskStatusEnum status,
    required TaskPriorityEnum priority,
  });
}

class TaskRepositoryImpl implements TaskRepository {
  const TaskRepositoryImpl({
    required Dio dio,
    required FirebaseAuth firebaseAuth,
  })  : _dio = dio,
        _firebaseAuth = firebaseAuth;

  final Dio _dio;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<TaskModel> createTask({
    required String name,
    required String? description,
    required TaskStatusEnum status,
    required TaskPriorityEnum priority,
  }) async {
    final Uri url = Uri.parse(
        '${AppConstants.baseUrl}/tasks/${window.localStorage['project_id']}');

    final token = await _firebaseAuth.currentUser?.getIdToken();

    if (token == null) {
      throw Exception('Token cannot be null');
    }

    final response = await _dio.postUri(
      url,
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      ),
      data: {
        'name': name,
        'description': description,
        'status': status.toString(),
        'priority': priority.toString(),
      },
    );

    return TaskModel.fromJson(response.data);
  }
}
