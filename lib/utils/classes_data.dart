import 'dart:ui';
import 'package:college_clock/types/class_info.dart';

List<ClassInfo> get classes => [
  // Monday ====================================================================
  ClassInfo(
    courseCode: 'DS164',
    courseName: 'DCT',
    startHour: 9,
    startMinute: 0,
    endHour: 11,
    endMinute: 0,
    dayOfWeek: 1,
    color: const Color(0xFFD8E2DC), // Light sage
  ),
  ClassInfo(
    courseCode: 'CS163',
    courseName: 'DSA',
    startHour: 11,
    startMinute: 30,
    endHour: 13,
    endMinute: 0,
    dayOfWeek: 1,
    color: const Color(0xFFBDE0FE), // Light blue
  ),
  ClassInfo(
    courseCode: 'N/A',
    courseName: 'Linux',
    startHour: 14,
    startMinute: 0,
    endHour: 15,
    endMinute: 30,
    dayOfWeek: 1,
    color: const Color(0xFFD0D1FF), // Periwinkle
  ),
  ClassInfo(
    courseCode: 'CS162',
    courseName: 'Optimization',
    startHour: 15,
    startMinute: 30,
    endHour: 17,
    endMinute: 0,
    dayOfWeek: 1,
    color: const Color(0xFFFFB3B3), // Salmon pink
  ),
  ClassInfo(
    courseCode: 'N/A',
    courseName: 'B3-TUT',
    startHour: 17,
    startMinute: 30,
    endHour: 18,
    endMinute: 30,
    dayOfWeek: 1,
    color: const Color(0xFFF0E6EF), // Very light purple
  ),
  // Tuesday ====================================================================
  ClassInfo(
    courseCode: 'N/A',
    courseName: 'VD',
    startHour: 9,
    startMinute: 0,
    endHour: 11,
    endMinute: 0,
    dayOfWeek: 2,
    color: const Color(0xFFB5EAD7), // Mint green
  ),
  ClassInfo(
    courseCode: 'CS164',
    courseName: 'CA',
    startHour: 11,
    startMinute: 45,
    endHour: 13,
    endMinute: 15,
    dayOfWeek: 2,
    color: const Color(0xFFE2BEF1), // Lilac
  ),
  ClassInfo(
    courseCode: 'CS162',
    courseName: 'TUT Optimization',
    startHour: 17,
    startMinute: 0,
    endHour: 18,
    endMinute: 0,
    dayOfWeek: 2,
    color: const Color(0xFFFFC1C1), // Lighter salmon (similar to Optimization)
  ),
  // Wednesday =================================================================
  ClassInfo(
    courseCode: 'HS161',
    courseName: 'English',
    startHour: 9,
    startMinute: 0,
    endHour: 10,
    endMinute: 0,
    dayOfWeek: 3,
    color: const Color(0xFF9ADCFF), // Sky blue
  ),
  ClassInfo(
    courseCode: 'CS162',
    courseName: 'Optimization',
    startHour: 10,
    startMinute: 0,
    endHour: 11,
    endMinute: 30,
    dayOfWeek: 3,
    color: const Color(0xFFFFB3B3), // Salmon pink
  ),
  ClassInfo(
    courseCode: 'N/A',
    courseName: 'Linux',
    startHour: 11,
    startMinute: 45,
    endHour: 13,
    endMinute: 15,
    dayOfWeek: 3,
    color: const Color(0xFFD0D1FF), // Periwinkle
  ),
  ClassInfo(
    courseCode: 'CS163',
    courseName: 'LAB DSA',
    startHour: 14,
    startMinute: 30,
    endHour: 16,
    endMinute: 30,
    dayOfWeek: 3,
    color: const Color(0xFFC9E4FF), // Lighter blue (similar to DSA)
  ),
  ClassInfo(
    courseCode: 'DS164',
    courseName: 'DCT',
    startHour: 17,
    startMinute: 0,
    endHour: 18,
    endMinute: 0,
    dayOfWeek: 3,
    color: const Color(0xFFD8E2DC), // Light sage
  ),
  // Thursday =================================================================
  ClassInfo(
    courseCode: 'HS161',
    courseName: 'English',
    startHour: 9,
    startMinute: 0,
    endHour: 10,
    endMinute: 0,
    dayOfWeek: 4,
    color: const Color(0xFF9ADCFF), // Sky blue
  ),
  ClassInfo(
    courseCode: 'CS164',
    courseName: 'CA',
    startHour: 10,
    startMinute: 00,
    endHour: 11,
    endMinute: 30,
    dayOfWeek: 4,
    color: const Color(0xFFE2BEF1), // Lilac
  ),
  ClassInfo(
    courseCode: 'CS164',
    courseName: 'LAB CA',
    startHour: 16,
    startMinute: 30,
    endHour: 18,
    endMinute: 30,
    dayOfWeek: 4,
    color: const Color(0xFFEFD3FF), // Lighter lilac (similar to CA)
  ),
  // Friday =================================================================
  ClassInfo(
    courseCode: 'N/A',
    courseName: 'VD',
    startHour: 9,
    startMinute: 0,
    endHour: 10,
    endMinute: 0,
    dayOfWeek: 5,
    color: const Color(0xFFB5EAD7), // Mint green
  ),
  ClassInfo(
    courseCode: 'CS163',
    courseName: 'DSA',
    startHour: 10,
    startMinute: 0,
    endHour: 11,
    endMinute: 30,
    dayOfWeek: 5,
    color: const Color(0xFFBDE0FE), // Light blue
  ),
  ClassInfo(
    courseCode: 'N/A',
    courseName: 'Linux',
    startHour: 12,
    startMinute: 15,
    endHour: 13,
    endMinute: 15,
    dayOfWeek: 5,
    color: const Color(0xFFD0D1FF), // Periwinkle
  ),
  ClassInfo(
    courseCode: 'HS161',
    courseName: 'English',
    startHour: 14,
    startMinute: 30,
    endHour: 15,
    endMinute: 30,
    dayOfWeek: 5,
    color: const Color(0xFF9ADCFF), // Sky blue
  ),
  ClassInfo(
    courseCode: 'DS164',
    courseName: 'DCT',
    startHour: 15,
    startMinute: 30,
    endHour: 16,
    endMinute: 30,
    dayOfWeek: 5,
    color: const Color(0xFFD8E2DC), // Light sage
  ),
];
