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
  final String? teachingAssistants;
  final bool segment; // true: "Full Semester"  false: "Half Semester"
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
    this.teachingAssistants,
    required this.segment,
    required this.lectureSessions,
    this.labSessions,
    this.tutorialSessions,
    this.lectureColor,
    this.labColor,
    this.tutorialColor,
  });

  Map<String, dynamic> jasonify() {
    List<Map> lectureData = [];
    List<Map>? labData;
    List<Map>? tutorialData;

    for (CourseSession lecture in lectureSessions) {
      lectureData.add(lecture.jsonify());
    }

    for (CourseSession lab in labSessions!) {
      lectureData.add(lab.jsonify());
    }

    for (CourseSession tutorial in tutorialSessions!) {
      lectureData.add(tutorial.jsonify());
    }

    return {
      // "id": this.courseID,
      "course name": courseName,
      "alias name": aliasName,
      "course code": courseCode,
      "professor": professor,
      "credits": credits,
      "lab assistants": labAssistants,
      "teaching assistants": teachingAssistants,
      "segment": segment,
      "lecture sessions": lectureData,
      "lab sessions": labData,
      "tutorial sessions": tutorialData,
      "lectureColor": lectureColor,
      "labColor": labColor,
      "tutorialColor": tutorialColor,
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

  Map<String, dynamic> jsonify() {
    return {
      "day": day,
      "start hour": startTime.hour,
      "start minute": startTime.minute,
      "end hour": endTime.hour,
      "end minute": endTime.minute,
      "classroom": classroom,
    };
  }
}
