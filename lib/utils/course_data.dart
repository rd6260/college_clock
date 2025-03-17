import 'package:college_clock/types/course.dart';
import 'package:college_clock/types/course_session.dart';
import 'package:flutter/material.dart';

final List<Course> courses = [
  Course(
    courseName: "Linear Algebra",
    courseCode: "MA163",
    professor: "Dr. Sibasankar Padhy",
    credits: "3-1-0-0-2",
    segment: "Full Semester",
    lectureSessions: [],
  ),
  Course(
    courseName: "Optimization",
    courseCode: "CS162",
    professor: "Dr. Dibyajyoti Guha",
    credits: "3-1-0-0-2",
    labAssistants: ["Shri Ranga Pujari", "Ashwini Chikkenakoppa"],
    segment: "Full Semester",
    lectureSessions: [
      CourseSession(
        day: 3, // Wednesday
        startTime: TimeOfDay(hour: 11, minute: 45),
        endTime: TimeOfDay(hour: 13, minute: 0),
        classroom: "C004",
      ),
    ],
    tutorialSessions: [
      CourseSession(
        day: 2, // Tuesday
        startTime: TimeOfDay(hour: 15, minute: 30),
        endTime: TimeOfDay(hour: 16, minute: 30),
        classroom: "C004",
      ),
    ],
  ),
  Course(
    courseName: "Computer Architecture",
    courseCode: "CS164",
    professor: "Dr. Manjunath",
    credits: "3-0-2-0-2",
    labAssistants: ["Vinod", "Basavaraj Choukimath"],
    segment: "Full Semester",
    lectureSessions: [
      CourseSession(
        day: 2, // Tuesday
        startTime: TimeOfDay(hour: 11, minute: 30),
        endTime: TimeOfDay(hour: 13, minute: 0),
        classroom: "C002",
      ),
      CourseSession(
        day: 4, // Thursday
        startTime: TimeOfDay(hour: 10, minute: 0),
        endTime: TimeOfDay(hour: 11, minute: 30),
        classroom: "C204",
      ),
    ],
    labSessions: [
      CourseSession(
        day: 4, // Thursday
        startTime: TimeOfDay(hour: 14, minute: 30),
        endTime: TimeOfDay(hour: 16, minute: 30),
        classroom: "L207/L208",
      ),
    ],
  ),
  Course(
    courseName: "English Language and Communication",
    courseCode: "HS161",
    professor: "Dr. Rajesh N S",
    credits: "3-0-0-0-3",
    segment: "Full Semester",
    lectureSessions: [
      CourseSession(
        day: 3, // Wednesday
        startTime: TimeOfDay(hour: 9, minute: 0),
        endTime: TimeOfDay(hour: 10, minute: 0),
        classroom: "C004",
      ),
      CourseSession(
        day: 4, // Thursday
        startTime: TimeOfDay(hour: 9, minute: 0),
        endTime: TimeOfDay(hour: 10, minute: 0),
        classroom: "C204",
      ),
      CourseSession(
        day: 5, // Friday
        startTime: TimeOfDay(hour: 14, minute: 0),
        endTime: TimeOfDay(hour: 14, minute: 30),
        classroom: "C004",
      ),
    ],
  ),
  Course(
    courseName: "Data Structures and Algorithms",
    courseCode: "CS163",
    professor: "Dr. Sunil Saumya",
    credits: "3-0-2-0-4",
    labAssistants: [
      "Mr. Vinod Konnur",
      "Anil M Kabbur",
      "Ms. Shraddha",
      "Basavaraj Choukimath",
    ],
    segment: "Full Semester",
    lectureSessions: [
      CourseSession(
        day: 1, // Monday
        startTime: TimeOfDay(hour: 11, minute: 30),
        endTime: TimeOfDay(hour: 13, minute: 0),
        classroom: "C004",
      ),
      CourseSession(
        day: 5, // Friday
        startTime: TimeOfDay(hour: 10, minute: 0),
        endTime: TimeOfDay(hour: 11, minute: 0),
        classroom: "C004",
      ),
    ],
    labSessions: [
      CourseSession(
        day: 3, // Wednesday
        startTime: TimeOfDay(hour: 14, minute: 30),
        endTime: TimeOfDay(hour: 16, minute: 30),
        classroom: "L207/L208",
      ),
    ],
  ),
  Course(
    courseName: "Data Curation Techniques",
    courseCode: "DS164",
    professor: "Dr. Siddharth R.",
    credits: "2-0-2-0-3",
    labAssistants: ["Ms. Vani", "Ms. Meghana"],
    segment: "Full Semester",
    lectureSessions: [
      CourseSession(
        day: 3, // Wednesday
        startTime: TimeOfDay(hour: 17, minute: 0),
        endTime: TimeOfDay(hour: 18, minute: 0),
        classroom: "C002",
      ),
      CourseSession(
        day: 5, // Friday
        startTime: TimeOfDay(hour: 16, minute: 0),
        endTime: TimeOfDay(hour: 17, minute: 0),
        classroom: "C002",
      ),
    ],
    labSessions: [
      CourseSession(
        day: 1, // Monday
        startTime: TimeOfDay(hour: 9, minute: 0),
        endTime: TimeOfDay(hour: 11, minute: 0),
        classroom: "L207/L208",
      ),
    ],
  ),
  // ];
  // final List<Course> openElectives = [
  Course(
    courseName: "New Data Science with Python",
    aliasName: "DSWP",
    professor: "Dr. Abdul Wahid",
    credits: "2-0-0-0-2",
    segment: "Half Semester",
    lectureSessions: [
      CourseSession(
        day: 1, // Monday
        startTime: TimeOfDay(hour: 14, minute: 30),
        endTime: TimeOfDay(hour: 15, minute: 30),
        classroom: "B4",
      ),
    ],
  ),
  Course(
    courseName: "New Introduction to Digital VLSI Design",
    aliasName: "VLSI",
    professor: "Dr. Prakash Pawar",
    credits: "2-0-0-0-2",
    segment: "Half Semester",
    lectureSessions: [
      CourseSession(
        day: 4, // Thursday
        startTime: TimeOfDay(hour: 14, minute: 30),
        endTime: TimeOfDay(hour: 15, minute: 30),
        classroom: "C203",
      ),
    ],
  ),
  Course(
    courseName: "New Industry Insights Program Part 1",
    aliasName: "IIP",
    professor: "Mr. Ram Subramanian & Mr. Sasi Kumar Sundara Rajan",
    credits: "1-0-0-0-1",
    segment: "Half Semester",
    lectureSessions: [], // No specific timing mentioned
  ),
  Course(
    courseName: "New Principles of Quantum Physics",
    aliasName: "Quantum",
    professor: "Dr. Ashwath Babu & Prof. Ravi Shankar",
    credits: "2-0-0-0-2",
    segment: "Half Semester",
    lectureSessions: [
      CourseSession(
        day: 1, // Monday
        startTime: TimeOfDay(hour: 14, minute: 30),
        endTime: TimeOfDay(hour: 15, minute: 30),
        classroom: "B4",
      ),
    ],
  ),
  Course(
    courseName: "New Linux for Engineers",
    aliasName: "Linux",
    professor: "Dr. Shirshendu Layek",
    credits: "2-0-0-0-2",
    segment: "Half Semester",
    lectureSessions: [
      CourseSession(
        day: 4, // Thursday
        startTime: TimeOfDay(hour: 14, minute: 30),
        endTime: TimeOfDay(hour: 15, minute: 30),
        classroom: "C203",
      ),
    ],
  ),
  Course(
    courseName: "New Photography101",
    aliasName: "Photography",
    professor: "Dr. Prabhu Prasad BM",
    credits: "1-0-0-0-1",
    segment: "Half Semester",
    lectureSessions: [
      CourseSession(
        day: 4, // Thursday
        startTime: TimeOfDay(hour: 14, minute: 30),
        endTime: TimeOfDay(hour: 15, minute: 30),
        classroom: "C204",
      ),
    ],
  ),
  Course(
    courseName: "New Introduction to Holistic Personality Development",
    aliasName: "Holistic",
    professor: "Prof. Chachadi & Dr. Chandrika K",
    credits: "1-0-0-0-1",
    segment: "Half Semester",
    lectureSessions: [], // Timing not specified
  ),
  Course(
    courseName:
        "New Visual Design – Principles and Application in Product Communication",
    aliasName: "Visual Design",
    professor: "Dr. Sandesh P",
    credits: "2-0-0-0-2",
    segment: "Half Semester",
    lectureSessions: [
      CourseSession(
        day: 2, // Tuesday
        startTime: TimeOfDay(hour: 9, minute: 0),
        endTime: TimeOfDay(hour: 10, minute: 0),
        classroom: "C304",
      ),
      CourseSession(
        day: 5, // Friday
        startTime: TimeOfDay(hour: 9, minute: 0),
        endTime: TimeOfDay(hour: 10, minute: 0),
        classroom: "C304",
      ),
    ],
  ),
  Course(
    courseName: "New Introduction to Internet of Things",
    aliasName: "IoT",
    professor: "Dr. Jagadeesha Bhat",
    credits: "2-0-0-0-2",
    segment: "Half Semester",
    lectureSessions: [], // Timing not specified
  ),
  Course(
    courseName: "New Computer Intensive Statistical Methods",
    aliasName: "CISM",
    professor: "Dr. Ramesh Athe",
    credits: "2-0-0-0-2",
    segment: "Half Semester",
    lectureSessions: [], // Timing not specified
  ),
  Course(
    courseName: "New Concurrency and Computation",
    aliasName: "Concurrency",
    professor: "Dr. Pramod Y",
    credits: "2-0-0-0-2",
    segment: "Half Semester",
    lectureSessions: [], // Timing not specified
  ),
];
