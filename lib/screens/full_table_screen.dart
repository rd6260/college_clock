import 'package:college_clock/utils/classes_data.dart';
import 'package:flutter/material.dart';

class FullTimeTableScreen extends StatelessWidget {
  const FullTimeTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F2F5),
      appBar: AppBar(
        title: const Text('Weekly Timetable'),
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: const TimetableView(),
    );
  }
}

class TimetableView extends StatelessWidget {
  const TimetableView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Day header
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: const Text(
                    'time',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: const [
                      Expanded(
                        child: Center(
                          child: Text(
                            'M',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'T',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'W',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'TH',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'F',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Timetable content
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Time column with vertical line
                Container(
                  width: 60,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Colors.grey.shade400),
                    ),
                  ),
                  child: Column(children: _buildTimeColumn()),
                ),

                // Day columns
                Expanded(
                  child: Stack(
                    children: [
                      // Grid lines
                      Column(children: _buildGridLines()),

                      // Class cards
                      ..._buildClassCards(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTimeColumn() {
    List<Widget> timeSlots = [];

    // Start from 9:00 and end at 18:30
    for (int hour = 9; hour <= 18; hour++) {
      String displayHour = '$hour:00';

      timeSlots.add(
        Container(
          height: 60, // Height of each hour cell
          alignment: Alignment.center,
          child: Text(
            displayHour,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      );

      // Add half-hour mark
      if (hour < 18) {
        timeSlots.add(
          Container(
            height: 30, // Height of half-hour cell
            alignment: Alignment.center,
            child: Text(
              '$hour:30',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        );
      }
    }

    return timeSlots;
  }

  List<Widget> _buildGridLines() {
    List<Widget> lines = [];

    // Start from 9:00 and end at 18:30
    for (int hour = 9; hour <= 18; hour++) {
      // Full hour line
      lines.add(
        Container(
          height: 60,
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
        ),
      );

      // Half-hour line (lighter)
      if (hour < 18) {
        lines.add(
          Container(
            height: 30,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey.shade200, width: 0.5),
              ),
            ),
          ),
        );
      }
    }

    return lines;
  }

  List<Widget> _buildClassCards(BuildContext context) {
    List<Widget> cards = [];
    final double totalWidth =
        MediaQuery.of(context).size.width -
        92; // Subtract time column width and margins
    final double columnWidth = totalWidth / 5; // 5 days

    for (var classInfo in classes) {
      // Calculate position
      final double left = (classInfo.dayOfWeek - 1) * columnWidth;

      // Calculate start position (9:00 is at top, position 0)
      final double startTime =
          ((classInfo.startHour - 9) * 60 + classInfo.startMinute).toDouble();
      final double endTime =
          ((classInfo.endHour - 9) * 60 + classInfo.endMinute).toDouble();
      final double top =
          startTime * (90 / 60); // Convert minutes to position (90px per hour)
      final double height =
          (endTime - startTime) * (90 / 60); // Height based on duration

      // Create card with minimum width for text
      cards.add(
        Positioned(
          left: left,
          top: top,
          width: columnWidth - 4, // Small margin
          height: height,
          child: Container(
            margin: const EdgeInsets.all(2),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: classInfo.color,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Stack(
              children: [
                // Start time (top right)
                Positioned(
                  top: 2,
                  right: 2,
                  child: Text(
                    '${classInfo.startHour.toString().padLeft(2, '0')}:${classInfo.startMinute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 8, color: Colors.black54),
                  ),
                ),

                // End time (bottom right)
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Text(
                    '${classInfo.endHour.toString().padLeft(2, '0')}:${classInfo.endMinute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 8, color: Colors.black54),
                  ),
                ),

                // Course info (centered)
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        classInfo.courseCode,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        classInfo.courseName,
                        style: const TextStyle(fontSize: 10),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return cards;
  }
}
