import 'package:college_clock/types/course_session.dart';

class Course {
  // Course Class to store all course-related information
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

  Course({
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
  });
}
