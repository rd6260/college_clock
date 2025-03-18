import 'dart:convert';
import 'package:college_clock/custom_widgets/classes_today_card.dart';
import 'package:college_clock/types/course.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedDay = DateTime.now().weekday - 1;
  List<Course> courses = [];
  bool _isLoading = true;
  final _supabase = Supabase.instance.client;
  final String _localFilePath = 'courses.json';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_localFilePath');
  }

  Future<void> _loadData() async {
    // First try to load from local file to show data immediately
    await _loadFromLocalStorage();

    // Then fetch fresh data from Supabase
    await _fetchFromSupabase();
  }

  Future<void> _loadFromLocalStorage() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        final List<dynamic> jsonData = json.decode(contents);
        setState(() {
          courses = jsonData.map((item) => Course.fromJson(item)).toList();
          _isLoading = false;
        });
      }
      debugPrint("DEV: Local storage successful");
    } catch (e) {
      debugPrint('DEV: Error loading from local storage: $e');
      // If loading from local storage fails, we'll rely on Supabase data
    }
  }

  Future<void> _fetchFromSupabase() async {
    try {
      final response = await _supabase.from('courses').select();

      final List<Course> fetchedCourses =
          (response as List).map((item) => Course.fromJson(item)).toList();

      // Check if data is different from what we have
      final bool isDifferent = _isDifferentData(fetchedCourses);

      if (isDifferent) {
        debugPrint("DEV: Updating local storage | Local storage different");

        // Update local storage
        await _writeToLocalStorage(fetchedCourses);

        // Update UI
        setState(() {
          courses = fetchedCourses;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('DEV: Error fetching from Supabase: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Check if local data is different from the one fetched from supabase
  bool _isDifferentData(List<Course> newCourses) {
    if (courses.length != newCourses.length) return true;

    // Simple comparison - if the course IDs or names don't match
    for (int i = 0; i < courses.length; i++) {
      if (courses[i].courseID != newCourses[i].courseID ||
          courses[i].courseName != newCourses[i].courseName) {
        return true;
      }
    }

    return false;
  }

  Future<void> _writeToLocalStorage(List<Course> coursesToSave) async {
    try {
      final file = await _localFile;
      final List<Map<String, dynamic>> jsonData =
          coursesToSave.map((course) => course.jsonify()).toList();
      await file.writeAsString(json.encode(jsonData));
    } catch (e) {
      debugPrint('Error writing to local storage: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateFormat = DateFormat('EEEE, MMM d');

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : CustomScrollView(
                  slivers: [
                    // App Bar
                    SliverAppBar(
                      backgroundColor: Colors.white,
                      floating: true,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Class Schedule',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                dateFormat.format(now),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.refresh,
                                  color: Colors.grey[700],
                                ),
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await _fetchFromSupabase();
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Colors.grey[700],
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Day selector
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: SizedBox(
                          height: 90,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 7,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemBuilder: (context, index) {
                              final day = DateTime.now().add(
                                Duration(
                                  days: index - DateTime.now().weekday + 1,
                                ),
                              );
                              final isSelected = _selectedDay == index;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedDay = index;
                                  });
                                },
                                child: Container(
                                  width: 60,
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected
                                            ? Colors.blue[500]
                                            : Colors.grey[200],
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow:
                                        isSelected
                                            ? [
                                              BoxShadow(
                                                color: Colors.blue.withValues(
                                                  alpha: 0.3,
                                                ),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              ),
                                            ]
                                            : null,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat('E').format(day),
                                        style: TextStyle(
                                          color:
                                              isSelected
                                                  ? Colors.white
                                                  : Colors.grey[700],
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        DateFormat('d').format(day),
                                        style: TextStyle(
                                          color:
                                              isSelected
                                                  ? Colors.white
                                                  : Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 30)),
                    SliverToBoxAdapter(
                      child: ClassesTodayCard(
                        courses: courses,
                        weekDayNumber: _selectedDay + 1,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
