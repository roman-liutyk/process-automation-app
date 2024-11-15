import 'package:flutter/material.dart';

enum ProjectStatusEnum {
  active,
  completed,
  onHold,
  cancelled;

  factory ProjectStatusEnum.fromString(String status) {
    switch (status) {
      case 'ACTIVE':
        return active;
      case 'COMPLETED':
        return completed;
      case 'ON_HOLD':
        return onHold;
      case 'CANCELLED':
        return cancelled;
      default:
        throw Exception('Provided project status does not exist.');
    }
  }

  @override
  String toString() {
    switch (this) {
      case active:
        return 'ACTIVE';
      case completed:
        return 'COMPLETED';
      case onHold:
        return 'ON_HOLD';
      case cancelled:
        return 'CANCELLED';
      default:
        throw Exception('Provided project status does not exist.');
    }
  }

  String get title {
    switch (this) {
      case active:
        return 'Active';
      case completed:
        return 'Completed';
      case onHold:
        return 'On hold';
      case cancelled:
        return 'Cancelled';
      default:
        throw Exception('Provided project status does not exist.');
    }
  }

  Color get backgroundColor {
    switch (this) {
      case active:
        return const Color(0xFFDBEAFE);
      case completed:
        return const Color(0xFFDCFCE7);
      case onHold:
        return const Color(0xFFFEFCE8);
      case cancelled:
        return const Color(0xFFFEF2F2);
      default:
        throw Exception('Provided project status does not exist.');
    }
  }

  Color get foregroundColor {
    switch (this) {
      case active:
        return const Color(0xFF1E4ED8);
      case completed:
        return const Color(0xFF168056);
      case onHold:
        return const Color(0xFFA16222);
      case cancelled:
        return const Color(0xFFB91C1B);
      default:
        throw Exception('Provided project status does not exist.');
    }
  }
}
