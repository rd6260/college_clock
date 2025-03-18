import 'package:college_clock/types/course.dart';
import 'package:flutter/material.dart';

final List<Course> courses = [
  Course(
    courseID: "9a8e5f9b-171b-4898-8b69-76496cfa9063",
    courseName: "Linear Algebra",
    aliasName: "LA",
    courseCode: "MA163",
    professors: ["Dr. Sibasankar Padhy"],
    credits: "3-1-0-0-2",
    segment: false,
    lectureSessions: [],
    relevant: true,
    semester: 2,
    department: "DSAI",
  ),
  Course(
    courseID: "d6463988-844a-4e70-a975-656d59108607",
    courseName: "Optimization",
    aliasName: "Optimization",
    courseCode: "CS162",
    professors: ["Dr. Dibyajyoti Guha"],
    credits: "3-1-0-0-2",
    assistantTeachers: ["Shri Ranga Pujari", "Ashwini Chikkenakoppa"],
    segment: false,

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
    relevant: true,
    semester: 2,
    department: "DSAI",
  ),
  Course(
    courseID: "99d33396-b8e6-465e-8f78-3670f50ccc18",
    courseName: "Computer Architecture",
    aliasName: "CA",
    courseCode: "CS164",
    professors: ["Dr. Manjunath"],
    credits: "3-0-2-0-2",
    assistantTeachers: ["Vinod", "Basavaraj Choukimath"],
    segment: false,
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
    relevant: true,
    semester: 2,
    department: "DSAI",
  ),
  Course(
    courseID: "0a2441da-2251-48b2-97fc-1d4a1509d833",
    courseName: "English Language and Communication",
    aliasName: "English",
    courseCode: "HS161",
    professors: ["Dr. Rajesh N S"],
    credits: "3-0-0-0-3",
    segment: true,
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
    relevant: true,
    semester: 2,
    department: "DSAI",
  ),
  Course(
    courseID: "4a6cac63-3a11-4ae8-b1b8-f6299a2c06c1",
    courseName: "Data Structures and Algorithms",
    aliasName: "DSA",
    courseCode: "CS163",
    professors: ["Dr. Sunil Saumya"],
    credits: "3-0-2-0-4",
    assistantTeachers: [
      "Mr. Vinod Konnur",
      "Anil M Kabbur",
      "Ms. Shraddha",
      "Basavaraj Choukimath",
    ],
    segment: true,
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
    relevant: true,
    semester: 2,
    department: "DSAI",
  ),
  Course(
    courseID: "cbc1d0de-61f2-4780-a1ee-198748547fce",
    courseName: "Data Curation Techniques",
    aliasName: "DCT",
    courseCode: "DS164",
    professors: ["Dr. Siddharth R."],
    credits: "2-0-2-0-3",
    assistantTeachers: ["Ms. Vani", "Ms. Meghana"],
    segment: true,
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
    relevant: true,
    semester: 2,
    department: "DSAI",
  ),
  // Open Electives
  Course(
    courseID: "eab9ba8e-47b5-446c-9971-47b592e2da1b",
    courseName: "Data Science with Python",
    aliasName: "DSWP",
    professors: ["Dr. Abdul Wahid"],
    credits: "2-0-0-0-2",
    segment: false,
    lectureSessions: [
      CourseSession(
        day: 4,
        startTime: TimeOfDay(hour: 11, minute: 45),
        endTime: TimeOfDay(hour: 13, minute: 15),
        classroom: "C002",
      ),
    ],
    tutorialSessions: [
      CourseSession(
        day: 1,
        startTime: TimeOfDay(hour: 17, minute: 30),
        endTime: TimeOfDay(hour: 18, minute: 30),
        classroom: "C002",
      ),
    ],
    relevant: true,
    semester: 2,
    department: "DSAI",
  ),
  Course(
    courseID: "f3c70377-bb65-4bbc-ad8b-00369a3aaf69",
    courseName: "Introduction to Digital VLSI Design",
    aliasName: "VLSI",
    professors: ["Dr. Prakash Pawar"],
    credits: "2-0-0-0-2",
    segment: false,
    lectureSessions: [
      CourseSession(
        day: 4, // Thursday
        startTime: TimeOfDay(hour: 14, minute: 30),
        endTime: TimeOfDay(hour: 15, minute: 30),
        classroom: "C203",
      ),
    ],
    relevant: true,
    semester: 2,
    department: "DSAI",
  ),
  Course(
    courseID: "9d68e0b0-5eba-4acf-9e36-e37255b77352",
    courseName: "Industry Insights Program Part 1",
    aliasName: "IIP",
    professors: ["Mr. Ram Subramanian", "Mr. Sasi Kumar Sundara Rajan"],
    credits: "1-0-0-0-1",
    segment: false,
    lectureSessions: [],
    relevant: true,
    semester: 2,
    department: "DSAI",
  ),
  Course(
    courseID: "5da5d484-4dda-490b-9f71-6f7d679d9525",
    courseName: "Principles of Quantum Physics",
    aliasName: "Quantum",
    professors: ["Dr. Ashwath Babu", "Prof. Ravi Shankar"],
    credits: "2-0-0-0-2",
    segment: false,
    lectureSessions: [
      CourseSession(
        day: 1, // Monday
        startTime: TimeOfDay(hour: 14, minute: 30),
        endTime: TimeOfDay(hour: 15, minute: 30),
      ),
    ],
    relevant: true,
    semester: 2,
    department: "DSAI",
  ),
  Course(
    courseID: "dcfec0d6-ac25-472d-871a-712d44441771",
    courseName: "Linux for Engineers",
    aliasName: "Linux",
    professors: ["Dr. Shirshendu Layek"],
    credits: "2-0-0-0-2",
    segment: false,
    lectureSessions: [
      CourseSession(
        day: 1,
        startTime: TimeOfDay(hour: 14, minute: 30),
        endTime: TimeOfDay(hour: 15, minute: 30),
        classroom: "C203",
      ),
      CourseSession(
        day: 3,
        startTime: TimeOfDay(hour: 11, minute: 45),
        endTime: TimeOfDay(hour: 13, minute: 15),
        classroom: "C203",
      ),
    ],
    tutorialSessions: [
      CourseSession(
        day: 5,
        startTime: TimeOfDay(hour: 12, minute: 15),
        endTime: TimeOfDay(hour: 13, minute: 15),
        classroom: "C203",
      ),
    ],
    relevant: true,
    semester: 2,
    department: "DSAI",
  ),
  Course(
    courseID: "a51c3ee4-bd2e-4312-9632-fe63ecda3d36",
    courseName: "Photography101",
    aliasName: "Photography",
    professors: ["Dr. Prabhu Prasad BM"],
    credits: "1-0-0-0-1",
    segment: false,
    lectureSessions: [
      CourseSession(
        day: 1,
        startTime: TimeOfDay(hour: 14, minute: 30),
        endTime: TimeOfDay(hour: 15, minute: 30),
        classroom: "C204",
      ),
      CourseSession(
        day: 3,
        startTime: TimeOfDay(hour: 11, minute: 45),
        endTime: TimeOfDay(hour: 13, minute: 15),
        classroom: "C204",
      ),
    ],
    tutorialSessions: [
      CourseSession(
        day: 5,
        startTime: TimeOfDay(hour: 12, minute: 15),
        endTime: TimeOfDay(hour: 13, minute: 15),
        classroom: "C204",
      ),
    ],
    relevant: true,
    semester: 2,
    department: "DSAI",
  ),
  Course(
    courseID: "58951711-d046-40d8-9b5a-cea857f34af3",
    courseName: "Introduction to Holistic Personality Development",
    aliasName: "Holistic",
    professors: ["Prof. Chachadi", "Dr. Chandrika K"],
    credits: "1-0-0-0-1",
    segment: false,
    lectureSessions: [],
    relevant: true,
    semester: 2,
    department: "DSAI",
  ),
  Course(
    courseID: "8c94dfea-afab-4722-9a41-e0fe16875dfa",
    courseName:
        "Visual Design - Principles and Application in Product Communication",
    aliasName: "Visual Design",
    professors: ["Dr. Sandesh P"],
    credits: "2-0-0-0-2",
    segment: false,
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
    relevant: true,
    semester: 2,
    department: "DSAI",
  ),
  Course(
    courseID: "a2fc5fdb-db3f-46a9-afca-8a3910c705b6",
    courseName: "Introduction to Internet of Things",
    aliasName: "IoT",
    professors: ["Dr. Jagadeesha Bhat"],
    credits: "2-0-0-0-2",
    segment: false,
    lectureSessions: [],
    relevant: true,
    semester: 2,
    department: "DSAI",
  ),
  Course(
    courseID: "f879b2bf-613a-4a59-9e80-c2524e3e4e2c",
    courseName: "Computer Intensive Statistical Methods",
    aliasName: "CISM",
    professors: ["Dr. Ramesh Athe"],
    credits: "2-0-0-0-2",
    segment: false,
    lectureSessions: [],
    relevant: true,
    semester: 2,
    department: "DSAI",
  ),
  Course(
    courseID: "be9518e8-5b67-4750-947c-94165bbf6933",
    courseName: "Concurrency and Computation",
    aliasName: "Concurrency",
    professors: ["Dr. Pramod Y"],
    credits: "2-0-0-0-2",
    segment: false,
    lectureSessions: [],
    relevant: true,
    semester: 2,
    department: "DSAI",
  ),
];
