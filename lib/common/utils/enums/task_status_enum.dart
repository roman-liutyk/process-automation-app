import 'package:flutter/material.dart';

enum TaskStatusEnum {
  todo,
  inProgress,
  done,
  inReview;

  factory TaskStatusEnum.fromString(String status) {
    switch (status) {
      case 'TODO':
        return todo;
      case 'IN_PROGRESS':
        return inProgress;
      case 'DONE':
        return done;
      case 'IN_REVIEW':
        return inReview;
      default:
        throw Exception('Provided task status does not exist.');
    }
  }

  @override
  String toString() {
    switch (this) {
      case todo:
        return 'TODO';
      case inProgress:
        return 'IN_PROGRESS';
      case done:
        return 'DONE';
      case inReview:
        return 'IN_REVIEW';
      default:
        throw Exception('Provided task status does not exist.');
    }
  }

  String get title {
    switch (this) {
      case todo:
        return 'Todo';
      case inProgress:
        return 'In progress';
      case done:
        return 'Done';
      case inReview:
        return 'In review';
    }
  }

  Color get backgroundColor {
    switch (this) {
      case inProgress:
        return const Color(0xFFDBEAFE);
      case done:
        return const Color(0xFFDCFCE7);
      case todo:
        return const Color(0xFFFEFCE8);
      case inReview:
        return const Color(0xFFFEF2F2);
      default:
        throw Exception('Provided task status does not exist.');
    }
  }

  Color get foregroundColor {
    switch (this) {
      case inProgress:
        return const Color(0xFF1E4ED8);
      case done:
        return const Color(0xFF168056);
      case todo:
        return const Color(0xFFA16222);
      case inReview:
        return const Color(0xFFB91C1B);
      default:
        throw Exception('Provided task status does not exist.');
    }
  }
}
