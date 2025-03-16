import 'dart:ui';

class ClassInfo {
  final String courseCode;
  final String courseName;
  final int startHour;
  final int startMinute;
  final int endHour;
  final int endMinute;
  final int dayOfWeek; // 1 = Monday, 2 = Tuesday, etc.
  final Color color;

  ClassInfo({
    required this.courseCode,
    required this.courseName,
    required this.startHour,
    required this.startMinute,
    required this.endHour,
    required this.endMinute,
    required this.dayOfWeek,
    required this.color,
  });
}
