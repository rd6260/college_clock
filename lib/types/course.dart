import 'package:flutter/material.dart';

class Course {
  // Course Class to store all course-related information
  // final String courseID; // Unique identifier of a course
  final String courseName;
  final String?
  aliasName; // nickname sort of, cause real name is very long sometimes
  final String? courseCode;
  final String professor;
  final String credits; // Format: L-T-P-S-C
  final List<String>? labAssistants;
  final String? teachingAssistant;
  final String segment; // "Full Semester" or "Half Semester"
  final List<CourseSession> lectureSessions;
  final List<CourseSession>? labSessions;
  final List<CourseSession>? tutorialSessions;
  final Color? lectureColor;
  final Color? labColor;
  final Color? tutorialColor;

  Course({
    // required this.courseID,
    required this.courseName,
    this.aliasName,
    this.courseCode,
    required this.professor,
    required this.credits,
    this.labAssistants,
    this.teachingAssistant,
    required this.segment,
    required this.lectureSessions,
    this.labSessions,
    this.tutorialSessions,
    this.lectureColor,
    this.labColor,
    this.tutorialColor,
  });
}



// Class for storing time slots of different sessions
class CourseSession {
  final int day; // monday = 1 to friday = 5
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String? classroom;

  CourseSession({
    required this.day,
    required this.startTime,
    required this.endTime,
    this.classroom,
  });
}
