enum TaskPriorityEnum {
  low,
  medium,
  high,
  urgent;

  factory TaskPriorityEnum.fromString(String status) {
    switch (status) {
      case 'LOW':
        return low;
      case 'MEDIUM':
        return medium;
      case 'HIGH':
        return high;
      case 'URGENT':
        return urgent;
      default:
        throw Exception('Provided task priority does not exist.');
    }
  }

  @override
  String toString() {
    switch (this) {
      case low:
        return 'LOW';
      case medium:
        return 'MEDIUM';
      case high:
        return 'HIGH';
      case urgent:
        return 'URGENT';
      default:
        throw Exception('Provided task priority does not exist.');
    }
  }

  String get title {
    switch (this) {
      case low:
        return 'Low';
      case medium:
        return 'Medium';
      case high:
        return 'High';
      case urgent:
        return 'Urgent';
      default:
        throw Exception('Provided task priority does not exist.');
    }
  }
}
