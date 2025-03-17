import 'package:flutter/material.dart';

class Course {
  // Course Class to store all course-related information
  // final String courseID; // Unique identifier of a course
  final String courseName;
  final String?
  aliasName; // nickname sort of, cause real name is very long sometimes
  final String? courseCode;
  final String credits; // Format: L-T-P-S-C
  final String professor;
  final List<String>? assistantTeachers;
  final bool segment; // true: "Full Semester"  false: "Half Semester"
  final List<CourseSession> lectureSessions;
  final List<CourseSession>? labSessions;
  final List<CourseSession>? tutorialSessions;
  final Color? lectureColor;
  final Color? labColor;
  final Color? tutorialColor;
  final bool relevant;
  final int semester;
  final String department;

  Course({
    // required this.courseID,
    required this.courseName,
    this.aliasName,
    this.courseCode,
    required this.credits,
    required this.professor,
    this.assistantTeachers,
    required this.segment,
    required this.lectureSessions,
    this.labSessions,
    this.tutorialSessions,
    this.lectureColor,
    this.labColor,
    this.tutorialColor,
    required this.relevant,
    required this.semester,
    required this.department,
  });

  Map<String, dynamic> jsonify() {
    List<Map> lectureData = [];
    List<Map>? labData;
    List<Map>? tutorialData;

    for (CourseSession lecture in lectureSessions) {
      lectureData.add(lecture.jsonify());
    }

    for (CourseSession lab in labSessions ?? []) {
      lectureData.add(lab.jsonify());
    }

    for (CourseSession tutorial in tutorialSessions ?? []) {
      lectureData.add(tutorial.jsonify());
    }

    return {
      // "id": this.courseID,
      "course_name": courseName,
      "alias_name": aliasName,
      "course_code": courseCode,
      "professor": professor,
      "credits": credits,
      "assistant_teachers": assistantTeachers,
      "segment": segment,
      "lecture_sessions": lectureData,
      "lab_sessions": labData,
      "tutorial_sessions": tutorialData,
      "lecture_color": lectureColor,
      "lab_color": labColor,
      "tutorial_color": tutorialColor,
      "relevant": relevant,
      "semester": semester,
      "department": department,
    };
  }
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

  // constructor to load from JSON
  factory CourseSession.fromJson(Map<String, dynamic> json) {
    return CourseSession(
      day: json['day'],
      startTime: TimeOfDay(
        hour: json['start_hour'],
        minute: json['start_minute'],
      ),
      endTime: TimeOfDay(hour: json['end_hour'], minute: json['end_minute']),
      classroom: json['classroom'],
    );
  }

  Map<String, dynamic> jsonify() {
    return {
      "day": day,
      "start_hour": startTime.hour,
      "start_minute": startTime.minute,
      "end_hour": endTime.hour,
      "end_minute": endTime.minute,
      "classroom": classroom,
    };
  }
}
