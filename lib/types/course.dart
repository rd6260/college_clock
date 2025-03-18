import 'package:flutter/material.dart';

class Course {
  // Course Class to store all course-related information
  final String courseID; // Unique identifier of a course
  final String courseName;
  final String
  aliasName; // nickname sort of, cause real name is very long sometimes
  final String? courseCode;
  final String credits; // Format: L-T-P-S-C
  final List<String> professors;
  final List<String>? assistantTeachers;
  final bool segment; // true: "Full Semester"  false: "Half Semester"
  final List<CourseSession> lectureSessions;
  final List<CourseSession>? labSessions;
  final List<CourseSession>? tutorialSessions;
  final String? lectureColor;
  final String? labColor;
  final String? tutorialColor;
  final bool relevant;
  final int semester;

  /// CSE, DSAI, ECE. If null it means it can be for any or all.
  final List<String>? departments;

  Course({
    required this.courseID,
    required this.courseName,
    required this.aliasName,
    this.courseCode,
    required this.credits,
    required this.professors,
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
    required this.departments,
  });

  /// JSON Constructor
  factory Course.fromJson(Map<String, dynamic> json) {
    List<CourseSession> parseSessions(List<dynamic>? data) {
      if (data == null) return [];
      return data.map((e) => CourseSession.fromJson(e)).toList();
    }

    return Course(
      courseID: json['id'],
      courseName: json['course_name'],
      aliasName: json['alias_name'],
      courseCode: json['course_code'],
      credits: json['credits'],
      professors: List<String>.from(json['professors']),
      assistantTeachers:
          json['assistant_teachers'] != null
              ? List<String>.from(json['assistant_teachers'])
              : null,
      segment: json['segment'],
      lectureSessions: parseSessions(json['lecture_sessions']),
      labSessions: parseSessions(json['lab_sessions']),
      tutorialSessions: parseSessions(json['tutorial_sessions']),
      lectureColor: json['lecture_color'],
      labColor: json['lab_color'],
      tutorialColor: json['tutorial_color'],
      relevant: json['relevant'],
      semester: json['semester'],
      departments: json['departments'],
    );
  }

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
      "id": courseID,
      "course_name": courseName,
      "alias_name": aliasName,
      "course_code": courseCode,
      "professors": professors,
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
      "departments": departments,
    };
  }

  String colorToHex(Color color, {bool leadingHashSign = true}) {
    int a = (color.a * 255).round();
    int r = (color.r * 255).round();
    int g = (color.g * 255).round();
    int b = (color.b * 255).round();

    return '${leadingHashSign ? '#' : ''}'
        '${a.toRadixString(16).padLeft(2, '0')}'
        '${r.toRadixString(16).padLeft(2, '0')}'
        '${g.toRadixString(16).padLeft(2, '0')}'
        '${b.toRadixString(16).padLeft(2, '0')}';
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
