// Class for storing time slots of different sessions
import 'package:flutter/material.dart';

class CourseSession {
  final int day; // monday = 1 to friday = 5
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String classroom;

  CourseSession({
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.classroom,
  });
}
