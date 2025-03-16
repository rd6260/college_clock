import 'package:flutter/material.dart';

class FullTableScreen extends StatelessWidget {
  const FullTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F2F5),
      appBar: AppBar(
        title: const Text('My Timetable'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: const FullTableView(),
    );
  }
}

class FullTableView extends StatelessWidget {
  const FullTableView({super.key});

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
                  width: 80,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  child: const Text(
                    'time',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text('M', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('T', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('W', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('TH', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('F', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('S', style: TextStyle(fontWeight: FontWeight.bold)),
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
                // Time column
                Column(
                  children: _buildTimeColumn(),
                ),
                
                // Day columns
                Expanded(
                  child: Stack(
                    children: [
                      // Grid lines
                      Column(
                        children: _buildGridLines(),
                      ),
                      
                      // Monday classes
                      Positioned(
                        left: 0,
                        width: 50,
                        top: 40, // PHILHIS position
                        child: _buildClassCard('PHILHIS', '3H', 'mint', 90),
                      ),
                      Positioned(
                        left: 0,
                        width: 50,
                        top: 200, // THED02 position
                        child: _buildClassCard('THED02', '3H', 'mint', 90),
                      ),
                      Positioned(
                        left: 0,
                        width: 50,
                        top: 320, // LIVIT position
                        child: _buildClassCard('LIVIT', '3H', 'mint', 60),
                      ),
                      Positioned(
                        left: 0,
                        width: 50,
                        top: 410, // CRTBKS position
                        child: _buildClassCard('CRTBKS', '2H', 'mint', 70),
                      ),
                      
                      // Tuesday classes
                      Positioned(
                        left: 50,
                        width: 50,
                        top: 0, // INTACCT2 position
                        child: _buildClassCard('INTACCT2', '', 'peach', 150),
                      ),
                      Positioned(
                        left: 50,
                        width: 50,
                        top: 320, // BAPACC position
                        child: _buildClassCard('BAPACC', '', 'peach', 150),
                      ),
                      Positioned(
                        left: 50,
                        width: 50,
                        top: 500, // CONFBA2 position
                        child: _buildClassCard('CONFBA2', '3H', 'peach', 100),
                      ),
                      
                      // Wednesday - no classes
                      
                      // Thursday classes
                      Positioned(
                        left: 150,
                        width: 50,
                        top: 40, // FINMRKT position
                        child: _buildClassCard('FINMRKT', '', 'yellow', 60),
                      ),
                      Positioned(
                        left: 150,
                        width: 50,
                        top: 130, // PHILHIS position
                        child: _buildClassCard('PHILHIS', '3H', 'yellow', 90),
                      ),
                      Positioned(
                        left: 150,
                        width: 50,
                        top: 250, // THED02 position
                        child: _buildClassCard('THED02', '3H', 'yellow', 90),
                      ),
                      Positioned(
                        left: 150,
                        width: 50,
                        top: 370, // LIVIT position
                        child: _buildClassCard('LIVIT', '3H', 'yellow', 60),
                      ),
                      Positioned(
                        left: 150,
                        width: 50,
                        top: 460, // CRTBKS position
                        child: _buildClassCard('CRTBKS', '', 'yellow', 70),
                      ),
                      
                      // Friday classes
                      Positioned(
                        left: 200,
                        width: 50,
                        top: 100, // STRACOS position
                        child: _buildClassCard('STRACOS', '', 'mint', 130),
                      ),
                      Positioned(
                        left: 200,
                        width: 50,
                        top: 260, // PATHFIT3 position
                        child: _buildClassCard('PATHFIT3', '4YR', 'blue', 90),
                      ),
                      
                      // Saturday classes
                      Positioned(
                        left: 250,
                        width: 50,
                        top: 90, // BUSLAW1 position
                        child: _buildClassCard('BUSLAW1', '', 'mint', 90),
                      ),
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
    for (int hour = 7; hour <= 20; hour++) {
      String displayHour = hour > 12 ? '${hour - 12}' : '$hour';
      if (hour < 10) displayHour = '0$hour';
      
      timeSlots.add(
        Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          child: Text(
            displayHour,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    return timeSlots;
  }

  List<Widget> _buildGridLines() {
    List<Widget> lines = [];
    for (int i = 0; i < 14; i++) {
      lines.add(
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      );
    }
    return lines;
  }

  Widget _buildClassCard(String title, String subtitle, String color, double height) {
    Color backgroundColor;
    switch (color) {
      case 'mint':
        backgroundColor = const Color(0xFFDCF8E6);
        break;
      case 'peach':
        backgroundColor = const Color(0xFFFEE6D9);
        break;
      case 'yellow':
        backgroundColor = const Color(0xFFFFF6D9);
        break;
      case 'blue':
        backgroundColor = const Color(0xFFD9E8FF);
        break;
      default:
        backgroundColor = Colors.white;
    }

    return Container(
      height: height,
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          if (subtitle.isNotEmpty)
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 8,
              ),
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 2),
        ],
      ),
    );
  }
}