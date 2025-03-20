import 'package:college_clock/screens/all_set_screen.dart';
import 'package:college_clock/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AcademicDetailsSetupScreen extends StatefulWidget {
  const AcademicDetailsSetupScreen({super.key});

  @override
  State<AcademicDetailsSetupScreen> createState() =>
      _AcademicDetailsSetupScreenState();
}

class _AcademicDetailsSetupScreenState
    extends State<AcademicDetailsSetupScreen> {
  // Supabase Database
  final _supabase = Supabase.instance.client;
  late Future<List<Map<String, dynamic>>> currentStateData;

  // Current step index
  int currentIndex = 0;

  // Selected values
  int? selectedSemester;
  String? selectedDepartment;
  String? selectedSection;

  // Available options
  late List<int> semesters;
  late List<String> departments;
  List<String> sections = ['A', 'B'];

  // Page controller for smooth transitions
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    currentStateData = _fetchCurrentStateData();
    // _loadSavedData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Load data from SharedPreferences
  // Future<void> _loadSavedData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     selectedSemester = prefs.getInt('semester');
  //     selectedDepartment = prefs.getString('department');
  //     selectedSection = prefs.getString('section');

  //     if (selectedSemester != null) {
  //       currentIndex = 1;
  //       if (selectedDepartment != null) {
  //         currentIndex = selectedDepartment == 'CSE' ? 2 : 3;
  //       }
  //     }

  //     // Update page controller
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       if (_pageController.hasClients) {
  //         _pageController.jumpToPage(currentIndex);
  //       }
  //     });
  //   });
  // }

  // Save data to SharedPreferences
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();

    if (selectedSemester != null) {
      await prefs.setInt('semester', selectedSemester!);
    }

    if (selectedDepartment != null) {
      await prefs.setString('department', selectedDepartment!);
    }

    if (selectedSection != null) {
      await prefs.setString('section', selectedSection!);
    }
  }

  void _moveToNextStep() async {
    await _saveData();

    setState(() {
      if (currentIndex == 1 && selectedDepartment != 'CSE') {
        // Skip section selection if department is not CSE
        currentIndex = 3;
      } else {
        currentIndex++;
      }

      // Animate to the next page
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _moveToPreviousStep() {
    setState(() {
      if (currentIndex == 3 && selectedDepartment != 'CSE') {
        // Skip section selection if coming back from the final screen
        currentIndex = 1;
      } else {
        currentIndex--;
      }

      // Animate to the previous page
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  // Auto-proceed to the next step when an option is selected
  void _handleOptionSelected() {
    if (_canMoveNext()) {
      _moveToNextStep();
    }
  }

  Future<List<Map<String, dynamic>>> _fetchCurrentStateData() async {
    try {
      final response = await _supabase.from('current_state').select();
      debugPrint('DEV: Supabase `current_state` data fetch SUCCESSFUL');
      return response;
    } catch (e) {
      debugPrint('DEV: Error fetching `current_state` from Supabase: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: currentStateData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    "Setting up your academics...",
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Scaffold(
            body: Center(
              child: Text(
                'No data found. Please try again.',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
          );
        }

        // Convert list of maps to key-value map
        final Map<String, dynamic> result = {
          for (var item in snapshot.data!) item['name']: item['data'],
        };

        semesters = result["running_sems"].cast<int>().toList();
        departments = result["departments"].cast<String>().toList();

        return _buildScreen(context);
      },
    );
  }

  Widget _buildScreen(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Content
            PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildSemesterSelection(),
                _buildDepartmentSelection(),
                _buildSectionSelection(),
                // _buildCompletionScreen(),
              ],
            ),

            // Bottom Navigation Buttons
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back Button
                    AnimatedOpacity(
                      opacity: currentIndex > 0 ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[100],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 18,
                          ),
                        ),
                        onPressed:
                            currentIndex > 0 ? _moveToPreviousStep : null,
                      ),
                    ),

                    // Complete Button or Next Button
                    if (currentIndex == 2 ||
                        currentIndex == 1 &&
                            !["CSE", null].contains(selectedDepartment))
                      ElevatedButton(
                        onPressed: () {
                          // Redirect to All Set Screen then to HomeScreen.
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => AllSetScreen(
                                    onComplete: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(),
                                        ),
                                      );
                                    },
                                  ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      )
                    else
                      AnimatedOpacity(
                        opacity: _canMoveNext() ? 1.0 : 0.7,
                        duration: const Duration(milliseconds: 200),
                        child: IconButton(
                          icon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(
                                    context,
                                  ).primaryColor.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: _canMoveNext() ? _moveToNextStep : null,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _canMoveNext() {
    switch (currentIndex) {
      case 0:
        return selectedSemester != null;
      case 1:
        return selectedDepartment != null;
      case 2:
        return selectedDepartment == 'CSE' ? selectedSection != null : true;
      default:
        return true;
    }
  }

  Widget _buildSemesterSelection() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            'Select Your Semester',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Which semester are you currently in?',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Center(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: semesters.length,
                itemBuilder: (context, index) {
                  final semester = semesters[index];
                  final isSelected = selectedSemester == semester;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSemester = semester;
                      });
                      _handleOptionSelected();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color:
                                isSelected
                                    ? Theme.of(
                                      context,
                                    ).primaryColor.withValues(alpha: 0.3)
                                    : Colors.grey.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          semester.toString(),
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentSelection() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            'Select Your Department',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Which department are you enrolled in?',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: departments.length,
                itemBuilder: (context, index) {
                  final department = departments[index];
                  final isSelected = selectedDepartment == department;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDepartment = department;
                          // Clear section if department is not CSE
                          if (department != 'CSE') {
                            selectedSection = null;
                          }
                        });
                        if (selectedDepartment == "CSE") {
                          _handleOptionSelected();
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color:
                                isSelected
                                    ? Theme.of(context).primaryColor
                                    : Colors.transparent,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  isSelected
                                      ? Theme.of(
                                        context,
                                      ).primaryColor.withValues(alpha: 0.2)
                                      : Colors.grey.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey[100],
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  department[0],
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : Colors.grey[700],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    department,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _getDepartmentDescription(department),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle_rounded,
                                color: Theme.of(context).primaryColor,
                                size: 28,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getDepartmentDescription(String dept) {
    switch (dept) {
      case 'CSE':
        return 'Computer Science & Engineering';
      case 'ECE':
        return 'Electronics & Communication Engineering';
      case 'DSAI':
        return 'Data Science & Artificial Intelligence';
      default:
        return '';
    }
  }

  Widget _buildSectionSelection() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            'Select Your Section',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Which section are you assigned to?',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    sections.map((section) {
                      final isSelected = selectedSection == section;

                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: section == 'A' ? 0 : 8,
                            right: section == 'B' ? 0 : 8,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSection = section;
                              });
                              _handleOptionSelected();
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? Theme.of(context).primaryColor
                                          : Colors.transparent,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        isSelected
                                            ? Theme.of(context).primaryColor
                                                .withValues(alpha: 0.2)
                                            : Colors.grey.withValues(
                                              alpha: 0.1,
                                            ),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          isSelected
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey[100],
                                      boxShadow:
                                          isSelected
                                              ? [
                                                BoxShadow(
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withValues(alpha: 0.3),
                                                  blurRadius: 12,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ]
                                              : null,
                                    ),
                                    child: Center(
                                      child: Text(
                                        section,
                                        style: TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              isSelected
                                                  ? Colors.white
                                                  : Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Section $section',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          isSelected
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildInfoRow(String label, String value) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Text(
  //         label,
  //         style: TextStyle(fontSize: 16, color: Colors.grey[600])
  //       ),
  //       Text(
  //         value,
  //         style: const TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.bold
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
