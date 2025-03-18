import 'package:college_clock/screens/weekly_time_table_screen.dart';
import 'package:college_clock/types/course.dart';
import 'package:flutter/material.dart';

class ClassesTodayCard extends StatelessWidget {
  final List<Course> courses;
  final int weekDayNumber;

  const ClassesTodayCard({
    super.key,
    required this.courses,
    required this.weekDayNumber,
  });

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // Get color based on session type
  Color _getSessionColor(BuildContext context, String sessionType) {
    final theme = Theme.of(context);

    switch (sessionType) {
      case 'Lecture':
        return theme.colorScheme.primary;
      case 'Lab':
        return theme.colorScheme.secondary;
      case 'Tutorial':
        return Colors.orange;
      default:
        return theme.colorScheme.primary;
    }
  }

  List<Map<String, dynamic>> _getTodaysSessions() {
    List<Map<String, dynamic>> todaysSessions = [];

    // If it's weekend, return empty list
    if (weekDayNumber == 0) {
      return todaysSessions;
    }

    for (final course in courses) {
      // Check lecture sessions
      for (final session in course.lectureSessions) {
        if (session.day == weekDayNumber) {
          todaysSessions.add({
            'course': course,
            'session': session,
            'type': 'Lecture',
            'startTimeValue':
                session.startTime.hour * 60 + session.startTime.minute,
          });
        }
      }

      // Check lab sessions
      if (course.labSessions != null) {
        for (final session in course.labSessions!) {
          if (session.day == weekDayNumber) {
            todaysSessions.add({
              'course': course,
              'session': session,
              'type': 'Lab',
              'startTimeValue':
                  session.startTime.hour * 60 + session.startTime.minute,
            });
          }
        }
      }

      // Check tutorial sessions
      if (course.tutorialSessions != null) {
        for (final session in course.tutorialSessions!) {
          if (session.day == weekDayNumber) {
            todaysSessions.add({
              'course': course,
              'session': session,
              'type': 'Tutorial',
              'startTimeValue':
                  session.startTime.hour * 60 + session.startTime.minute,
            });
          }
        }
      }
    }

    // Sort by start time
    todaysSessions.sort((a, b) => a['startTimeValue'] - b['startTimeValue']);

    return todaysSessions;
  }

  @override
  Widget build(BuildContext context) {
    final todaysSessions = _getTodaysSessions();
    final theme = Theme.of(context);

    if (todaysSessions.isEmpty) {
      return Card(
        color: Colors.grey[200],
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                Icon(
                  Icons.event_available_outlined,
                  size: 40,
                  color: theme.colorScheme.primary.withValues(alpha: 0.7),
                ),
                const SizedBox(height: 12),
                Text(
                  "No classes scheduled for today",
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeeklyTimetableScreen(),
                          ),
                        ),
                    child: Text(
                      'Weekly View',
                      style: TextStyle(
                        color: Colors.grey[700],
                        // backgroundColor: Colors.grey[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ...todaysSessions.map(
              (data) => _buildClassItem(
                context,
                data['course'],
                data['session'],
                data['type'],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassItem(
    BuildContext context,
    Course course,
    CourseSession session,
    String sessionType,
  ) {
    final theme = Theme.of(context);
    final sessionColor = _getSessionColor(context, sessionType);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time indicator with colored accent based on session type
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: sessionColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: sessionColor.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Text(
                  _formatTimeOfDay(session.startTime),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: sessionColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatTimeOfDay(session.endTime),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: sessionColor.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Course details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        course.courseName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Session type badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: sessionColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: sessionColor.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        sessionType,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: sessionColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                if (course.courseCode != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    course.courseCode!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                // Location row
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      session.classroom ?? "N/A",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.8,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      // "Prof: ${course.professor.split(' ').last}",
                      course.professors.join("\n"),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Usage example:
// ClassesTodayCard(courses: allCourses)
