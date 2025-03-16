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
    dayOfWeek: 1, // Monday
    color: const Color(0xFFDCF8E6), // Mint
  ),
  ClassInfo(
    courseCode: 'CS163',
    courseName: 'DSA',
    startHour: 11,
    startMinute: 30,
    endHour: 13,
    endMinute: 0,
    dayOfWeek: 1, // Monday
    color: const Color(0xFFDCF8E6), // Mint
  ),
  ClassInfo(
    courseCode: 'N/A',
    courseName: 'Linux',
    startHour: 14,
    startMinute: 0,
    endHour: 15,
    endMinute: 30,
    dayOfWeek: 1, // Monday
    color: const Color(0xFFDCF8E6), // Mint
  ),
  ClassInfo(
    courseCode: 'CS162',
    courseName: 'Optimization',
    startHour: 15,
    startMinute: 30,
    endHour: 17,
    endMinute: 0,
    dayOfWeek: 1, // Monday
    color: const Color(0xFFDCF8E6), // Mint
  ),
  ClassInfo(
    courseCode: 'N/A',
    courseName: 'B3-TUT',
    startHour: 17,
    startMinute: 30,
    endHour: 18,
    endMinute: 30,
    dayOfWeek: 1, // Monday
    color: const Color(0xFFDCF8E6), // Mint
  ),

];
